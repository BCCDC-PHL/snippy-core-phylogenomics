# Snippy-Core -> Gubbins Pipeline

This pipeline runs `snippy` on a set of illumina paired-end samples.
It aligns reads against a reference genome using `bwa` and calls SNPs with `freebayes`.

Core SNPs are identified by `snippy-core`. `gubbins` is used to identify and filter recombinant loci.

## Inputs

- A .tsv file with three columns, with headers `sample_id`, `read_1`, `read_2`:

1. `sample_id` An identifier for the sample
2. `read_1` Path to the `R1` `.fastq.gz` sequence file
3. `read_2` Path to the `R2` `.fastq.gz` sequence file

- A reference .fasta file

## Running the pipeline

```
nextflow run main.nf --input samples.tsv --ref ref.fa --outdir outdir
```

## Conda environments

- snippy-4.4.5
- gubbins-2.4.1
- snp-sites-2.5.1


