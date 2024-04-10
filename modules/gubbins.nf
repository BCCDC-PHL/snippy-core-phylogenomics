process gubbins {
  
  errorStrategy 'ignore'

  publishDir "${params.outdir}", mode: 'copy', pattern: "gubbins.*"

  input:
  path(alignment)
  val(run_gubbins)

  output:
  path('gubbins.filtered_polymorphic_sites.fasta'), emit: filtered_polymorphic_sites
  path('gubbins.recombination_predictions.gff'),    emit: recombination_predictions_gff
  path('gubbins.per_branch_statistics.tsv'),        emit: per_branch_statistics

  when:
  run_gubbins == "true"
  

  script:
  """
  run_gubbins.py \
    --threads ${task.cpus} \
    -p gubbins \
    ${alignment}

  mv gubbins.per_branch_statistics.csv gubbins.per_branch_statistics.tsv
  """
}