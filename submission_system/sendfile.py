#!/user/bin/python

import sys

""" 
read in the filename, the first three is submit course section
"""
i=0
filefolder=[]
while(i<3):
	filefolder.append(sys.argv[i])
	i++


i=3
filename=[]
while(i<len(sys.argv)):
	filename.append(sys.argv[i])
	i=i+1



i=0
while(i<len(filename)):
	files = {filename[i]: open('report.xls', 'rb')}
	r = requests.post(url, files=files)
	r.text
	r.request.get(url)
	r.status_code
