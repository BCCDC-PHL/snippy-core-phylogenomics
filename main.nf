#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { snippy_core }                from './modules/snippy_core.nf'
include { snp_sites }                  from './modules/snp_sites.nf'
include { snp_dists }                  from './modules/snp_dists.nf'
include { gubbins }                    from './modules/gubbins.nf'
include { iqtree }                     from './modules/iqtree.nf'
include { shiptv }                     from './modules/shiptv.nf'
include { pipeline_provenance }        from './modules/provenance.nf'
include { collect_provenance }         from './modules/provenance.nf'


workflow {
  ch_workflow_metadata = Channel.value([
	workflow.sessionId,
	workflow.runName,
	workflow.manifest.name,
	workflow.manifest.version,
	workflow.start,
    ])

  ch_pipeline_provenance = pipeline_provenance(ch_workflow_metadata)

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
    ch_alignment = gubbins.out.filtered_polymorphic_sites

  } else {
    ch_alignment = snippy_core.out.clean_full_alignment
  }
  
  snp_sites(ch_alignment)

  iqtree(snp_sites.out.clean_core_aln)

  snp_dists(snp_sites.out.clean_core_aln)
  
  shiptv(iqtree.out.tree)

  // Provenance collection processes
  // The basic idea is to build up a channel with the following structure:
  // [provenance_file_1.yml, provenance_file_2.yml, provenance_file_3.yml...]]
  // ...and then concatenate them all together in the 'collect_provenance' process.

   ch_pipeline_prov = pipeline_provenance.out
   ch_snippy_prov = snippy_core.out.provenance
   ch_snp_sites_prov = snp_sites.out.provenance
   ch_iqtree_prov = iqtree.out.provenance
   ch_shiptv_prov = shiptv.out.provenance

// Add gubbins output if applicable and combine these channels in the desired order

  if (!params.skip_gubbins) {
    ch_gubbins_prov = gubbins.out.provenance

    ch_provenance = ch_pipeline_prov
    .concat(ch_snippy_prov)
    .concat(ch_gubbins_prov)
    .concat(ch_snp_sites_prov)
    .concat(ch_iqtree_prov)
    .concat(ch_shiptv_prov)
    .collect()

  } else {
    ch_provenance = ch_pipeline_prov
    .concat(ch_snippy_prov)
    .concat(ch_snp_sites_prov)
    .concat(ch_iqtree_prov)
    .concat(ch_shiptv_prov)
    .collect()
  }


  collect_provenance(ch_provenance)

}
