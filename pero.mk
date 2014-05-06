#!/usr/bin/make -rRsf

###########################################
###        -usage 'assembly.mk RUN=run CPU=8 MEM=15 READ1=/location/of/read1.fastq READ2=/location/of/read2.fastq'
###         -RUN= name of run
###
###
###         -Make sure your samTools, BWA and Trinity are installed and in
###          your path
###
###
############################################


##### No Editing should be necessary below this line  #####

MINLEN=25
PHRED=33
SEQ=fq
MINK=1
MEM=2
TRIM=2
CPU=2
BCPU=$(CPU)
RUN=run
READ1=left.fq
READ2=right.fq
BCODES=barcodes.fa


MAKEDIR := $(dir $(firstword $(MAKEFILE_LIST)))
DIR := ${CURDIR}
export PATH := ${MAKEDIR}plugins/trinityrnaseq-code/:${MAKEDIR}/plugins:$(PATH)

.PHONY: check clean
all: check $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq $(RUN).Trinity.fasta $(RUN).xprs
trim: check $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq
assemble: check $(RUN).Trinity.fasta
express: check $(RUN).xprs
single: check $(RUN)_SE.$(TRIM).fastq $(RUN).SE.Trinity.fasta $(RUN).SE.xprs
flash: check out.notCombined_1.fastq out.notCombined_2.fastq out.extendedFrags.fastq \
$(RUN)_left.FL$(TRIM).fastq $(RUN)_right.FL$(TRIM).fastq $(RUN)_extended.$(TRIM).fastq \
$(RUN).FLASH.Trinity.fasta $(RUN).FLASH.xprs


check:
	@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` ---Begin--- '\n\n'
	@echo "\n\n\n"###I am checking to see if you have all the dependancies installed.### "\n"
	command -v bwa mem >/dev/null 2>&1 || { echo >&2 "I require BWA but it's not installed.  Aborting."; exit 1; }
	@echo BWA is Installed
	command -v samtools >/dev/null 2>&1 || { echo >&2 "I require samTools but it's not installed.  Aborting."; exit 1; }
	@echo samTools is Installed
	command -v $(TRINITY) >/dev/null 2>&1 || { echo >&2 "I require Trinity but it's not installed.  Aborting."; exit 1; }
	@echo Trinity is Installed
	if [ -f $(READ1) ]; then echo 'left fastQ exists'; else echo 'Im having trouble finding your left fastQ file, check PATH \n'; exit 1; fi;
	if [ -f $(READ2) ]; then echo 'right fastQ exists \n'; else echo 'Im having trouble finding your right fastQ file, check PATH \n'; fi;
	chmod -w $(READ1) 2>/dev/null; true
	chmod -w $(READ2) 2>/dev/null; true
	@echo Your PATH=$$PATH

$(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq: $(READ1) $(READ2)
	@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` About to start trimming
		java -XX:ParallelGCThreads=32 -Xmx$(MEM)g -jar ${MAKEDIR}/plugins/trimmomatic-0.32.jar PE -phred$(PHRED) -threads $(CPU) \
		$(READ1) \
		$(READ2) \
		$(RUN).pp.1.fq \
		$(RUN).up.1.fq \
		$(RUN).pp.2.fq \
		$(RUN).up.2.fq \
		ILLUMINACLIP:${MAKEDIR}/$(BCODES):2:40:15 \
		LEADING:$(TRIM) TRAILING:$(TRIM) SLIDINGWINDOW:4:$(TRIM) MINLEN:$(MINLEN) 2> trim.log ;
		cat $(RUN).pp.1.fq $(RUN).up.1.fq > $(RUN)_left.$(TRIM).fastq ;
		cat $(RUN).pp.2.fq $(RUN).up.2.fq > $(RUN)_right.$(TRIM).fastq ;
		@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` Finished trimming '\n\n'

$(RUN).Trinity.fasta: $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq
	Trinity.pl --full_cleanup --min_kmer_cov $(MINK) --seqType $(SEQ) --JM $(MEM)G --PasaFly --bflyGCThreads 25 --bflyHeapSpaceMax $(MEM)G --bflyCPU $(BCPU) \
	--left $(RUN)_left.$(TRIM).fastq --right $(RUN)_right.$(TRIM).fastq --group_pairs_distance 999 --CPU $(CPU) --output $(RUN) >>$(RUN).trinity.pe.log
