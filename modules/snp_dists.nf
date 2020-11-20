process snp_dists {
    publishDir "${params.outdir}", mode: 'copy', pattern: "distances.tsv"
    input:
    path(alignment)

    output:
    path('distances.tsv')

    script:
    """
    snp-dists \
      '${alignment}' \
      > distances.tsv
    """
}
