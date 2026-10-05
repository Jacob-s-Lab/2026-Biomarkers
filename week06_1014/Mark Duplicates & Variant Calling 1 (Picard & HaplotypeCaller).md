Date：20261014  
Language：[EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-V) / [中文](#生物標記物與它們的產地實作課程五) 

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part V)

## Main Content of the Course
1. Use Picard to mark duplicates
2. Using GATK HaplotypeCaller for the germline Variant Calling
3. Use ThinLinc to open IGV and view the alignment/MarkDuplicates results
4. Learn to read VCF files (the results of variant calling).



> [!Important]
> #### What is Picard?
> - Picard is a genomic data analysis toolkit designed specifically for handling high-throughput sequencing data. It provides a wide range of powerful tools to assist users in performing various operations during the analysis process, such as MarkDuplicates, manipulating read groups, Sorting and indexing files, data-cleanup operations, statistical analysis, and format conversion. Picard is widely used in workflows for variant detection and genome analysis.
>
> #### What is MarkDuplicates?
> - In genomics and next-generation sequencing (NGS), duplicate reads refer to multiple reads originating from the same original DNA molecule during the sequencing process. These duplicate reads are typically produced due to the PCR amplification process, where DNA polymerase replicates the template DNA during each amplification cycle, doubling the amount of DNA with each cycle. In theory, this should produce a large number of identical DNA fragments. However, certain DNA fragments are amplified more efficiently than others during PCR, which can affect the representativeness and accuracy of the final sequencing data. This can result from factors such as primer design, GC content of the DNA sequence, secondary structures of the DNA (e.g., hairpins), PCR temperature and time, and the efficiency of the DNA polymerase.
> - **Thus, we use MarkDuplicates to identify and mark duplicate reads. This process typically occurs after alignment and is intended to prevent errors in subsequent analyses caused by duplicate reads originating from the same DNA sequence.**
>
> #### Introduction to GATK
> - GATK (Genome Analysis Toolkit) is a powerful software toolkit for genomic analysis, specifically designed to process high-throughput DNA and RNA sequence data. It focuses on variant calling, data quality control, and data post-processing. GATK is widely used in research to analyze genetic variations associated with diseases, cancer genomics, and individual genomic analysis.
> - The tool used in this course is HaplotypeCaller, which is the most commonly used variant calling tool in GATK, specifically for detecting single nucleotide variants (SNPs) and insertion/deletion variants (Indels). 
> https://gatk.broadinstitute.org/hc/en-us
>
> #### What is Variant Calling?
> 
> - **Variant calling** is a process in bioinformatics used to detect and identify genetic variations in a genome from DNA sequence data. These variations may represent differences between the DNA sequences and a reference genome. Common applications of variant calling include identifying disease-related gene mutations, individual genomic analysis, and studying genetic diversity within populations.
> 
> - Variants can typically be classified into the following categories:
> (1) Single Nucleotide Variants (SNPs): Changes in a single nucleotide. For example, if the reference sequence is A, but a T is found in the sample.
> (2) Insertions and Deletions (Indels): The insertion or deletion of one or more nucleotides in the DNA sequence.
> (3) Structural Variants (SVs): Larger-scale variations that may involve significant rearrangements, duplications, or translocations of genomic segments.


> #### How to Use `mv`
> `mv` is a command-line tool used for moving or renaming files and directories, widely used in Linux and macOS systems. The mv command helps you move files or directories from one location to another, or rename files or directories.
> - Move a file:`mv <source_file> <destination_directory>/`
> - Rename a file:`mv <old_filename> <new_filename>`
> - Move and rename a file:`mv <source_file> /<new_directory>/<new_filename>`
> - Move the directory:`mv <source_directory>/ <destination_directory>/`

## The File Tree of This Course
[Variantcalling_file tree](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week06_1014/week06_tree.txt)

### Step 1: Create a Path on the NCHC 
1. Log in to the NCHC (For those who forgot how to log in, please refer to this [link](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)).
2. Create a folder named "variantcalling" in the "work/username" directory. 
```marksown=
cd /work/username
mkdir variantcalling
```
3.  Enter the "variantcalling" folder.
 ```
cd /work/username/variantcalling
```
4.  Copy the executable files needed for the class.
```
rsync -avz /work/u9482849/2026Biomarkers ./
```

### Step 2: Modify the Analysis Executable
1. Enter [variantcalling.sh](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week6_1008/variantcalling.sh).
```
vim variantcalling.sh
```
2. Please press <kbd>i</kbd> to modify the following code:
>The following serves as an example based on the files  `variantcalling.sh` .

