#!/bin/bash

#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --time=600:00
#SBATCH --mem=50G

# $1 : reference genome
# $2 : sample name
# $3 : root directory of the experiment repo

rootDir=$3
refDir=$rootDir/data/reference_genomes
fofDir=$rootDir/files_of_files
nbCore=8

# Metacompass is not available on bioconda. load genouest environment :
source /local/env/envconda.sh
source /local/env/envsamtools-1.6.sh
source /local/env/envmegahit-1.1.2.sh
source /local/env/envblast+-2.5.0.sh
source /local/env/envjava-1.8.0.sh
export PATH=~cguyomar/soft/meryl-r2013/meryl:$PATH
export PATH=~cguyomar/soft/mash-Linux64-v2.1.1:$PATH
source activate ~cguyomar/conda/env_snakemake  # also contains  bowtie2-2.3.4.3

in=$(sed -e 's/\\t/,/g' $fofDir/$2)

/usr/bin/time -v ~cguyomar/git/MetaCompass/go_metacompass.py -r $refDir/$1.fa \
					-P $in \
					-o metacompass.$2.$1 \
					-m 1 -t $nbCore  \
