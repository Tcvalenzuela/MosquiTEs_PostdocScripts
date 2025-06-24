#!/bin/bash

#SBATCH --time=168:00:00 # Job time limit
#SBATCH -J MontTEFlonLoop # Job name
#SBATCH -o %x_%j.out # Output file name
#SBATCH -e %x_%j.err # Error file name
#SBATCH --cpus-per-task=15 # Number of CPUs on the same node
#SBATCH --mem=100G # Memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27 # Exclude specific nodes

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

conda activate Teflon
TEflon1="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon.v0.4.py"
bwa="/beegfs/data/tcarrasco/Programs/Conda/envs/TEFlon/bin/bwa"
samtools="/beegfs/data/tcarrasco/Programs/Conda/envs/TEFlon/bin/samtools"
TF="/beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/F5Manual.prep_TF/"
Samples="/beegfs/project/mosquites/aalbo1200g/TEFloN/Montpelier/SamplesMontpelier.txt"
WD="/beegfs/project/mosquites/aalbo1200g/TEFloN/Montpelier"


for file in $WD/*.sorted.bam
do sname=$(basename "$file"| sed 's*.sorted.bam**g')

python $TEflon1 -wd $WD -d $TF -s $Samples -i $sname -eb $bwa -es $samtools -l1 family -l2 family -q 0 -t 15
done 