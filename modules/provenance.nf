process collect_provenance {


  executor 'local'

  publishDir "${params.outdir}", pattern: "*_provenance.yml", mode: 'copy'

  input:
  path(provenance_files)

  output:
  file("*_provenance.yml")

  script:
  """
  cat ${provenance_files} >\$(date +%Y%m%d%H%M%S)_provenance.yml
  """
}

process pipeline_provenance {

    tag { pipeline_name + " / " + pipeline_version }

    executor 'local'

    input:
    tuple val(session_id), val(run_name), val(pipeline_name), val(pipeline_version), val(analysis_start)

    output:
    file("pipeline_provenance.yml")

    script:
    """
    printf -- "- pipeline_name: ${pipeline_name}\\n"             >> pipeline_provenance.yml
    printf -- "  pipeline_version: ${pipeline_version}\\n"       >> pipeline_provenance.yml
    printf -- "  nextflow_session_id: ${session_id}\\n"          >> pipeline_provenance.yml
    printf -- "  nextflow_run_name: ${run_name}\\n"              >> pipeline_provenance.yml
    printf -- "  timestamp_analysis_start: ${analysis_start}\\n" >> pipeline_provenance.yml
    """
}
