process shiptv {

  publishDir "${params.outdir}", mode: 'copy', pattern: "*.html"

  input:
  file(tree)

  output:
  path("${tree}.html")
    
  script:
  """
  shiptv -n ${tree} -o ${tree}.html
  """
}