rule trimmomatic:
    input:
        r1=FR,
        r2=RR,
    output:
        r1=f"{OUTDIR}/trimmed/{PREFIX}_1.fastq.gz",
        r2=f"{OUTDIR}/trimmed/{PREFIX}_2.fastq.gz",
        # reads where trimming entirely removed the mate
        r1_unpaired=f"{OUTDIR}/trimmed/{PREFIX}_1.unpaired.fastq.gz",
        r2_unpaired=f"{OUTDIR}/trimmed/{PREFIX}_2.unpaired.fastq.gz",
    conda: envs.trimmomatic
    threads:
        workflow.cores
    params:
        trueseq = f"{EXECUTION_FOLDER}/workflow/data/TruSeq3-PE.fa"
    shell: "trimmomatic PE {input.r1} {input.r2} {output.r1} {output.r1_unpaired} {output.r2} {output.r2_unpaired} -threads {threads}\
                ILLUMINACLIP:{params.trueseq}:2:30:10:2:True LEADING:3 TRAILING:3 MINLEN:36"