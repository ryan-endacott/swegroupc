#!/user/bin/python

import sys

""" 
read in the filename, the first three is submit course section
"""
i=4
filename=[]
while(i<len(sys.argv)):
	filename.append(sys.argv[i])
	i=i+1