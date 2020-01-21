#!/bin/bash

#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --time=600:00
#SBATCH --mem=50G

# $1 : reference genome name
# $2 : sample name
# $3 : root directory of the experiment repo

rootDir=$3

fofDir=$rootDir/data//files_of_files
refDir=$rootDir/data/reference_genomes
resDir=$rootDir/results/MinYS
nbCore=8

source /local/env/envconda.sh
conda activate ~/conda/env_minys

/usr/bin/time -v MinYS.py -fof $fofDir/$2 \
	-ref $refDir/$1.fa \
	-assembly-kmer-size 61 \
	-assembly-abundance-min 10 \
	-min-contig-size 400 \
	-gapfilling-kmer-size 51 \
	-gapfilling-abundance-min 5 \
	-max-nodes 300 -max-length 50000 \
	-nb-cores $nbCore \
	-out $resDir/$2.$1.61_10_400_51_5
