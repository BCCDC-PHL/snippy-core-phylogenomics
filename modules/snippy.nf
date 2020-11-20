process snippy {
    tag { sample_id }
    cpus 8
    input:
    tuple val(grouping_key), file(fastq), path(ref)

    output:
    path("${sample_id}", type: 'dir')
    
    script:
    if (grouping_key =~ '_S[0-9]+_') {
      sample_id = grouping_key.split("_S[0-9]+_")[0]
    } else {
      sample_id = grouping_key.split("_")[0]
    }
    read_1 = fastq[0]
    read_2 = fastq[1]
    """
    snippy \
      --cpus 8 \
      --report \
      --ref "${ref}" \
      --R1 "${read_1}" \
      --R2 "${read_2}" \
      --outdir '${sample_id}'
    """
}