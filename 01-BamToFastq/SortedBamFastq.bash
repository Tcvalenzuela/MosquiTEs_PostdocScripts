#!/bin/bash

#SBATCH --time=100:00:00 #job time limit
#SBATCH -J SortedBamFastq #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=10 #ncpu on the same node
#SBATCH --mem=10G #memory reservation


folder="/beegfs/project/mosquites/aalbo1200g/bams"
Out="/beegfs/project/mosquites/aalbo1200g/"
Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq/"


for file in $folder/*.bam
do  sname=$(basename "$file"| sed 's*.bam**g')
samtools sort -@ 10 -n  -o $Out/${sname}_qsort.bam $folder/$sname.bam && rm $folder/$sname.bam
/beegfs/data/tcarrasco/Programs/Conda/envs/bowtie/bin/bamToFastq -i $Out/${sname}_qsort.bam -fq $Fastq/${sname}_1.fq -fq2 $Fastq/${sname}_2.fq 2>$Fastq/${sname}_1.err && rm $Out/${sname}_qsort.bam
echo "Done with " $file
done 
