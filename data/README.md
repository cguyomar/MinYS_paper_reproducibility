# Data to reproduce experiments of the MinYS paper

[MinYS: Mine Your Symbiont by targeted genome assembly in symbiotic communities](https://www.biorxiv.org/content/10.1101/2019.12.13.875021v1) 
Guyomar C, Delage W, Legeai F, Mougel C, Simon JC, Lemaitre C 
BioRxiv **2019**, [doi:10.1101/2019.12.13.875021](https://www.biorxiv.org/content/10.1101/2019.12.13.875021v1)



This folder contains the data and/or links to get the data used in the paper:

* folder `files_of_files/` contains a text file for each sample giving the path to fastq sequencing files on the GenOuest cluster. 
* folder `reference_genomes/` contains the 4 *Buchnera aphidicola* reference genomes used in the paper
* `individuals.list` and `pool.list` contain the names of the individual (resp. pool) samples
* `sra_identifiers.tsv` contains the SRA identifiers of all sequencing files.



Additionnally a synthetic sequencing dataset has been produced to perform the "strain coexisentce" result. Reads are available at this link : [https://data-access.cesgo.org/index.php/s/0drzRw2dBt637Ob](https://data-access.cesgo.org/index.php/s/0drzRw2dBt637Ob). 

Note : they can also be re-generated (but not reproduced exactly) using the protocol described in [../scripts/strain_coexistence.md](../scripts/strain_coexistence.md).

