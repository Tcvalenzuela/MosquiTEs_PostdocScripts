#!/bin/bash

#SBATCH --time=168:00:00 #job time limit
#SBATCH -J KrasMapFree #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=10 #ncpu on the same node
#SBATCH --mem=30G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init
# Paths
reference="/beegfs/data/tcarrasco/Reference/GCF_035046485.1_AalbF5_genomic.fna"
Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq/MoreSamples/Krasnodar/"
OUT="/beegfs/project/mosquites/aalbo1200g/Detettore/Krasnodar"
conda activate base
cd $OUT
# Loop through files
for file in $Fastq/*_NoDup_1_val_1.fq.gz; do
    sname=$(basename "$file" | sed 's/_NoDup_1_val_1.fq.gz//g')  # Extract sample name
    # Check if BAM file already exists
    if [ -e "${sname}MapFreely_sorted.bam" ]; then
        continue
    fi
    # Define R1 and R2 paths
    R1="$file"
    R2="${file/_NoDup_1_val_1.fq.gz/_NoDup_2_val_2.fq.gz}"  # Replace `_1` with `_2` for the second pair

    # Run BWA-MEM2 and process output
	bwa-mem2 mem -t 10 "$reference" "$R1" "$R2" | \
	samtools view -b | \
	samtools sort -o "${sname}MapFreely_sorted.bam"
	samtools index "${sname}MapFreely_sorted.bam"
done
