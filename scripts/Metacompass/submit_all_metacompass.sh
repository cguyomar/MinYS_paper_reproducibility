#!/bin/bash

# Will submit jobs for every sample/reference genomes

rootDir="/scratch/cguyomar/MinYS_paper"

fofDir=$dataDir/files_of_files
scriptDir=$rootDir/scripts/Metacompass

for ref in myzus # LSR1 rearranged schyzaphis
  do for file in $fofDir
    do sbatch $scriptDir/run_metacompass.sh $ref $file $rootDir
  done
done
