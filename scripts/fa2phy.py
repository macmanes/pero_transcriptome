from Bio import SeqIO
import sys
import os

count = SeqIO.convert(sys.argv[1], "fasta", sys.argv[2], "phylip-sequential")
