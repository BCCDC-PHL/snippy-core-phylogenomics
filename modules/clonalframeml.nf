process clonalframeml {

    publishDir "${params.outdir}", mode: 'copy', pattern: "cfml.*"

    input:
    tuple path(tree), path(alignment)

    output:
    path('cfml.*')

    script:
    """
    ClonalFrameML \
      ${tree} \
      ${alignment} \
      cfml
    """
}