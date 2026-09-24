Date：20260930
Language：[EN](#fantastic-genomic-biomarkers-and-where-to-find-them-practical-course-part-ii) / [中文](#生物標記物與它們的產地實作課程二)  

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (Part II)

> [!IMPORTANT]
> This tutorial is for Windows users only!

## Main Content of This Course
 Use MobaXterm to open IGV and view the sorted.bam file.

## Tool Overview
 **MobaXterm (Local Software)**: An all-in-one terminal client that provides SSH access, built-in SFTP file transfer, and an embedded X11 server for remote computing and graphical tool display. \
 **IGV (Integrative Genomics Viewer)**: A tool used for visualizing and analyzing large-scale genomic data. It is widely applied in genomics, bioinformatics, and molecular biology, allowing users to intuitively display various types of genomic data, such as sequences, variants, transcription data, and epigenetic data.

### Step 1: Download MobaXterm
1. Download software: MobaXterm
  - Click [here](https://drive.google.com/file/d/1rUIF8k3mm2clIrDIFA9hGMiqlRj1BXjj/view?usp=sharing) to download ``MobaXterm_Portable_v26.5.zip``   
    <img src="https://hackmd.io/_uploads/SJRDCQz5fe.png" width="80%">
2. **Unzip** ``MobaXterm_Portable_v26.5.zip``, and you will see three files. Click ``MobaXterm_Personal_26.5`` to open the software.
    <img src="https://hackmd.io/_uploads/r17X1Vz9zg.png" width="80%">

 
### Step 2: Using MobaXterm to Log into NCHC, Access the Remote Host, and Open Terminal
> [!CAUTION]
> If you still cannot log in after following the steps below, please check the following:
> > (1) If you encounter "Permission denied (keyboard-interaction)", please ensure you have filled out the form provided by the instructor. If not, fill it out immediately and notify the TA.\
> > (2) Confirm that OTP authentication is enabled on the iService website.\
> > (3) Ensure the input order during login is correct.\
> > (4) Verify that the supercomputer password is entered correctly\
> >  (Note: This is different from the iService account password).\
> > (5) Pay attention to case sensitivity, language switching, and full-width/half-width character switching issues (Mac users should be extra cautious).
> 
> ⚠️ **If all the above issues are resolved and you still cannot log in, please notify the instructor or TA. Do not force a login attempt, as it may lock your account!**    

* The MobaXterm login screen is as follows:      
 ![image](https://hackmd.io/_uploads/r1xf1oz5Me.png)
 
1. Click Session
2. Click SSH
3. Enter the login node `twnia3.nchc.org.tw` in the server field.
4. Enter your "NCHC supercomputer account" in the username field.
5. OK
6. Accept \
   <img src="https://hackmd.io/_uploads/B1vyuoMczl.png" width="60%">
7. Enter in sequence: 1 → supercomputer password → OTP. \
   <img src="https://hackmd.io/_uploads/rJhnZsG5fl.png" width="80%">
8. Save password: No \
   <img src="https://hackmd.io/_uploads/SyLKvoGqMg.png" width="60%">
9. Terminal is opened.       
**If the system logs you out after a period of inactivity, you will need to repeat the login process**

  
### Step 3: Opening sorted.bam file in IGV on MobaXterm
1. In the terminal, use the `sh` command to start the IGV software.
   ```
   sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
   ```
   >Copy and paste is disabled. Please type using your keyboard.
3. Use the area in the upper left corner of the screen to select the corresponding reference genome.
  ![image](https://hackmd.io/_uploads/HJa0cGxpA.png)
    
    (1) Select "More..." from the dropdown menu in the upper left corner.  
      ![image](https://hackmd.io/_uploads/BJmviGeTC.jpg)
    
    (2) Search for hg38 and download Human hg38.
      ![image](https://hackmd.io/_uploads/B1loizeaR.png)
   
    (3) Use File → Load from file in the upper left corner to import SAM and BAM files (using BAM files as an example). The files are located at the following path:   
    - bam file:
    `/work/username/alignment/SRR13076392.sorted.bam/`
      ![image](https://hackmd.io/_uploads/SkeIz-Vcle.png)
    
    (4) In the upper left corner, you can select the chromosome and range to view (blue box), while in the upper right corner (red box), you can select the view size (you may need to zoom in to a sufficient scale to see the results). 
      ![image](https://hackmd.io/_uploads/rkfvbOYPh.jpg)
    
>For example, using chr16:
>
>- Enter 16:175,000-178,500 in the box above (you can >adjust the range as needed). If successful, the result will be displayed as shown in the image below.
>![image](https://hackmd.io/_uploads/r1myUreTA.png)   
 >   
>- Right-click in the gray area on the left side.
>    1. Check "View as pairs."
>    2. Select "Color alignments by → insert size and pair >orientation."
>    3. Choose "Sort alignments by → insert size." \
 ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

If you want to understand what each read's color represents in IGV, you can refer to the following link:
https://igv.org/doc/desktop/#
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]


---------------------------------------------
---------------------------------------------


# 生物標記物與它們的產地實作課程(二)

> [!IMPORTANT]
> 本教學僅適用於 Windows 使用者

## 本次課程主要內容
 使用 MobaXterm 開啟 IGV 查看 sorted.bam 檔案

## 工具概述
 **MobaXterm (本機軟體)**：全功能遠端連線終端工具，整合了 SSH 連線、SFTP 檔案傳輸介面與內建 X11 伺服器，適用於遠端指令操作與簡易圖形化介面顯示。 \
 **IGV (Integrative Genomics Viewer)**：一個用於視覺化和分析大規模基因組數據的工具。它被廣泛應用於基因組學、生物信息學和分子生物學領域，能夠直觀展示基因組序列、變異、轉錄數據、表觀遺傳數據等不同類型的基因數據。
 
## Step 1:下載 MobaXterm
### 下載 MobaXterm
1. 下載 MobaXterm 的壓縮檔
  - 點擊 [here](https://drive.google.com/file/d/1rUIF8k3mm2clIrDIFA9hGMiqlRj1BXjj/view?usp=sharing) 下載 ``MobaXterm_Portable_v26.5.zip``   
    <img src="https://hackmd.io/_uploads/SJRDCQz5fe.png" width="80%">
2. **解壓縮** ``MobaXterm_Portable_v26.5.zip``，總共有三個檔案。點擊 ``MobaXterm_Personal_26.5`` 開啟軟體。
    <img src="https://hackmd.io/_uploads/r17X1Vz9zg.png" width="80%">
    
### Step 2: 使用 MobaXterm 登入國網、進入遠端主機、開啟終端機 (terminal)
> [!CAUTION]
> 依照以下步驟仍無法登入時，請先確認：
> > (1) 如果出現Permission denied (keyboard-interaction)，請確認當時是否有填寫老師給你的表單，如果沒有請立馬填寫、通知助教\
> > (2) 是否有到iservice網站啟用OTP認證\      
> > (3) 登入時，輸入的東西順序是否正確\      
> > (4) 主機帳號密碼是否輸錯 (注意：跟iservice帳號密碼不一樣)\     
> > (5) 釐清大小寫/中英切換/全形半形字切換問題 (Mac使用者更需注意)\
>        
> **若上述問題都排除後，仍無法登入，請通知老師or助教，千萬不要硬登！會被鎖起來！！！**      
  
* MobaXterm 登入畫面如下：
 ![image](https://hackmd.io/_uploads/r1xf1oz5Me.png)
 
1. 點選 Session
2. 點選 SSH
3. 在登入節點輸入 `twnia3.nchc.org.tw`
4. 輸入國網主機帳號名稱
5. 點選 OK
6. 點選 Accept \
   <img src="https://hackmd.io/_uploads/B1vyuoMczl.png" width="60%">
7. 按順序輸入： 1 → supercomputer password → OTP \
   <img src="https://hackmd.io/_uploads/rJhnZsG5fl.png" width="80%">
8. 不儲存密碼 \
   <img src="https://hackmd.io/_uploads/SyLKvoGqMg.png" width="60%">
9. 終端機已開啟
**小提醒：如果過一陣子沒有使用，系統會自動跳出，這時候再重新操作登入流程**

### Step 3: 在 MobaXterm 上開啟 IGV，查看 sorted.bam 檔案

1. 在開啟的終端機中, 使用 `sh` 指令開啟IGV
   ```
   sh /opt/ohpc/Taiwania3/pkg/biology/IGV/IGV_v2.10.3/igv.sh
   ```
   >本操作不支援複製貼上，請使用鍵盤手動輸入
2. 透過畫面左上角的區域來選取相對應的reference genome
  ![image](https://hackmd.io/_uploads/HJa0cGxpA.png)
    
    (1) 左上角下拉選單選取**More...**  
      ![image](https://hackmd.io/_uploads/BJmviGeTC.jpg)
    
    (2) 搜尋**hg38**，下載**Human hg38**
      ![image](https://hackmd.io/_uploads/B1loizeaR.png)
   
    (3) 透過左上角的**File → Load from file**可匯入sam檔及bam檔(在這以bam檔為範例)，檔案位於以下路徑：   
    - bam file:
    `/work/username/alignment/SRR13076392.sorted.bam/`
      ![image](https://hackmd.io/_uploads/SkeIz-Vcle.png)
    
    (4) 左上角可選取要看的染色體以及範圍（藍色框），右上角（紅色框）可選取要看的大小（需要放大到足夠的級距才能看到結果） 
      ![image](https://hackmd.io/_uploads/rkfvbOYPh.jpg)

> 以*chr16*為例：
> * 請在上方輸入**16:175,000-178,500**（可自行調整級距），若成功開啟會呈現如下圖的結果
![image](https://hackmd.io/_uploads/r1myUreTA.png)

> * 在左側灰色區域點右鍵
>   1. 勾選 "View as pairs"
>   2. Color alignments by → insert size and pair orientation
>   3. Sort alignments by → insert size \
> ![image](https://hackmd.io/_uploads/Hkr0ckj80.png)

若你想要了解在 IGV 中每個 read 的顏色所代表的意義，可以參考以下連結(https://igv.org/doc/desktop/#)
[User Guide > Tracks and Data Types > Alignments > Paired-end alignments > Detecting structral variants]
