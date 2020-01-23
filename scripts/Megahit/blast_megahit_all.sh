#!/bin/bash

source /local/env/envblast+-2.5.0.sh
source /local/env/envR-3.2.2.sh

rootDir="/scratch/cguyomar/MinYS_paper"

fofDir=$rootDir/data/files_of_files
refDir=$rootDir/data/reference_genomes/
megahitResDir=$rootDir/results/Megahit
scriptDir=$rootDir/scripts/MegaHit/

index_refs=true

if [[ $index_refs ]]
  then makeblastdb -dbtype nucl -out $refDir/buchnera_plasmids -in $refDir/buchnera_plasmids.fa
fi

for ref in  myzus # LSR1 rearranged schyzaphis
  do if $index_refs
    then makeblastdb -dbtype nucl -out $refDir/$ref -in $refDir/$ref.fa
  fi
  for file in $(ls $fofDir)
      do assemblyDir=$megahitResDir/megahit.$file/
      blastn -query $assemblyDir/final.contigs.fa -db $refDir/$ref -out $assemblyDir/$ref.blast -outfmt "6 qseqid sseqid pident qlen length qstart qend sstart send evalue bitscore"
      Rscript filter_blast.R $assemblyDir/$ref.blast $assemblyDir/final.contigs.fa $assemblyDir/megahit.$file.$ref.fa

      # Finding and removing plasmid sequences :
      blastn -db $refDir/buchnera_plasmids -query $assemblyDir/megahit.$file.$ref.fa -outfmt 6 -out $assemblyDir/megahit.$file.$ref.plasmids.tsv
      cut -f1 $assemblyDir/megahit.$file.$ref.plasmids.tsv | uniq > $assemblyDir/megahit.$file.$ref.plasmids.contigs.lst
      python $scriptDir/remove_sequences.py $assemblyDir/megahit.$file.$ref.fa $assemblyDir/megahit.$file.$ref.plasmids.contigs.lst $assemblyDir/megahit.$file.$ref.nocontigs.fa
  done
done
