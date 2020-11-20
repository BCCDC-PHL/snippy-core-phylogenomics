process iqtree {
    publishDir "${params.outdir}", mode: 'copy', pattern: "clean.full.aln.*"
    input:
        path(alignment)

    output:
        path('clean.full.aln.*')

    script:
    """
    iqtree \
      -nt 16 \
      -t PARS \
      -ninit 2 \
      -m GTR+G \
      -s ${alignment}
    """
}
