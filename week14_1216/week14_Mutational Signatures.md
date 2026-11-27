Date：20261216  
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-ix) / [中文](#生物標記物與它們的產地實作課程九)

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
> Sample IDs range from 90 to 98, replace `96` with your assigned sample ID.
>
> For example, to obtain `96.maf`:
>
> ```
> rsync -azvP /work/u2777445/2026Biomarker_TA/MAF/96.maf ./
> ```

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

#### 學習使用 `vcf2maf` 與 `maftools` 進行突變特徵分析（Mutational Signature Analysis）。

> [!IMPORTANT]
> #### 什麼是突變特徵（Mutational Signatures）？
>
> 突變特徵是指與不同突變機制相關的特定突變模式，例如 DNA 損傷、DNA 修復缺陷及環境因子暴露等。
> 單鹼基替換（Single Base Substitution, SBS）可依據六種鹼基替換類型，以及突變位置相鄰的 5' 與 3' 鹼基，進一步分類為 96 種突變類型。
> 詳細資訊：[COSMIC Mutational Signatures - SBS](https://cancer.sanger.ac.uk/signatures/sbs/)

> [!WARNING]
> ### 前情提要：請先複製課程所需檔案。
> 請將 `username` 替換為自己的國網中心（NCHC）帳號。
> ```
> cd /work/username
> mkdir MAF
> cd MAF
>
> rsync -azvP /work/u2777445/R_libs ./
> rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/vcf2maf.pl ./
> rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/vcf2maf.sh ./
> ```
> 共用的 `R_libs` 資料夾包含本次課程所需的 R 套件。

---

### Step 1：將 VCF 檔案轉換為 MAF 檔案

#### 什麼是 `vcf2maf`？

`vcf2maf` 是一個將 Variant Call Format (VCF) 檔案轉換為 Mutation Annotation Format (MAF) 檔案的工具，以利後續的資料分析與視覺化。

詳細資訊：[vcf2maf - GitHub Repository](https://github.com/mskcc/vcf2maf)

#### 1-1. 修改 `vcf2maf.sh` 中所需的參數。

```
vim vcf2maf.sh
```

* 將 username 替換為自己的國網中心（NCHC）帳號。
* 將 sample ID 修改為自己所分配到的樣本編號。
* 確認 VCF 檔案輸入路徑。

例如：

> <img width="374" height="78" alt="vcf2maf.sh parameter settings" src="https://github.com/user-attachments/assets/951acd0b-61ae-46ad-a452-0990ab77a992" />

修改完成後，按下 `Esc`，輸入 `:wq`，再按下 `Enter` 儲存並離開。

#### 1-2. 提交 `vcf2maf.sh`。

```
sbatch vcf2maf.sh
```

確認工作執行狀態：

```
sacct
```

檔案轉換約需 20 分鐘，實際執行時間取決於輸入檔案大小及運算資源。

> [!TIP]
> 同學也可以直接複製助教已完成轉換的 MAF 檔案。
>
> 樣本編號範圍為 90 至 98，請將 `96` 替換為自己所分配到的樣本編號。
>
> 以複製 `96.maf` 為例：
>
> ```
> rsync -azvP /work/u2777445/2026Biomarker_TA/MAF/96.maf ./
> ```
>

---

### Step 2：使用 `maftools` 進行突變特徵分析

#### 什麼是 `maftools`？

`maftools` 是 R/Bioconductor 的套件之一，主要用於彙整、分析、註釋及視覺化以 Mutation Annotation Format (MAF) 格式儲存的體細胞突變（somatic mutation）資料。

本次課程將使用 `maftools` 搭配 R script 進行以下分析：

* 讀取 MAF 檔案。
* 建立包含 96 種突變類型的三核苷酸突變矩陣（trinucleotide mutation matrix）。
* 計算樣本突變分布與 COSMIC 參考 SBS signatures 之間的餘弦相似度（cosine similarity）。
* 找出與樣本突變分布最相似的 COSMIC SBS signatures。
* 將突變分布進行視覺化。

詳細資訊：[maftools - Official Documentation](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#910_Mutational_Signatures)

#### 2-1. 複製分析所需的程式檔案。

```
rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/MutationSignature.R ./
rsync -azvP /work/u9482849/2026Biomarkers/MAF/tutorials/runR.sh ./
```

#### 2-2. 修改 `runR.sh` 中所需的參數。

```
vim runR.sh
```

* 將 username 替換為自己的國網中心（NCHC）帳號。
* 修改 sample ID，使其與欲分析的 MAF 檔案名稱相符。

例如：

> <img width="262" height="87" alt="runR.sh parameter settings" src="https://github.com/user-attachments/assets/5c1fc752-f888-49db-8fd6-b1d3a27e92ef" />

> 此 script 將載入分析所需的運算環境：
> ```
> module load biology
> module load R/4.4.1
> module load gcc/10.5.0
> ```
> 並透過以下指令，將 sample ID 傳入 `MutationSignature.R`：
> ```
> Rscript --vanilla ${DIR_MAF}/MutationSignature.R ${sample}
> ```

修改完成後，按下 `Esc`，輸入 `:wq`，再按下 `Enter` 儲存並離開。

> [!NOTE]
> 同學只需要修改 `runR.sh`。
>
> 不需要另外修改 `MutationSignature.R` 中的 sample ID。
>
> `runR.sh` 會自動執行 `MutationSignature.R`，因此不需要手動執行 R script。

#### 2-3. 提交 `runR.sh`。

```
sbatch runR.sh
```

確認工作執行狀態：

```
sacct
```

---

> [!IMPORTANT]
> #### 補充說明（Additional notes）
>
> `maftools` 官方教材亦介紹如何使用非負矩陣分解（Non-negative Matrix Factorization, NMF）進行從頭突變特徵萃取（de novo signature extraction）。
>
> 主要使用的函數及其功能如下：
>
> | Function | Purpose |
> | --- | --- |
> | `trinucleotideMatrix()` | 建立包含 96 種突變類型的三核苷酸突變矩陣。 |
> | `estimateSignatures()` | 使用 NMF 評估不同突變特徵數量的候選模型。 |
> | `plotCophenetic()` | 將不同 NMF rank 的 Cophenetic correlation 進行視覺化，以協助選擇適合的突變特徵數量。 |
> | `extractSignatures()` | 使用 NMF 萃取指定數量的突變特徵。 |
> | `compareSignatures()` | 使用 cosine similarity 比較萃取出的突變特徵與 COSMIC 已知的突變特徵。 |
> | `plotSignatures()` | 將萃取出的突變特徵進行視覺化。 |
>
> 由於本次實作課程著重於單一樣本分析，因此不使用 NMF 進行 de novo signature extraction，而是直接將樣本觀察到的突變分布與 COSMIC 已知的突變特徵進行比較。
>
> Cosine similarity 用於衡量不同突變分布之間的相似程度，其數值不應被解讀為某一突變特徵的貢獻比例，也不能作為特定突變機制存在的直接證據。
>
> 詳細資訊：[maftools - 9.10.3 Signature analysis](https://bioconductor.org/packages/release/bioc/vignettes/maftools/inst/doc/maftools.html#9103_Signature_analysis)

---

### Step 3：確認分析結果

分析結果將儲存於以下資料夾：

```
/work/username/MAF/sampleID_MAFresult/
```

若分析的樣本編號為 `96`，則可使用以下指令查看結果：

```
cd /work/username/MAF/96_MAFresult
ls
```

結果資料夾包含以下三個檔案（以樣本 96 為例）：

```
96_MAFresult/
├── 96_cosmic_similarity.tsv
├── 96_mutation_counts.tsv
└── 96_trinucleotide_profile.pdf
```

| Output file | Description |
| --- | --- |
| `sampleID_cosmic_similarity.tsv` | 樣本與 COSMIC v3.4 SBS signatures 的 cosine similarity 數值及排名。 |
| `sampleID_mutation_counts.tsv` | 96 種三核苷酸突變類型的突變計數。 |
| `sampleID_trinucleotide_profile.pdf` | 樣本的突變分布圖，並標示相似度最高的前三種 COSMIC signatures。 |

#### 3-1. 查看 COSMIC 相似度分析結果。

```
head 96_cosmic_similarity.tsv
```

#### 3-2. 查看各突變類型的計數。

```
head 96_mutation_counts.tsv
```

#### 3-3. 檢視三核苷酸突變分布圖。

下載並開啟以下 PDF 檔案（以樣本 96 為例）：

```
96_trinucleotide_profile.pdf
```

> [!TIP]
> 若忘記如何從國網中心（NCHC）下載檔案，請參考第一週教材：[Week 1 - Step 2: File Transfer](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-2-file-transfer)。

> [!IMPORTANT]
> 餘弦相似度（Cosine similarity）用於衡量樣本觀察到的突變分布與參考突變特徵之間的相似程度。
>
> 數值越接近 1，代表兩者的突變分布越相似。
>
> 例如，若 SBS5 的 cosine similarity 為 0.876，並不代表樣本中有 87.6% 的突變可歸因於 SBS5。

