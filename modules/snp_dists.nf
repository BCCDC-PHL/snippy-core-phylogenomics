process snp_dists {

    publishDir "${params.outdir}", mode: 'copy', pattern: "${alignment.baseName}.distances.tsv"

    input:
    path(alignment)

    output:
    path("${alignment.baseName}.distances.tsv")

    script:
    """
    snp-dists \
      '${alignment}' \
      > ${alignment.baseName}.distances.tsv
    """
}
