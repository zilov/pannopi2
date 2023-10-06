rule jellycount:
    input:
        fr = FR,
        rr = RR
    conda:
        envs.jellyfish
    threads: workflow.cores
    output:
        jellycount_file = f"{OUTDIR}/qc/jellyfish_genomescope/{PREFIX}.jf2",
    params:
        outdir = directory(f"{OUTDIR}/qc/jellyfish_genomescope")
    shell:
        """
        jellyfish count \
            -m 23 \
            -t {threads} \
            -s 2G \
            -C \
            -o {output} \
            <(zcat {input.fr}) <(zcat {input.rr})
        """

rule jellyhisto:
    input:
        rules.jellycount.output,
    conda:
        envs.jellyfish
    threads: workflow.cores
    output:
        jellyhisto_file = f"{OUTDIR}/qc/jellyfish_genomescope/{PREFIX}.histo",
    shell:
        """
        jellyfish histo \
            -o {output} \
            {input}
        """

rule genomescope:
    input:
        rules.jellyhisto.output
    conda:
        envs.genomescope
    threads: 1
    output:
        scope_file = f"{OUTDIR}/qc/jellyfish_genomescope/{PREFIX}_linear_plot.png"
    params:
        scope_dir = rules.jellycount.params.outdir,
        prefix = PREFIX
    shell:
        """
        genomescope2 -i {input} -o {params.scope_dir} -k 23 -n {params.prefix}
        """
