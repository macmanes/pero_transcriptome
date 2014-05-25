#! /bin/bash


for i in `ls paml/*out` do;
	grep lnL $i | awk '{print $5}' > tmp
	var1=$(sed -n '2p' tmp)
	var2=$(sed -n '3p' tmp)
	var3=$(sed -n '4p' tmp)
	var4=$(sed -n '5p' tmp)
	var5=$(awk -v VAR1=$var1 -v VAR2=$var2 'BEGIN {print 2*(VAR1-VAR2) <0 ? -2*(VAR1-VAR2) : 2*(VAR1-VAR2)}')
	var6=$(awk -v VAR1=$var3 -v VAR2=$var4 'BEGIN {print 2*(VAR3-VAR4) <0 ? -2*(VAR3-VAR4) : 2*(VAR3-VAR4)}')
	echo -e $i '\t' M1a vs M2a '\t' $var5 >> M2.txt
	echo -e $i '\t' M7 vs M8 '\t' $var6 >> M8.txt
done
