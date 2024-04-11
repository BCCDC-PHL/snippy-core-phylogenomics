#!/bin/bash

.github/scripts/apply_variants.py --genome .github/data/assemblies/NC_000962.3.fa --variants .github/data/variants/variants-01.vcf -o .github/data/assemblies/sample-01.fa
.github/scripts/apply_variants.py --genome .github/data/assemblies/NC_000962.3.fa --variants .github/data/variants/variants-02.vcf -o .github/data/assemblies/sample-02.fa
.github/scripts/apply_variants.py --genome .github/data/assemblies/NC_000962.3.fa --variants .github/data/variants/variants-03.vcf -o .github/data/assemblies/sample-03.fa
