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
all: check index.bwt 321.bam 354.bam 382.bam 373.bam 380.bam 372.bam 369.bam 340.bam 365.bam 366.bam 368.bam 359.bam 352.bam 308.bam 305.bam

#Need 368 305 308 

check:
	@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` ---Begin--- '\n\n'
	@echo "\n\n\n"###I am checking to see if you have all the dependancies installed.### "\n"
	command -v bwa mem >/dev/null 2>&1 || { echo >&2 "I require BWA but it's not installed.  Aborting."; exit 1; }
	@echo BWA is Installed
	command -v /share/samtools/samtools >/dev/null 2>&1 || { echo >&2 "I require /share/samtools/samtools but it's not installed.  Aborting."; exit 1; }
	@echo /share/samtools/samtools is Installed




#DC April
365_read3='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index3.1.fq.gz'
365_read4='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index3.2.fq.gz'
###
340_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index1.1.fq.gz'
340_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index1.2.fq.gz'
###
366_read3='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index8.1.fq.gz'
366_read4='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index8.2.fq.gz'
###
368_read3='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index10.1.fq.gz'
368_read4='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index10.2.fq.gz'
###
369_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index16.1.fq.gz'
369_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index16.2.fq.gz'

### DC Aug
305_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index2.1.fq.gz'
305_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index2.2.fq.gz'
###
308_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index4.1.fq.gz'
308_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index4.2.fq.gz'
308_read3='/mnt/data3/macmanes/sequence-reads/peromyscus/peer.308.dc.fq.bz2'
### DC Oct
352_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index5.1.fq.gz'
352_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index5.2.fq.gz'
352_read3='/mnt/data3/macmanes/sequence-reads/peromyscus/peer.354.dc.fq.bz2'
### 
359_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index6.1.fq.gz'
359_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index6.2.fq.gz'
###
360_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index7.1.fq.gz'
360_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index7.2.fq.gz'
360_read3='/mnt/data3/macmanes/peromyscus/peer.360.dc.fq.bz2'
##
##
368_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index11.1.fq.gz'
368_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index11.2.fq.gz'
##
365_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index12.1.fq.gz'
365_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index12.2.fq.gz'
##
366_read1='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index14.1.fq.gz'
366_read2='/mnt/data3/macmanes/peromyscus/raw.reads/MBE_MDM_41_index14.2.fq.gz'
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

340.bam: name := 340
340.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

369.bam: name := 369
369.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

305.bam: name := 305
305.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

308.bam: name := 308
308.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -o $(name)1.bam -@ $(CPU) -b -
	bwa mem -t $(CPU) index $($(name)_read3)  | /share/samtools/samtools view -o $(name)2.bam -o $(name)2.bam -@ $(CPU) -b - 
	/share/samtools/samtools merge -@ 24 $(name).bam $(name)1.bam $(name)2.bam
	/share/samtools/samtools sort -@ 24 -O bam -o $(name).sort.bam -T $(name) $(name).bam 

352.bam: name := 352
352.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -o $(name)1.bam -@ $(CPU) -b -
	bwa mem -t $(CPU) index $($(name)_read3)  | /share/samtools/samtools view -o $(name)2.bam -o $(name)2.bam -@ $(CPU) -b - 
	/share/samtools/samtools merge -@ 24 $(name).bam $(name)1.bam $(name)2.bam
	/share/samtools/samtools sort -@ 24 -O bam -o $(name).sort.bam -T $(name) $(name).bam 

359.bam: name := 359
359.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

368.bam: name := 368
368.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -o $(name)1.bam -@ $(CPU) -b - 
	bwa mem -t $(CPU) index $($(name)_read3) $($(name)_read4)  | /share/samtools/samtools view -o $(name)2.bam -@ $(CPU) -b - 
	/share/samtools/samtools merge -@ 24 $(name).bam $(name)1.bam $(name)2.bam
	/share/samtools/samtools sort -@ 24 -O bam -o $(name).sort.bam -T $(name) $(name).bam 

365.bam: name := 365
365.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -o $(name)1.bam -@ $(CPU) -b - 
	bwa mem -t $(CPU) index $($(name)_read3) $($(name)_read4)  | /share/samtools/samtools view -o $(name)2.bam -@ $(CPU) -b - 
	/share/samtools/samtools merge -@ 24 $(name).bam $(name)1.bam $(name)2.bam
	/share/samtools/samtools sort -@ 24 -O bam -o $(name).sort.bam -T $(name) $(name).bam

366.bam: name := 366
366.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1) $($(name)_read2)  | /share/samtools/samtools view -o $(name)1.bam -@ $(CPU) -b -
	bwa mem -t $(CPU) index $($(name)_read3) $($(name)_read4)  | /share/samtools/samtools view -o $(name)2.bam -@ $(CPU) -b - 
	/share/samtools/samtools merge -@ 24 $(name).bam $(name)1.bam $(name)2.bam
	/share/samtools/samtools sort -@ 24 -O bam -o $(name).sort.bam -T $(name) $(name).bam 

321.bam: name := 321
321.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

354.bam: name := 354
354.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

382.bam: name := 382
382.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

373.bam: name := 373
373.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

372.bam: name := 372
372.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin 372--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -

380.bam: name := 380
380.bam:
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin $(name)--- '\n\n'
	bwa mem -t $(CPU) index $($(name)_read1)  | /share/samtools/samtools view -@ $(CPU) -b - | /share/samtools/samtools sort -@ 8 -O bam -T $(name) -o $(name).bam -
