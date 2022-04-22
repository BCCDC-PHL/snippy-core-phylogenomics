# Snippy Phylogenomics

Core SNPs are identified by `snippy-core`. [`ClonalFrameML`](https://github.com/xavierdidelot/ClonalFrameML) and [`maskrc-svg`](https://github.com/kwongj/maskrc-svg)
are used to identify and filter recombinant loci.

## Inputs

- `--snippy_dirs`:
- `--ref`: A reference `.fasta` file

## Usage

```
nextflow run dfornika/snippy-phylogenomics-nf \
  --snippy_dirs </path/to/snippy_output_dirs> \
  --ref ref.fa \
  [--mask mask.bed] \
  --outdir outdir
```

## Outputs


