#!/bin/bash

artifacts_dir="artifacts"

echo "Prepare artifacts .." >> ${artifacts_dir}/test.log

mkdir -p ${artifacts_dir}/fastq

mv .github/data/fastq/*.fastq.gz ${artifacts_dir}/fastq

mkdir -p ${artifacts_dir}/pipeline_outputs

mv .github/data/snippy-core-phylogenomics-output/* ${artifacts_dir}/pipeline_outputs
