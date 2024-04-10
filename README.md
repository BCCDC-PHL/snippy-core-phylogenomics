[![Tests](https://github.com/BCCDC-PHL/snippy-core-phylogenomics/actions/workflows/tests.yml/badge.svg)](https://github.com/BCCDC-PHL/snippy-core-phylogenomics/actions/workflows/tests.yml)

# Snippy Phylogenomics

Core SNPs are identified by `snippy-core`. [`gubbins`](https://github.com/nickjcroucher/gubbins) is used to identify and filter recombinant loci.

## Inputs

- `--snippy_dirs`:
- `--ref`: A reference `.fasta` file

## Usage

```
nextflow run BCCDC-PHL/snippy-phylogenomics-nf \
  --snippy_dirs </path/to/snippy_output_dirs> \
  --ref ref.fa \
  [--mask mask.bed] \
  --outdir outdir
```

## Outputs


