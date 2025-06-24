#!/bin/bash

#SBATCH --time=168:00:00 #job time limit
#SBATCH -J MontpelierTEfMapping #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=32 #ncpu on the same node
#SBATCH --mem=100G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27


source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

conda info --envs
echo =$(which samtools)
conda activate Teflon

REF="/beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/Reference_TEs.prep_MP/Reference_TEs.mappingRef.fa"
Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq"

mkdir /beegfs/project/mosquites/aalbo1200g//TEFloN/Montpelier
OUT="/beegfs/project/mosquites/aalbo1200g//TEFloN/Montpelier"
for file in $Fastq//Montpelier*//*_NoDup_1_val_1.fq.gz
do sname=$(basename "$file"| sed 's*_NoDup_1_val_1.fq.gz**g')
R1=${sname}_NoDup_1_val_1.fq.gz
R2=${sname}_NoDup_2_val_2.fq.gz

bwa mem -t 32 -Y $REF $Fastq//Montpelier*/$R1 $Fastq//Montpelier*/$R2 > ${OUT}/${sname}.sam
samtools view -Sb ${OUT}/${sname}.sam | samtools sort -@ 32 - -o ${OUT}/${sname}.sorted.bam
samtools index ${OUT}/${sname}.sorted.bam
rm ${OUT}/${sname}.sam
done
