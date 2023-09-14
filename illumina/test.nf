#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

workflow {
	println "IDAT to VCF: TEST"
	println ""
	println "IDIR    = ${params.idat_dir}"
	println "BPM     = ${params.manifest_bpm}"
	println "CSV     = ${params.manifest_csv}"
	println "CST     = ${params.cluster_file}"
	println "FASTA   = ${params.fasta_ref}"
	println "BAM     = ${params.bam_alignment_file}"												// if processing in build 38 (hg38), provide a bam alignment file
	println "NAME    = ${params.output_prefix}"
	println "ODIR    = ${params.output_dir}"
	println "ACCOUNT = ${params.account}"
	println "QUEUE   = ${params.queue}"
	println "TASKS   = ${params.njobs}"
	println "CDIR    = ${params.containers_dir}"
	println ""

	//call_genotypes()
	plink()
}

workflow.onComplete { 
	println "Workflow completed at:	${workflow.complete}"
	println "Execution status:	${ workflow.success ? 'OK' : 'failed'}"
}

workflow.onError{
	println "workflow execution stopped with the following message: ${workflow.errorMessage}"
}

process call_genotypes() {
	tag "processing ... ${params.idat_dir}"
	label 'gencall'
	publishDir path: "${params.output_dir}/test"
	debug true

	script:
		"""		
		iaap-cli \
			gencall \
			--help

		"""
}

process plink() {

	// directives
	tag "processing ... ${params.idat_dir}"
	label 'plink2'
	label 'idat_to_gtc'
	publishDir path: "${params.output_dir}/output"
	debug true

	script:
		"""
		plink2 \
			--help \
			--file

		"""
}