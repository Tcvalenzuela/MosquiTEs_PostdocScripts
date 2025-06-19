#!/bin/bash
#SBATCH --time=168:00:00 #job time limit
#SBATCH -J TrimGaloreLoop #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=8 #ncpu on the same node
#SBATCH --mem=100G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27


export PATH=/beegfs/data/tcarrasco/Programs/:$PATH
export PATH=/beegfs/data/tcarrasco/Programs/openssl-3.2.0:$PATH
alias python2.7='/usr/bin/python2.7'
alias gawk='/usr/bin/gawk'

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

conda activate MultiQC

Fastq="/beegfs/project/mosquites/aalbo1200g/Fastq/"
DeleteDups="/beegfs/project/mosquites/aalbo1200g/Fastq/DeleteduplicatedReads.py"

cd $Fastq
for file in $Fastq/*_1.fq
do sname=$(basename "$file"| sed 's*_1.fq**g')
if [ -e "$Fastq//${sname}_2_val_2.fq" ]; then
                continue
        fi

R1=${sname}_1.fq
R2=${sname}_2.fq
python $DeleteDups --F $R1 --o ${sname}_NoDup_1.fq | python $DeleteDups --F $R2 --o ${sname}_NoDup_2.fq
rm $R1 $R2 
trim_galore -j 8 --length 90 --max_n 0.05 --paired ${sname}_NoDup_1.fq ${sname}_NoDup_2.fq
rm ${sname}_NoDup_1.fq ${sname}_NoDup_2.fq
done
