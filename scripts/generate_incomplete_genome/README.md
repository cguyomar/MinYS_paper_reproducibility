- ## Simulating deletions  in Buchnera genome 

  ref genome :  ./data/reference_genomes/LSR1.fa ` (Acc NZ_ACFK01000001.1)

  

  ```
  python make_fixed_size_deletions.py -g ./data/reference_genomes/LSR1.fa -o rearranged -l 20000,20000,20000,10000,10000,10000,5000,5000,5000,5000,1000,1000,1000,1000,500,500,500,300,300,300 -s 50 -b
  ```

  Final files:

  - `rearranged.fasta` : rearranged genome sequence
  - `rearranged.del.bed` :coordinates of the 20 deletions