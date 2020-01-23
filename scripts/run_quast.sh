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

quast.py $resDir/*/assembly.fa -R $rootDir/data/reference_genomes/LSR1.fa

## Assembly part of MinYS (minia)
quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/*/assembly/*filtered*.fa


## Megahit
resDir=$rootDir/results/MegaHit/

quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/*/contigs.noplasmid.myzus.fa -o $rootDir/quast/Megahit


## Metacompass

resDir=$rootDir/results/Metacompass

quast.py -R $rootDir/data/reference_genomes/LSR1.fa $resDir/metacompass.myzus.*/metacompass_output/metacompass.myzus.fa -o $rootDir/quast/Myzus
