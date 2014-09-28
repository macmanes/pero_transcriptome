#!/bin/bash

total=13000
n=1
while [ $n -lt $total ]; do
	var1=$(sed -n "${n}p" peer-pema-good.blast)
	echo $var1 > tmp
	var2=$(awk '{print $1}' tmp)
	var3=$(awk '{print $2}' tmp)
	grep -A1 -w --max-count=1 $var2 ../pema/pema.rna.fa > $n.hits.fa
	grep -A1 -w --max-count=1 $var3 ../peer/peer.genes.fasta >> $n.hits.fa;
	echo "Line $n = $var1"
	let n=n+1
done



