#! /bin/bash


usage=$(cat << EOF
   # This script runs a pipeline that takes a fasta file and BAMfiles and tests for selection:
   #   
   
   omegav3.sh [options]

   Options:
      -t <v> : *required* Number of threads to use.
      -o <v> : *required* output directory.
EOF
);


while getopts i:t:o: option
do
    case "${option}"
    in
	i) ID=${OPTARG};;
	t) TC=${OPTARG};;
	o) OD=${OPTARG};;
    esac
done


mkdir $ID
mkdir $OD


total=11000
n=1
while [ $n -lt $total ]; do
	i=`ps -all | grep 'java\|codeml' | wc -l`
	if [ $i -lt $TC ] ; #are there less than $TC jobs currently running?
	then
		#echo 'I have a core to use'
		if [ -f $ID/$n.hits.aln ] ; #does the file exist?
		then
			if [ ! -f $OD/$n.hits.out ] ; #have I done PAML?
			then
				sed -i 's_!_-_g' $ID/$n.hits.aln
				sed -i "s/cds.ENSM.*/mus/g" $ID/$n.hits.aln
				sed -i "s/pema.gi.*/pema/g" $ID/$n.hits.aln
				sed -i "s/[0-9].*/peer/g" $ID/$n.hits.aln
				sed -i "s/cds.ENSR.*/rat/g" $ID/$n.hits.aln
				python $HOME/pero_transcriptome/fa2phy.py $ID/$n.hits.aln $ID/$n.hits.phy
				sed -i "s_seqfile =.*_seqfile = ${ID}/${n}.hits.phy_g" codeml.ctl
				sed -i "s_outfile =.*_outfile = ${OD}/${n}.hits.out_g" codeml.ctl
				yes "\n" | codeml &
				let n=n+1	
			else
				let n=n+1
			fi
		else
			let n=n+1
		fi
	else
		echo 'Dont wake me up until there is something else to do'
		sleep 15s #there are already $TC jobs-- you can take a rest now...
	fi
done
wait
