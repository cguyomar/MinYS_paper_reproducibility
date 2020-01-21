#!/bin/bash

# Will submit jobs for every sample/reference genomes

rootDir="/scratch/cguyomar/MinYS_paper"

dataDir=$rootDir/data
resDir=$rootDir/results
scriptDir=$rootDir/scripts/MinYS

fofDir=$dataDir/files_of_files
poolList=$dataDir//pools.list
indList=$dataDir/individuals.list

for ref in LSR1 rearranged schyzaphis myzus
  do
  for file in $fofDir/*
    do sampleName=$(basename $file)
    echo $file
    echo $sampleName
    if [[ $sampleName =~ $(echo ^\($(paste -sd'|' $poolList)\)$) ]]; then
        sbatch $scriptDir/run_minys_pool.sh $ref $sampleName $rootDir
    elif [[ $sampleName =~ $(echo ^\($(paste -sd'|' $indList)\)$) ]]; then
      sbatch $scriptDir/run_minys_pool.sh $ref $sampleName $rootDir

        echo nothing done
    else
      echo "$file not found"
    fi
  done
done
