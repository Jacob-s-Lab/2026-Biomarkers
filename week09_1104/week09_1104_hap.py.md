Date：20251029  
Language：[EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-IIX) / [中文](#生物標記物與它們的產地實作課程八)

## Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part IIX)

## Main Content of the Course

#### Using `hap.py` to compare the analysis results of HaplotypeCaller and Mutect2 to understand their performance and accuracy in differnt scenarios.

> [!Warning]
> ### Prerequisite: Prepare the results of the 3 WGS data from the previous tutorial, each processed with two variant calling methods: HaplotypeCaller and Mutect2!! 
> #### If not yet completed, please first copy the TA's files.
> ```markdown=
> cd /work/username
> mkdir vcf_for_happy
> cd vcf_for_happy
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S14_VC/SRR13076392_S14_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S15_VC/SRR13076393_S15_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S18_VC/SRR13076396_S18_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S14_VC/SRR13076392_S14_L002.sorted.markdup.hc.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S15_VC/SRR13076393_S15_L002.sorted.markdup.hc.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S18_VC/SRR13076396_S18_L002.sorted.markdup.hc.vcf.gz ./
> ```

> [!Important]
> #### What is `hap.py`?
> 
> `Hap.py` (Haplotype Comparison Tools) is a tool used for comparing genomic variants. It is often utilized to evaluate the accuracy of variant calling algorithms, especially in identifying variants such as SNPs and Indels in somatic or germline cells. `hap.py` can be used to compare variant calling results with known standards (e.g., a gold standard VCF) to assess the sensitivity, precision, and other metrics of variant detection methods.

### Step 1 : Run [`hap.py`](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week9_1029/hap.sh)
1. Copy the executable files and reference files required for the class.
```markdown=
cd /work/username
rsync -avz /work/evelyn92/hap.sh ./
rsync -avz /work/evelyn92/KnownPositives_hg38_Liftover.vcf ./
rsync -avz /work/evelyn92/High-Confidence_Regions_v1.2.bed.gz ./
``` 

2. Open `hap.sh` and enter the correct path names.  \
(1) 🔴 **Red** part: Change the TA's username to your own.  \
(2) 🔵 **Blue** file names: Modify according to your files.  \
(3) 🟡 **Yellow** part: Change to your own file path.

![螢幕擷取畫面 2025-10-15 152422](https://hackmd.io/_uploads/SypGyRhaex.png)
![螢幕擷取畫面 2025-10-15 153242](https://hackmd.io/_uploads/SJ6710hpxe.png)


> [!Important]
> #### Reminder: 
> **The bcftools command is used to remove multiallelic variants from the VCF file so that `hap.py` can read it.**

3. Run `hap.sh`.
```
sbatch hap.sh
```

4. Get the results: a total of 11 files.
- output_prefix.runinfo.json
- output_prefix.metrics.json.gz
- output_prefix.roc.Locations.SNP.csv.gz
- output_prefix.roc.Locations.SNP.PASS.csv.gz
- output_prefix.roc.Locations.INDEL.csv.gz 
- output_prefix.roc.Locations.INDEL.PASS.csv.gz
- output_prefix.roc.all.csv.gz
- output_prefix.summary.csv
- output_prefix.extended.csv
- output_prefix.vcf.gz
- output_prefix.vcf.gz.tbi

### Step 2: Use [`rocplot.sh`](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week9_1029/rocplot.sh) results to create an ROC plot.

1. Copy the executable files required for the class.
```markdown=
rsync -avz /work/evelyn92/rocplot/rocplot.sh ./
rsync -avz /work/evelyn92/rocplot/rocplot_test.Rscript ./
```
2. Enter R and load the required packages.
```markdown=
R
install.packages("ggplot2")
61
install.packages("tools")
q()
n
```

3. Change to the correct path.  \
   (1) 🔵 **Blue** part: Make sure whether it is a HaplotypeCaller or Mutect2 file.  \
   (2) 🔴 **Red** part: Replace with your own username.
![螢幕擷取畫面 2025-10-15 215643](https://hackmd.io/_uploads/rJljF_76agl.png)

4. Run `rocplot.sh`.
```
sbatch rocplot.sh
```
5. The results are saved in the rocplot_HC or rocplot_M2 folders, each containing two plots.
For example:

- Comparison of **SNP results** for S14, S15, S18 using Mutect2:
![hap_plot.SNP](https://hackmd.io/_uploads/BJBePXa6ex.png)


- Comparison of **Indel results** for S14, S15, S18 using Mutect2:
![hap_plot.INDEL](https://hackmd.io/_uploads/rkm-v76Txl.png)



6. You can also open IGV to compare the results from `hap.py`.
The results are saved in ```output_prefix.vcf.gz.```
- Comparison between tools:
Example: Comparison of SNPs from S18 Mutect2 and HaplotypeCaller. At position 241,884,674, the variant can be found with HaplotypeCaller, but not with Mutect2.
![螢幕擷取畫面 2025-10-15 214642](https://hackmd.io/_uploads/Hy6D8XpTeg.png)

- Comparison between samples: 
Example: Comparison of SNPs for S14, S15, S18 using Mutect2.
![樣本間比較](https://hackmd.io/_uploads/SkmUH7pTeg.png)






--------------------------------
# 生物標記物與它們的產地實作課程(八)
## 本次課程主要內容
    
#### 學習利用`hap.py`比較 Haplotypecaller 和 Mutect2 的分析結果，以了解它們在不同情境下的性能和準確性。


> [!Warning]
> ### 前情提要：需先準備好之前 tutorial 做完的三個 WGS data 分別做兩種 variant calling: HaplotypeCaller 及 Mutect2 的結果！！
> #### 如果尚未完成請先複製助教的檔案～
>  ```markdown=
> cd /work/username
> mkdir vcf_for_happy
> cd vcf_for_happy
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S14_VC/SRR13076392_S14_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S15_VC/SRR13076396_S15_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S18_VC/SRR13076396_S18_L002.sorted.markdup.m2.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S14_VC/SRR13076392_S14_L002.sorted.markdup.hc.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S15_VC/SRR13076393_S15_L002.sorted.markdup.hc.vcf.gz ./
> rsync -avzP /work/evelyn92/result/tutorial_result/tutorial_VC/S18_VC/SRR13076396_S18_L002.sorted.markdup.hc.vcf.gz ./
> ```

> [!Important]
> #### 什麼是`hap.py`？
> `hap.py`（Haplotype Comparison Tools）是一個用於比較基因組變異的工具。它經常被用來評估 variant calling 算法的準確性，特別是在體細胞或生殖細胞中的 SNPs 和 Indels 等變異的識別。`hap.py` 可以用來對比 variant calling 結果與已知的標準答案（例如 gold standard VCF ），以評估變異檢測方法的靈敏度 (Recall)、精確度 (Precision)等指標。

### step 1 : 執行 [`hap.py`](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week9_1029/hap.sh)

1. 複製上課所需執行檔與標準檔。
```markdown=
cd /work/username
rsync -avz /work/evelyn92/hap.sh ./
rsync -avz /work/evelyn92/KnownPositives_hg38_Liftover.vcf ./
rsync -avz /work/evelyn92/High-Confidence_Regions_v1.2.bed.gz ./
```

2. 打開`hap.sh`並寫入正確的路徑名稱。  \
   (1)🔴 **紅色** 部分：助教的 **username** 改成自己的。  \
   (2)🔵 **藍色** 的檔案名稱：隨你的檔案改變。  \
   (3)🟡 **黃色** 部分：改成自己的檔案路徑。
![螢幕擷取畫面 2025-10-15 152422](https://hackmd.io/_uploads/SypGyRhaex.png)
![螢幕擷取畫面 2025-10-15 153242](https://hackmd.io/_uploads/SJ6710hpxe.png)

> [!Important]
> #### 提醒：
> **bcftools 命令的部分是將 vcf 檔中的 multialelic 去除，以便`hap.py`可以讀取。**
> 

3. 執行```hap.sh```
```
sbatch hap.sh
```
4. 得到結果 : 共11個檔案。
- output_prefix.runinfo.json
- output_prefix.metrics.json.gz
- output_prefix.roc.Locations.SNP.csv.gz
- output_prefix.roc.Locations.SNP.PASS.csv.gz
- output_prefix.roc.Locations.INDEL.csv.gz 
- output_prefix.roc.Locations.INDEL.PASS.csv.gz
- output_prefix.roc.all.csv.gz
- output_prefix.summary.csv
- output_prefix.extended.csv
- output_prefix.vcf.gz
- output_prefix.vcf.gz.tbi




### step 2 : 利用 [`rocplot.sh`](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week9_1029/rocplot.sh) 結果製作 ROC 圖

1. 複製上課所需執行檔。
```markdown=
rsync -avz /work/evelyn92/rocplot/rocplot.sh ./
rsync -avz /work/evelyn92/rocplot/rocplot_test.Rscript ./
```
2. 進入R，載入需要的 package
```markdown=
R
install.packages("ggplot2")
61
install.packages("tools")
q()
n
```

3. 更改正確路徑  \
   (1)🔵 **藍色** 的部分：須注意是 **Haplotypecaller 或是 Mutect2 的檔案**。  \
   (2)🔴 **紅色** 的部分：需換成自己的 **username**。
![螢幕擷取畫面 2025-10-15 215643](https://hackmd.io/_uploads/rJljF_76agl.png)

5. 執行`rocplot.sh`
```
sbatch rocplot.sh
```
5. 得到結果存於 rocplot_HC 或 rocplot_M2 資料夾，裡面各有兩張圖。


例如：
- S14, S15, S18 Mutect2 在 SNP 的結果比較：
![hap_plot.SNP](https://hackmd.io/_uploads/SJz1Ym6Tee.png)




- S14, S15, S18 Mutect2 在 Indel 的結果比較：
![hap_plot.INDEL](https://hackmd.io/_uploads/H17xYQTaxx.png)


6. 也可以打開 IGV 比較`hap.py`的結果。
結果儲存於```output_prefix.vcf.gz```
- 工具間的比較：
    舉例：S18 Mutect2 及 Haplotypecaller 的 SNP 比較，在 chr1 的241,884,674這個位點可以在 Haplotypecaller 被找到，但在 Mutect2 找不到。
![螢幕擷取畫面 2025-10-15 214642](https://hackmd.io/_uploads/S1CWFQpTee.png)
- 樣本間的比較：
    舉例：S14, S15, S18 Mutect2 的 SNP 比較。
![樣本間比較](https://hackmd.io/_uploads/BkJmFQapee.png)
