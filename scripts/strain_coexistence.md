# Assembly of two coexisting strains

## Data generation

20X of simulated were generated using the incomplete genomes

```
source /local/env/envsamtools-1.6.sh

wgsim -1 100 -2 100 -N 131400 rearranged.fa rearranged_reads_50X.1.fq rearranged_reads_50X.2.fq # 50x

```
 We can generate the following fof by adding simulated reads to a sample :

```
/groups/bipaa/bipaa-data/rawseq/Eukaryota/Arthropoda/Hemiptera/Aphidinae/Macrosiphini/Acyrthosiphon_pisum/speciaphid/137825.2_seqresults/L10Lap02.r.slx.gz	/groups/bipaa/bipaa-data/rawseq/Eukaryota/A
rthropoda/Hemiptera/Aphidinae/Macrosiphini/Acyrthosiphon_pisum/speciaphid/137825.2_seqresults/L10Lap02.f.slx.gz
 /groups/genscale/clemaitr/publication_MinYS/rearranged_reads_50X.2.fq  /groups/genscale/clemaitr/publication_MinYS/rearranged_reads_50X.2.fq
```

## MinYS assembly

```
MinYS.py -fof ./L10Lap02_sim.fof \
	-ref ./data/reference_genomes/LSR1.fa \
	-assembly-kmer-size 61 \
	-assembly-abundance-min 5 \
	-min-contig-size 400 \
	-gapfilling-kmer-size 51 \
	-gapfilling-abundance-min 3 \
	-max-nodes 2000 -max-length 30000 \
	-nb-cores 8 \
	-out L10Lap02_myzus_sim_run2.61_5_400_51_3


```
