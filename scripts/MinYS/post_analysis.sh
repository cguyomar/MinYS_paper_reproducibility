#!/bin/bash

# - find all MinYS outputs (gfa) and put them in the dame directory (graphs)
# - apply filter_components (remove conected components smaller than 12kbp -> plasmid sequences)
# - apply gfa2fasta (write all gfa nodes in a fasta)
# - Use Bandage to make a picture
# - submit a slurm job for enumeration of paths

source /local/env/envconda.sh
conda activate ~/conda/env_minys

rootDir="/scratch/cguyomar/MinYS_paper"
minysDir="/home/genouest/genscale/cguyomar/conda/env_minys/bin/"  # Should be changed when all scripts are in $PATH for the conda env
bandageBin="~/bin/Bandage"  # Should Bandage by in the conda env?

# Initializing variables
scriptDir=$rootDir/scripts/MinYS
dataDir=$rootDir/data
resDir=$rootDir/results/MinYS

fofDir=$dataDir/files_of_files
poolList=$dataDir/pools.list
indList=$dataDir/individuals.list


runBandage=false


resDir=$rootDir/results/MinYS

for ref in LSR1 rearranged schyzaphis myzus
  do
  for file in $fofDir/*
    do sampleName=$(basename $file)

    # Pool/ind specific variables
    if [[ $sampleName =~ $(echo ^\($(paste -sd'|' $poolList)\)$) ]]; then
      expDir=$resDir/$sampleName.$ref.81_20_400_71_10
      gfaPrefix=$expDir/gapfilling/minia_k81_abundancemin_20_filtered_400_gapfilling_k71_abundancemin_10
    elif [[ $sampleName =~ $(echo ^\($(paste -sd'|' $indList)\)$) ]]; then
      expDir=$resDir/$sampleName.$ref.61_10_400_51_5
      gfaPrefix=$expDir/gapfilling/minia_k61_abundancemin_10_filtered_400_gapfilling_k51_abundancemin_5
    else
      echo "Invalid sample name"
    fi

    # removing small components
    python $minysDir/graph_simplification/filter_components.py $gfaPrefix.simplified.gfa $gfaPrefix.filtered.gfa 12000
    python $minysDir/graph_simplification/gfa2fasta.py $gfaPrefix.filtered.gfa $gfaPrefix.filtered.fa 500
    # We change the contig names because quast fails when they are too long
  	awk '/^>/{print ">contig" ++i; next}{print}' < $gfaPrefix.filtered.fa > $gfaPrefix.filtered.tmp && mv $gfaPrefix.filtered.tmp $gfaPrefix.filtered.fa

    # Submitting path enumeration
    sbatch $scriptDir/enumerate_paths.sh $gfaPrefix.filtered.gfa $expDir/path_enumeration
      #statements

    if $runBandage ; then
      $bandageBin image $gfaPrefix.filtered.gfa $gfaPrefix.filtered.svg
    fi

  done
done
