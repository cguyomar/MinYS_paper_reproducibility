# Documentation to reproduce experiments of the MinYS paper

The scripts are intended to be run on the (GenOuest computing cluster)[https://www.genouest.org/], they can easily be adapted to other HPC systems.

## Todo :
- update some paths in the script


## Initialization

Cloning this repository will generate a suitable directory structure :
- `./data` contains reference genomes, and paths to dataset on the GenOuest cluster (SRA identifiers available in *Guyomar et al. 2019*)
- `./scripts` contrains the scripts to run the analyses. Some editing may be required to adapt to your environment.
- By default, results will be stored in `./results`

When not used on the GenOuest cluster, pea aphid sequencing data must be downloaded from SRA and fof files have to be updated with the resulting file paths. All SRA identifiers are given in the file (data/sra_identifiers.tsv)[data/data/sra_identifiers.tsv].

## Environment set-up

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

## Targetted assembly jobs

These scripts will submit targetted assembly jobs for: each sample $\times$ each reference genome  $\times$ each tool. All results are put in the `./results/` folder.

### MinYS

All the MinYS jobs can be run by executing:

```
./scripts/MinYS/submit_all_minys.sh
```

The script will: 

* read files of files in `data/files_of_files/`, 
* evaluate whether it is a pool or individual sequencing, 
* and submit 4 MinYS jobs (for the 4 reference genomes).

#### Post-analysis

For comparison with other approaches, the output of MinYS was further analyzed. This notably includes the enumeration and comparison of genomic paths extracted from the output gfa file, as described in the paper.

```
./scripts/MinYS/post_analysis.sh
```

### Metacompass

```
# run Metacompass
./scripts/Metacompass/submit_all_metacompass.sh
# contig filtering with blast using the different reference genomes.
./scripts/Metacompass/blast_metacompass_contigs.sh
```

### Megahit

```
# run Megahit
./scripts/Megahit/submit_all_megahit.sh
# contig filtering with blast using the different reference genomes.
./scripts/Megahit/blast_megahit_all.sh
```


## Result analyses

## Paper figure generation
