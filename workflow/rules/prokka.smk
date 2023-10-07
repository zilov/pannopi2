rule prokka:
    input:
        ASSEMBLY
    conda:
        envs.prokka
    threads: workflow.cores
    output:
        annotation_faa = f"{OUTDIR}/prokka/{PREFIX}.faa",
        annotation_gbk = f"{OUTDIR}/prokka/{PREFIX}.gbk",
        report_txt = f"{OUTDIR}/prokka/{PREFIX}.txt",
    params:
        outdir = f"{OUTDIR}/prokka",
        prokka_prefix = PREFIX
    shell:
        """
        prokka \
            --force \
            --cpus {threads} \
            --outdir {params.outdir} \
            --prefix {params.prokka_prefix} \
            --centre X --compliant {input}
        """
