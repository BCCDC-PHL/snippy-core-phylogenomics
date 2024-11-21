process iqtree {

  publishDir "${params.outdir}", mode: 'copy', pattern: "*.treefile"
    
  input:
  path(alignment)

  output:
  path('*.treefile'), emit: tree
  path("iqtree_provenance.yml"), emit: provenance

  script:
  """
  printf -- "- process_name: iqtree\\n"                                                      >> iqtree_provenance.yml
  printf -- "  tools:\\n"                                                                    >> iqtree_provenance.yml
  printf -- "    - tool_name: iqtree\\n"                                                     >> iqtree_provenance.yml
  printf -- "      tool_version: \$(iqtree --version 2>&1 | awk '/IQ-TREE/ {print \$4}')\\n" >> iqtree_provenance.yml
  printf -- "      parameters:\\n"                                                           >> iqtree_provenance.yml
  printf -- "        - parameter: -nt\\n"                                                    >> iqtree_provenance.yml
  printf -- "          value: ${task.cpus}\\n"                                               >> iqtree_provenance.yml
  printf -- "        - parameter: -fconst\\n"                                                >> iqtree_provenance.yml
  printf -- "          value: \$(snp-sites -C ${alignment})\\n"                              >> iqtree_provenance.yml
  printf -- "        - parameter: -s\\n"                                                     >> iqtree_provenance.yml
  printf -- "          value: ${alignment}\\n"                                               >> iqtree_provenance.yml
  printf -- "        - parameter: -st\\n"                                                    >> iqtree_provenance.yml
  printf -- "          value: DNA\\n"                                                        >> iqtree_provenance.yml
  printf -- "        - parameter: -m\\n"                                                     >> iqtree_provenance.yml
  printf -- "          value: GTR+G\\n"                                                      >> iqtree_provenance.yml

  iqtree \
    -nt ${task.cpus} \
    -fconst \$(snp-sites -C ${alignment}) \
    -s ${alignment} \
    -st DNA \
    -m GTR+G
  """
}
