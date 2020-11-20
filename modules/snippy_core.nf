process snippy_core {
    publishDir "${params.outdir}", mode: 'copy', pattern: "clean.full.aln"

    input:
    path(snippy_dirs)
    path(ref) 

    output:
    path('clean.full.aln')

    script:
    """
    snippy-core \
      --ref '${ref}' \
      $snippy_dirs
    snippy-clean_full_aln core.full.aln > clean.full.aln
    """
}