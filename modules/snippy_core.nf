process snippy_core {
    publishDir "${params.outdir}", mode: 'copy', pattern: "*.aln"
    publishDir "${params.outdir}", mode: 'copy', pattern: "core.vcf"
    publishDir "${params.outdir}", mode: 'copy', pattern: "core.tsv"

    input:
    tuple path(snippy_dirs), path(ref), path(mask)

    output:
    path('core.aln'), emit: core_alignment
    path('core.vcf'), emit: core_variants
    path('core.tsv'), emit: core_stats
    path('core.full.aln'), emit: full_alignment
    path('clean.full.aln'), emit: clean_full_alignment
    path("snippy_core_provenance.yml"), emit: provenance


    script:
    """
    printf -- "- process_name: snippy_core\\n"                                                      >> snippy_core_provenance.yml
    printf -- "  tools:\\n"                                                                         >> snippy_core_provenance.yml
    printf -- "    - tool_name: snippy_core\\n"                                                     >> snippy_core_provenance.yml
    printf -- "      tool_version: \$(snippy-core --version | awk '{print \$2}')\\n"                >> snippy_core_provenance.yml
    printf -- "      parameters:\\n"                                                                >> snippy_core_provenance.yml
    printf -- "        - parameter: --ref\\n"                                                       >> snippy_core_provenance.yml
    printf -- "          value: ${ref}\\n"                                                          >> snippy_core_provenance.yml
    printf -- "        - parameter: --mask\\n"                                                      >> snippy_core_provenance.yml
    printf -- "          value: ${mask}\\n"                                                         >> snippy_core_provenance.yml

    snippy-core \
      --ref ${ref} \
      --mask ${mask} \
      $snippy_dirs

    snippy-clean_full_aln core.full.aln > clean.full.aln

    add_percent_used.py core.txt > core.tsv

    """
}

