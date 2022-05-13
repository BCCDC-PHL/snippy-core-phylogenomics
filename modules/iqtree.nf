process iqtree {

  publishDir "${params.outdir}", mode: 'copy', pattern: "*.treefile"
    
  input:
  path(alignment)

  output:
  path('*.treefile')

  script:
  """
  iqtree \
    -nt ${task.cpus} \
    -fconst \$(snp-sites -C ${alignment}) \
    -s ${alignment} \
    -st DNA \
    -m GTR+G
  """
}
