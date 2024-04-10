#!/bin/bash

set -eo pipefail

sed -i 's/cpus = 8/cpus = 4/g' nextflow.config 

outdir = .github/data/snippy-core-phylogenomics-output

nextflow run main.nf \
	 -profile conda \
	 --cache ${HOME}/.conda/envs \
	 --ref .github/data/assemblies/NC_000913.3.fasta \
	 --snippy_dirs .github/data/snippy-variants-v0.1-output \
	 --outdir ${outdir} \
	 -with-report ${outdir}/nextflow_report.html \
 	 -with-trace ${outdir}/nextflow_trace.tsv
