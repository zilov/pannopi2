rule fastqc:
    input:
        forward_read = FR,
        rewerse_read = RR
    conda:
        envs.fastqc
    threads: workflow.cores
    output:
        fastq_file_1 = f"{FASTQC_DIR}/{PREFIX}_R1_fastqc.zip",
    params:
        fastqc1_dir = directory(f"{FASTQC_DIR}")
    shell:
        """
        fastqc \
            -o {params.fastqc1_dir} \
            -t {threads} \
            {input}
            
        mv {params.fastqc1_dir}/*_R1_*.zip {output.fastq_file_1}
        """