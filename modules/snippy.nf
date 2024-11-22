process snippy {
    tag { sample_id }
    cpus 8
    input:
    tuple val(grouping_key), file(fastq), path(ref)

    output:
    path("${sample_id}", type: 'dir'), emit: sample_id_dir
    tuple val(sample_id), path("snippy_provenance.yml"), emit: provenance
    
    script:
    if (grouping_key =~ '_S[0-9]+_') {
      sample_id = grouping_key.split("_S[0-9]+_")[0]
    } else {
      sample_id = grouping_key.split("_")[0]
    }
    read_1 = fastq[0]
    read_2 = fastq[1]
    """
    printf -- "- process_name: snippy\\n"                                                      >> snippy_provenance.yml
    printf -- "  tools:\\n"                                                                    >> snippy_provenance.yml
    printf -- "    - tool_name: snippy\\n"                                                     >> snippy_provenance.yml
    printf -- "      tool_version: \$(snippy --version | awk '{print $2}')\\n"                 >> snippy_provenance.yml
    printf -- "      parameters:\\n"                                                           >> snippy_provenance.yml
    printf -- "        - parameter: --cpus\\n"                                                 >> snippy_provenance.yml
    printf -- "          value: 8\\n"                                                          >> snippy_provenance.yml
    printf -- "        - parameter: -report\\n"                                                >> snippy_provenance.yml
    printf -- "          value: null\\n"                                                       >> snippy_provenance.yml
    printf -- "        - parameter: --ref\\n"                                                  >> snippy_provenance.yml
    printf -- "          value: "${ref}"\\n"                                                   >> snippy_provenance.yml
    printf -- "        - parameter: -R1\\n"                                                    >> snippy_provenance.yml
    printf -- "          value: ${read_1}\\n"                                                  >> snippy_provenance.yml
    printf -- "        - parameter: -R2\\n"                                                    >> snippy_provenance.yml
    printf -- "          value: ${read_2}\\n"                                                  >> snippy_provenance.yml
    printf -- "        - parameter: -outdir\\n"                                                >> snippy_provenance.yml
    printf -- "          value: ${sample_id}\\n"                                               >> snippy_provenance.yml
   
    snippy \
      --cpus 8 \
      --report \
      --ref "${ref}" \
      --R1 "${read_1}" \
      --R2 "${read_2}" \
      --outdir '${sample_id}'
    """
}