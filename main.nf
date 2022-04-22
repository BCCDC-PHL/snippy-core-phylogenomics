#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { snippy_core } from './modules/snippy_core.nf'
include { snp_sites } from './modules/snp_sites.nf'
include { snp_dists as snp_dists_core } from './modules/snp_dists.nf'
include { snp_dists as snp_dists_core_recomb_filtered } from './modules/snp_dists.nf'
include { clonalframeml } from './modules/clonalframeml.nf'
include { maskrc_svg } from './modules/maskrc_svg.nf'
include { iqtree_pre_recombination_filtering } from './modules/iqtree.nf'
include { iqtree_post_recombination_filtering } from './modules/iqtree.nf'


workflow {
  if (params.samplesheet_input != 'NO_FILE') {
    ch_snippy_dirs = Channel.fromPath(params.samplesheet_input).splitCsv(header: true).map{ it -> [it['ID'], it['SNIPPY_DIR']] }.map{ it -> it[1] }
  } else {
    ch_snippy_dirs = Channel.fromPath("${params.snippy_dirs}/*", type: 'dir', maxDepth: 1)
  }
  
  
  ch_ref = Channel.fromPath( "${params.ref}", type: 'file')
  
  if (params.mask == "NO_FILE") {
    ch_mask = Channel.fromPath("$baseDir/assets/mask.bed", checkIfExists: true)
  } else {
    ch_mask = Channel.fromPath("$baseDir/assets/mask.bed", checkIfExists: true)
  }

  main:

  snippy_core(ch_snippy_dirs.collect().combine(ch_ref).map{ it -> [it[0..-2], it[-1]] }.combine(ch_mask))

  iqtree_pre_recombination_filtering(snippy_core.out.full_alignment)

  clonalframeml(iqtree_pre_recombination_filtering.out.combine(snippy_core.out.full_alignment))

  maskrc_svg(snippy_core.out.full_alignment.combine(clonalframeml.out).map{ it -> [it[0], it[1..-1]] })

  snp_sites(maskrc_svg.out.alignment)

  iqtree_post_recombination_filtering(snp_sites.out)
  
  snp_dists_core(snippy_core.out.core_alignment)

  snp_dists_core_recomb_filtered(snp_sites.out)

}
