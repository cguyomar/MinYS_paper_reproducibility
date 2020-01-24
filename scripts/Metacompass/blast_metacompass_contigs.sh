#!/bin/bash

# Metacompass assembly includes a complete metagenomic assembly of unmapped reads
# We filter out the contigs matching with a buchenra genome just like we did with Megahit
# We also ensure that all pilon contigs are kept (since they are built from the reference)

source /local/env/envblast+-2.5.0.sh
source /local/env/envR.sh


rootDir="/scratch/cguyomar/MinYS_paper"

fofDir=$rootDir/data/files_of_files
refDir=$rootDir/data/reference_genomes/
metacompassResDir=$rootDir/results/Metacompass
scriptDir=$rootDir/scripts/

index_refs=false


for ref in  myzus # LSR1 rearranged schyzaphis
  do if $index_refs
    then makeblastdb -dbtype nucl -out $refDir/$ref -in $refDir/$ref.fa
  fi
  for file in $(ls $fofDir)
      do echo $file
      assemblyDir=$metacompassResDir/metacompass.$ref.$file/
      blastn -query $assemblyDir/metacompass_output/metacompass.final.ctg.fa -db $refDir/$ref -out $assemblyDir/metacompass_output/$ref.blast -outfmt "6 qseqid sseqid pident qlen length qstart qend sstart send evalue bitscore"

      # Retaining Pilon contigs
      grep pilon $assemblyDir/metacompass_output/metacompass.final.ctg.fa | sed 's/^.//' > $assemblyDir/metacompass_output/pilon_contigs.lst

      # Extracting the contigs
      Rscript $scriptDir/Megahit/filter_blast.R $assemblyDir/metacompass_output/$ref.blast $assemblyDir/metacompass_output/metacompass.final.ctg.fa $assemblyDir/metacompass_output/metacompass.$ref.fa $assemblyDir/metacompass_output/pilon_contigs.lst
    done
done
