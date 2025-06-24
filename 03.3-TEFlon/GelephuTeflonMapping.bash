#!/bin/bash

#SBATCH --time=168:00:00 #job time limit
#SBATCH -J GeleTEfMapping #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=10 #ncpu on the same node
#SBATCH --mem=100G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27


source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

conda activate Teflon

REF="/beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/Reference_TEs.prep_MP/Reference_TEs.mappingRef.fa"
Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq/MoreSamples/Gelephu"
OUT="/beegfs/project/mosquites/aalbo1200g//TEFloN/Gelephu"
export PATH="/beegfs/data/soft/samtools-1.9/bin/:$PATH"
mkdir -p $OUT
cd $OUT
for file in $Fastq/*_NoDup_1_val_1.fq.gz
do sname=$(basename "$file"| sed 's*_NoDup_1_val_1.fq.gz**g')

R1=${sname}_NoDup_1_val_1.fq.gz
R2=${sname}_NoDup_2_val_2.fq.gz

bwa mem -t 10 -Y $REF $Fastq/$R1 $Fastq/$R2 > $sname.sam
samtools view -Sb $sname.sam | samtools sort -@ 10 - -o $sname.sorted.bam

samtools index $sname.sorted.bam
rm ${OUT}/${sname}.sam

done
