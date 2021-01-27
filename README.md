# Snippy-Core -> Gubbins Pipeline

This pipeline runs `snippy` on a set of illumina paired-end samples.
It aligns reads against a reference genome using `bwa` and calls SNPs with `freebayes`.

Core SNPs are identified by `snippy-core`. `gubbins` is used to identify and filter recombinant loci.

## Inputs

- `--fastq_input`: A directory containing paired `.fastq.gz` files
- `--ref`: A reference `.fasta` file

## Running the pipeline

```
nextflow run main.nf -profile conda --cache ~/.conda/envs --fastq_input <path_to_fastq_dir> --ref ref.fa --outdir outdir
```



