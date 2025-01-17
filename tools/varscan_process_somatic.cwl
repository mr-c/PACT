#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "varscan v2.4.2 processSomatic"
arguments: [
    "cp", $(inputs.variants.path), "$(runtime.outdir)/$(inputs.variants.basename)",
    { valueFrom: " && ", shellQuote: false },
    "java", "-jar", "/usr/local/bin/Varscan.jar", "processSomatic"
]
requirements:
    - class: ShellCommandRequirement
    - class: DockerRequirement
      dockerPull: "jbwebster/snv_pipeline_docker"
    - class: ResourceRequirement
      ramMin: 4000
    - class: StepInputExpressionRequirement
inputs:
    variants:
        type: File
        inputBinding:
            valueFrom:
                $(runtime.outdir)/$(self.basename)
            position: 1
    max_normal_freq:
        type: float?
        inputBinding:
            prefix: "--max-normal-freq"
            position: 2
outputs:
    somatic_hc:
        type: File
        outputBinding:
            glob: "*.Somatic.hc.vcf"
    somatic:
        type: File
        outputBinding:
            glob: "*.Somatic.vcf"
    germline_hc:
        type: File
        outputBinding:
            glob: "*.Germline.hc.vcf"
    germline:
        type: File
        outputBinding:
            glob: "*.Germline.vcf"
    loh_hc:
        type: File
        outputBinding:
            glob: "*.LOH.hc.vcf"
    loh:
        type: File
        outputBinding:
            glob: "*.LOH.vcf"
