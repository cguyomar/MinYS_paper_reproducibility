#!/bin/bash

rootDir="/scratch/cguyomar/MinYS_paper"
dataDir=$rootDir/data

scriptDir=$rootDir/scripts/MinYS
fofDir=$dataDir/files_of_files

for ref in LSR1 rearranged schyzaphis myzus
  do
  for file in $fofDir/*
    do sampleName=$(basename $file)
    echo $file
    echo $sampleName
    sbatch $scriptDir/enumerate_paths.sh $ref $sampleName $rootDir
  done
done
