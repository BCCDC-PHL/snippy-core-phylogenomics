process maskrc_svg {

    cpus 8

    publishDir "${params.outdir}", mode: 'copy', pattern: "*-maskrc.{aln,svg}"

    input:
    tuple path(alignment), path(cfml_out)

    output:
    path('cfml-maskrc.aln'), emit: alignment
    path('cfml-maskrc.svg'), emit: svg

    script:
    """
    maskrc-svg.py \
      --aln ${alignment} \
      --out cfml-maskrc.aln \
      --svg cfml-maskrc.svg \
      cfml
    """
}