#!/bin/bash

# Will submit jobs metagenomic assembly of every sample

rootDir="/scratch/cguyomar/MinYS_paper"

dataDir=$rootDir/data
scriptDir=$rootDir/scripts/Megahit

fofDir=$dataDir/files_of_files

do for file in fofDir
  do sbatch $scriptDir/run_megahit.sh $file $rootDir
done

# When all jobs are done run blast_megahit_all.sh
