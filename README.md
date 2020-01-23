# Documentation to reproduce experiments of the MinYS paper

Intended to run analyses on the Genouest cluster, can be adapted to other HPC systems

## Todo :
- new release of MinYS for conda
- update some paths in the script
- Add notebook for the figure
- Add deletions generation/experiments


## Initialize

Cloning this repository will generate a suitable directory structure :
- `./data` contains reference genomes, and paths to dataset on the GenOuest cluster (SRA identifiers available in *Guyomar et al. 2019*)
- `./scripts` contrains the scripts to run the analyses. Some editing may be required to adapt your enviornment
- By default, results will be stored in `./results`

## Set-up environment

- MinYS :
```
conda install -c bioconda minys=???
```
- Megahit :
```
conda install -c bioconda megahit=1.1.2
```
- Metacompass :
Metacompass is not available as a conda environment. Please follow the (documentation)[https://github.com/marbl/MetaCompass/blob/master/README.md].
The experiments described in the paper were performed using the development version at commit `3d187c64324034b7d579e6b6cfe1b366ad94e7a6` (9/04/2019)

## Submit jobs

### MinYS

All the MinYS jobs can be run by executing submit_all_minys.sh
The script will read files of files in data/files_of_files, evaluate wether it is a pool or individual sequencing, and submit 4 MinYS jobs (for the 4 reference genomes)

#### Post-analysis

For comparison with other approaches, the output of MinYS was further analyzed. This notably includes the enumeration of comparison of paths within the gfa, as described in the paper.
This can be run using `post_analysis.sh`

### Metacompass

- Metacompass is not available as a conda environment
- run `submit_all_metacompass.sh`, that will submit slurm jobs for each sample

### Megahit

2 steps are required :
- `submit_all_megahit.sh` will run one Slurm megahit job for each sample.
- Once all the assemblies are done, `blast_megahit_all.sh` will filter out contigs using the different reference genomes.


## Analyze jobs results

## Create paper figures
