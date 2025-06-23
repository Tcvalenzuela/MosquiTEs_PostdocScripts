#!/bin/bash

#SBATCH --time=168:00:00 # Job time limit
#SBATCH -J KrasDete # Job name
#SBATCH -o %x_%j.out # Output file name
#SBATCH -e %x_%j.err # Error file name
#SBATCH --cpus-per-task=5 # Number of CPUs on the same node
#SBATCH --mem=50G # Memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27 # Exclude specific nodes

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init
conda activate detettore

TEDB="/beegfs/data/tcarrasco/DB/TEMP2.2_Annot_extended_consensi_16_11_23.fa"
BED="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomic.fnaMOD2.gff3"
Reference="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomic.fna"
bwa_index="/beegfs/data/tcarrasco/RepeatMasker/F5NewManual/F5/GCF_035046485.1_AalbF5_genomic.fna"

OUT="/beegfs/project/mosquites/aalbo1200g/Detettore/Krasnodar"

Path="/beegfs/data/tcarrasco/Programs/detettore/"

cd $OUT

for bam in $OUT/*.bam
do sname=$(basename "$bam"| sed 's*MapFreely_sorted.bam**g')
if [ -e "${sname}.detettore.vcf.gz" ]; then
        continue
    fi

detettore \
  -b $bam \
  -r $Reference \
  -a $BED \
  -t $TEDB \
  -o $OUT/$sname \
  -m tips \
   --include_invariant

done 