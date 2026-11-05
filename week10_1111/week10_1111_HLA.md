Date：20261111 
Language：[EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-X) / [中文](#生物標記物與它們的產地實作課程十)

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part X)
## The main content of this course

#### Learning to use `T1K` for HLA typing.

> [!Warning]
> ### Prerequisite:Please first copy the necessary files for the course.
> ```
> cd /work/username
> mkdir T1K
> cd T1K
> rsync -avz /work/u9482849/T1K/T1K_temp.sh ./
> rsync -avz /work/u9482849/T1K/hla_dna_seq.fa ./
> ```


> [!Important]
> #### What is T1K?
> T1K (The ONE genotyper for KIR and HLA) is a computational tool designed to infer alleles of highly diverse genes, such as KIR and HLA. T1K leverages RNA-seq, WES, or WGS read alignment results to calculate allele abundance for the provided reference allele sequences and determines the actual alleles for each gene based on these abundance data.
> 
> T1K also offers subsequent analysis steps, including novel SNP (single nucleotide polymorphism) detection and single-cell expression analysis. T1K supports both single-end and paired-end sequencing data and is compatible with any read length.



### Step 1: Execute `T1K_temp.sh`
1. Open [`T1K_temp.sh`](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week10_1111/T1K_temp.sh) and enter the correct path names.  \
    (1) :red_circle: **Red** section: Replace the TA's username with your own.  \
    (2) :yellow_circle: **Yellow** section: Change it to your own sampleID.
   
    <img width="949" height="214" alt="截圖 2026-11-05 中午12 40 59" src="https://github.com/user-attachments/assets/5d6419c6-ef14-4946-b716-faeb1c8a822e" />


       
3. Execute`T1K_temp.sh`
```
sbatch T1K_temp.sh
```
3. Result: A total of 7 files, all located in the HLA typing folder.
```
- SRR13076390_aligned_1.fa: Records the portion of the reference sequence that R1 aligned to.
- SRR13076390_aligned_2.fa: Records the portion of the reference sequence that R2 aligned to.
- SRR13076390_allele.tsv: Records the simplified HLA typing results.
- SRR13076390_allele.vcf: Records the variant sites identified by alignment to the HLA gene.
- SRR13076390_candidate_1.fq: R1 reads identified as likely related to HLA sequences.
- SRR13076390_candidate_2.fq: R2 reads identified as likely related to HLA sequences.
- SRR13076390_genotype.tsv: Records the main analysis results for reviewing HLA genotypes.
```

:bangbang: **We need the HLA typing results, which are all stored in the file. [`SRR13076390_genotype.tsv`](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week10_1111/SRR13076390_genotype.tsv)
<img width="1173" height="254" alt="截圖 2026-11-05 下午2 00 48" src="https://github.com/user-attachments/assets/057926af-19e2-48cb-b96e-989bfe72de1a" />



Column Descriptions (using the first row as an example):
| Description | Example |
|:--|:--|
| Gene name | HLA-A |
| Number of different alleles identified | 2 |
| First allele | HLA-A*02:01:01 |
| Abundance of first allele | 1109.002429 |
| Quality score of first allele | 60 |
| Second allele | HLA-A*03:01:01 |
| Abundance of second allele | 722.066683 |
| Quality score of second allele | 60 |
| Additional possible allele | HLA-A*31:14N |
| Abundance of additional allele | 187.988517 |
| Quality score of additional allele | 2 |




 ------------------
# 生物標記物與它們的產地實作課程(十)
## 本次課程主要內容
    
#### 學習利用 T1K 做 HLA typing。


> [!Warning]
> ### 前情提要：請先複製課程所需檔案
> ```
> cd /work/username
> mkdir T1K
> cd T1K
> rsync -avz /work/u9482849/T1K/T1K_temp.sh ./
> rsync -avz /work/u9482849/T1K/hla_dna_seq.fa ./
> ```

> [!Important]
> #### 什麼是 T1K？
>　T1K（The ONE genotyper for KIR and HLA）是一種計算工具，用於推測多樣性基因（如 KIR 和 HLA）的等位基因，T1K 基於 RNA-seq、WES 或 WGS 的讀取比對結果，針對提供的等位基因參考序列計算等位基因的豐富度，並使用這些豐富度數據來確定每個基因的真實等位基因。
> 
> T1K 還提供後續分析步驟，包括新穎 SNP（單核苷酸多樣性）的檢測和單細胞表現分析，T1K 支援單端（single-end）和雙端（paired-end）測序數據，且適用於任何讀取長度。


### step 1 : 執行 `T1K_temp.sh`

1. 打開 [`T1K_temp.sh`](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week10_1111/T1K_temp.sh) 並寫入正確的路徑名稱。  \
    (1) :red_circle: **紅色** 部分：助教的 **username** 改成自己的。  \
    (2) :yellow_circle: **黃色** 部分：改成自己的檔案名稱。

   <img width="949" height="214" alt="截圖 2026-11-05 中午12 40 59" src="https://github.com/user-attachments/assets/5d6419c6-ef14-4946-b716-faeb1c8a822e" />



    
3. 執行 `T1K_temp.sh`
```
sbatch T1K_temp.sh
```
3. 得到結果 : 共7個檔案,都在 HLA typing 資料夾中。
   ```
   SRR13076390_aligned_1.fa ：紀錄參考序列中R1比對到的部分。
   SRR13076390_aligned_2.fa ：紀錄參考序列中R2比對到的部分。
   SRR13076390_allele.tsv ：紀錄簡易的HLA分型結果。
   SRR13076390_allele.vcf ：紀錄與HLA基因比對的變異位點。
   SRR13076390_candidate_1.fq ：R1被認為與HLA相關的序列。
   SRR13076390_candidate_2.fq ：R2被認為與HLA相關的序列。
   SRR13076390_genotype.tsv ：紀錄主要分析結果用於查看HLA分型。
     ```
  


:bangbang: **我們需要 S14 的 HLA typing 結果都在 [`SRR13076390_genotype.tsv`](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week10_1111/SRR13076390_genotype.tsv)
<img width="1173" height="254" alt="截圖 2026-11-05 下午2 00 48" src="https://github.com/user-attachments/assets/057926af-19e2-48cb-b96e-989bfe72de1a" />

欄位介紹（第一列為例）：
| 說明 | 範例 |
|:--|:--|
| 基因名稱 | HLA-A |
| 不同等位基因數量 | 2 |
| 第一個等位基因 | HLA-A*02:01:01 |
| 第一個等位基因豐度 | 1109.002429 |
| 第一個等位基因品質分數 | 60 |
| 第二個等位基因 | HLA-A*03:01:01 |
| 第二個等位基因豐度 | 722.066683 |
| 第二個等位基因品質分數 | 60 |
| 額外有可能的等位基因 | HLA-A*03:279N |
| 額外有可能的等位基因豐度 | 16.559770 |
| 額外有可能的等位基因品質分數 | 2 |
