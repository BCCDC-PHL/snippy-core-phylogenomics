process snp_dists {

  publishDir "${params.outdir}", mode: 'copy', pattern: "${alignment.baseName}.distances.tsv"

  input:
  path(alignment)

  output:
  path("${alignment.baseName}.distances.tsv"), emit: distances
  path("snp_dists_provenance.yml"), emit: provenance

  script:
  """
  printf -- "- process_name: snp_dists\\n"                                                        >> snp_dists_provenance.yml
  printf -- "  tools:\\n"                                                                         >> snp_dists_provenance.yml
  printf -- "    - tool_name: snp-dists\\n"                                                       >> snp_dists_provenance.yml
  printf -- "      tool_version: \$(snp-dists -v | awk '{print \$2}')\\n"                        >> snp_dists_provenance.yml

  snp-dists \
    '${alignment}' \
    > ${alignment.baseName}.distances.tsv
  """
}
