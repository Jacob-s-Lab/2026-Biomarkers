Date：20260930 \
Language：[EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-III) / [中文](#生物標記物與它們的產地實作課程三)  

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part III)

-------------------------
## FastQC Report
#### Introduction to the FastQC Report from Course II
1. Fastqc report
![image](https://hackmd.io/_uploads/SJgWblgCR.png)

2. Per base sequence quality
![image](https://hackmd.io/_uploads/BySxllgCA.png)

3. Per sequence quality scores
 ![image](https://hackmd.io/_uploads/r1LbexeCR.png)

4. Per base sequence content
![image](https://hackmd.io/_uploads/H1KfeggAA.png)

5. Per sequence GC content
![image](https://hackmd.io/_uploads/ryaNelgRC.png)

6. Per base N content
![image](https://hackmd.io/_uploads/HJbLgxeCC.png)

7. Sequence Length Distribution
![image](https://hackmd.io/_uploads/S1fPlxeAR.png)

8. Sequence Duplication Levels
![image](https://hackmd.io/_uploads/rkp_eggRR.png)

9. Overrepresented sequences \
![image2](https://hackmd.io/_uploads/r1__GI65le.png)

10. Adapter Content
![image](https://hackmd.io/_uploads/S1Y2egeCA.png)

-------------------------

## Main Content of the Course
1. Use BWA for alignment
2. Use ThinLinc to open IGV to view the alignment results.
Before proceeding, make sure to download ThinLinc. Detailed instructions can be found at the [link](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week1_0903/week1_0903.md) 

## Alignment
> [!Important]
> #### What is Alignment?
> Alignment in bioinformatics refers to comparing two or more sequences to identify their similarities and differences. These sequences can be DNA, RNA, or protein sequences. The main goal of alignment is to infer evolutionary relationships, functional similarities, or structural features by comparing different biological sequences.

## The File Tree of This Course
[Alignment_file tree](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week4_0924/wk4_tree.txt)

## Step 1: Create a Path to NCHC
1. Log into the NCHC (if you’ve forgotten how, please refer to this [link](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)).
2. Enter the work folder by `cd /work/username` and `mkdir alignment` ,this creates a folder named "alignment" in your work directory for storing files. 
```markdown=
cd /work/username
mkdir alignment
```
3. Enter the alignment folder and copy the execution files needed for the class:
```markdown=
cd alignment
pwd
rsync -azv /work/u9482849/2026Biomarkers/bwa.sh .
```

> [!Important]
> #### Command Basics 101
> `pwd`: This command stands for "print working directory" and is used to display the current directory.


## Step 2: Modify the Shell Script
Enter the [bwa.sh](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week4_0924/bwa.sh) file by typing:
```
vim bwa.sh
```

> If no content is visible in the file, it may be due to a lack of "read" permission:      
> (1) Press the `Esc` key on the keyboard, then type `:q!` to unsave and exit.     
> (2) Check the file's permissions    
> ```
> ls -lh bwa.sh
> ```
> ![image](https://github.com/user-attachments/assets/f0503a8b-dc94-47a0-9b37-d2d30e799d52)    
> ℹ️    
> `--w-rwxrwx+` means:          
> > [Type][Owner Permissions][Group Permissions][Others Permissions]         
> > 1.	`-`: File type (`-` indicates a regular file, `d` indicates a directory).      
> > 2.	Owner Permissions: `--w-`          
> >     Only write permission is granted; read and execute permissions are not.       
> > 3.	Group Permissions: `rwx`     
> >     Group members have full permissions (read, write, and execute).      
> > 4.	Others Permissions: `rwx`       
> >     Other users also have full permissions.        
> > 5.	`+`:    
> >     Indicates that the file has an Access Control List (ACL), which defines more granular permissions beyond the basic settings.    
> 
> Key Points:    
> 1. As the file owner, you lack read permission, preventing vim from displaying the file's content.   
> 2. Both group members and other users have full operational permissions.   
> 3. The `+` symbol suggests that the file may have additional ACL settings, which might restrict your operations further.
>
> (3) Change the permission of this file
> ```
> chmod u+r bwa.sh
> ```
> (4) `-rw-rwxrwx+` means read permission has been granted.
> (5) Repeat the command from Step 2-1.


> [!Important]
> #### What is BWA?
> BWA (Burrows-Wheeler Aligner) is a tool used for aligning genome sequences, particularly for mapping short reads to a reference genome.

The following example will use the files in the `bwa.sh` folder as a demonstration (please follow the format provided in the example, no need to include the file extension).

1. Press <kbd>i</kbd> to edit the following lines: Update the script following the format provided. 

![image](https://hackmd.io/_uploads/B1aeOifclx.png)

```
#!/usr/bin/sh
#SBATCH -A ACD115175           #Account name/project number
#SBATCH -J alignment           ###Job name: can be modified 
#SBATCH -p ngscourse           ###Partition Name: equivalent to the -q Queue name in PBS.
#SBATCH -c 2                   #使用的core數:Please refer to the Queue resource settings
#SBATCH --mem=13g              #使用的記憶體量:Please refer to the Queue resource settings
#SBATCH -o 115Biomarker_alignment.out.log          ###Path to the standard output file:can be modified 
#SBATCH -e 115Biomarker_alignment.err.log          ###Path to the standard error ouput file:can be modified 
#SBATCH --mail-user=           ###e-mail:can be modified 
#SBATCH --mail-type=END        ###Specify the email sending time: it can be NONE, BEGIN, END, FAIL, REQUEUE, or ALL
```

2. Make sure to replace `username` with your account and change the file path.
```
# Please enter the R1 & R2 file name and your username
user=SUPERCOMPUTER_ACCOUNT
sampleR1=/work/${user}/result/fastqc/ASSIGNED_FILE_1.fastq.gz
sampleR2=/work/${user}/result/fastqc/ASSIGNED_FILE_2.fastq.gz
sample=ASSIGNED_FILE
path1=/work/${user}/alignment/alignmentR

mkdir -p ${path1}
```
> [!Tip]
> #### How to modify `username`
> - method 1: Replace any occurrence of `username` with your own host account.   
> ![image](https://hackmd.io/_uploads/By2o1Zxoeg.png)
> - method 2 : Define `username` as a variable.    
> ![螢幕擷取畫面 2025-09-09 130229](https://hackmd.io/_uploads/Sk0FIBBjll.png)    

3. Create a folder (named `alignmentR`) to store the results.
```
mkdir -p /work/username/alignment/alignmentR
```

4. First press the <kbd>Esc</kbd>, then type `:wq` to save and exit.
```
:wq
```
5. Run the script: 
(1)Submit the edited script as a job by using`sbatch bwa.sh`
```
sbatch bwa.sh
```
(2)If successful, the script will create an "alignmentR" folder under your alignment folder containing the result files.
![image](https://hackmd.io/_uploads/H1dbv9WT0.png)
(3)To check the job status:
```
sacct
```
![螢幕擷取畫面 2024-09-12 151517](https://hackmd.io/_uploads/Hk33LGxp0.png)

6. View results: Check the files in the alignmentR folder and verify the integrity of the `.sam` and `.bam` files.

(1) Open the alignmentR folder: You can use either a relative path or an absolute path.
```
cd alignmentR                           # relative path
cd /work/username/alignment/alignmentR  # absolute path
```

> [!Important]
> #### Relative Path vs. Absolute Path
> 1. **Relative Path**: A relative path is a path that starts from the current working directory. It describes the location of a file or directory in relation to where you are currently positioned in the directory structure. For example, if you're in the "home" directory and want to access a file in the "documents" folder within "home," you could use a relative path like `./documents/filename.txt`.
>
> 2. **Absolute Path**: An absolute path is the full path to a file or directory starting from the root directory of the file system (denoted by "/"). It provides the exact location of a file or directory regardless of your current working directory. For example, `/home/username/documents/filename.txt`is an absolute path because it starts from the root (/) and traces the complete path to the file.


(2) Check if the files exist:
```
ls
```
(3) Verify the file contents:
```
less ASSIGNED_FILE.sam
```
(4) Use <kbd>shift</kbd>+<kbd>g</kbd> to scroll to the bottom
![image](https://hackmd.io/_uploads/HJUrZ7B60.png)       

> The following messages and corresponding handling methods may appear consecutively:   
> ![image](https://github.com/user-attachments/assets/cb3a456f-4fd7-44d7-84b1-53beb18a1423)   
> Press <kbd>Ctrl</kbd>+<kbd>C</kbd> on the keyboard to stop.    
> 
> ![image](https://github.com/user-attachments/assets/13e4791f-b8f9-4aab-9311-cc7b26f5a363)   
> Press "any key" on the keyboard to exit.    
> 
> ![image](https://github.com/user-attachments/assets/048dbcd2-3444-4127-9d36-b1c51ea4b4de)   
> Press `q` on the keyboard to quit.    

(5)exit by typing q
```
q
```


> [!Important]
> #### File Introduction: 
> 1. **SAM and BAM Files**
>SAM and BAM files are two common formats used in bioinformatics to represent sequence alignment results. They play a crucial role in genome sequencing and variant analysis.
> (1) **SAM File** (Sequence Alignment/Map):
> A SAM file is a text-based format used to store sequence alignment results. It is human-readable, making it easy to debug and inspect. Below is an example and a brief explanation of key fields in a
> SAM file:
> ![image](https://hackmd.io/_uploads/SyzJRMxTR.png)
> - r001: Read name.
> - 163: FLAG, which indicates the read's state (e.g., whether it is paired-end sequencing, or if it is a reverse complement).
> - chr1: The chromosome name in the reference genome.
> - 7: The starting position of the read alignment.
> - 30: The MAPQ (mapping quality) score.
> - 10M: CIGAR string, which describes how the read aligns with the reference genome (in this case, it means 10 bases are perfectly matched).
> - =: Mate read's position, "=" means it is aligned on the same chromosome.
> - 37: Starting position of the mate read.
> - 39: Insert size (distance between paired reads).
> - AGCTTAGCTA: The read's sequence.
> - *: Undefined quality score (usually this field contains actual values, but in this example, it's not filled).
> 
> (2) **BAM File** (Binary Alignment/Map):
> A BAM file is the binary and compressed version of a SAM file. It contains the same information as a SAM file but in a more efficient binary format, making it ideal for large datasets. BAM files are easier to process and store.
> 
> - `less`:
> `less` is a command-line tool used in Unix and Unix-like systems (such as Linux and macOS) to view text files. It is a pager that allows you to navigate large files easily and includes various search and navigation functions.
> 
> - `q`:
> Use the `q` to quit and exit the less viewer.

## Viewing Results in IGV

> [!Important]
> #### What is IGV?
> IGV (Integrative Genomics Viewer) is a tool used for visualizing and analyzing large-scale genomic data. It is widely applied in genomics, bioinformatics, and molecular biology, allowing users to intuitively display various types of genomic data, such as sequences, variants, transcription data, and epigenetic data.



> [!Caution] 
Since the alignment process using BWA takes a long time, the following steps will be based on results already generated by the teaching assistant. Please copy the assistant's results into the alignment folder before proceeding.(insure you copy both of bam and bai files.)
>```
> rsync -avz /work/evelyn92/alignment/alignmentR/SRR13076392.sorted.bam ./
> 
> rsync -avz /work/evelyn92/alignment/alignmentR/SRR13076392.sorted.bam.bai ./
> ```


### Step 1: Use ThinLinc to Open IGV

1. Use ThinLinc to open the 'Xfce terminal'.
2. In the terminal, use the sh command to start the IGV software.
    
```
sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
```
3. Use the area in the upper left corner of the screen to select the corresponding reference genome.
![HYRsUmf](https://hackmd.io/_uploads/HJa0cGxpA.png)
    
(1) Select "More..." from the dropdown menu in the upper left corner.  
    ![upload_5665be535b603da2fd1d955771c76554](https://hackmd.io/_uploads/BJmviGeTC.jpg)
    
(2) Search for hg38 and download Human hg38.
    ![upload_137c491955544cb3bfb7e23c7490ade3](https://hackmd.io/_uploads/B1loizeaR.png)
    
(3) Use File → Load from file in the upper left corner to import SAM and BAM files (using BAM files as an example). The files are located at the following path:   
- bam file:
    `/work/username/alignment/SRR13076392.sorted.bam/`
    ![image](https://hackmd.io/_uploads/SkeIz-Vcle.png)
    
(4) In the upper left corner, you can select the chromosome and range to view (blue box), while in the upper right corner (red box), you can select the view size (you may need to zoom in to a sufficient scale to see the results). 
     ![](https://hackmd.io/_uploads/rkfvbOYPh.jpg)
    
>For example, using chr16:
>
>- Enter 16:175,000-178,500 in the box above (you can >adjust the range as needed). If successful, the result will be displayed as shown in the image below.
>![image](https://hackmd.io/_uploads/r1myUreTA.png)   
 >   
>- Right-click in the gray area on the left side.
>    1. Check "View as pairs."
>    2. Select "Color alignments by → insert size and pair >orientation."
>    3. Choose "Sort alignments by → insert size."
 ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

If you want to understand what each read's color represents in IGV, you can refer to the following link:
https://igv.org/doc/desktop/#
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]

-----------
-----------

# 生物標記物與它們的產地實作課程(三)

## 本次課程主要內容
1. [介紹第二週做出來的fastqc report]
2. [利用BWA做alignment]
3. [用thinlinc打開IGV查看alignment的結果]
所以在這之前必須要先下載好thinlinc，詳細[連結](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week1_0903/week1_0903.md)可見此

-----------
### Fastqc Report介紹
#### 介紹第二週做出來的fastqc report
1. Fastqc report
![image](https://hackmd.io/_uploads/SJgWblgCR.png)

2. Per base sequence quality
![image](https://hackmd.io/_uploads/BySxllgCA.png)

3. Per sequence quality scores
 ![image](https://hackmd.io/_uploads/r1LbexeCR.png)

4. Per base sequence content
![image](https://hackmd.io/_uploads/H1KfeggAA.png)

5. Per sequence GC content
![image](https://hackmd.io/_uploads/ryaNelgRC.png)

6. Per base N content
![image](https://hackmd.io/_uploads/HJbLgxeCC.png)

7. Sequence Length Distribution
![image](https://hackmd.io/_uploads/S1fPlxeAR.png)

8. Sequence Duplication Levels
![image](https://hackmd.io/_uploads/rkp_eggRR.png)

9. Overrepresented sequences \
![image](https://hackmd.io/_uploads/HkLUfU69lx.png)

10. Adapter Content
![image](https://hackmd.io/_uploads/S1Y2egeCA.png)

-----------



## Alignment
> [!Important]
> #### 甚麼是Alignment?
> Alignment（比對）是bioinformatics中的一個重要概念，指的是將兩條或多條序列進行比較，以找出它們之間的相似性和差異性。這些序列可以是DNA、RNA或蛋白質的序列。Alignment 的主要目的是通過比較不同的生物序列來推測它們之間的進化關係、功能相似性或結構特徵。

## 本次課程的樹狀資料結構
[Alignment_file tree](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week4_0924/wk4_tree.txt)

### Step 1在國網上建立路徑
1. 登入國網（忘記怎麼登入的人請參見[連結](https://hackmd.io/jcvG9iIiRW6DTUysi8AKug)）
2. 進入work資料夾輸入`cd /work/username`，接著輸入`mkdir alignment`可以在國網主機目前的位置下建立一個叫做alignment的資料夾，作為本次檔案儲存的資料夾
```marksown=
cd /work/username
mkdir alignment
```
3. 進入work資料夾輸入`cd /alignmnet`資料夾，接著複製上課所需執行檔
```marksown=
cd alignmnet
pwd
rsync -azv /work/u9482849/2026Biomarkers/bwa.sh .
```

> [!Important]
> #### 命令小學堂
> `pwd`
> pwd 指令代表 "print working directory"（打印工作目錄），用於類 Unix 系統（例如 Linux 和 macOS）中，顯示當前正在工作的目錄。當在終端中執行 `pwd`時，它會顯示當前目錄的完整路徑。

### Step 2 修改分析執行檔
1. 進入 [bwa.sh](https://github.com/Jacob-s-Lab/2025-Biomarkers/blob/main/week4_0924/bwa.sh) 輸入`vim bwa.sh`
```
vim bwa.sh
```

> 如果檔案裡看不到任何內容，可能是無"讀取"權限：  
> (1) 鍵盤先按`Esc`鈕，再輸入`:q!`不儲存離開     
> (2) 請確認此檔案的權限    
> ```
> ls -lh bwa.sh
> ```
> ![image](https://github.com/user-attachments/assets/f0503a8b-dc94-47a0-9b37-d2d30e799d52)    
> ℹ️    
> `--w-rwxrwx+` 代表：      
> > [類型][擁有者權限][群組權限][其他用戶權限]         
> > 1.	-：檔案類型（- 表示一般檔案，d 表示目錄）。      
> > 2.	擁有者權限（Owner）：--w-          
> >     僅有寫入權限，沒有讀取或執行權限。       
> > 3.	群組權限（Group）：rwx     
> >     群組成員擁有讀取、寫入和執行的所有權限。    
> > 4.	其他用戶權限（Others）：rwx    
> >     其他用戶也擁有所有權限。    
> > 5.	`+` 號：    
> >     表示檔案有 存取控制清單（ACL，Access Control List），定義了比基本權限更多的細緻權限。    
> 1. 你作為檔案的擁有者，沒有讀取權限，導致 vim 無法顯示檔案內容。   
> 2. 其他用戶和群組有完全的操作權限。   
> 3. `+` 表示檔案可能有額外的 ACL 設定，這些設定可能限制了你的操作權限。
>  
> (3) 更改此檔案的權限    
> ```
> chmod u+r bwa.sh
> ```
> 
> (4) `-rw-rwxrwx+` 開通讀取權限           
> ![image](https://github.com/user-attachments/assets/92547795-910e-495c-879e-5bcbddfc513c)
>
> (5) 重複操作step2-1的指令      

> [!Important]
> #### 甚麼是BWA?
> BWA（Burrows-Wheeler Aligner）是一個用於基因組序列比對的工具，特別適用於將短序列讀段（reads）比對到參考基因組(reference genome)。

1. 請輸入<kbd>i</kbd>更改以下程式碼：
> 以下示範會以bwa.sh資料夾中的做為示範 (格式請依照裡面給你的範例，副檔名不用寫進去)

![image](https://hackmd.io/_uploads/B1aeOifclx.png)

```
#!/usr/bin/sh
#SBATCH -A ACD115175           #Account name/project number
#SBATCH -J alignment           ###Job name:可修改
#SBATCH -p ngscourse           ###Partition Name:等同PBS裡面的 -q Queue name
#SBATCH -c 2                   #使用的core數:請參考Queue資源設定
#SBATCH --mem=13g              #使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_alignment.out_al.log          ###Path to the standard output file:可修改
#SBATCH -e 115Biomarker_alignment.err_al.log          ###Path to the standard error ouput file:可修改
#SBATCH --mail-user=           ###e-mail:可修改
#SBATCH --mail-type=END        ###指定送出email時機:可為NONE, BEGIN, END, FAIL, REQUEUE, ALL
```

2. 修改`username`及檔案路徑    
```
# Please enter the R1 & R2 file name and your username
user=SUPERCOMPUTER_ACCOUNT
sampleR1=/work/${user}/result/fastqc/ASSIGNED_FILE_1.fastq.gz
sampleR2=/work/${user}/result/fastqc/ASSIGNED_FILE_2.fastq.gz
sample=ASSIGNED_FILE
path1=/work/${user}/alignment/alignmentR

mkdir -p ${path1}
```
> [!Tip]
> #### 修改`username`的方法
> - method 1 : 在任何`username`的位子輸入自己的主機帳號   
> ![image](https://hackmd.io/_uploads/By2o1Zxoeg.png)
> - method 2 : 將username寫為變數    
> ![螢幕擷取畫面 2025-09-09 130229](https://hackmd.io/_uploads/Sk0FIBBjll.png)    

3. 建立資料夾(命名為`alignmentR`)來存放結果
```
mkdir -p /work/username/alignment/alignmentR
```    
4. 鍵盤先按<kbd>Esc</kbd>鈕，再輸入`:wq`儲存離開
```
:wq
```
5. 執行script
(1)輸入以下指令，來以sbatch job的方式送出編輯完成的草稿
```
sbatch bwa.sh
```

(2)若送出成功將會出現以下文字(bwa.sh的檔案跑完後會自動在alignmnet資料下的建一個alignmentR資料夾，將結果放在裡面)

![image](https://hackmd.io/_uploads/H1dbv9WT0.png)

(3)可使用以下指令查看工作執行情況
```
sacct
```
![螢幕擷取畫面 2024-09-12 151517](https://hackmd.io/_uploads/Hk33LGxp0.png)

 5. 察看結果:在`alignmentR`資料夾中會有`sam`,`bam`檔，並確認檔案完整性，詳細步驟逐條列在下面

(1)開啟alignmentR資料夾:可使用相對路徑或絕對路徑
```marksown=
cd alignmnetR                            #可使用相對路徑
cd /work/username/alignment/alignmentR   #或使用絕對路徑
```
> [!Important]
> #### 相對路徑vs.絕對路徑
> 1. **相對路徑**: 相對路徑是從當前工作目錄開始的路徑。它描述了相對於當前目錄的位置來找到某個文件或資料夾。例如，如果你在 "home" 目錄中，想要訪問 "home" 中的 "documents" 資料夾內的文件，你可以使用相對路徑 ./documents/filename.txt。
> 
> 2. **絕對路徑**: 絕對路徑是從文件系統的根目錄（用 "/" 表示）開始的完整路徑。它提供了文件或資料夾的確切位置，與當前工作目錄無關。例如，/home/username/documents/filename.txt 是一個絕對路徑，因為它從根目錄（/）開始，並且包含到文件的完整路徑。


(2)確認檔案存在:
```
ls
```
(3)確認檔案完整性:
```
less ASSIGNED_FILE.sam
```
(4)利用 <kbd>shift</kbd>+<kbd>g</kbd> 查看檔案最底部
![image](https://hackmd.io/_uploads/HJUrZ7B60.png)   

> 可能會接連出現以下訊息&對應處理方法：   
> ![image](https://github.com/user-attachments/assets/cb3a456f-4fd7-44d7-84b1-53beb18a1423)   
> 鍵盤輸入 <kbd>Ctrl</kbd>+<kbd>C</kbd>，即可停止
> 
> ![image](https://github.com/user-attachments/assets/13e4791f-b8f9-4aab-9311-cc7b26f5a363)   
> 鍵盤輸入"任一鍵"，即可跳出
> 
> ![image](https://github.com/user-attachments/assets/048dbcd2-3444-4127-9d36-b1c51ea4b4de)   
> 鍵盤輸入`q`，即可退出    

(5)退出:
```
q
```

> [!Important]
> #### 檔案介紹
> 1. **sam檔及bam檔介紹**:
SAM和BAM檔是生物信息學中用於表示序列比對結果的兩種常見文件格式。它們在基因組測序和變異分析中扮演了重要角色。
> (1)**SAM檔**（Sequence Alignment/Map）:
是一種文本格式，用於儲存序列比對結果。它是可讀的純文本格式，方便人們閱讀和調試。
> Example:
> ![image](https://hackmd.io/_uploads/SyzJRMxTR.png)
> - r001：讀段名稱（read name）。
> - 163：標誌位（FLAG），說明讀段的狀態（如是否雙端測序、是否是反向補序列等）。
> - chr1：參考基因組的染色體名稱（chromosome）。
> - 7：讀段比對的開始位置（position）。
> - 30：比對的質量得分（MAPQ）。
> - 10M：CIGAR 字符串，表示讀段如何比對到參考基因組（這裡的意思是 10 個碱基完全匹配）。
> - =：配對讀段的位置，這裡 = 表示和當前染色體相同。
> - 37：配對讀段的開始位置。
> - 39：插入的大小（insert size）。
> - AGCTTAGCTA：讀段的序列（sequence）。
> - *：未定義的質量分數（通常會有實際數值，但這裡是未填寫）。
> 
> (2)**BAM檔**（Binary Alignment/Map）:
是 SAM 文件的二進制版本。它提供了與 SAM 文件相同的信息，但以壓縮的二進制格式存儲，便於處理和存儲。
> - `less`
less 是一個用於在 Unix 和類 Unix 系統（如 Linux 和 macOS）中查看文本文件的命令行工具。它是一個頁面查看器，能夠方便地查看大文件，並提供多種導航和搜索功能。
> - `q`
退出`less`

## 用IGV察看結果
> [!Important]
> #### 甚麼是IGV?
> IGV（Integrative Genomics Viewer）是一個用於視覺化和分析大規模基因組數據的工具。它被廣泛應用於基因組學、生物信息學和分子生物學領域，能夠直觀展示基因組序列、變異、轉錄數據、表觀遺傳數據等不同類型的基因數據。

> [!Caution]  
> 由於bwa在執行alignment的時間較長，所以執行以下步驟時使用的都是助教已經跑出的結果，請先複製助教的結果到alignment資料夾底下(兩個檔案都要)
> 
> ```
> rsync -avz /work/evelyn92/alignment/alignmentR/SRR13076392.sorted.bam ./
> 
> rsync -avz /work/evelyn92/alignment/alignmentR/SRR13076392.sorted.bam.bai ./
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
    ![upload_137c491955544cb3bfb7e23c7490ade3](https://hackmd.io/_uploads/B1loizeaR.png)



    
(3) 透過左上角的**File → Load from file**可匯入sam檔及bam檔(在這以bam檔為範例)，檔案位於以下路徑：

* bam file:
`/work/username/alignment/SRR13076392.sorted.bam/`
    ![image](https://hackmd.io/_uploads/SkeIz-Vcle.png)


(4) 左上角可選取要看的染色體以及範圍（藍色框），右上角（紅色框）可選取要看的大小（需要放大到足夠的級距才能看到結果）
    ![](https://hackmd.io/_uploads/rkfvbOYPh.jpg)

> 以*chr16*為例：
> * 請在上方輸入**16:175,000-178,500**（可自行調整級距），若成功開啟會呈現如下圖的結果
![image](https://hackmd.io/_uploads/r1myUreTA.png)

> * 在左側灰色區域點右鍵
>   1. 勾選 "View as pairs"
>   2. Color alignments by → insert size and pair orientation
>   3. Sort alignments by → insert size
> ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

若你想要了解在 IGV 中每個 read 的顏色所代表的意義，可以參考以下連結(https://igv.org/doc/desktop/#)
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]
