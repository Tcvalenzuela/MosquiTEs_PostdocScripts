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
bwa="/beegfs/data/tcarrasco/Programs/Conda/envs/TEFlon/bin/bwa"
export PATH="/beegfs/data/soft/samtools-1.9/bin/:$PATH"
SAMPLES="/beegfs/project/mosquites/aalbo1200g/TEFloN/Montpelier/SamplesMontpelier.txt"
PREFIX="Reference_TEs"
PPN="15"
WD="/beegfs/project/mosquites/aalbo1200g/TEFloN/Montpelier"


##Run TEFLoN
##teflon discover

TEflon1="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon.v0.4.py"
TEflon2="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_collapse.py"
TEflon3="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_count.py"
TEflon4="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_genotype.py"
for file in $WD/*.sorted.bam
do sname=$(basename "$file"| sed 's/\.sorted\.bam//')
python $TEflon1 \
    -wd ${WD} \
    -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/ \
    -s ${SAMPLES} \
    -i ${sname} \
    -l1 family \
    -l2 order \
    -q 20 \
    -t $PPN
    -sd 2000
done

##teflon collapse
python $TEflon2 \
    -wd ${WD} \
    -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/ \
    -s ${SAMPLES} \
    -n1 1 \
    -n2 1 \
    -q 20 \
    -t $PPN

##teflon count
for file in $WD/*.sorted.bam
do sname=$(basename "$file"| sed 's/\.sorted\.bam//')
python $TEflon3 \
    -wd ${WD} \
    -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/ \
    -s ${SAMPLES} \
    -i ${sname} \
    -l2 order \
    -q 20 \
    -t $PPN
done
##teflon genotype

python $TEflon4 \
    -wd ${WD} \
    -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/ \
    -s ${SAMPLES} \
    -lt 1 \
    -ht 100 \
    -dt pooled

