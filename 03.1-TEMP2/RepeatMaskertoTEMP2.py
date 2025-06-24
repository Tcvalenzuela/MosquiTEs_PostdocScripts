###This script is to bridge the gap between TEMP2 and RepeatMasker
#It is publish on the error page of TEMP2
#https://github.com/weng-lab/TEMP2/issues/20


import argparse

parser = argparse.ArgumentParser(description= "Select Kimura under param and create bed")
parser.add_argument("--RMfnaout", "-RepeatMasker_fnaout",  help="out of RepeatMasker .fna.out")
arg = parser.parse_args()
filehandle = open(arg.RMfnaout)
for line in filehandle:
	if line.startswith("SW"):
		continue
	stripped=line.split("\t")
	Chr=stripped[4]
	startChr=stripped[5]
	endChr=stripped[6]
	if stripped[9].startswith("("):
		continue
	if stripped[9].startswith("A-rich"):
		continue
	if stripped[9].startswith("G-rich"):
		continue
	else:
		TEname=stripped[9]
	if stripped[8].startswith("C"):
		strand="-"
	else:
		strand=stripped[8]

	print(str(Chr)+"\t"+str(startChr)+"\t"+str(endChr)+"\t"+str(TEname)+"\t"+"0"+"\t"+str(strand))