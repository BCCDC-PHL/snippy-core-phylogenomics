#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { snippy } from './modules/snippy.nf'
include { snippy_core } from './modules/snippy_core.nf'
include { snp_sites } from './modules/snp_sites.nf'
include { snp_dists } from './modules/snp_dists.nf'
include { gubbins } from './modules/gubbins.nf'
include { iqtree } from './modules/iqtree.nf'

if (params.profile){
    println("Profile should have a single dash: -profile")
    System.exit(1)
}

workflow {
  ch_fastq = Channel.fromFilePairs( "${params.fastq_input}/*_R{1,2}*.fastq.gz", type: 'file', maxDepth: 1)
  ch_ref = Channel.fromPath( "${params.ref}", type: 'file')

  main:

  snippy(
    ch_fastq
     .combine(ch_ref)
  )

  snippy_core(
    snippy.out.collect(),
    ch_ref
  )
  
  gubbins(snippy_core.out)

  snp_sites(
    snippy_core.out
  )
  
  snp_dists(
    snp_sites.out
  )

  iqtree(
    snippy_core.out
  )
}
