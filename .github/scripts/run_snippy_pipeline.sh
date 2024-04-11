#!/bin/bash

set -eo pipefail

nextflow pull BCCDC-PHL/snippy-variants -r v0.1.0

sed -i 's/cpus = 8/cpus = 4/g' $HOME/.nextflow/assets/BCCDC-PHL/snippy-variants/nextflow.config 

outdir=".github/data/snippy-variants-v0.1-output"

nextflow run $HOME/.nextflow/assets/BCCDC-PHL/snippy-variants/main.nf \
	 -c $HOME/.nextflow/assets/BCCDC-PHL/snippy-variants/nextflow.config \
	 -profile conda \
	 --cache ${HOME}/.conda/envs \
	 --ref .github/data/assemblies/NC_000962.3.fa \
	 --fastq_input .github/data/fastq \
	 --outdir ${outdir} \
	 -with-report ${outdir}/nextflow_report.html \
 	 -with-trace ${outdir}/nextflow_trace.tsv
