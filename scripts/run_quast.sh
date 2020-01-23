source /local/env/envconda.sh
source activate ~/conda/env_quast/ # quast 5.0.2

## MinYS

rootDir=/scratch/cguyomar/MinYS_paper/

resDir=$rootDir/results/MinYS


for sampleDir in $(find $resDir -maxdepth 1 -type d)
  # Select largest path for each component
  # Concatenate the paths for each component into an assembly
  do for compDir in $sampleDir/path_enumeration/*
    do largest=$(ls -S $compDir/ | head -1)
    echo $largest
    cp $compDir/$largest $compDir/largest.fa
  done
  cat $sampleDir/path_enumeration/comp_*/largest.fa > $sampleDir/assembly.fa
  awk '/^>/{print ">component_" ++i; next}{print}' < $sampleDir/assembly.fa > $sampleDir/tmp.fa
  mv $sampleDir/tmp.fa $sampleDir/assembly.fa
done

quast.py $resDir/*/assembly.fa -R $rootDir/data/reference_genomes/LSR1.fa -o $rootDir/quast/MinYS

## Assembly part of MinYS (minia)
resDir=$rootDir/results/MinYS

# We need to rename assembly files so we can recognize sample and genome names in the quast output
while read line
  do for genome in LSR1 myzus rearranged schyzaphis
      do cp $resDir/$line.$genome.61_10_400_51_5/assembly/minia_k61_abundancemin_10_filtered_400.fa $resDir/$line.$genome.61_10_400_51_5/assembly/$line.$genome.minia.fa
  done
done < $rootDir/data/individuals.list
# Same for the pooles
while read line
  do for genome in LSR1 myzus rearranged schyzaphis
      do cp $resDir/$line.$genome.81_20_400_71_10/assembly/minia_k81_abundancemin_20_filtered_400.fa $resDir/$line.$genome.81_20_400_71_10/assembly/$line.$genome.minia.fa
  done
done < $rootDir/data/pools.list

quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/*/assembly/*minia.fa -o $rootDir/quast/minia


## Megahit
resDir=$rootDir/results/MegaHit/

quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/*/contigs.noplasmid.myzus.fa -o $rootDir/quast/Megahit


## Metacompass

resDir=$rootDir/results/Metacompass

quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/metacompass.myzus.*/metacompass_output/metacompass.myzus.fa -o $rootDir/quast/Metacompass
