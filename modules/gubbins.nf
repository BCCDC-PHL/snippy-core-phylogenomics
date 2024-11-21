process gubbins {
  
  errorStrategy 'ignore'

  publishDir "${params.outdir}", mode: 'copy', pattern: "gubbins.*"

  input:
  path(alignment)

  output:
  path('gubbins.filtered_polymorphic_sites.fasta'), emit: filtered_polymorphic_sites
  path('gubbins.recombination_predictions.gff'),    emit: recombination_predictions_gff
  path('gubbins.per_branch_statistics.tsv'),        emit: per_branch_statistics
  path("gubbins_provenance.yml"), emit: provenance


  script:
  """
  printf -- "- process_name: gubbins\\n"                                                     >> gubbins_provenance.yml
  printf -- "  tools:\\n"                                                                    >> gubbins_provenance.yml
  printf -- "    - tool_name: gubbins\\n"                                                    >> gubbins_provenance.yml
  printf -- "      tool_version: \$(gubbins -h | grep -i \"Version:\" | awk '{print \$2}')\\n"  >> gubbins_provenance.yml
  printf -- "      parameters:\\n"                                                           >> gubbins_provenance.yml
  printf -- "        - parameter: --threads\\n"                                              >> gubbins_provenance.yml
  printf -- "          value: ${task.cpus}\\n"                                               >> gubbins_provenance.yml
  printf -- "        - parameter: -p\\n"                                                     >> gubbins_provenance.yml
  printf -- "          value: gubbins\\n"                                                    >> gubbins_provenance.yml

  run_gubbins.py \
    --threads ${task.cpus} \
    -p gubbins \
    ${alignment}

  mv gubbins.per_branch_statistics.csv gubbins.per_branch_statistics.tsv
  """
}