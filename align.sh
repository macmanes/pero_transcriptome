#! /bin/bash


usage=$(cat << EOF
   # This script runs a pipeline that takes a fasta file and BAMfiles and tests for selection:
   #   
   
   omegav3.sh [options]

   Options:
      -t <v> : *required* Number of threads to use.
EOF
);


while getopts o:t: option
do
    case "${option}"
    in
	t) TC=${OPTARG};;
	o) OD=${OPTARG};;
    esac
done


mkdir $OD

##Align
total=10000
n=1
while [ $n -lt $total ]; do
	i=`ps -all | grep 'java\|codeml' | wc -l`
	if [ $i -lt $TC ] ; #are there less than $TC jobs currently running?
	then
		#echo 'I have a core to use'
		if [ -f $OD/$n.hits.fa ] ; #does the file exist?
		then
			if [ ! -f $OD/$n.hits.aln ] ; #have I done alignment?
			then
				java -Xmx1000m -jar /share/bin/macse_v1.01b.jar -prog alignSequences -seq $OD/$n.hits.fa -out_NT $OD/$n.hits.aln & #just do it!   	
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
