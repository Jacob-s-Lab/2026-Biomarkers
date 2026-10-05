Date：20261028 \
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-v) / [中文](#生物標記物與它們的產地實作課程五) 

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part V)

## Main Content of the Course
1. Using GATK Mutect2 for somatic Variant Calling
2. Use VEP for annotation

## **The File Tree of This Course**
[week08_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/week08_tree.txt)


> [!Important]
> #### Introduction to GATK Mutect2
> GATK (Genome Analysis Toolkit) is a widely used toolkit for variant discovery and genomic data analysis.
> - The tool used in this section is Mutect2, GATK’s specialized somatic variant calling tool designed for detecting single nucleotide variants (SNVs) and small Indels in tumor samples. Unlike HaplotypeCaller which models germline ploidy, Mutect2 is optimized to detect low-frequency somatic mutations, even in tumor-only mode. \
> [https://gatk.broadinstitute.org/hc/en-us](https://gatk.broadinstitute.org/hc/en-us/articles/360037593851-Mutect2)


## Using GATK Mutect2 for somatic Variant Calling

### Step 1: Create a Path on the NCHC 
1.  Enter the "variantcalling" folder.
      ```marksown=
      cd /work/username/variantcalling
      ```
2.  Copy the executable files needed for the class.
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

    ![image](https://hackmd.io/_uploads/Hy7pGF0qee.png)

    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J m2_variantcalling      # Job name
    #SBATCH -p ngscourse           # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 2                   # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=13g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_m2_variantcalling.out.log          # Path to the standard output file
    #SBATCH -e 115Biomarker_m2_variantcalling.err.log          # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # pecifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

3. Make sure to replace `username` with your account and change the file path.

    ![image](https://hackmd.io/_uploads/BJTXESBilx.png)

4. Enter `:wq` to save and exit.
      ```
      :wq
      ```
5. Execute the script \
    a. Enter the following command to submit the edited draft as an sbatch job:
      ```
      sbatch m2_variantcalling.sh
      ```
    b. If submitted successfully, the following message will appear (after the variantcalling.sh file completes running, an variantcallingR folder will be automatically created under the variantcalling directory to store the results):
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. You can use the following command to check the status of the job execution:
    ```
    sacct
    ```
    ![image](https://hackmd.io/_uploads/Bkor4GBAC.png)

> [!Note]
> The expected runtime for this job is about 15 hours.\
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
   less {ASSIGNED_FILE}.M2.vcf.gz
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

### Step 1: Create a Path on the NCHC 
1. Log in to the NCHC (For those who forgot how to log in, please refer to this [link](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)).
2. Create a folder named "variantcalling" in the "work/username" directory. 
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
      rsync -avz /work/u2777445/2026Biomarker_TA/script/vep.sh /work/username/annotation
      ```

### Step 2: Modify the Analysis Executable
1. Enter [vep.sh](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week08_1028/ref_vep.sh).
      ```
      vim vep.sh
      ```
2. Please press <kbd>i</kbd> to modify the following code:
      >The following serves as an example based on the files  `ref_vep.sh` .

    ![image](https://hackmd.io/_uploads/Hy7pGF0qee.png)

    ```
    #!/usr/bin/sh
    #SBATCH -A ACD115175           # Account name/project number
    #SBATCH -J annotation      # Job name
    #SBATCH -p ngscourse92G           # Partition Name (equivalent to PBS's -q Queue name)
    #SBATCH -c 14                   # Number of cores used (refer to Queue resource settings)
    #SBATCH --mem=92g              # Amount of memory used (refer to Queue resource settings)
    #SBATCH -o 115Biomarker_annotation.out.log          # Path to the standard output file
    #SBATCH -e 115Biomarker_annotation.err.log          # Path to the standard error ouput file
    #SBATCH --mail-user=           # e-mail
    #SBATCH --mail-type=FAIL,END   # pecifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
    # For NCHC usage
    ```

    Make sure to replace `username` with your account and change the file path.

    ![image](https://hackmd.io/_uploads/BJTXESBilx.png)


3. Introduction to commands
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

5. Enter `:wq` to save and exit.
      ```
      :wq
      ```
6. Execute the script \
a. Enter the following command to submit the edited draft as an sbatch job:
      ```
      sbatch vep.sh
      ```
    b. If submitted successfully, the following message will appear (after the variantcalling.sh file completes running, an variantcallingR folder will be automatically created under the variantcalling directory to store the results):
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

    c. You can use the following command to check the status of the job execution:
      ```
      sacct
      ```

> [!Note]
> The expected runtime for this job is about 20~40 minutes.

7. After execution, the following files will be generated:

- **sample.HC.normed.vcf.gz**: The VCF after splitting multiallelic variants.
- **sample.HC.VEP.vcf**:  After VEP annotation, the file sample.HC.VEP.vcf_summary.html is generated first, followed by the output in VCF format.
- **sample.HC.VEP.vcf_warnings.txt**: Files containing statistical summaries and warnings after VEP annotation.
- **sample.HC.VEP.tsv, sample.HC.VEP_filtered.tsv**: The VCF format converted to TSV format, with some fields removed in the filtered version. Each line represents a variant, and different transcripts are separated by a comma (",").

## Explanation of TSV Files

> [!Caution]
> #### Background Information
> Since VEP takes a longer time to run the annotation, the steps below will use results that have already been processed by the teaching assistant. Please copy the TA's results first.
> ```
> rsync -avz /work/evelyn92/variantcalling/variantcallingR/SRR13076392.HC.VEP_filtered.tsv ./  改成雲端下載連結？
> ```  
    
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

------------------------------------
# 生物標記物與它們的產地實作課程(五)
## 本次課程主要內容
 1. 利用BWA做alignment
 2. 利用picard做mark duplicates
 3. ❗**利用GATK做variant calling**❗
 4. 學會看vcf檔案(variant calling的結果)

> [!Important]
> #### GATK介紹
>　- GATK（Genome Analysis Toolkit）是一套功能強大的基因組學分析軟件工具集，專門設計來處理高通量 DNA 和 RNA sequence data，特別是處理變異檢測（variant calling）、數據品質控制以及數據後處理。GATK 被廣泛應用於研究中，用來分析與疾病相關的遺傳變異、癌症基因組學及個體基因組分析。
> - 課程中使用的部分為HaplotypeCaller，是GATK 中最常用的變異檢測工具，專門用於檢測單核苷酸變異（SNPs）和插入/刪除變異（Indels）。
>
>    https://gatk.broadinstitute.org/hc/en-us
>
> #### 甚麼是variant calling?
> - Variant calling（變異檢測)是生物信息學中的一個過程，用於從 DNA sequnece data 中檢測和識別基因組中的遺傳變異。這些變異可能是不同的 DNA sequence與reference genome 相比存在的差異。變異檢測的常見應用包括尋找疾病相關的基因突變、個人基因組分析以及研究群體中的遺傳多樣性。
> 
> - 變異通常可以分為以下幾類：
> (1)單核苷酸變異（SNP，Single Nucleotide Polymorphisms）：單個核苷酸的改變。例如參考序列是 A，但在樣本中發現變為 T。
> (2)插入與刪除變異（Indels，Insertions and Deletions）：DNA 序列中插入或刪除了一個或多個核苷酸。
> (3)結構變異（Structural Variants, SVs）：較大範圍的變異，可能涉及基因組的大塊重排、複製、轉位等。

## 本次課程的樹狀資料結構
[Variantcalling](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week6_1008/wk6_tree.txt)

### step1:在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 在`work/username`建立variantcalling資料夾
```marksown=
cd /work/username
mkdir VP
```
3. 進入variantcalling資料夾
```marksown=
cd /work/username/VP
```
4. 複製上課所需執行檔
```marksown=
rsync -avz /work/evelyn92/2025Biomarker/variantcalling.sh /work/username/VP
```

### step 2 修改分析執行檔


1. 進入 [variantcalling.sh](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week6_1008/variantcalling.sh).
```
vim variantcalling.sh
```

2. 請輸入 <kbd>i</kbd> 更改以下程式碼：
> 以下以`variantcalling.sh`做為示範 (格式請依照裡面給你的範例，副檔名不用寫進去)


![image](https://hackmd.io/_uploads/Hy7pGF0qee.png)



```
#!/usr/bin/sh
#SBATCH -A ACD114093                # Account name/project number
#SBATCH -J variantcalling           # Job name:可修改
#SBATCH -p ngscourse                # Partition Name:等同PBS裡面的 -q Queue name
#SBATCH -c 2                        # 使用的core數:請參考Queue資源設定
#SBATCH --mem=13g                   # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o out_vc.log               # Path to the standard output file:可修改
#SBATCH -e err_vc.log               # Path to the standard error ouput file:可修改
#SBATCH --mail-user=                # e-mail:可修改
#SBATCH --mail-type=FAIL,END        # 指定送出email時機:可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
```
3. 將`username`的位子改成自己的主機帳號並修改成正確的檔案路徑
![image](https://hackmd.io/_uploads/BJTXESBilx.png)

> [!Warning]
> #### 本次加入的步驟:Variant calling
> ![螢幕擷取畫面 2025-09-11 180745](https://hackmd.io/_uploads/ry55CpE6xe.png)

4. 輸入`:wq`儲存離開
```
:wq
```
5. 執行script

(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch variantcalling.sh
```


(2)若送出成功將會出現以下文字 (`variantcalling.sh`的檔案跑完後會自動在variantcalling資料夾下建立一個variantcallingR資料夾，將結果放在裡面)

![image](https://hackmd.io/_uploads/HymfEzrRR.png)



(3)可使用以下指令查看工作執行情況
```
sacct
```
![image](https://hackmd.io/_uploads/Bkor4GBAC.png)



 6. 查看結果:在`variantcallingR`資料夾中會有`vcf檔，並確認檔案完整性，詳細步驟逐條列在下面

(1)開啟variantcallingR資料夾:可使用相對路徑或絕對路徑
```marksown=
cd variantcallingR                           #可使用相對路徑
cd /work/username/variantcalling/variantcallingR   #或使用絕對路徑
```

(2)確認檔案存在:
```
ls
```
(3)確認檔案完整性:
```
less SRR13076392.HC.vcf.gz
```
(4)利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部

![image](https://hackmd.io/_uploads/SJofG57C0.png)


(5)退出:
```
q
```


 ## Vcf檔案講解說明
 
> [!CAUTION]
> #### 前情提要
>由於GATK在執行variant calling的時間較長，所以執行以下步驟時使用的都是助教已經跑出的結果，請先複製助教的結果到variantcalling資料夾底下(兩個檔案都要)
> ```
> rsync -avz /work/evelyn92/variantcalling/variantcallingR/SRR13076392.HC.vcf.gz ./
> rsync -avz /work/evelyn92/variantcalling/variantcallingR/SRR13076392.HC.vcf.gz.tbi ./
> ```


> [!IMPORTANT]
> #### 何為vcf檔?
> VCF（Variant Call Format）檔案是一種用於存儲基因變異數據的標準檔案格式，通常用來記錄 DNA sequence中與regerence genome不同的變異信息。VCF 檔案的主要應用是在基因組學研究中，特別是基於高通量測序（NGS）技術所產生的數據。這些檔案可以記錄多種類型的變異，包括單核苷酸多態性（SNPs）、插入或刪除變異（Indels）等。
> https://www.htslib.org/doc/vcf.html
>
> ![image](https://hackmd.io/_uploads/S17rF97RA.png)
> ![image](https://hackmd.io/_uploads/BkeBEXHRR.png)
