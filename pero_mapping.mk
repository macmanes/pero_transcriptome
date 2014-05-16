#!/usr/bin/make -rRsf

###########################################
###
############################################


##### No more Editing should be necessary below this line  #####

MAKEDIR := $(dir $(firstword $(MAKEFILE_LIST)))
DIR := ${CURDIR}

CPU=2
RUN=test
REF=
WD=$(DIR)/`date +%d%b%Y`
CONVERT=$(shell locate fq2fa.py)


.PHONY: check clean
all: check test test2 index.bwt 380.fasta 372.fasta


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
19_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index19.1.fq.gz'
19_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index19.2.fq.gz'
##
321_read1='/mnt/data3/macmanes/peromyscus/peer.321.dc.fq'
##
354_read1='/mnt/data3/macmanes/peromyscus/peer.354.dc.fq'
##
382_read1='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/382k_notx_peer_index15.fastq.gz'
##
373_read1='/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/373k_wet_peer_index3.fastq.gz'
##
380_read1=/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/380k_dry_peer_index1.fastq.gz
##
372_read1=/mnt/data3/macmanes/121027_HS3A_pero/raw_reads/372k_wet_peer_index2.fastq.gz
###


index.bwt:
	@echo ---Quantitiating Transcripts---
	bwa index -p index $(REF)



.PHONY: 19.fasta
19.fasta: name := 19
19.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta





.PHONY: 321.fasta
321.fasta: name := 321
321.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta



.PHONY: 354.fasta
354.fasta: name := 354
354.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta




.PHONY: 382.fasta
382.fasta: name := 382
382.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta



.PHONY: 373.fasta
373.fasta: name := 373
373.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta


.PHONY: 372.fasta
372.fasta: name := 372
372.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin 372--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta



.PHONY: 380.fasta
380.fasta: name := 380
380.fasta:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) 2> bwa.log | samtools view -@ $(CPU) -b - | samtools sort -m20G - $(name)
	samtools mpileup -AIuf $(REF) $(name).bam | bcftools view - | vcfutils.pl vcf2fq > $(name).fq
	python $(CONVERT) $(name).fq $(name).fa
	sed -i "s_>.*_&-${name}_g" $(name).fa
	sed ':begin;$!N;/[ACTGNn-]\n[ACTGNn-]/s/\n//;tbegin;P;D' $(name).fa > $(name).fasta
















