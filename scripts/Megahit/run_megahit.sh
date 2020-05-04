#!/bin/bash

#SBATCH --cpus-per-task=8
#SBATCH --ntasks=1
#SBATCH --time=600:00
#SBATCH --mem=50G

# $1 : Sample name
# $2 : root directory of the git experiment repo

rootDir=$2

fofDir=$rootDir/data/files_of_files
resDir=$rootDir/results/Megahit

source /local/env/envmegahit-1.1.2.sh

in1=$(cut -f1 $fofDir/$1)
in2=$(cut -f2 $fofDir/$1)

megahit -1 $in1 -2 $in2 -o $resDir/megahit.$1 -m 0.5 -t 8
