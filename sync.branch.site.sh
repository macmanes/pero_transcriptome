#!/bin/bash

total=1700
n=1
while [ $n -lt $total ]; do
	var1=$(grep lnL paml/${n}.hits.out | awk '{print $5}')
	var2=$(grep lnL paml-branch/${n}.hits.out | awk '{print $5}')
	var3=$(awk -v VAR1=$var1 -v VAR2=$var2 'BEGIN {print 2*(VAR1-VAR2) <0 ? -2*(VAR1-VAR2) : 2*(VAR1-VAR2)}')
	echo -e $n.hits.out '\t' branch-site '\t' $var3 >> branch-site.txt
done