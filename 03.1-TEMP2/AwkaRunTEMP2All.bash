#!/bin/bash

#SBATCH --time=168:00:00 #job time limit
#SBATCH -J AwkTEMP2 #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=20 #ncpu on the same node
#SBATCH --mem=40G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27

alias TEMP2='/beegfs/data/tcarrasco/Programs/TEMP2/TEMP2'
export PATH=/beegfs/data/tcarrasco/Programs/:$PATH
export PATH=/beegfs/data/tcarrasco/Programs/openssl-3.2.0:$PATH
alias python2.7='/usr/bin/python2.7'
alias gawk='/usr/bin/gawk'

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

conda activate TEMP-P2.7

TEDB="/beegfs/data/tcarrasco/DB/TEMP2.2_Annot_extended_consensi_16_11_23.fa"
Reference="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomic.fna"
bwa_index="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomic.fna"
OUT="/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/Awka/"
CPUS=20
BED="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomicTABS.fna.TEMP.bed"

mkdir -p $OUT

Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq/MoreSamples/Awka/"
for file in $Fastq/*_1.fq.gz
do  sname=$(basename "$file"| sed 's*_NoDup_1_val_1.fq.gz**g')

R1=$Fastq//"$sname"_NoDup_1_val_1.fq.gz
R2=$Fastq//"$sname"_NoDup_2_val_2.fq.gz


/beegfs/data/tcarrasco/Programs/TEMP2/TEMP2 insertion -d -l $R1 -r $R2 -I $bwa_index -g $Reference -R $TEDB -t $BED -o $OUT/$sname -c 20
done