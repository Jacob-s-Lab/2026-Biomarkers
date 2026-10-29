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
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/hg38_cds.merged.bed ./
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

6. Copy `hap.sh` and rename it `hap_M2.sh`. Replace all `HC` with **M2** in the script (including Slurm settings and all variables), and then run hap_M2.sh.
    ```
    cp hap.sh hap_M2.sh
    vim hap_M2.sh
    ```
    
> [!Warning]
> #### Make sure to set `vctool` to "M2", or your previous HC files will be overwritten.


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
  <img src="https://hackmd.io/_uploads/ByptFOg6zg.png" width="80%">

- Comparison of **INDEL results**: HaplotypeCaller vs. Mutect2
  <img src="https://hackmd.io/_uploads/ry7WYdxpGx.png" width="80%">

> #### Comparison between samples
> - Comparison of **SNP results** across `SRR13076390`, `SRR13076392`, and `SRR13076393` (using Mutect2)
>   <img src="https://hackmd.io/_uploads/r1BDtdlTfl.png" width="80%">
> - Comparison of **INDEL results** across `SRR13076390`, `SRR13076392`, and `SRR13076393` (using Mutect2)
>   <img src="https://hackmd.io/_uploads/HkiPF_l6fx.png" width="80%">


6. You can also open [**IGV**](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week04_0930/week04_0930_BWA.md#step-1-use-thinlinc-to-open-igv) to compare the results from `hap.py`.
The results are saved in ```output_prefix.vcf.gz.```
- **Comparison between tools**
<br>Example: Comparison of SNPs for `SRR13076390` using HaplotypeCaller and Mutect2. \
At position `chr10:5,200,201`, the variant can be found with Mutect2, but not with HaplotypeCaller.
    <img src="https://hackmd.io/_uploads/rkmVbpgTzl.png" width="100%">

- **Comparison between samples**
<br>Example: Comparison of SNPs across `SRR13076390`, `SRR13076392`, `SRR13076393` using Mutect2. \
At position `chr17:7,740,935`, the variant is shared across all three samples.  \
At position `chr17:7,743,278`, the variant is sample-specific and only detected in `SRR13076392`.
    <img src="https://hackmd.io/_uploads/ryt4bTlpGl.png" width="100%">



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

1. 在 `work/username` 下建立並進入 `hap` 資料夾。
    ```
    cd /work/username
    mkdir hap
    cd /work/username/hap
    ```
2. 複製上課所需執行檔與標準檔。
    ```
    rsync -avz /work/u2777445/2026Biomarker_TA/script/hap.sh ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/KnownPositives_hg38_Liftover.vcf ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/High-Confidence_Regions_v1.2.bed.gz ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/hg38_cds.merged.bed ./
    ``` 

3. 開啟 `hap.sh` 並修改。
    ```
    vim hap.sh
    ```
- Slurm
    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J 115_HC_hap          # Job name
    #SBATCH -p ngscourse           # Partition Name (等同PBS裡面的 -q Queue name)
    #SBATCH -c 2                   # 使用的core數 請參考Queue資源設定
    #SBATCH --mem=13g              # 使用的記憶體量 請參考Queue資源設定
    #SBATCH -o 115Biomarker_hap_HC.out.log       # Path to the standard output file
    #SBATCH -e 115Biomarker_hap_HC.err.log       # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```
    
- 🔴 **紅色** 部分: 輸入你的國網主機帳號
- 🟡 **黃色** 部分: 輸入你的 sample ID (e.g., SRR13076390)  <br> *忘記sample ID請[點此](https://cool.ntu.edu.tw/courses/65400/files/10266690?module_item_id=2715043)查詢*
- 🔵 **藍色** 部分: 輸入使用的 variant calling 工具 (`HC` 或 `M2`)

    <img src="https://hackmd.io/_uploads/SyPgUaO3Mx.png" width="75%">

> [!Important]
> #### 提醒：
> **bcftools 命令的部分是將 vcf 檔中的 multialelic 去除，以便`hap.py`可以讀取。**
> 

4. 執行```hap.sh```
    ```
    sbatch hap.sh
    ```
5. 得到結果 : 共11個檔案。
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

6. 複製 `hap.sh` 並命名為 `hap_M2.sh`. 將 `hap_M2.sh` 內所有的 `HC` 替換為 **M2**（包含 Slurm 設定與腳本內的所有變數），完成後執行 `hap_M2.sh`。
    ```
    cp hap.sh hap_M2.sh
    vim hap_M2.sh
    ```
    
> [!Warning]
> #### 請務必將 `vctool` 設定為 M2，否則先前產生的 HC 檔案會被覆蓋掉。


### step 2 : 利用 [`rocplot.sh`](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week9_1029/rocplot.sh) 結果製作 ROC 圖

1. 在 `work/username/hap` 下建立並進入 `rocplot` 資料夾。
    ```
    cd /work/username/hap
    mkdir rocplot
    cd /work/username/hap/rocplot
    ```
2. 複製上課所需執行檔。
    ```
    rsync -avz /work/u2777445/2026Biomarker_TA/script/rocplot.sh ./
    rsync -avz /work/u2777445/2026Biomarker_TA/hap/rocplot/rocplot.Rscript ./
    ```
3. 進入R，載入需要的 package
    ```
    R
    install.packages("ggplot2")
    61
    install.packages("tools")
    q()
    n
    ```

4. 修改 `rocplot.sh`

- Slurm
    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J 115_roc             # Job name
    #SBATCH -p ngscourse           # Partition Name (等同PBS裡面的 -q Queue name)
    #SBATCH -c 2                   # 使用的core數 請參考Queue資源設定
    #SBATCH --mem=13g              # 使用的記憶體量 請參考Queue資源設定
    #SBATCH -o 115Biomarker_roc_HCvsM2.out.log       # Path to the standard output file
    #SBATCH -e 115Biomarker_roc_HCvsM2.err.log       # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

- 輸入你的國網主機帳號

    <img src="https://hackmd.io/_uploads/HJIzbod3zl.png" width="50%">

5. 執行`rocplot.sh`
    ```
    sbatch rocplot.sh
    ```
6. 得到結果存於 rocplot_HCvsM2 資料夾，裡面有兩張圖。

- **SNP 結果比較**：HaplotypeCaller vs. Mutect2
  <img src="https://hackmd.io/_uploads/ByptFOg6zg.png" width="80%">

- **INDEL 結果比較**：HaplotypeCaller vs. Mutect2
  <img src="https://hackmd.io/_uploads/ry7WYdxpGx.png" width="80%">

> #### 樣本間的比較
> - **SNP 結果比較**：`SRR13076390`、`SRR13076392` 與 `SRR13076393`（使用 Mutect2）
>   <img src="https://hackmd.io/_uploads/r1BDtdlTfl.png" width="80%">
> - **INDEL 結果比較**：`SRR13076390`、`SRR13076392` 與 `SRR13076393`（使用 Mutect2）
>   <img src="https://hackmd.io/_uploads/HkiPF_l6fx.png" width="80%">


6. 也可以打開 [**IGV**](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week04_0930/week04_0930_BWA.md#step-1-use-thinlinc-to-open-igv) 比較`hap.py`的結果。
結果儲存於```output_prefix.vcf.gz```
- **工具間的比較**
<br>例子: `SRR13076390` Mutect2 及 HaplotypeCaller 的 SNP 比較。 \
`chr10:5,200,201` 這個位點可以在 Mutect2 被找到，但在 HaplotypeCaller 找不到。
    <img src="https://hackmd.io/_uploads/rkmVbpgTzl.png" width="100%">

- **樣本間的比較**
<br>例子: `SRR13076390`, `SRR13076392`, `SRR13076393` Mutect2 的 SNP 比較。 \
三個樣本都有在 `chr17:7,740,935` 找到變異。 `chr17:7,743,278` 僅在 `SRR13076392` 找到。
    <img src="https://hackmd.io/_uploads/ryt4bTlpGl.png" width="100%">
