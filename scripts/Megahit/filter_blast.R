#!/usr/bin/Rscript

# Read blast tabular output
# Select contigs with more than 50% blast coverage
# Output subset of the assembly with selected contigs

# Args : blast file, assembly file, outfile

library(GenomicRanges)
argv <- commandArgs(TRUE)

cov.thr <- 0.5

blast.file = argv[1]
assembly.file = argv[2]
outfile = argv[3]

select_contigs = function(blast_file){
  tab <- read.table(blast.file)
  contig.length <- aggregate(tab$V4,by=list(tab$V1),unique)

  blast=GRanges(tab$V1,IRanges(start=apply(tab[,6:7],1,min),end=apply(tab[,6:7],1,max)))

  # Merge overlapping hits
  aln.length <- data.frame(contig=as.character(seqnames(reduce(blast))),length=width(reduce(blast)))

  # Compute covered length by contig
  aln.length <- aggregate(aln.length$length,by=list(aln.length$contig),FUN=sum)

  res <- merge(contig.length,aln.length,by=1)

  return(as.character(res[res[,3]/res[,2]>cov.thr,1]))
}



filter_assembly = function(fasta.file,to.keep,outfile) {
  incon = file(fasta.file, "r")
  start = TRUE

  while ( TRUE ) {
    line = readLines(incon, n = 1)
    if ( length(line) == 0 ) {
      break
    }
    if (substr(line,1,1) == ">"){
      out=FALSE
      seqname = substring(line,2)
      seqname = strsplit(seqname,split=c(" "))[[1]][1]
      if (seqname %in% to.keep){
        out = TRUE
        if (start) {
          cat(line,file=outfile,append=FALSE,sep="\n")
          start = FALSE
        } else {
          cat(line,file=outfile,append=TRUE,sep="\n")
        }
      }
    } else {
      if (out){
        cat(line,file=outfile,append=TRUE,sep="\n")
      }
    }
  }
  close(incon)
}

hit.contigs = select_contigs(blast.file)
filter_assembly(assembly.file,hit.contigs,outfile)
