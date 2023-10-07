rule quast:
    input:
        ASSEMBLY,
    conda:
        envs.quast,
    output:
        quast_output = f"{OUTDIR}/quast/report.txt"
    params:
        directory(f"{OUTDIR}/quast")
    shell: "quast -o {params} {input}"