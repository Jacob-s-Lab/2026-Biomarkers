Date：20261216  
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-ix) / [中文](#生物標記物與它們的產地實作課程-九)

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part IX)

## The main content of this course

#### Learning to use `vcf2maf` and `maftools` for mutational signature analysis.

> [!IMPORTANT]
> #### What are Mutational Signatures?
>
> Mutational signatures are characteristic patterns of mutations associated with different mutational processes, such as DNA damage, DNA repair deficiencies, and environmental exposures.
>
> Single Base Substitution (SBS) patterns can be classified into 96 mutation categories based on six substitution types and their immediate 5' and 3' neighboring bases.
>
> More details: [COSMIC Mutational Signatures - SBS](https://cancer.sanger.ac.uk/signatures/sbs/)

> [!WARNING]
> ### Please copy the required files for the course first.
>
> Replace `username` with your own NCHC username.
>
> ```
> cd /work/username
> mkdir MAF
> cd MAF
>
> rsync -azvP /work/u2777445/R_libs ./
> rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/vcf2maf.pl ./
> rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/vcf2maf.sh ./
> ```
>
> The shared `R_libs` directory contains the R packages required for this course.

---

### Step 1: Convert a VCF file to a MAF file

#### What is `vcf2maf`?

`vcf2maf` is a tool that converts Variant Call Format (VCF) files into Mutation Annotation Format (MAF) files for downstream analysis and visualization.
More details: [vcf2maf - GitHub Repository](https://github.com/mskcc/vcf2maf)

#### 1-1. Modify the required parameters in `vcf2maf.sh`.

```
vim vcf2maf.sh
```

* Replace the username with your own NCHC username.
* Change the sample ID to your assigned sample.
* Confirm the input path of your VEP-annotated VCF file.

For example:
> <img width="374" height="78" alt="截圖 2026-11-27 下午6 02 03" src="https://github.com/user-attachments/assets/951acd0b-61ae-46ad-a452-0990ab77a992" />

Press `Esc`, type `:wq`, and press `Enter` to save and exit.


#### 1-2. Submit `vcf2maf.sh`.

```
sbatch vcf2maf.sh
```
Check the job status:
```
sacct
```

The conversion may take approximately 20 minutes, depending on the input file size and computing resources.

> [!TIP]
> Alternatively, you can copy a pre-generated MAF file provided by the TA.
>
> Sample IDs range from 90 to 98, depending on file availability.
>
> For example, to obtain `96.maf`:
>
> ```
> rsync -azvP /work/u2777445/2026Biomarker_TA/MAF/96.maf ./
> ```
>
> Replace `96` with your assigned sample ID.

---

### Step 2: Perform mutational signature analysis using `maftools`


#### What is `maftools`?

`maftools` is an R/Bioconductor package designed to summarize, analyze, annotate, and visualize somatic mutation data stored in Mutation Annotation Format (MAF).

In this course, we will use `maftools` and an R script to:

* Read a MAF file.
* Generate a 96-channel trinucleotide mutation matrix.
* Calculate cosine similarity between the observed mutation profile and reference COSMIC SBS signatures.
* Identify the most similar COSMIC SBS signatures.
* Visualize the mutation profile.

More details: [maftools - Official Documentation](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#910_Mutational_Signatures)

#### 2-1. Copy the required analysis scripts.

```
rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/MutationSignature.R ./
rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/runR.sh ./
```

#### 2-2. Modify the required parameters in `runR.sh`.

```
vim runR.sh
```

* Replace the username with your own NCHC username.
* Change the sample ID to match your MAF file.

For example:
> <img width="262" height="87" alt="截圖 2026-11-27 下午6 02 35" src="https://github.com/user-attachments/assets/5c1fc752-f888-49db-8fd6-b1d3a27e92ef" />


> The script loads the required computing environment:
> ```
> module load biology
> module load R/4.4.1
> module load gcc/10.5.0
> ```
> The sample ID is passed to `MutationSignature.R` through the following command:
> ```
> Rscript --vanilla ${DIR_MAF}/MutationSignature.R ${sample}
> ```

Press `Esc`, type `:wq`, and press `Enter` to save and exit.

> [!NOTE]
> You only need to modify `runR.sh`.
> There is no need to modify the sample ID in `MutationSignature.R`.
> `runR.sh` automatically executes `MutationSignature.R`.
> You do not need to execute the R script manually.

#### 2-3. Submit `runR.sh`.

```
sbatch runR.sh
```
Check the job status:
```
sacct
```

---

> [!IMPORTANT]
> #### Additional notes
>
> The official `maftools` tutorial also describes de novo signature extraction using Non-negative Matrix Factorization (NMF).
>
> The main functions include:
>
> | Function | Purpose |
> | --- | --- |
> | `trinucleotideMatrix()` | Generate a 96-channel trinucleotide mutation matrix. |
> | `estimateSignatures()` | Evaluate candidate numbers of signatures using NMF. |
> | `plotCophenetic()` | Visualize cophenetic correlation across different NMF ranks to help select the optimal number of signatures. |
> | `extractSignatures()` | Extract a specified number of mutational signatures using NMF. |
> | `compareSignatures()` | Compare extracted signatures with known COSMIC signatures using cosine similarity. |
> | `plotSignatures()` | Visualize extracted mutational signatures. |
>
> Since this practical course focuses on single-sample analysis, we directly compare the observed mutation profile with known COSMIC signatures instead of performing de novo signature extraction using NMF.
>
> Cosine similarity measures the similarity between mutation profiles. It should not be interpreted as the proportion of mutations attributed to a signature or as direct evidence of a specific mutational process.
>
> More details: [maftools - 9.10.3 Signature analysis](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#9103_Signature_analysis)

---

### Step 3: Check the output files

The analysis results will be saved in:

```
/work/username/MAF/sampleID_MAFresult/
```

For example, if your sample ID is `96`:

```
cd /work/username/MAF/96_MAFresult
ls
```

The output directory contains three files (using sample 96 as an example):

```
96_MAFresult/
├── 96_cosmic_similarity.tsv
├── 96_mutation_counts.tsv
└── 96_trinucleotide_profile.pdf
```

| Output file | Description |
| --- | --- |
| `sampleID_cosmic_similarity.tsv` | Cosine similarity scores ranked against COSMIC v3.4 SBS signatures. |
| `sampleID_mutation_counts.tsv` | Mutation counts for the 96 trinucleotide mutation categories. |
| `sampleID_trinucleotide_profile.pdf` | Mutation profile with the top three COSMIC signature matches. |

#### 3-1. Check the COSMIC similarity results.

```
head 96_cosmic_similarity.tsv
```

#### 3-2. Check the mutation counts.

```
head 96_mutation_counts.tsv
```

#### 3-3. Visualize the trinucleotide mutation profile.

Download and open the following PDF file (using sample 96 as an example):

```
96_trinucleotide_profile.pdf
```

> [!TIP]
> If you need a reminder on how to download files from NCHC, please refer to [Week 1 - Step 2: File Transfer](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-2-file-transfer).


> [!IMPORTANT]
> Cosine similarity measures the similarity between the observed mutation profile and a reference mutational signature.
>
> A value closer to 1 indicates a more similar mutation pattern.
>
> For example, a cosine similarity of 0.876 for SBS5 does not mean that 87.6% of the mutations were caused by SBS5.


 ------------------------
# 生物標記物與它們的產地實作課程(九)
## 本次課程主要內容
