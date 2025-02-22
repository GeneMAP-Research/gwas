#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include {
    getVcf;
    getVcfIndex;
    getNewVcf;
    fixVcf
} from "${projectDir}/modules/clean_imputed_vcf.mdl"

workflow {
    println "\nEXTRACT REQUIRED SAMPLES FROM IMPUTED VCF FILES TO MAKE NEW VCFs\n"
    vcf = getVcf()
    vcf_fileset = getVcfIndex(vcf)
    new_vcf = getNewVcf(vcf_fileset)
    fixVcf(new_vcf).view()
}


