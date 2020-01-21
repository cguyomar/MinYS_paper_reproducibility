#!/bin/bash

source /local/env/envblast+-2.5.0.sh
source /local/env/envR-3.2.2.sh

rootDir="/scratch/cguyomar/MinYS_paper"

fofDir=$rootDir/data/files_of_files
refDir=$rootDir/data/reference_genomes/
megahitResDir=$rootDir/results/Megahit

index_refs=true

for ref in LSR1 rearranged schyzaphis myzus
  do if index_refs
    then makeblastdb -dbtype nucl -out $refDir/$ref -in $refDir/$ref.fa
  fi
  for file in $(ls $fofDir)
      do assemblyDir=$megahitResDir/megahit.$file/
      blastn -query $assemblyDir/final.contigs.fa -db $refDir/$ref -out $assemblyDir/$ref.blast -outfmt "6 qseqid sseqid pident qlen length qstart qend sstart send evalue bitscore"
      Rscript filter_blast.R $assemblyDir/$ref.blast $assemblyDir/final.contigs.fa $assemblyDir/megahit.$file.$ref.fa
  done
done
