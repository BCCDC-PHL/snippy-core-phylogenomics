# Snippy Phylogenomics

Core SNPs are identified by `snippy-core`. [`gubbins`](https://github.com/nickjcroucher/gubbins) is used to identify and filter recombinant loci.


```mermaid
flowchart TD
  snippy_dirs[snippy_dirs] --> snippy_core[snippy_core]
  ref[reference.fasta] --> snippy_core
  snippy_core --> core_aln[core.aln]
  snippy_core --> core_variants[core.vcf]
  snippy_core --> core_stats[core.vcf]
  snippy_core --> full_alignment[core.full.aln]
  snippy_core --> clean_full_alignment[clean.full.aln]
  clean_full_alignment -->|process WITH gubbins| gubbins(gubbins)
  gubbins --> filtered_polymorphic_sites[gubbins.filtered_polymorphic_sites.fasta]
  gubbins --> recombination_predictions_gff[gubbins.recombination_predictions.gff]
  gubbins --> per_branch_statistics[gubbins.per_branch_statistics.tsv]
  clean_full_alignment --> |process WITHOUT gubbins| snp_sites
  snp_sites -->  snp_sites_out[clean.core.aln]
  filtered_polymorphic_sites --> snp_sites
  snp_sites_out --> iqtree
  iqtree --> iqtree_out[alignment.treefile]
  snp_sites_out --> snp_dists
  snp_dists --> snp_dists_out[alignment.distances.tsv]
  iqtree_out --> shiptv
  shiptv --> tree_html[tree.html]  
  
```

Note: the process WITHOUT gubbins occurs if --skip_gubbins is true, or if there are only two samples input as gubbins requires a minimum of 3 samples.

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


