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


MEM=2
CPU=2
BCPU=$(CPU)
RUN=test123
READ1=left.fq
READ2=right.fq


MAKEDIR := $(dir $(firstword $(MAKEFILE_LIST)))
DIR := ${CURDIR}

.PHONY: check clean
all: check $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq $(RUN).Trinity.fasta $(RUN).xprs
trim: check $(RUN)_left.$(TRIM).fastq $(RUN)_right.$(TRIM).fastq
assemble: check $(RUN).Trinity.fasta
express: check $(RUN).xprs


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



$(RUN).xprs: $(RUN).Trinity.fasta
		@echo ---Quantitiating Transcripts---
		bwa index -p index $(RUN).Trinity.fasta
		bwa mem -t $(CPU) index $(READ1) $(READ2) 2>bwa.log | samtools view -@ $(CPU) -1 - > $(RUN).bam
		samtools flagstat $(RUN).bam > $(RUN).map.stats &
		@echo --eXpress---
		express -o $(RUN).xprs \
		-p $(CPU) $(RUN).Trinity.fasta $(RUN).bam 2>express.log
		@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` Finished eXpress '\n\n'
