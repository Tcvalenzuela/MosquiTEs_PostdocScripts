#!/bin/bash

#SBATCH --time=168:00:00 #job time limit
#SBATCH -J BayTEMP #jobname
#SBATCH -o %x_%j.out #output file name
#SBATCH -e %x_%j.err #error file name
#SBATCH --cpus-per-task=5 #ncpu on the same node
#SBATCH --mem=100G #memory reservation
#SBATCH --constraint='haswell|broadwell|skylake' 
#SBATCH --exclude=pbil-deb27

source /beegfs/home/tcarrasco/.bashrc
source /beegfs/data/tcarrasco/Programs/Conda/etc/profile.d/conda.sh
/beegfs/data/tcarrasco/Programs/Conda/condabin/conda init

baypass="/beegfs/data/tcarrasco/Programs/baypass_public/sources/g_baypass"
GenoPath="/beegfs/project/mosquites/aalbo1200g/TEMP2Loops/All"
CovFile="/beegfs/project/mosquites/aalbo1200g/Fastq/ppileupFiles/ClimateCovSubSample.txt"


$baypass -gfile $GenoPath/Chr1_merged_All_baypassAllelek3run -efile $CovFile -outprefix Chr1Allelek2CovMode
$baypass -gfile $GenoPath/Chr2_merged_All_baypassAllelek3run -efile $CovFile -outprefix Chr2Allelek2CovMode
$baypass -gfile $GenoPath/Chr3_merged_All_baypassAllelek3run -efile $CovFile -outprefix Chr3Allelek2CovMode
