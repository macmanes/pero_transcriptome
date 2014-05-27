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


while getopts t: option
do
    case "${option}"
    in
	t) TC=${OPTARG};;
	o) OD=${OPTARG};;
    esac
done


mkdir aligned
mkdir $OD


total=11000
n=1
while [ $n -lt $total ]; do
	i=`ps -all | grep 'java\|codeml' | wc -l`
	if [ $i -lt $TC ] ; #are there less than $TC jobs currently running?
	then
		#echo 'I have a core to use'
		if [ -f aligned/$n.hits.aln ] ; #does the file exist?
		then
			if [ ! -f $OD/$n.hits.out ] ; #have I done PAML?
			then
				sed -i 's_!_-_g' aligned/$n.hits.aln
				sed -i "s/ENS.*/mus/g" aligned/$n.hits.aln
				sed -i "s/gi.*/pema/g" aligned/$n.hits.aln
				sed -i "s/[0-9].*/peer/g" aligned/$n.hits.aln
				python $HOME/pero_transcriptome/fa2phy.py aligned/$n.hits.aln aligned/$n.hits.phy
				sed -i "s_seqfile =.*_seqfile = aligned/${n}.hits.phy_g" codeml.ctl
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
