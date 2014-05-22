from Bio import SeqIO
import sys
import os

#usage python /home/matthew/Desktop/python/fq2fa.py .fq .fa

count = SeqIO.convert(sys.argv[1], "fastq", sys.argv[2], "fasta")
