process snp_sites {

  publishDir "${params.outdir}", mode: 'copy', pattern: "clean.core.aln"

  input:
  path(alignment)

  output:
  path('clean.core.aln')

  script:
  """
  snp-sites \
    -c '${alignment}' \
    > clean.core.aln
  """
}
