import distance
import sys
import os


str1='ATGC'
str2='ATTG'

dist = distance.hamming(sys.argv[1], sys.argv[2])
print dist