```
#!/usr/bin/sh
#SBATCH -A ACD114093           # Account name/project number
#SBATCH -J variantcalling      # Job name
#SBATCH -p ngscourse           # Partition Name (equivalent to PBS's -q Queue name)
#SBATCH -c 2                   # Number of cores used (refer to Queue resource settings)
#SBATCH --mem=13g              # Amount of memory used (refer to Queue resource settings)
#SBATCH -o out_vc.log          # Path to the standard output file
#SBATCH -e err_vc.log          # Path to the standard error ouput file
#SBATCH --mail-user=           # e-mail
#SBATCH --mail-type=FAIL,END   # pecifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
# For NCHC usage
```

3. Make sure to replace `username` with your account and change the file path.

![image](https://hackmd.io/_uploads/BJTXESBilx.png)

> [!Warning]
> #### The step we add today: Variant calling
> ![image](https://hackmd.io/_uploads/ry55CpE6xe.png)



4. Enter `:wq` to save and exit.
```
:wq
```
5. Execute the script
(1) Enter the following command to submit the edited draft as an sbatch job:
```
sbatch variantcalling.sh
```
(2) If submitted successfully, the following message will appear (after the variantcalling.sh file completes running, an variantcallingR folder will be automatically created under the variantcalling directory to store the results):
![image](https://hackmd.io/_uploads/HymfEzrRR.png)

(3) You can use the following command to check the status of the job execution:
```
sacct
```
![image](https://hackmd.io/_uploads/Bkor4GBAC.png)


6. View Results: In the variantcallingR folder, there will be a vcf file. Check the file's integrity, and the detailed steps are listed below:
(1) Open the variantcallingR folder: You can use a relative or absolute path.

```
cd variantcallingR                                 # Use a relative path
cd /work/username/variantcalling/variantcallingR   # Or use an absolute path
```
(2) Confirm the file exists:

```
ls
```
(3) Verify the file's integrity:
```
less SRR13076390.HC.vcf.gz
```
(4) Use <kbd>Shift</kbd> + <kbd>g</kbd> to view the bottom of the file.
![image](https://hackmd.io/_uploads/SJofG57C0.png)

(5) Exit:
```
q
```

## View Results with IGV
> [!Caution]
> ### Previous information
> Since the alignment/MarkDuplicates step in bwa takes a long time, the results used in the following steps are those already generated by the TA. Please first copy the results from the TA into the alignment folder (both files are required).
>    
> ```
> rsync -avh --progress --partial /work/u9482849/2026Biomarkers/alignment/alignmentRM/SRR13076390.sorted.markdup.bai ./
> rsync -avh --progress --partial /work/u9482849/2026Biomarkers/alignment/alignmentRM/SRR13076390.sorted.markdup.bam ./
> ```


### Step 1: Use ThinLinc to Open IGV
1. Use ThinLinc to open a terminal.
2. In the terminal, use the `sh` command to open the IGV software:
  ```
  sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
  ```
3. Use the area in the upper left corner of the screen to select the corresponding reference genome.
  ![HYRsUmf](https://hackmd.io/_uploads/HJa0cGxpA.png)

(1) Select "More..." from the dropdown menu in the upper left corner.  
  ![upload_5665be535b603da2fd1d955771c76554](https://hackmd.io/_uploads/BJmviGeTC.jpg)
    
(2) Search for hg38 and download Human hg38.
  ![image](https://hackmd.io/_uploads/HyVI28a9eg.png)

(3) Use **File → Load from file** in the upper left corner to import SAM and BAM files (using BAM files as an example). The files are located at the following path:
* bam file:`/work/username/alignment/SRR13076390.sorted.markdup.bam`


    ![image](https://hackmd.io/_uploads/SyVzTSacel.png)

(4) In the upper left corner, you can select the chromosome and range to view (blue box), while in the upper right corner (red box), you can select the view size (you may need to zoom in to a sufficient scale to see the results). 
     ![image](https://hackmd.io/_uploads/rkfvbOYPh.jpg)
    
>For example, using chr16:
>- Enter 16:175,000-178,500 in the box above (you can >adjust the range as needed). If successful, the result will be displayed as shown in the image below.
> ![image](https://hackmd.io/_uploads/H1Ys1XK60.png)
> 
>- Right-click in the gray area on the left side.
>    1. Check "View as pairs."
>    2. Select "Color alignments by → insert size and pair >orientation."
>    3. Choose "Sort alignments by → insert size."
>     ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

If you want to understand what each read's color represents in IGV, you can refer to the following link:
https://igv.org/doc/desktop/#
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]

### Step 2: Observe the Impact of MarkDuplicates (Compare This Week's and Last Week's Results)
![image](https://hackmd.io/_uploads/rJSV4Lp5ll.png)
If you want to know th details about bwa :https://bio-bwa.sourceforge.net/bwa.shtml



### Explanation of VCF Files
> [!Caution]
> #### Background Information
> Since the GATK takes a long time to execute variant calling, the results used in the following steps are those already generated by the teaching assistant. Please copy the assistant's results into the variantcalling folder (both files are required):
> ```
> rsync -avz /work/u9482849/2026Biomarkers/variantcalling/variantcallingR/SRR13076390.HC.vcf.gz ./
> rsync -avz /work/u9482849/2026Biomarkers/variantcalling/variantcallingR/SRR13076390.HC.vcf.gz.tbi ./
> ```

> [!Important]
> #### What is a VCF File?
> **VCF (Variant Call Format)** files are a standard file format used to store genetic variation data, typically documenting the differences in DNA sequences compared to a reference genome. VCF files are primarily used in genomics research, especially for data generated by next-generation sequencing (NGS) technologies. These files can record various types of variants, including single nucleotide polymorphisms (SNPs), insertions, and deletions (Indels).
> https://www.htslib.org/doc/vcf.html
> 
> ![image](https://hackmd.io/_uploads/S17rF97RA.png)
> ![image](https://hackmd.io/_uploads/rkgqBnHC0.png)

------------------------------------
# 生物標記物與它們的產地實作課程(五)
## 本次課程主要內容
 1. 利用picard做mark duplicates
 2. 利用GATK做variant calling
 3. 用thinlinc打開IGV查看alignment/ MarkDuplicates後的結果
 4. 學會看vcf檔案(variant calling的結果)

> [!Important]
> #### 甚麼是Picard?
> Picard 是一套genomic data analysis，專為處理高通量測序數據設計，提供了一系列功能強大的工具，幫助用戶在分析過程中進行各種操作，提供如 MarkDuplicates、調整讀數群組、重新排序、數據清理、統計分析和格式轉換等功能，廣泛應用於變異檢測和基因體分析的工作流程中。
>
> #### 甚麼是MarkDuplicats?
> - 在Genomics和次世代定序（NGS）中，重複讀數（duplicate reads）是指在定序的過程中由同一原始DNA分子產生的多個讀數。這些讀數的出現通常是由於PCR amplification的過程造成的，在每個擴增循環中，DNA polymerase會複製template DNA，使得每個循環後的DNA量都會成倍增加。理論上，這應該會產生大量相同的DNA片段，但因PCR的過程中，某些DNA片段的擴增效率比其他片段高，會影響最終測序數據的代表性和準確性。這種影響可能源於幾個因素：Primer的設計、DNA sequence的GC含量、DNA的二級結構(hairpin)、PCR的溫度時間及DNA polymerase的效率等。
> - **因此我們利用MarkDuplicates來辨識並標記 duplicate reads。這個過程通常在比對alignment之後進行，主要目的是防止來自同一個DNA序列因為重複讀數在後續分析中引起錯誤結果。**
>
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

> 如何使用`mv`
> - `mv` 是一個用於移動或重新命名文件和資料夾的命令行工具，在 > Linux 和 macOS 系統中廣泛使用。`mv` 命令可以幫助你將文件或目錄從一個位置移動到另一個位置，或者將文件或目錄重新命名。
> - 移動文件:`mv <source_file> <destination_directory>/`
> - 重新命名:`mv <old_filename> <new_filename>`
> - 移動並重新命名:`mv <source_file> /<new_directory>/<new_filename>`
> - 移動目錄:`mv <source_directory>/ <destination_directory>/`

## 本次課程的樹狀資料結構
[Variantcalling](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week06_1014/week06_tree.txt)

### step1:在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 在`work/username`建立variantcalling資料夾
```
cd /work/username
mkdir variantcalling
```
3. 進入variantcalling資料夾
```
cd /work/username/variantcalling
```
4. 複製上課所需執行檔
```
rsync -avz /work/u9482849/2026Biomarkers ./
```

### step 2 修改分析執行檔


1. 進入 [variantcalling.sh](week06_1014/ref_variantcalling.sh).
```
vim variantcalling.sh
```

2. 請輸入 <kbd>i</kbd> 更改以下程式碼：
> 以下以`variantcalling.sh`做為示範 (格式請依照裡面給你的範例，副檔名不用寫進去)

```
#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J variantcalling           # Job name:可修改
#SBATCH -p ngscourse                # Partition Name:等同PBS裡面的 -q Queue name
#SBATCH -c 2                        # 使用的core數:請參考Queue資源設定
#SBATCH --mem=13g                   # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_variantcalling.out_vc.log               # Path to the standard output file:可修改
#SBATCH -e 115Biomarker_variantcalling.err_vc.log               # Path to the standard error ouput file:可修改
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
less SRR13076390.HC.vcf.gz
```
(4)利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部

![image](https://hackmd.io/_uploads/SJofG57C0.png)


(5)退出:
```
q
```

 ## 用IGV察看結果
 
> [!Caution]
> ### 前情提要
> 由於bwa在執行alignment/ MarkDuplicates的時間較長，所以執行以下步驟時使用的都是助教已經跑出的結果，請先複製助教的結果到alignment資料夾底下(兩個檔案都要)
>    
> ```
> rsync -avh --progress --partial /work/u9482849/2026Biomarkers/alignment/alignmentRM/SRR13076390.sorted.markdup.bai ./
> rsync -avh --progress --partial /work/u9482849/2026Biomarkers/alignment/alignmentRM/SRR13076390.sorted.markdup.bam ./
> ```

### step 1使用Thinlinc、開啟IGV
1. 使用Thinlinc、開啟 'Xfce terminal'
2. 在terminal利用`sh`指令開啟IGV軟體
```
sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
```


3. 透過畫面左上角的區域來選取相對應的reference genome
![HYRsUmf](https://hackmd.io/_uploads/HJa0cGxpA.png)




(1) 左上角下拉選單選取**More...**
    ![upload_5665be535b603da2fd1d955771c76554](https://hackmd.io/_uploads/BJmviGeTC.jpg)


(2) 搜尋**hg38**，下載**Human hg38**
    ![image](https://hackmd.io/_uploads/HyVI28a9eg.png)



    
(3) 透過左上角的**File → Load from file**可匯入sam檔及bam檔(在這以bam檔為範例)，檔案位於以下路徑：

* bam file:`/work/username/alignment/SRR13076390.sorted.markdup.bam`


![image](https://hackmd.io/_uploads/S1dHkQFTR.png)



(4) 左上角可選取要看的染色體以及範圍（藍色框），右上角（紅色框）可選取要看的大小（需要放大到足夠的級距才能看到結果）
    ![](https://hackmd.io/_uploads/rkfvbOYPh.jpg)

> 以*chr16*為例：
> * 請在上方輸入**16:175,000-178,500**（可自行調整級距），若成功開啟會呈現如下圖的結果
![image](https://hackmd.io/_uploads/H1Ys1XK60.png)
> 
> * 在左側灰色區域點右鍵
>   1. 勾選 "View as pairs"
>   2. Color alignments by → insert size and pair orientation
>   3. Sort alignments by → insert size     
>     ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

若你想要了解在 IGV 中每個 read 的顏色所代表的意義，可以參考以下連結(https://igv.org/doc/desktop/#)
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]

### step 2 觀察MarkDuplicates這步驟的影響(比較本週及上週結果)
![image](https://hackmd.io/_uploads/HybQE8aqee.png)
如果想知道bwa的詳細內容:https://bio-bwa.sourceforge.net/bwa.shtml


 ## Vcf檔案講解說明
 
> [!CAUTION]
> #### 前情提要
>由於GATK在執行variant calling的時間較長，所以執行以下步驟時使用的都是助教已經跑出的結果，請先複製助教的結果到variantcalling資料夾底下(兩個檔案都要)
> ```
> rsync -avz /work/u9482849/2026Biomarkers/variantcalling/variantcallingR/SRR13076390.HC.vcf.gz ./
> rsync -avz /work/u9482849/2026Biomarkers/variantcalling/variantcallingR/SRR13076390.HC.vcf.gz.tbi ./
> ```


> [!IMPORTANT]
> #### 何為vcf檔?
> VCF（Variant Call Format）檔案是一種用於存儲基因變異數據的標準檔案格式，通常用來記錄 DNA sequence中與regerence genome不同的變異信息。VCF 檔案的主要應用是在基因組學研究中，特別是基於高通量測序（NGS）技術所產生的數據。這些檔案可以記錄多種類型的變異，包括單核苷酸多態性（SNPs）、插入或刪除變異（Indels）等。
> https://www.htslib.org/doc/vcf.html
>
> ![image](https://hackmd.io/_uploads/S17rF97RA.png)
> ![image](https://hackmd.io/_uploads/BkeBEXHRR.png)
