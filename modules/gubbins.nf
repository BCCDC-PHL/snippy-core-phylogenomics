process gubbins {
    cpus 8
    publishDir "${params.outdir}", mode: 'copy', pattern: "gubbins.*"
    input:
        path(alignment)

    output:
        path('gubbins.*')

    script:
    """
    run_gubbins.py \
      --threads 8 \
      -p gubbins \
      ${alignment}
    """
}