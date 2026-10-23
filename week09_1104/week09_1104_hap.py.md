Date：20261104  
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-vi) / [中文](#生物標記物與它們的產地實作課程六)

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part VI)

## Main Content of the Course

#### Using `hap.py` to compare the analysis results of HaplotypeCaller and Mutect2 to understand their performance and accuracy in differnt scenarios.

> [!Important]
> #### What is `hap.py`?
> 
> `hap.py` (Haplotype Comparison Tools) is a tool used for comparing genomic variants. It is often utilized to evaluate the accuracy of variant calling algorithms, especially in identifying variants such as SNPs and Indels in somatic or germline cells. `hap.py` can be used to compare variant calling results with known standards (e.g., a gold standard VCF) to assess the sensitivity, precision, and other metrics of variant detection methods.

## The File Tree of This Course
[hap_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week09_1104/week09_tree.txt)


### Step 1 : Run [hap.py](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week09_1104/ref_hap.sh)
1. Create a folder named "hap" in the "work/username" directory. Enter "hap" folder.
    ```
    cd /work/username
    mkdir hap
    cd /work/username/hap
    ```
2. Copy the executable files and reference files required for the class.
    ```
    rsync -avz /work/u2777445/2026Biomarker_TA/script/hap.sh ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/KnownPositives_hg38_Liftover.vcf ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/High-Confidence_Regions_v1.2.bed.gz ./
    ``` 

3. Open `hap.sh` and enter the correct path names.
    ```
    vim hap.sh
    ```
- Slurm
    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J 115_HC_hap          # Job name
    #SBATCH -p ngscourse           # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 2                   # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=13g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_hap_HC.out.log         # Path to the standard output file
    #SBATCH -e 115Biomarker_hap_HC.err.log         # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```
    
- 🔴 **Red** part: Enter your username.
- 🟡 **Yellow** part: Enter your sample ID. (e.g., SRR13076390)  <br> *Forgot your sample ID? Check [here](https://cool.ntu.edu.tw/courses/65400/files/10266690?module_item_id=2715043).*
- 🔵 **Blue** part: Enter your variant calling tool (`HC` or `M2`)

    <img src="https://hackmd.io/_uploads/SyPgUaO3Mx.png" width="75%">
   


> [!Important]
> #### Reminder: 
> **The bcftools command is used to remove multiallelic variants from the VCF file so that `hap.py` can read it.**
> <img src="https://hackmd.io/_uploads/r17WD9u3fl.png" width="50%">

4. Run `hap.sh`.
    ```
    sbatch hap.sh
    ```

5. Get the results: a total of 11 files.
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

6. Copy `hap.sh` and rename it `hap_M2.sh`. **Set vctool=M2** in the script, and then run hap_M2.sh.

   <img src="https://hackmd.io/_uploads/BkjAu6u3fg.png" width="10%">
    
> [!Warning]
> #### Make sure to set vctool to "M2", or your previous HC files will be overwritten.


### Step 2: Use [rocplot.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week09_1104/ref_rocplot_HC.sh) results to create an ROC plot.

1. Create a folder named "rocplot" in the "work/username/hap" directory. Enter "rocplot" folder.
    ```
    cd /work/username/hap
    mkdir rocplot
    cd /work/username/hap/rocplot
    ```
2. Copy the executable files required for the class.
    ```
    rsync -avz /work/u2777445/2026Biomarker_TA/script/rocplot.sh ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/rocplot/rocplot.Rscript ./
    ```
3. Enter R and load the required packages.
    ```
    R
    install.packages("ggplot2")
    61
    install.packages("tools")
    q()
    n
    ```

4. Modify `rocplot.sh`.

- Slurm
    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J 115_roc             # Job name
    #SBATCH -p ngscourse           # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 2                   # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=13g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_roc_HCvsM2.out.log         # Path to the standard output file
    #SBATCH -e 115Biomarker_roc_HCvsM2.err.log         # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

- Replace with your own username.

    <img src="https://hackmd.io/_uploads/HJIzbod3zl.png" width="50%">

4. Run `rocplot.sh`.
    ```
    sbatch rocplot.sh
    ```
5. The results are saved in the rocplot_HCvsM2 folder, containing two plots.

- Comparison of **SNP results**: HaplotypeCaller vs. Mutect2
  <img src="https://hackmd.io/_uploads/Hk_rUK_3Ml.png" width="80%">

- Comparison of **INDEL results**: HaplotypeCaller vs. Mutect2
  <img src="https://hackmd.io/_uploads/Hyl88tOhfx.png" width="80%">

> #### Comparison between samples
> - Comparison of **SNP results** across `SRR13076390`, `SRR13076392`, and `SRR13076393` (using Mutect2)
>   <img src="https://hackmd.io/_uploads/H1hZP1KnMe.png" width="80%">
> - Comparison of **INDEL results** across `SRR13076390`, `SRR13076392`, and `SRR13076393` (using Mutect2)
>   <img src="https://hackmd.io/_uploads/H1IWvJKhze.png" width="80%">


6. You can also open **IGV** to compare the results from `hap.py`.
The results are saved in ```output_prefix.vcf.gz.```
- Comparison between tools
<br>Example: Comparison of SNPs for `SRR13076390` using HaplotypeCaller and Mutect2. \
At position `chr1:239,220,118`, the variant can be found with HaplotypeCaller, but not with Mutect2.
    <img src="https://hackmd.io/_uploads/B1VlOou3Mx.png" width="100%">

- Comparison between samples
<br>Example: Comparison of SNPs across `SRR13076390`, `SRR13076392`, `SRR13076393` using Mutect2. \
At position chr2:47,466,649, the variant is shared across all three samples.  \
At position chr2:47,466,617, the variant is sample-specific and only detected in `SRR13076392`.
    <img src="https://hackmd.io/_uploads/BkFvglt2Ml.png" width="100%">



--------------------------------
# 生物標記物與它們的產地實作課程(六)
## 本次課程主要內容
    
#### 學習利用`hap.py`比較 Haplotypecaller 和 Mutect2 的分析結果，以了解它們在不同情境下的性能和準確性。

> [!Important]
> #### 什麼是`hap.py`？
> `hap.py`（Haplotype Comparison Tools）是一個用於比較基因組變異的工具。它經常被用來評估 variant calling 算法的準確性，特別是在體細胞或生殖細胞中的 SNPs 和 Indels 等變異的識別。`hap.py` 可以用來對比 variant calling 結果與已知的標準答案（例如 gold standard VCF ），以評估變異檢測方法的靈敏度 (Recall)、精確度 (Precision)等指標。

## **本次課程的樹狀資料結構**
[hap_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week09_1104/week09_tree.txt)


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
