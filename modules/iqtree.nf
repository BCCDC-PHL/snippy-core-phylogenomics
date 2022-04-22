process iqtree {

    cpus 16

    publishDir "${params.outdir}", mode: 'copy', pattern: "clean.full.aln.*"
    
    input:
        path(alignment)

    output:
        path('clean.full.aln.*')

    script:
    """
    iqtree \
      -nt ${task.cpus} \
      -t PARS \
      -ninit 2 \
      -m GTR+G \
      -s ${alignment}
    """
}

process iqtree_pre_recombination_filtering {

    cpus 16

    publishDir "${params.outdir}", mode: 'copy', pattern: "*.treefile"
    
    input:
        path(alignment)

    output:
        path('*.treefile')

    script:
    """
    iqtree \
      -nt ${task.cpus} \
      -s ${alignment} \
      -st DNA \
      -m GTR+G4 \
      -bb 1000 \
      -alrt 1000
    """
}

process iqtree_post_recombination_filtering {

    cpus 16

    publishDir "${params.outdir}", mode: 'copy', pattern: "*.treefile"
    
    input:
        path(alignment)

    output:
        path('*.treefile')

    script:
    """
    iqtree \
      -nt AUTO \
      -s ${alignment} \
      -st DNA \
      -m GTR+G+ASC \
      -bb 1000 \
      -alrt 1000
    """
}
