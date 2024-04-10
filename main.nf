#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { snippy_core } from './modules/snippy_core.nf'
include { snp_sites }   from './modules/snp_sites.nf'
include { snp_dists }   from './modules/snp_dists.nf'
include { gubbins }     from './modules/gubbins.nf'
include { iqtree }      from './modules/iqtree.nf'
include { shiptv }      from './modules/shiptv.nf'


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
    ch_mask = Channel.fromPath(params.mask)
  }

  

  main:

  snippy_core(ch_snippy_dirs.collect().combine(ch_ref).map{ it -> [it[0..-2], it[-1]] }.combine(ch_mask))

  
  if (!params.skip_gubbins) {
  
    gubbins(snippy_core.out.clean_full_alignment)

    if (gubbins.out.filtered_polymorphic_sites != null) {
      ch_alignment = gubbins.out.filtered_polymorphic_sites
    } else {
    ch_alignment = snippy_core.out.clean_full_alignment
  }

    
  } else {
    ch_alignment = snippy_core.out.clean_full_alignment
  }
   


  snp_sites(ch_alignment)

  iqtree(snp_sites.out)

  snp_dists(snp_sites.out)
  
  shiptv(iqtree.out)

}
