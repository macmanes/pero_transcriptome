#!/usr/bin/make -rRsf

###########################################
###
############################################


##### No more Editing should be necessary below this line  #####

MAKEDIR := $(dir $(firstword $(MAKEFILE_LIST)))
DIR := ${CURDIR}

CPU=2
RUN=test
GENOME_DIR=/mouse/mouse_rnaseq/genome
REF=$(GENOME_DIR)/pero.for.maker.fasta
DATA_DIR=/mouse/mouse_rnaseq/data


.PHONY: check clean
all: check $(GENOME_DIR)/peer_genome/chrLength.txt 2926Aligned.sortedByCoord.out.bam 2925Aligned.sortedByCoord.out.bam \
2342Aligned.sortedByCoord.out.bam 2345Aligned.sortedByCoord.out.bam 2346Aligned.sortedByCoord.out.bam \
2336Aligned.sortedByCoord.out.bam 334Aligned.sortedByCoord.out.bam 335Aligned.sortedByCoord.out.bam \
336Aligned.sortedByCoord.out.bam 2335Aligned.sortedByCoord.out.bam 2355Aligned.sortedByCoord.out.bam \
234Aligned.sortedByCoord.out.bam


check:
	@echo TIMESTAMP: `date +'%a %d%b%Y  %H:%M:%S'` ---Begin--- '\n\n'
	@echo "\n\n\n"###I am checking to see if you have all the dependancies installed.### "\n"
	command -v STAR >/dev/null 2>&1 || { echo >&2 "I require STAR but it's not installed.  Aborting."; exit 1; }
	@echo STAR is Installed
	command -v samtools >/dev/null 2>&1 || { echo >&2 "I require samTools but it's not installed.  Aborting."; exit 1; }
	@echo samTools is Installed


$(GENOME_DIR)/peer_genome/chrLength.txt:$(REF)
	@echo ---Quantitiating Transcripts---
	mkdir -p $(GENOME_DIR)/peer_genome
	STAR --genomeDir $(GENOME_DIR)/peer_genome --runMode genomeGenerate --genomeFastaFiles $(REF) \
	--runThreadN $(CPU) --limitGenomeGenerateRAM 100000000000

2926Aligned.sortedByCoord.out.bam: name := 2926
2926Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/Pero2926.1.fastq $(DATA_DIR)/Pero2926.2.fastq --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000


2925Aligned.sortedByCoord.out.bam: name := 2925
2925Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/Pero2925.1.fastq $(DATA_DIR)/Pero2925.2.fastq --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000


2342Aligned.sortedByCoord.out.bam: name := 2342
2342Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2342.trim_1P.fq.gz $(DATA_DIR)/2342.trim_2P.fq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

2345Aligned.sortedByCoord.out.bam: name := 2345
2345Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2345.1.fastq.gz $(DATA_DIR)/2345.2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

2346Aligned.sortedByCoord.out.bam: name := 2346
2346Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2346.1.fastq.gz $(DATA_DIR)/2346.2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

2336Aligned.sortedByCoord.out.bam: name := 2336
2336Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2336.1.fastq.gz $(DATA_DIR)/2336.2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

334Aligned.sortedByCoord.out.bam: name := 334
334Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/334K.R1.fastq.gz $(DATA_DIR)/334K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

335Aligned.sortedByCoord.out.bam: name := 335
335Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/335K.R1.fastq.gz $(DATA_DIR)/335K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

336Aligned.sortedByCoord.out.bam: name := 336
336Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/336K.R1.fastq.gz $(DATA_DIR)/336K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

2335Aligned.sortedByCoord.out.bam: name := 2335
2335Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2335K.R1.fastq.gz $(DATA_DIR)/2335K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

2355Aligned.sortedByCoord.out.bam: name := 2355
2355Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/2355K.R1.fastq.gz $(DATA_DIR)/2355K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000

234Aligned.sortedByCoord.out.bam: name := 234
234Aligned.sortedByCoord.out.bam:$(GENOME_DIR)/peer_genome/chrLength.txt
	@echo TIMESTAMP: '\n\n' `date +'%a %d%b%Y  %H:%M:%S'` ---Begin mapping of sample number $(name)--- '\n\n'
	STAR --outFilterMatchNminOverLread 0.40 --outStd Log --genomeDir $(GENOME_DIR)/peer_genome --outFilterMismatchNmax 2 \
	--readFilesIn $(DATA_DIR)/234K.R1.fastq.gz $(DATA_DIR)/234K.R2.fastq.gz --outFilterScoreMinOverLread 0.40 \
	--runThreadN $(CPU) --genomeLoad LoadAndKeep --outFilterIntronMotifs RemoveNoncanonical --readFilesCommand gzip -cd \
	--outSAMtype BAM SortedByCoordinate --outFileNamePrefix $(name) --limitBAMsortRAM 100000000000
