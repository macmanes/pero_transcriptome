	#!/usr/bin/make -rRsf

###########################################
###        -usage 'assembly.mk RUN=run CPU=2 MEM=15 READ1=/location/of/read1.fastq READ2=/location/of/read2.fastq'
###         -RUN= name of run
###
###
###         -Make sure your samTools, BWA and Trinity are installed and in
###          your path
###
###
############################################


##### No more Editing should be necessary below this line  #####

MAKEDIR := $(dir $(firstword $(MAKEFILE_LIST)))
DIR := ${CURDIR}

CPU=2
RUN=test
REF=
INDEX=/media/macmanes/hd3/pero
WD=$(DIR)/`date +%d%b%Y`






.PHONY: check clean
all: check $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq $(RUN).Trinity.fasta $(RUN).xprs



check:
	@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` ---Begin--- '\n\n'
	@echo "\n\n\n"###I am checking to see if you have all the dependancies installed.### "\n"
	command -v bwa mem >/dev/null 2>&1 || { echo >&2 "I require BWA but it's not installed.  Aborting."; exit 1; }
	@echo BWA is Installed
	command -v samtools >/dev/null 2>&1 || { echo >&2 "I require samTools but it's not installed.  Aborting."; exit 1; }
	@echo samTools is Installed
	if [ -f $(READ1) ]; then echo 'left fastQ exists'; else echo 'Im having trouble finding your left fastQ file, check PATH \n'; exit 1; fi;
	if [ -f $(READ2) ]; then echo 'right fastQ exists \n'; else echo 'Im having trouble finding your right fastQ file, check PATH \n'; fi;
	chmod -w $(READ1) 2>/dev/null; true
	chmod -w $(READ2) 2>/dev/null; true



#DC April
pero365_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index3.1.fq.gz'
pero365_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index3.2.fq.gz'
###
pero340_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index1.1.fq.gz'
pero340_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index1.2.fq.gz'
###
pero366_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index8.1.fq.gz'
pero366_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index8.2.fq.gz'
###
pero368_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index10.1.fq.gz'
pero368_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index10.2.fq.gz'
###
pero369_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index16.1.fq.gz'
pero369_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index16.2.fq.gz'
### DC Aug
pero305_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index2.1.fq.gz'
pero305_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index2.2.fq.gz'
###
pero308_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index4.1.fq.gz'
pero308_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index4.2.fq.gz'
pero308_3='/mnt/data3/macmanes/sequence-reads/peromyscus/peer.308.dc.fq.bz2'
### DC Oct
pero352_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index5.1.fq.gz'
pero352_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index5.2.fq.gz'
pero352_3='/mnt/data3/macmanes/sequence-reads/peromyscus/peer.354.dc.fq.bz2'
### 
pero359_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index6.1.fq.gz'
pero359_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index6.2.fq.gz'
###
pero360_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index7.1.fq.gz'
pero360_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index7.2.fq.gz'
pero360_3='/mnt/data3/macmanes/peromyscus/peer.360.dc.fq.bz2'
##
##
pero368b_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index11.1.fq.gz'
pero368b_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index11.2.fq.gz'
##
pero365b_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index12.1.fq.gz'
pero365b_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index12.2.fq.gz'
##
pero366b_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index14.1.fq.gz'
pero366b_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index14.2.fq.gz'
##
pero19_1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index19.1.fq.gz'
pero19_2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index19.2.fq.gz'
##
pero321='/mnt/data3/macmanes/peromyscus/peer.321.dc.fq'
##
pero354='/mnt/data3/macmanes/peromyscus/peer.354.dc.fq'
##
pero382k='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/382k_notx_peer_index15.fastq.gz'
##
pero373k='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/373k_wet_peer_index3.fastq.gz'
##
pero380k='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/380k_dry_peer_index1.fastq.gz'
##
372_read1='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/372k_wet_peer_index2.fastq.gz'
###
##





index.bwt: $(REF)
	@echo ---Quantitiating Transcripts---
	bwa index -p index $(REF)
		
$(name).fasta:$($(name)_read1)
	name=372
	bwa mem -t $(CPU) index $($(name)_read1) 2>bwa.log | samtools view -@ $(CPU) -1 - | samtools sort -@ 6 -m 1G - $(name) > $(name).bam
	samtools mpileup -uvf $(REF) $(name).bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $(name).fq
	python ~/Desktop/python/fq2fa.py $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	fasta_formatter -i $(name).fa -o $(name).fasta






echo "##################################################"
echo "Beginning pero372k @ `date`."
echo "##################################################"
cd $home
name=372
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero372k | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name > $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
fi
echo "##################################################"
echo "Beginning pero380k @ `date`."
echo "##################################################"
cd $home
name=380
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero380k | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
fi
echo "##################################################"
echo "Beginning pero373k @ `date`."
echo "##################################################"
cd $home
name=373
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero373k | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
fi
echo "##################################################"
echo "Beginning pero382k @ `date`."
echo "##################################################"
cd $home
name=382
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero382k | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi
echo "##################################################"
echo "Beginning pero321 @ `date`."
echo "##################################################"
cd $home
name=321
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero321 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi
echo "##################################################"
echo "Beginning pero326 @ `date`."
echo "##################################################"
cd $home
name=326
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero326 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta	
fi
echo "##################################################"
echo "Beginning 305 @ `date`."
echo "##################################################"

cd $home
name=305
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero305_1 $pero305_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta	
fi



echo "##################################################"
echo "Beginning 340 @ `date`."
echo "##################################################"

cd $home
name=340
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero340_1 $pero340_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi


echo "##################################################"
echo "Beginning 308 @ `date`."
echo "##################################################"
cd $home
name=308
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero308_1 $pero308_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi
echo "##################################################"
echo "Beginning 352 @ `date`."
echo "##################################################"
cd $home
name=352
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero352_1 $pero352_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi

echo "##################################################"
echo "Beginning pero354 @ `date`."
echo "##################################################"
cd $home
name=354
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero354 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi


echo "##################################################"
echo "Beginning 359 @ `date`."
echo "##################################################"
cd $home
name=359
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero359_1 $pero359_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi
echo "##################################################"
echo "Beginning 360 @ `date`."
echo "##################################################"
#need to do SE elignments
cd $home
name=360
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero360_1 $pero360_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi


echo "##################################################"
echo "Beginning 365 @ `date`."
echo "##################################################"
cd $home
name=365
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero365_1 $pero365_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi


echo "##################################################"
echo "Beginning Index 366 @ `date`."
echo "##################################################"
cd $home
name=366
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero366_1 $pero366_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta	
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi
echo "##################################################"
echo "Beginning 366b @ `date`."
echo "##################################################"
#cd $p366b
#name=366
#if [ -f $name.bam ];
#then
#   echo "File exists"
#else
#	bwa mem -t 8  $index/$bwa_index $pero366b_1 $pero366b_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
#	
#fi


echo "##################################################"
echo "Beginning Index 368b @ `date`."
echo "##################################################"
echo "##################################################"
echo "Beginning Index 368 @ `date`."
echo "##################################################"
cd $home
name=368
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8  $index/$bwa_index $pero368_1 $pero368_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi

echo "##################################################"
echo "Beginning Index 369 @ `date`."
echo "##################################################"
cd $home
name=369
if [ -f $name.bam ];
then
   echo "File exists"
else
	bwa mem -t 8 $index/$bwa_index $pero369_1 $pero369_2 | samtools view -Sb - | samtools sort -@ 6 -m 1G - $name 
	samtools mpileup -uvf $fasta $name.bam | bcftools view -cgIS - | vcfutils.pl vcf2fq > $name.fq
	python ~/Desktop/python/fq2fa.py $name.fq $name.fa
	sed -i "s_>.*_&-${name}_g" $name.fa
	fasta_formatter -i $name.fa -o $name.fasta
       	sed -i ':begin;$!N;/[ACTG]\n[ACTG]/s/\n//;tbegin;P;D' $name.fasta
fi