process shiptv {

  publishDir "${params.outdir}", mode: 'copy', pattern: "*.html"

  input:
  file(tree)

  output:
  path("${tree}.html")
  path("shiptv_provenance.yml"), emit: provenance
    
  script:
  """
  printf -- "- process_name: shiptv\\n"                                                           >> shiptv_provenance.yml
  printf -- "  tools:\\n"                                                                         >> shiptv_provenance.yml
  printf -- "    - tool_name: shiptv\\n"                                                          >> shiptv_provenance.yml
  printf -- "      tool_version: \$(shiptv --version | awk '{print \$3}')\\n"                     >> shiptv_provenance.yml
  printf -- "      parameters:\\n"                                                                >> shiptv_provenance.yml
  printf -- "        - parameter: -n\\n"                                                          >> shiptv_provenance.yml
  printf -- "          value: ${tree}\\n"                                                         >> shiptv_provenance.yml
  printf -- "        - parameter: -0\\n"                                                          >> shiptv_provenance.yml
  printf -- "          value: ${tree}.html\\n"                                                    >> shiptv_provenance.yml

  shiptv -n ${tree} -o ${tree}.html
  """
}