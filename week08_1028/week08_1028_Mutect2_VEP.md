Date：20261028 \
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-v) / [中文](#生物標記物與它們的產地實作課程五) 

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part V)

## Main Content of the Course
1. Using GATK Mutect2 for somatic Variant Calling
2. Use VEP for annotation
3. HW2: Comparing HaplotypeCaller and Mutect2 Variant Calling Results

## **The File Tree of This Course**
[week08_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/week08_tree.txt)


> [!Important]
> #### Introduction to GATK Mutect2
> GATK (Genome Analysis Toolkit) is a widely used toolkit for variant discovery and genomic data analysis.
> - The tool used in this section is Mutect2, GATK’s specialized somatic variant calling tool designed for detecting single nucleotide variants (SNVs) and small Indels in tumor samples. Unlike HaplotypeCaller which models germline ploidy, Mutect2 is optimized to detect low-frequency somatic mutations, even in tumor-only mode. \
> [https://gatk.broadinstitute.org/hc/en-us](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2)


## Using GATK Mutect2 for somatic Variant Calling

### Step 1: Enter Directory and Copy Script 
1.  Enter the "variantcalling" folder.
      ```marksown=
      cd /work/username/variantcalling
      ```
2.  Copy the executable files needed for the class.
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/m2_variantcalling.sh ./
      ```
      or
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/m2_variantcalling.sh /work/username/variantcalling
      ```

### Step 2: Modify the Analysis Executable
1. Enter [m2_variantcalling.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/edit/main/week08_1028/ref_m2_variantcalling.sh).
      ```
      vim m2_variantcalling.sh
      ```
2. Please press <kbd>i</kbd> to modify the following code:
      >The following serves as an example based on the files  `ref_m2_variantcalling.sh` .

   <img src="https://hackmd.io/_uploads/SktA2h3sfx.png" width="75%">

    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J m2_variantcalling   # Job name
    #SBATCH -p ngscourse           # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 2                   # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=13g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_m2_variantcalling.out.log         # Path to the standard output file
    #SBATCH -e 115Biomarker_m2_variantcalling.err.log         # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

3. Make sure to replace `SUPERCOMPUTER_ACCOUNT` with your supercomputer username and `ASSIGNED_FILE` with your assigned sample ID.

   <img src="https://hackmd.io/_uploads/S1jn0h2sMl.png" width="50%">

4. Enter `:wq` to save and exit.
      ```
      :wq
      ```
5. Execute the script \
    a. Enter the following command to submit the edited draft as an sbatch job:
      ```
      sbatch m2_variantcalling.sh
      ```
    b. If submitted successfully, the following message will appear:
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. You can use the following command to check the status of the job execution:
    ```
    sacct
    ```
    ![image](https://hackmd.io/_uploads/Bkor4GBAC.png)

> [!Note]
> The expected runtime for this job is about 15~20 hours. (Varies by file size) \
> Step 6 should be done after job finished.

6. View Mutect2 Results: In the variantcallingR folder, there will be a M2.vcf file. Check the file's integrity, and the detailed steps are listed below: \
a. Open the variantcallingR folder: You can use a relative or absolute path.

   ```
   cd variantcallingR                                 # Use a relative path
   cd /work/username/variantcalling/variantcallingR   # Or use an absolute path
   ```
    b. Confirm the file exists:

   ```
   ls
   ```
    c. Verify the file's integrity:
   ```
   less ASSIGNED_FILE.M2.vcf.gz
   ```
    d. Use <kbd>Shift</kbd> + <kbd>g</kbd> to view the bottom of the file.
   ![image](https://hackmd.io/_uploads/SJofG57C0.png)

    e. Exit:
   ```
   q
   ```

> [!Important]
> #### What is Annotation?
> **Annotation** refers to the functional annotation of biological sequences (such as DNA, RNA, and proteins) to help interpret their biological significance. It primarily includes structural information, used to mark the location of genes, such as exons and introns, and functional information, used to predict the biological function of genes or the role of proteins. This helps us understand the relationship between structure and function.
> 
> #### Introduction to VEP
> **VEP (Variant Effect Predictor)** is a tool developed by Ensembl, used to analyze genetic information, especially to assess the impact of different variants in genes (such as SNVs, insertions, deletions, and structural variants) on biological function. It is particularly suitable for annotation purposes.


## Use VEP for annotation
> [!Important]
> Use the **HaplotypeCaller (HC)** variant calling output for this annotation step.

### Step 1: Create a Path on the NCHC 
1. Log in to the NCHC (For those who forgot how to log in, please refer to this [link](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)).
2. Create a folder named "annotation" in the "/work/username" directory. 
      ```marksown=
      cd /work/username
      mkdir annotation
      ```
3.  Enter the "annotation" folder.
      ```marksown=
      cd /work/username/annotation
      ```
4.  Copy the executable files needed for the class.
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/vep.sh ./
      ```
      or
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/vep.sh /work/username/annotation
      ```

### Step 2: Modify the Analysis Executable
1. Enter [vep.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/ref_vep.sh).
      ```
      vim vep.sh
      ```
2. Please press <kbd>i</kbd> to modify the following code:
      >The following serves as an example based on the files  `ref_vep.sh` .

    <img src="https://hackmd.io/_uploads/BJspyiJ3Ml.png" width="85%">

    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J annotation_HC       # Job name
    #SBATCH -p ngscourse92G        # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 14                  # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=92g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_annotation_HC.out.log      # Path to the standard output file
    #SBATCH -e 115Biomarker_annotation_HC.err.log      # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

    Make sure to replace the following placeholders in your script:
   * `SUPERCOMPUTER_ACCOUNT` with your supercomputer username
   * `ASSIGNED_FILE` with your assigned sample ID (ex. SRR13076390)
   * `HC_or_M2` with the tool that generated your input VCF (**HC**:HaplotypeCaller, **M2**:Mutect2)

       <img src="https://hackmd.io/_uploads/BJdA-iknMe.png" width="60%">


4. Introduction to commands
* VEP PATH
![image](https://hackmd.io/_uploads/rJMI4jDixl.png)

* Split multiallelic and normalized  \
![image](https://hackmd.io/_uploads/rJgNiYo2gg.png)

    ![Screenshot 2024-10-15 at 15.53.38](https://hackmd.io/_uploads/SJockiiyJe.png)

    ![Screenshot 2024-10-15 at 15.54.49](https://hackmd.io/_uploads/H10RyisJkx.png)

    ![Screenshot 2024-10-15 at 15.56.42](https://hackmd.io/_uploads/Sy5Ixjj11g.png)

    ![Screenshot 2024-10-15 at 16.31.47](https://hackmd.io/_uploads/SJp9uiikJx.png)

    [https://genome.sph.umich.edu/wiki/Variant_Normalization](https://)

* VEP annotation

    ![image](https://hackmd.io/_uploads/HyGb3Ki3xl.png)

* Original VEP output

    ![Screenshot 2024-10-15 at 16.09.19](https://hackmd.io/_uploads/SyxcSmis1kg.png)



* Format into TSV
![Screenshot 2024-10-15 at 16.00.36](https://hackmd.io/_uploads/H1ULbso1kg.png)

    ![Screenshot 2024-10-15 at 16.08.42](https://hackmd.io/_uploads/B1RI7js11g.png)

4. Enter `:wq` to save and exit.
      ```
      :wq
      ```
5. Execute the script \
a. Enter the following command to submit the edited draft as an sbatch job:
      ```
      sbatch vep.sh
      ```
    b. If submitted successfully, the following message will appear:
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. You can use the following command to check the status of the job execution:
      ```
      sacct
      ```

> [!Note]
> The expected runtime for this job is about 10~40 minutes. (Varies by file size)

6. After execution, the following files will be generated:

- **sample.HC.normed.vcf.gz**: The VCF after splitting multiallelic variants.
- **sample.HC.VEP.vcf**:  After VEP annotation, the file sample.HC.VEP.vcf_summary.html is generated first, followed by the output in VCF format.
- **sample.HC.VEP.vcf_warnings.txt**: Files containing statistical summaries and warnings after VEP annotation.
- **sample.HC.VEP.tsv, sample.HC.VEP_filtered.tsv**: The VCF format converted to TSV format, with some fields removed in the filtered version. Each line represents a variant, and different transcripts are separated by a comma (",").


### Explanation of TSV Files

> **Viewing the TSV File on NCHC**
> ```
> cd /work/username/annotation/annotationR/
> less -S ASSIGNED_FILE.HC.VEP.tsv
> ```
> <img src="https://hackmd.io/_uploads/H1vkudxhGe.png" width="90%">


1. **CHROM**: The chromosome.
2. **POS**: The position of the variant.
3. **REF**: The reference allele.
4. **ALT**: The alternate allele.
5. **DP**: Sequencing depth.
6. **Allele**: Same as ALT.
7. **Consequence**: The effect of the variant on the alternative allele.(https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html)
8. **SYMBOL**: The official gene symbol.
9. **Gene**: The ID of the affected gene (e.g., ENSG00000223972).
10. **gnomADe_EAS_AF**: The allele frequency of this variant in the East Asian population in the gnomAD Exome database.
11. **gnomADg_EAS_AF**: The allele frequency of this variant in the East Asian population in the gnomAD Genome database (if available).
12. **CLIN_SIG**: Clinical significance records in ClinVar database.
13. **TWB_official_SNV_indel_AF**: The allele frequency of this variant in the Taiwan Biobank.(https://www.sciencedirect.com/science/article/pii/S2090123223004058?via%3Dihub)


## HW2: Comparing HaplotypeCaller and Mutect2 Variant Calling Results

> [!Important]
> #### To complete HW2, you will need to compare the VCF annotation results between HC and M2.
> The HC annotation was already done in class; please **execute the M2 annotation after class once your M2 variant calling finishes** to obtain the necessary files for comparison.
> 
> ### M2 Annotation Tutorial
> 1. Enter "annotation" folder.
>    ```
>    cd /work/username/annotation/
>    ```
> 2. Copy ``vep.sh``, and rename it ``vep_m2.sh``.
>    ```
>    cp vep.sh vep_m2.sh
>    ```
> 3. Modify ``vep_m2.sh``
>    ```
>    vim vep_m2.sh
>    ```
>      Please change the following HC instances to **M2**: 
>      <img src="https://hackmd.io/_uploads/HJlve3khMx.png" width="100%">
> 4. Save and exit the file (`:wq`), then submit the job.
>    ```
>    sbatch vep_m2.sh
>    ```
> If you encounter any issues, feel free to email the TA or ask during the next class.

1. Download .tsv via rsync (Mac) or WINSCP (Windows)
2. Open .tsv file, compare the differences between HC and M2 output to answer HW2 questions on NTU COOL.

------------------------------------
# 生物標記物與它們的產地實作課程(五)
## 本次課程主要內容
 1. 利用GATK Mutect2做variant calling
 2. 利用VEP做annotation
 3. HW2:比較HaplotypeCaller和Mutect2的variant calling結果

## **本次課程的樹狀資料結構**
[week08_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/week08_tree.txt)

> [!Important]
> #### GATK Mutect2 介紹
>　- GATK（Genome Analysis Toolkit）是一套功能強大的基因組學分析軟件工具集，專門設計來處理高通量 DNA 和 RNA sequence data，特別是處理變異檢測（variant calling）、數據品質控制以及數據後處理。GATK 被廣泛應用於研究中，用來分析與疾病相關的遺傳變異、癌症基因組學及個體基因組分析。
> - 本次課程所使用的工具為 Mutect2，它是 GATK 專門用於體細胞變異偵測（somatic variant calling）的工具，專為偵測腫瘤樣本中的單核苷酸變異（SNVs）與小型插入／缺失（small Indels）所設計。不同於以生殖系倍性（germline ploidy）建立模型的 HaplotypeCaller，Mutect2 經過最佳化，即使在僅有腫瘤樣本的情況下，也能精準偵測低頻率的體細胞突變。
>   [https://gatk.broadinstitute.org/hc/en-us](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2)

## 使用 GATK Mutect2 進行 Somatic Variant Calling

### Step1:進入資料夾並複製執行檔
1. 進入variantcalling資料夾
      ```marksown=
      cd /work/username/variantcalling
      ```
2. 複製上課所需執行檔
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/m2_variantcalling.sh ./
      ```
      或
      ```marksown=
      rsync -avz /work/u2777445/2026Biomarker_TA/script/m2_variantcalling.sh /work/username/variantcalling
      ```

### Step 2 修改分析執行檔

1. 進入 [m2_variantcalling.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/edit/main/week08_1028/ref_m2_variantcalling.sh)
      ```
      vim m2_variantcalling.sh
      ```

2. 請輸入 <kbd>i</kbd> 更改以下程式碼：
      > 以下以`ref_m2_variantcalling.sh`做為示範

      <img src="https://hackmd.io/_uploads/SktA2h3sfx.png" width="75%">

      ```
      #!/usr/bin/sh
      #SBATCH -A ACD115175           # Account name/project number
      #SBATCH -J m2_variantcalling   # Job name
      #SBATCH -p ngscourse           # Partition Name 等同PBS裡面的 -q Queue name
      #SBATCH -c 2                   # 使用的core數 請參考Queue資源設定
      #SBATCH --mem=13g              # 使用的記憶體量 請參考Queue資源設定
      #SBATCH -o 115Biomarker_m2_variantcalling.out.log        # Path to the standard output file
      #SBATCH -e 115Biomarker_m2_variantcalling.err.log        # Path to the standard error ouput file
      #SBATCH --mail-user=           # e-mail
      #SBATCH --mail-type=FAIL,END   # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
      # For NCHC usage
      ```
3. 將 `SUPERCOMPUTER_ACCOUNT` 改為你的國網主機帳號，並將 `ASSIGNED_FILE` 改為你被分配到檔案的 sample ID。
      <img src="https://hackmd.io/_uploads/S1jn0h2sMl.png" width="50%">

4. 輸入`:wq`儲存離開
      ```
      :wq
      ```
5. 執行script

    a. 輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
      ```
      sbatch m2_variantcalling.sh
      ```
    b. 若送出成功將會出現以下文字:
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. 可使用以下指令查看工作執行情況
    ```
    sacct
    ```
    ![image](https://hackmd.io/_uploads/Bkor4GBAC.png)

> [!Note]
> 預計執行時間為15~20小時 (因檔案大小而有差異) \
> Step 6 請在job執行完成後再進行

6. 查看結果:在`variantcallingR`資料夾中會有 M2.vcf檔，請確認檔案完整性，詳細步驟逐條列在下面：

    a. 開啟variantcallingR資料夾:可使用相對路徑或絕對路徑
    ```marksown=
    cd variantcallingR                                 #可使用相對路徑
    cd /work/username/variantcalling/variantcallingR   #或使用絕對路徑
    ```

    b. 確認檔案存在:
    ```
    ls
    ```
    c. 確認檔案完整性:
    ```
    less ASSIGNED_FILE.M2.vcf.gz
    ```
    d. 利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部

    ![image](https://hackmd.io/_uploads/SJofG57C0.png)

    e. 退出:
    ```
    q
    ```

> [!Important]
> #### 甚麼是annotation?
> Annotation是指對生物序列（如DNA、RNA、蛋白質）進行功能標注，幫助解釋其生物意義，主要有結構資訊，用於標記基因的位置，列如exon、intron等；和功能資訊，用於預測基因的生物功能、蛋白質的作用等，這樣可以幫助我們理解結構與功能的關聯。
>
> #### VEP介紹
> VEP（Variant Effect Predictor）是由Ensembl開發的一款工具，用於分析遺傳資訊，特别是評估基因中的不同變異（如SNVs、insertion、deletion和Structural variants）對生物功能的影響，非常適合用於annotation。

## 使用VEP做annotation
> [!Important]
> 請使用 **HaplotypeCaller** (HC) 的 variant calling output進行annotation

### Step1:在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 在`work/username`建立annotation資料夾
   ```marksown=
   cd /work/username
   mkdir annotation
   ```
3. 進入annotation資料夾
   ```marksown=
   cd /work/username/annotation
   ```
4. 複製上課所需執行檔
   ```marksown=
   rsync -avz /work/u2777445/2026Biomarker_TA/script/vep.sh ./
   ```
   or
   ```marksown=
   rsync -avz /work/u2777445/2026Biomarker_TA/script/vep.sh /work/username/annotation
   ```

### Step 2: 修改分析執行檔
1. 進入 [vep.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/ref_vep.sh).
      ```
      vim vep.sh
      ```
2. 請輸入 <kbd>i</kbd> 更改以下程式碼
    >以下以`ref_vep.sh`作為示範

    <img src="https://hackmd.io/_uploads/BJspyiJ3Ml.png" width="85%">

    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J annotation_HC       # Job name
    #SBATCH -p ngscourse92G        # Partition Name 等同PBS裡面的 -q Queue name
    #SBATCH -c 14                  # 使用的core數 請參考Queue資源設定
    #SBATCH --mem=92g              # 使用的記憶體量 請參考Queue資源設定
    #SBATCH -o 115Biomarker_annotation_HC.out.log      # Path to the standard output file
    #SBATCH -e 115Biomarker_annotation_HC.err.log      # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

    更改改腳本中的以下位置:
   * 將`SUPERCOMPUTER_ACCOUNT`替換為你的國網主機帳號
   * 將`ASSIGNED_FILE`替換為你被分配到的sample ID (ex. SRR13076390)
   * 將`HC_or_M2`替換為用來產生input VCF 的工具 (**HC**:HaplotypeCaller, **M2**:Mutect2)

       <img src="https://hackmd.io/_uploads/BJdA-iknMe.png" width="60%">

3. 指令介紹
* VEP路徑
![image](https://hackmd.io/_uploads/rJMI4jDixl.png)

* 拆分單一位置多種變異以及座標向左對齊  \
![image](https://hackmd.io/_uploads/rJgNiYo2gg.png)

    ![Screenshot 2024-10-15 at 15.53.38](https://hackmd.io/_uploads/SJockiiyJe.png)

    ![Screenshot 2024-10-15 at 15.54.49](https://hackmd.io/_uploads/H10RyisJkx.png)

    ![Screenshot 2024-10-15 at 15.56.42](https://hackmd.io/_uploads/Sy5Ixjj11g.png)

    ![Screenshot 2024-10-15 at 16.31.47](https://hackmd.io/_uploads/SJp9uiikJx.png)

    [https://genome.sph.umich.edu/wiki/Variant_Normalization](https://)

* VEP註解遺傳變異

    ![image](https://hackmd.io/_uploads/HyGb3Ki3xl.png)

* 原始VEP格式（VCF）

    ![Screenshot 2024-10-15 at 16.09.19](https://hackmd.io/_uploads/SyxcSmis1kg.png)


* 轉換為Tab分隔格式
![Screenshot 2024-10-15 at 16.00.36](https://hackmd.io/_uploads/H1ULbso1kg.png)

    ![Screenshot 2024-10-15 at 16.08.42](https://hackmd.io/_uploads/B1RI7js11g.png)

4. 輸入`:wq`儲存離開
      ```
      :wq
      ```
5. 執行script

    a. 輸入以下指令，以sbatch job的方式送出編輯完成的草稿
      ```
      sbatch vep.sh
      ```
    b. 若送出成功將會出現以下文字:
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. 可使用以下指令查看工作執行情況
      ```
      sacct
      ```

> [!Note]
> 預計執行時間: 10~40分鐘 (因檔案大小而有差異)


6. 執行完成後會產生以下檔案：
- sample.HC.normed.vcf.gz：split multiallelic 後的 vcf
- sample.HC.VEP.vcf：VEP annotate 後以 vcf 的格式輸出sample.HC.VEP.vcf_summary.html
- sample.HC.VEP.vcf_warnings.txt：VEP annotate 完後的一些統計及警告的資料
- sample.HC.VEP.tsv及sample.HC.VEP_filtered.tsv：將 vcf 的格式轉換成 tsv 的格式，以及將一些的欄位刪減後的 tsv。每一行為一個 variant，若有不同 transcript 會以 "," 分隔


### TSV檔案講解說明
 
> **在國網上查看TSV檔**
> ```
> cd /work/username/annotation/annotationR/
> less -S ASSIGNED_FILE.HC.VEP.tsv
> ```
> <img src="https://hackmd.io/_uploads/H1vkudxhGe.png" width="80%">

1. CHROM：變異所在的染色體
2. POS:變異所在的座標
3. REF：參考資料之等位基因
4. ALT：變異後的等位基因
5. DP：定序深度
6. Allele：與ALT相同
7. Consequence：變異位點所影響之等位基因。(https://www.ensembl.org/info/genome/variation/prediction/predicted_data.html)
7. SYMBOL：基因的官方名稱。
8. Gene：受影響基因的 ID（例如，ENSG00000223972 等）。
9. gnomADe_EAS_AF：此變異在gnomAD Exome資料庫中的東亞人群等位基因頻率。
10. gnomADg_EAS_AF：此變異在gnomAD Genome資料庫中的東亞人群等位基因頻率（如果存在）。
12. CLIN_SIG：在ClinVar database中臨床意義。
13. TWB_official_SNV_indel_AF：最新臺灣人體資料庫中此變異的等位基因頻率。(https://www.sciencedirect.com/science/article/pii/S2090123223004058?via%3Dihub)


## HW2:比較HaplotypeCaller和Mutect2的variant calling結果

> [!Important]
> #### 完成 HW2 需要使用 HC 與 M2 的 VCF 註解結果進行比較分析
> 課堂上已完成 HC annotation，請在課後、**待 M2 variant calling 跑完後，執行 M2 annotation** 以取得比較所需之檔案。
> 
> ### M2 Annotation 教學
> 1. 進入 "annotation" 資料夾
>    ```
>    cd /work/username/annotation/
>    ```
> 2. 複製 `vep.sh`, 並重新命名為 `vep_m2.sh`
>    ```
>    cp vep.sh vep_m2.sh
>    ```
> 3. 修改 ``vep_m2.sh``
>    ```
>    vim vep_m2.sh
>    ```
>      請將以下紅框處的 HC 改為 M2：
>      <img src="https://hackmd.io/_uploads/HJlve3khMx.png" width="100%">
> 4. 儲存並離開 (`:wq`)，送出編輯完成的草稿
>    ```
>    sbatch vep_m2.sh
>    ```
> 如果遇到任何問題，歡迎隨時寄信給助教或在下次課堂詢問

1. 用 rsync (Mac) 或 WINSCP (Windows) 下載.tsv
2. 在本機開啟檔案，比較兩者找到的variants差異，回答NTU COOL上HW2的問題
