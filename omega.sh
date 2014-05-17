#! /bin/bash

######Requirements
#samtools, gnu parallel, MACse, omegaMap, fasTool

#Need to specify bam folder
#Need to give trinity.fasta file


usage=$(cat << EOF
   # This script runs a pipeline that takes a fasta file and BAMfiles and tests for selection:
   #   
   
   omegav3.sh [options]

   Options:
      -f <v> : *required* specify the FASTA file.
      -o <v> : *required* omegaMap control file.
      -t <v> : *required* Numberof threads to use.
EOF
);


while getopts f:b:o:t: option
do
    case "${option}"
    in
    f) FA=${OPTARG};;
	o) CF=${OPTARG};;
	t) TC=${OPTARG};;
    esac
done

#MACSE = which macse_v1.01b.jar

##cluster seqs
mkdir unalign
mkdir aligned
grep '>'  $FA | awk '{print $1}' | sed 's_>__g' > list ##Change this to $fasta when I know how--DONE
for i in `cat list`; do grep --max-count=1 --no-group-separator -wA1 $i 3*fasta > unalign/om.$i.fa; done 
for i in `ls unalign/om*fa`; do sed -i 's_R_A_g;s_Y_G_g;s_W_A_g;s_S_C_g;s_M_A_g;s_K_C_g' $i; done
#rm list

##Align
total=10057015980
n=1
while [ $n -lt $total ]; do
	i=`ps -all | grep java | wc -l`
	if [ $i -lt $TC ] ; #are there less than $TC jobs currently running?
	then
		echo 'I have a core to use'
		if [ -f unalign/om.$n.fa ] ; #does the file exist?
		then
			echo "The input file om.$i.fa seems to exist"
			if [ ! -f aligned/om.$n.aln ] ; #have I already done the analyses elsewhere?
			then
				echo 'I need to do the analysis'
				java -Xmx5000m -jar macse_v1.01b.jar -prog alignSequences -seq unalign/om.$n.fa -out_NT aligned/om.$n.aln & #just do it!        
				let n=n+1
			else
				echo "Sweet! I already made om.$n.aln!"
				let n=n+1
			fi
		else
			let n=n+1
			#echo "I'm up to $n"
		fi
	else
		echo 'Dont wake me up until there is something else to do'
		sleep 15s #there are already $TC jobs-- you can take a rest now...
	fi
done
wait
#for i in `ls om*fa`; do rm $i; done
for i in `ls aligned/om*aln`; do sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $i;done
rm commands.txt

##Format fastas in prep for omega map
for i in `ls aligned/om*aln`; do sed -i 's_TAG$_GGG_g;s_TGA$_GGG_g;s_TAA$_GGG_g;s_N_C_g;s_!_C_g;s_-_C_g' $i; done

##Do omegaMap
mkdir omega
total=10057015980
n=1
while [ $n -lt $total ]; do
	i=`ps -all | grep omegaMap | wc -l`
	if [ $i -lt $TC ] ; #are there less than 16 jobs currently running?
	then
		echo 'I have a core to use'
		if [ -f aligned/om.$n.aln ] ; #does the file exist?
		then
			echo "The input file om.m$n.aln seems to exist"
			if [ ! -f omega/om.$n.aln.out ] ; #have I already done the analyses elsewhere?
			then
				echo 'I need to do the analysis'
				omegaMap $CF -outfile omega/om.$n.aln.out -fasta aligned/om.$n.aln & #just do it!        
				let n=n+1
			else
				echo "Sweet! I already made om.m.$n.aln.out!"
				let n=n+1
			fi
		else
			let n=n+1
		fi
	else
		echo 'Dont wake me up until there is something else to do'
		sleep 30s #there are already 16 jobs-- you can take a rest now...
	fi
done
wait
for i in `ls omega/om*out`; do summarize 2000 $i > omega/$i.results; done

##Process Results
rm summary.file names.fa
for i in `ls omega/om*results`; do sed -n '4p' $i >> summary.file; done
for i in `ls omega/om*results`; do F=`basename $i .out.results`; echo $F >> names.fa; done; paste names.fa summary.file > selection.txt
cat selection.txt |  awk '0.00015<$6{next}1' | awk '{print $1 "\t" $4 "\t" $6}' > positive.selection
cat selection.txt |  awk '0.01<$6{next}1' | awk '{print $1}' | grep -wEo -A1  m.[[:digit:]]\{1,} | grep -w -A1 --no-group-separator -f - $FA > sig.selection.fa
cat selection.txt |  awk '0.00015<$6{next}1' | awk '{print $1}' | grep -wEo -A1  m.[[:digit:]]\{1,} | grep -w -A1 --no-group-separator -f - ../aas.pep > sig.selection.pep
