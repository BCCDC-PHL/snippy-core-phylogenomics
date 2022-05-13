process gubbins {

  publishDir "${params.outdir}", mode: 'copy', pattern: "gubbins.*"

  input:
  path(alignment)

  output:
  path('gubbins.filtered_polymorphic_sites.fasta'), emit: filtered_alignment

  script:
  """
  run_gubbins.py \
    --threads ${task.cpus} \
    -p gubbins \
    ${alignment}
  """
}