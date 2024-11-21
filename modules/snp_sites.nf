process snp_sites {

  publishDir "${params.outdir}", mode: 'copy', pattern: "clean.core.aln"

  input:
  path(alignment)

  output:
  path('clean.core.aln'), emit: clean_core_aln
  path("snp_sites_provenance.yml"), emit: provenance

  script:
  """
  printf -- "- process_name: snp_sites\\n"                                                        >> snp_sites_provenance.yml
  printf -- "  tools:\\n"                                                                         >> snp_sites_provenance.yml
  printf -- "    - tool_name: snp_sites\\n"                                                       >> snp_sites_provenance.yml
  printf -- "      tool_version: \$(snp-sites -V | awk '{print ${2}}')\\n"                        >> snp_sites_provenance.yml
  printf -- "      parameters:\\n"                                                                >> snp_sites_provenance.yml
  printf -- "        - parameter: -c\\n"                                                          >> snp_sites_provenance.yml
  printf -- "          value: '${alignment}'\\n"                                                  >> snp_sites_provenance.yml

  snp-sites \
    -c '${alignment}' \
    > clean.core.aln
  """
}
