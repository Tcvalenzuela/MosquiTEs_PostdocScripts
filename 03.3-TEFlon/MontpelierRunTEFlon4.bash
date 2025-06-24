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
TEflon2="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_collapse.py"
TEflon3="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_count.py"
TEflon4="/beegfs/data/tcarrasco/Programs/TEFLoN/teflon_genotype.py"
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


python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_10 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 167

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_11 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 171

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_12 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 160

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_13 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 137

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_14 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 175

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_15 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 144

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_16 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 163

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_17 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 160

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_18 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 181

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_19 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 159

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_1 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 160

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_20 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 163

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_21 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 156

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_2 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 152

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_3 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 166

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_4 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 154

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_5 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 160

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_6 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 149

python $TEflon1 -wd ${WD} \
 -d /beegfs/project/mosquites/aalbo1200g/TEFloN/Reference/${PREFIX}.prep_TF/\
 -s ${SAMPLES} -i Montpelier_France_7 \
 -l1 family -l2 order -q 20 -t $PPN\
 -sd 177

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