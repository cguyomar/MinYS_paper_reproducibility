#!/bin/bash
#SBATCH --mem=600G

#SBATCH --cpus-per-task=1
#SBATCH --ntasks=1
#SBATCH --time=600:00

# $1 : Sample name
# $2 : genome
# $3 : root directory of the git experiment repo

rootDir=$3

fofDir=$rootDir/data/files_of_files
resDir=$rootDir/results/NOVOPlasty/
refDir=$rootDir/data/reference_genomes
confDir=$rootDir/scripts/novoplasty/conf_files

in2=$(cut -f1 $fofDir/$1)
in1=$(cut -f2 $fofDir/$1)
confFile=$1.$2.conf

cp $rootDir/scripts/novoplasty/template.conf $confDir/$confFile

echo $in2

sed -i -e 's|${name}|'$1'\.'$2'|' $confDir/$confFile
sed -i -e 's|${ref}|'$refDir'/'$2'.fa|' $confDir/$confFile
sed -i -e 's|${read1}|'$in1'|' $confDir/$confFile
sed -i -e 's|${read2}|'$in2'|' $confDir/$confFile


/usr/bin/time -v perl ~/soft/NOVOPlasty/NOVOPlasty3.8.3.pl -c $confDir/$confFile

