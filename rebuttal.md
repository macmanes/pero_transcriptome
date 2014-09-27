Pero Transcriptome Revision
--

>Reviewer Comments

>Reviewer 1 (C. Titus Brown)

>Basic reporting

--- 
1. The authors do a good job at framing their work, showing why the study is needed, the limitations and the how the work will/can lead to future research.


2. The assembly and annotation steps were well thought out. Assemblies were error corrected, quality filtered and several steps were implemented for annotation using closely related species, Pfam database and extraction of putative coding sequences. **The only thing I wonder is why didn’t the authors pool the samples when assembling.** This would not change their downstream pipeline much, however, it would help to recover low expressed transcripts. (Are there any citations for this?) **Also, I do not understand if or why the addition reads for kidney were not used for assembly.**

	*I did not conduct an assembly of the pooled samples is because I believe that tissue-specific isoforms may be reconstructed with more fidelity in this manner. I make a statement to this effect on line 103:105*

	*I did not use the 15 replicate individuals in the assembly for concerns that the added polymorphism would increase run time, hardware requirements, and would decrease assembly contiguity - all effects related to a more complex de Bruijn graph. Line 99:100*

3. The author mentioned in results line 185 “The kidney appears to [be] an outlier in the number of unique sequences, though this could […] result [from] the recovery of more lowly expressed transcripts [caused by] deeper sequencing.” Why would this not also be the case for liver, which only has 3M (5%) less sequences?

	*I have removed this statement. I do wonder why this organ produced a larger number of contigs in the assembly, but a similar number of transcripts after filtering. I admit that I do not have a good explanation, and I hope a reader will..*

4. I am trying to understand the filtering process for the assembled reads. From my understanding (Page 4, lines 103:109) sequences were filtered using Blastn, (Page 4, lines 113:120) annotated using Blastn, HMMER3 and Transdecoder. Is my understanding correct? If so, why were the assembled sequences filtered with Blastn before annotated with Blastn and HMMER3? I thought the point of HMMER3 was to retain divergent sequences not detected by blastn.

	*Yes, I filtered based on blastN to the Peromyscus maniculatus and Mus musculus transcriptomes, as well as a Mus ncRNA dataset. Given the combo of P. maniculatus being so closely related (and with a high quality annotation) and Mus being more distantly related but fantastically annotated coding regions, I am confident that I am not missing a substantial number of 'real' transcripts by employing this strategy. I think it is likely that I could have recovered more contigs using Pfam, but I would worry that the sensitivity of a HMM based search may result in the recovery of 'false' transcripts, which I am relatively intolerant of. I am electing to not filter based on Pfam, understanding the implications of this.*

5. For the natural section results, I think it would be interest to add more than two genes. Perhaps the top and bottom 10 genes from the Tajima’s D analysis.

	*I have added a few more genes, Aqp1,2,4,9. There is not evidence of positive selection in the eremicus lineage for any of these genes, as expected. The de novo (e.g. NOT focused on candidate genes) exploration of positive selection on P. eremicus will be presented in a later work, in connection with a genome sequence*

6. It would also be nice to have the various parts of the analysis in a repository, for reviewing and open science purposes.

	*I will make sure that the scripts are placed in a public GitHub repo.*

Overall I believe it is a good paper with interesting analysis, and cool results.



> Reviewer 2

>Basic reporting
---

Major comments in basic reporting section:

1. Citation format should match the "name, year" format described for the journal, currently it is in a different, numbered format

	*I have fixed this*


2. Introduction, lines 46-47: In discussing that P. eremicus does not drink water, is there a study or citation that gives their lifespan and/or drinking habits? Are the authors referring back to the species account cited in the previous section?

3. In reporting the individuals captured the authors should provide some metadata such as age (juvenile vs. adult) and sex (were there equal numbers of each sex, or more of one sex than the other)?

4. In the methods lines 86-89, the specific multiplexing and number of lanes of sequencing should be reported (how many individuals were sequenced on each lane, etc.) Perhaps this information could be included in table 1.

5. The figure legend for figure 1 needs to be more descriptive and informative.

Minor Revisions:

Line 106: The abbreviation for transcripts per million (TMP) is provided here but the full term is not stated until line 189, TMP should be defined here first.

Lines 164-168. Should assembly be plural in these two sentences? As it reads, it seems that the authors are referring to one combined assembly of all 4 reference tissues, but given the numbers and the subsequent text this meaning does not seem to be correct and it should instead be 'assemblies'.

Lines 167-168: The use of 'tissue-specific' terminology is somewhat confusing as this denotes that the transcripts are unique to the tissue but this is clearly not the meaning here given lines 183-185 and figure 1.

Why aren't gene symbols provided for each of the genes in tables 3 and 4, if you are going to report gene symbols for some of the genes why not do so for all of the genes?

Line 248 and Line 250: Were p-values truly equal to 0 and 1 or are these rounded estimates, would p<.05 or p>.05 be more appropriate? This may be a matter of personal preference.
Very Minor/Grammatical revisions:

Line 48: The beginning of the sentence should probably read "These rodents have a distinct..."). This is one of several minor grammatical changes/typos that should be addressed but I will not belabor this as it is a very minor point.

Experimental design

Major comments:

1. Can the authors provide an explanation for the choice of male reproductive tissue for the reference tissues while leaving out the female reproductive tissue? Presumably one of the other sampled individuals was a female and tissue could have been harvested, yet only the testes were included in the reference transcriptome sequencing.

2. For the sentence from line 136-140 the authors later reference a paper for this, but the citation should probably be included here as well and addressed heteromyid rodents, not just Dipodomys.

3. Lines 138-142 Did the alignments produced contain insertions/deletions or internal stop codons? If so how were these treated for the PAML analysis? The results of the branch-sites test can be sensitive to alignment errors and with a small number of comparisons the alignments can be inspected manually to ensure this does not occur.

4. Line 143 Clustal-Omega is usually used as a multiple sequence aligner, can the authors provide details on what method it uses for producing a tree and whether branch lengths were provided to PAML or estimated in PAML?

5. This may be something planned in subsequent work but could the authors have provided kidney expression data for the 15 additional individuals or tested for differences in expression between the individuals of different sex?

Minor comments:

Line 95, do the authors mean PHRED < 2 or PHRED <20?

Line 109 should this say "using default settings"?

Validity of the findings

Major comments:

1. The authors mention calculating the site frequency spectrum for their data in line 133, did anything come of this analysis?

2. Is anything known about the demographic history of this population? As the authors acknowledge, the patterns used to infer selection according to Tajima's D can also be produced from demographic events and the authors should provide any data that exists on the population history. If this data does not exist the authors should state that this and include demography as a possible explanation of their data in their conclusions about tables 3 and 4.

3. Do the authors have data on Tajima's D for either of the genes tested in the branch sites test? If so they should report these values.

Minor comments:

Line 200: Do the authors mean complete coding sequence or open reading frame rather than 'complete exons'?

Comments for the author

In this study the authors characterized the transcriptome of four separate tissues for an individual Peromyscus eremicus and conducted RNA-seq of kidney tissue of an additional 15 individuals to provide transcriptomic resources for the study of osmoregulation in this desert rodent. The study is sound in its methodology and provides a significant resource, however it does require some modifications and/or clarifications about some of the methodology and data before it could be published. In the above sections I provide suggestions and/or questions that should be addressed.

© 2014, PeerJ, Inc. PO Box 614 Corte Madera, CA 94976, USA