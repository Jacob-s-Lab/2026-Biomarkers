Date: 20260909

Language: [EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-I) / [中文](#生物標記物與它們的產地實作課程一)  



# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (part I)


## Main Content of This Course

> [!CAUTION]
> ‼️ Please Do Not skip steps, and pay close attention to the instructions

1. [NCHC registration and login](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-1-nchc-operations-and-settings)
2. [Uploading files to NCHC and downloading files](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-2-file-transfer)

## Tool Overview
 1. **iServer (Website)**: Used to create server accounts and enable OTP (One-Time Password) functionality to secure accounts.
 2. **Terminal (macOS) or CMD (Windows)**: Access the server or supercomputer remotely from the local machine for command-line operations.
 3. **rsync (macOS Tool) or WinSCP (Windows Software)**: Used for transferring and managing files between the local machine and the server.


## step 1: NCHC Operations and Settings
### Introduction
> This is a guide for NCHC registration and login. Please follow the steps below in order.

### Registering for an iService Account
1. Go to the iService interface: https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. Click "Registeration" in the upper right corner of the screen.
![image](https://hackmd.io/_uploads/ByH6hOVhR.png)

3. Read and agree to the iService Member Registration and Service Terms.
4. Enter the desired iService account name.\
(Note: The iService account here is **only for logging into the iService website (not the supercomputer!)**)
5. Fill out the **Member Information** and **Supercomputer account information** sequentially.\
 (Note: A single mobile number can only be used to apply for one account.)\
 (Note: Make sure to record the email & password used for registering (for logging into the **iService website**), as well as the supercomputer account & password (for logging into and operating the **NCHC**).)
![image](https://hackmd.io/_uploads/rkWmFLr20.png)

6. Complete the verification as instructed.\
 (Note: The member registration confirmation email will be sent to the email used for registration, and the registration authorization code will be sent via SMS.)

### Logging into iService
1. Go to the iService website: https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. Click "Login" in the upper right corner of the screen.
![image](https://hackmd.io/_uploads/SyaH6dE3A.png)

3. Click the following options at the top of the screen: Member Center -> Member Profile -> System Account
![image](https://hackmd.io/_uploads/HkmW81Yugg.png)

   A. Check if your supercomputer account has the "Enable" label next to it. If not, please check if you have completed the verification step in [Registering for an iService Account](###Registering-for-an-iService-Account).
   ![image](https://hackmd.io/_uploads/r1c0puVn0.png)
    (Note: You may periodically change the supercomputer password if necessary.)  
 
   B. Click "Create OTP Token" and check your email for the "Token Registration Notification". 
   ![image](https://hackmd.io/_uploads/ByhrAuNh0.png)

   C. Follow the instructions in the email to install the 'IDExpert' app and complete the mobile binding. 
   (https://iservice.nchc.org.tw/nchc_service/nchc_service_qa_single.php?qa_code=774)

### Project
1. After accessing the iService webpage, click the following options at the top of the screen: Member Center -> Projects -> My Projects \
![image](https://hackmd.io/_uploads/Hyk4FkFOel.png)
2. Please fill NCHC Account Registration form.
[NCHC Account Registration form](https://docs.google.com/forms/d/e/1FAIpQLSdnunRVXkrLesS0VVylwFRqyK5xhRRZFd27YM5wXWKvIn2ZMg/viewform?usp=dialog)
3. After filling out the form, please wait for the TA to add your account to the "2025 Fantastic Genomic Biomarkers and Where to Find Them" project.

### Logging into NCHC

- For Windows users, open CMD.     
![image](https://hackmd.io/_uploads/HymEIIO_ll.png)     

- For Mac users, open Terminal.     
![image](https://hackmd.io/_uploads/rkP16IH3A.png)     

1. In CMD (or Terminal), type`ssh supercomputeraccount@twnia3.nchc.org.tw`to log into the NCHC biomedical node.

> [!IMPORTANT]
> #### Commands Lecture
> - `ssh`: Log in to a remote server.
> - Usage: `ssh user@hostname`
> - `user` is your username on the remote server, and 'hostname'is the IP address or hostname of the remote server.
>   
> ⚠️ The biomedical node is `twnia3.nchc.org.tw`. When logging into the node for the first time, you will be prompted with the message: "Are you sure you want to continue connecting (yes/no/[fingerprint])?". Please type `yes` to proceed.

  - Terminal screen:
    ![](https://hackmd.io/_uploads/BkvbPN7ha.png)
  - Windows  screen:
    ![image](https://hackmd.io/_uploads/H1OqvuV3A.png)

2. Enter the two-factor authentication method (**this is not the supercomputer password**).If you chose two-factor authentication method 1 or 3, you will need to enter the OTP.

3. Enter the supercomputer password (this is not the iService login password). **It is normal if the password does not appear on the screen while typing.**

4. Enter OTP
> [!CAUTION]
> !! Enter the supercomputer password first, then the OTP. Do not reverse the order.

5. If the login is successful, you will see the following screen:
![](https://hackmd.io/_uploads/S1H454mha.png)

---------------------------------------------
 
## Step 2: File Transfer  

 
### Uploading/Downloading Files
- Mac users can use the terminal and the rsync command to [upload](#Uploading-Files-with-rsync) or [download](#Downloading-Files-Using-rsync) files.
- Windows users can use WinSCP to [upload](#Uploading-Files-Using-WinSCP) or [download](#Downloading-Files-with-WinSCP-files).
- Provide a [file](https://drive.google.com/file/d/1xu47eNwk6H98Nms1DHp9iAqrzKiloMfY/view?usp=sharing) for everyone to practice uploading/downloading. It is recommended to create a separate folder on your Desktop and place the practice file there.

## Uploading Files with rsync
1. First, ensure that the three files you want to upload are placed together in a separate folder on your computer (Do not store them in your computer’s desktop or download folder, as the subsequent steps will upload all files in that folder).
(You can just pick any small file to use for practice)

2. Open the **local terminal** on your computer (**Note: Open a new terminal, not the one where you are logged into the NCHC host!**).
![image](https://hackmd.io/_uploads/Bk3Q4L7pp.png)

3. Use the `cd` command to navigate to the directory containing the files you want to upload (You can quickly input the folder path by dragging the folder into the terminal command line).
![image](https://hackmd.io/_uploads/HyrRNL7aa.png)
(For reference on how to display the file or folder path in Finder on a Mac, see [macOS User Guide](https://support.apple.com/zh-tw/guide/mac-help/mchlp1774/mac)).

4. Use the following command to upload the files from your local directory to `/home/supercomputer account/HW1` on the NCHC host (Replace your_username with your actual username): ``rsync -azrvh .supercomputeraccount@twnia3.nchc.org.tw:/home/supercomputeraccount/HW1``

> [!IMPORTANT]
> #### Command Lecture
> - `rsync` :The command itself, used for synchronizing files and directories.
> -  `-azrvh` :
>  1. -a : Archive mode. This is a combination of several options that preserve the structure and attributes of the files. It ensures that symbolic links, devices, attributes, permissions, ownerships, and timestamps are preserved. Essentially, it attempts to make an exact copy of the source.
>  2. -z : Compress file data during the transfer. This option compresses the data as it is being transferred to reduce the amount of data that needs to be sent over the network or between locations.
>  3. -r : Recursive. This option tells rsync to copy directories recursively. It is necessary when you want to synchronize directories and their contents.
>  4. -v : Verbose. This option increases the verbosity of the output, providing more information about what rsync is doing during the synchronization process. It shows details about the files being transferred and other related actions.
>  5. -h : Human-readable. This option makes the output more readable by converting file sizes into a human-friendly format (e.g., KB, MB) rather than displaying raw byte sizes.
>  6. "." : This represents the source directory. In this case, it means the current directory. rsync will synchronize the contents of the current directory to the specified destination (which is missing in this command).
>     
> ⚠️ If the directory name on NCHC is not "HW1", modify it accordingly.\
>     (Note: The "."represents the current directory.)\
> ⚠️ **There must be a space between the file and "."**\
>     (Note: If the files are large, it may take some time to upload, so be patient.)

5. Enter your two-factor authentication, supercomputer password, and OTP (required only if you selected 1 or 3 as your authentication method) in sequence to start uploading the files.

---------------------------------------------
### Downloading Files Using rsync
1. Open the local terminal and `cd` to the **directory where you want to download the files** (You can input the folder path by dragging the folder into the terminal command line). 
(Note: **Open a new terminal, not the one where you are logged into the NCHC host!**).
![image](https://hackmd.io/_uploads/HJ2t2Aq2a.png)

2. Use the following command to download the folder `/home/your_username/HW1` from the NCHC server to the current local directory:
   ``` 
   rsync -azvh supercomputeraccount@twnia3.nchc.org.tw:file path .
   ```
   If you need to download a **folder**, modify the command to `rsync -azrvh`.
   (Important: **There must be a space between the file and "."**)

3. Enter your **authentication method**, **supercomputer password**, and **OTP** in sequence to start the download. After the download is complete, you can access the files from your local machine.
   
---------------------------------------------
### Uploading Files Using WinSCP
1. If you haven’t installed WinSCP, go to this [link](https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download) and click **Direct Download** to download.
![image](https://hackmd.io/_uploads/SkgMA6gcex.png)

2. Follow the prompts: click Accept → Next → Next → Install. When the following screen appears, click Finish to complete the installation.
![image](https://hackmd.io/_uploads/Sysw0Te9xl.png)

3. Open WinSCP

4. Fill in or change the options as shown in the following screen:
![image](https://hackmd.io/_uploads/SJze0T9_ee.png)
 ```
 File protocol: SFTP
 Host name: twnia3.nchc.org.tw
 User name: your supercomputer account
 Password: your supercomputer passward
 ```
5. After making the changes, click **Save** → **OK** → **Login** → **Accept**. In the pop-up window, enter in sequence: **1** → **supercomputer password** → **OTP**.

6. Once connected successfully, the left panel shows your local files and paths, while the right panel shows your NCHC files and paths.
![image](https://hackmd.io/_uploads/ByheMC5dgg.jpg)

7. On the right side under remote site, navigate to the directory where you want to upload the files.
![image](https://hackmd.io/_uploads/By9g8Cc_xx.jpg)
![image](https://hackmd.io/_uploads/ByGRUC5_xe.png)

8. In the left panel (local space), select the file you want to upload and drag it to the right panel (NCHC space) to upload it to NCHC.

### Downloading Files with WinSCP
1. Connect as described earlier in the [Uploading Files](###Uploading-Files-Using-WinSCP) section.

2. On the left side, navigate to the directory where you want to download the files (to avoid losing track of where the files are saved).

3. On the right side (NCHC directories), select the files you want to download, right-click and choose Download. The files will be downloaded to the directory displayed on the left side of the screen.        
![image](https://hackmd.io/_uploads/Bywn5Cqdgl.jpg)
 (**Note: If you want to open the file, do not open it directly from the local site panel in WinSCP. Instead, go back to your computer’s desktop, navigate to the path where you saved the file, and open it from there. Opening it directly from the local site panel in WinSCP will upload the file to NCHC.**)

---------------------------------------------
---------------------------------------------

# 生物標記物與它們的產地實作課程(一)


## 本次課程主要內容
> [!CAUTION]
> ‼️不要跳步驟、不要跳步驟、不要跳步驟
> ‼️請看好文字及注意事項、請看好文字及注意事項、請看好文字及注意事項

1. [國網註冊及登入](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-1國網操作與設定)
2. [上傳檔案至國網及至國網下載檔案](https://github.com/Jacob-s-Lab/2026-Biomarkers/blob/main/week01_0909/week01_NCHC_account.md#step-2檔案資料傳輸)


## 工具概述

1. **iServer（網站）**：用於建立伺服器帳號，並啟用 OTP（一次性密碼）功能來保護帳號安全
2. **Terminal開啟終端機（macOS）或CMD命令列（Windows）**：從本地電腦遠端登入伺服器或超級電腦，進行指令操作
3. **rsync（macOS 工具）或 WinSCP（Windows 軟體）**：在本地與伺服器之間傳輸與管理檔案


## Step 1:國網操作與設定

### 前言
> 這是一份國網註冊及登入的教學指南，請按照以下步驟逐一操作

### 註冊iservice帳號
1. 進入iservice介面：https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. 點選畫面右上角的"註冊"       
![image](https://hackmd.io/_uploads/B1VWT7Q36.png)      
3. 閱讀並同意iService會員註冊及服務使用條款
4. 請輸入預計註冊的iservice帳號
(注意：這裡的iservice帳號**只是用來登入iservice網站(非主機！)用的**)
5. 依序填寫**會員資料**、**主機帳號資料** 
(注意：一支手機號碼只能申請一個帳號)
(注意：請記下你用來註冊的信箱＆密碼(用來登入**iservice網站**)、記下你的主機帳號＆密碼(用來登入及操作**國網主機**))      
![image](https://hackmd.io/_uploads/BJF9JVXhp.png)     
6. 依照指示完成驗證
(注意：會員註冊確認信會寄送到你用來註冊的信箱、註冊授權碼會寄送到手機簡訊)

### 登入iservice帳號
1. 進入iservice介面：https://iservice.nchc.org.tw/nchc_service/index.php?lang_type=
2. 點選畫面右上角的"登入"     
![image](https://hackmd.io/_uploads/B1VWT7Q36.png)     
3. 依序點選畫面上方的：會員中心->會員資訊->主機帳號資訊
![image](https://hackmd.io/_uploads/rkcKy8Ouge.png)

    A. 注意你的主機帳號旁邊是否有註記"啟用"，若沒有請注意[註冊iservice帳號](##註冊iservice帳號)是否有完成驗證步驟      
     ![image](https://hackmd.io/_uploads/SkgBlY4X2a.png)      
        (注意：若有需要可自行定期更改主機密碼)     
    B. 請點選"建立OTP載具"，並到當時註冊的信箱中收取"載具註冊通知信"      
     ![image](https://hackmd.io/_uploads/HyoL8V736.png)      
    C. 依據信件中的指示安裝『IDExpert APP』並完成綁定手機      
  *更詳細的[取得OTP認證碼](https://iservice.nchc.org.tw/nchc_service/nchc_service_qa_single.php?qa_code=774)步驟請參考連結文章

### 加入計畫
1. 進入iservice網頁後，依序點選畫面上方的：會員中心->計畫管理->我的計畫
![image](https://hackmd.io/_uploads/rJDAbL_ueg.png)
2. 請填寫表單[NCHC Account Registration form](https://docs.google.com/forms/d/e/1FAIpQLSdnunRVXkrLesS0VVylwFRqyK5xhRRZFd27YM5wXWKvIn2ZMg/viewform?usp=dialog)
4. 完成表單後，**敬請等待**助教們將您的帳號加入本課程「2025生物標記物與它們的產地」的計畫中

### 登入國網
* 使用Windows的同學開啟命令題字元(CMD)      
![image](https://hackmd.io/_uploads/HymEIIO_ll.png)      

* 使用Mac的同學開啟終端機 (terminal)      
![](https://hackmd.io/_uploads/H1K5YKDna.png)      

1. 在CMD(或terminal)中打上`ssh 主機帳號@twnia3.nchc.org.tw`登入國網生醫節點
> [!IMPORTANT]
> #### 命令小學堂
> - `ssh`:登錄到遠程伺服器
> - 用法:`ssh user@hostname`
> - `user` 你在遠程伺服器上的用戶名，'hostname' 是遠程伺服器的 IP 地址或主機名。
>  
> ⚠️ `twnia3.nchc.org.tw`為生醫節點。另外，第一次登入節點時會出現 "Are you sure you want to continue connecting (yes/no/[fingerprint])?"，請輸入 `yes`。

- 終端機畫面：
![](https://hackmd.io/_uploads/BkvbPN7ha.png)
- Windows畫面：
![image](https://hackmd.io/_uploads/Hk-LvdVhC.png)

2. 輸入兩階段驗證方式（**不是主機密碼**），若兩階段驗證方式選擇1或3，需要輸入OTP
3. 輸入主機密碼(不是登入iservice的密碼)，輸入密碼時密碼沒有出現在螢幕上是正常的
4. 輸入OTP

> [!CAUTION]
> ‼️注意是先輸入主機密碼，再輸入OTP，不要輸反了</span>

5.登入成功則可以看到以下畫面
![](https://hackmd.io/_uploads/S1H454mha.png)

---------------------------------------------

## Step 2:檔案資料傳輸
### 上傳/下載檔案

- 使用Mac的同學可使用終端機並搭配[rsync指令上傳](#使用rsync上傳檔案)/[下載](#使用rsync下載檔案)
- 使用Windows的同學可使用[WinSCP上傳](#使用WinSCP上傳檔案)/[下載](#使用WinSCP下載檔案)
- 提供大家練習[上傳/下載的檔案](https://drive.google.com/file/d/1xu47eNwk6H98Nms1DHp9iAqrzKiloMfY/view?usp=sharing)，建議放在桌面獨立新增的資料夾

-----------------------------

### 使用rsync上傳檔案
1. 首先，先確認你自己的電腦，你要上傳的檔案是否統一放在一個獨立的資料夾
   (⚠️千萬不要放到本機電腦的desktop or download，不然依照後面的步驟會把所有在資料夾的檔案全部上傳喔)
   (可以隨便選一個檔案大小小的檔案作為練習用)
   
3. 開啟**本機端的**終端機
(**注意，要另外開一個終端機，不是你現在有登入國網主機的終端機！**)
![image](https://hackmd.io/_uploads/Bk3Q4L7pp.png)

4. `cd` 到你要上傳的資料夾位置（資料夾位置的部分，可用滑鼠拖曳的方式將資料夾拉到終端機指令區，即可快速輸入資料夾位置）
![image](https://hackmd.io/_uploads/HyrRNL7aa.png)
 （附註：『Mac如何在finder顯示檔案或檔案夾的路徑位置』可參見[macOS 使用手冊](https://support.apple.com/zh-tw/guide/mac-help/mchlp1774/mac)）
![image](https://hackmd.io/_uploads/Hk3bBUmaT.png)


5. 使用以下指令將本機資料夾中的檔案上傳到 `/home/主機帳號/HW1` 下 (請自行將主機帳號替換成自己的)
    ```
    rsync -azrvh . 主機帳號@twnia3.nchc.org.tw:/home/主機帳號/HW1
    ```

> [!IMPORTANT]
> #### 命令小學堂
> - `rsync`：這是用來同步文件和目錄的命令工具
> - `-azrvh`:
>  1. -a：歸檔模式。這是一個選項組合，保留文件的結構和屬性。確保符號鏈接、設備、屬性、權限、所有權和時間戳被保留。基本上，它會嘗試創建源文件的精確副本。
>  2. -z：在傳輸過程中壓縮文件數據。這個選項會在數據傳輸過程中進行壓縮，以減少需要通過網絡或在位置之間傳輸的數據量。
>  3. -r：遞歸。這個選項告訴 rsync 以遞歸方式複製目錄。當你想同步目錄及其內容時，這個選項是必要的。
>  4. -v：詳細模式。這個選項增加了輸出的詳細程度，提供更多有關 rsync 在同步過程中正在做什麼的信息。它顯示有關正在傳輸的文件和其他相關操作的詳細信息。
>  5. -h：人類可讀。這個選項使輸出更易於閱讀，將文件大小轉換為更友好的格式（例如 KB、MB），而不是顯示原始字節大小。
>  6. "."：這表示源目錄。在這種情況下，它意味著當前目錄。rsync 會將當前目錄的內容同步到指定的目標位置（在這個命令中目標位置缺失）。
>
> ⚠️ 如果你在國網上建的資料夾名稱不是 "HW1" 的話，請根據你的資料夾名稱更改\
     （附註："."代表你現在資料夾所在的位置）\
> ⚠️**檔案與 "." 之間需空一格**）\
     （附註，檔案比較大，可能會上傳很久，可以打坐冥想）

 
5. 依序輸入**兩階段驗證方式**、**主機密碼** 與 **OTP**（若兩階段驗證方式選擇1或3才需要) 後就會將資料夾中的檔案開始上傳

---------------------------------------------

### 使用rsync下載檔案

1. 開啟**本機端的**終端機並 `cd` 到**檔案要下載到的位置**（可用滑鼠拖曳的方式將資料夾位置輸入到終端機中）
   (**注意，要另外開一個終端機，不是你現在有登入國網主機的終端機！**)
![](https://hackmd.io/_uploads/HJ2t2Aq2a.png)

2. 使用以下指令將國網上的資料夾`/home/主機帳號/HW1`下載到本機端當前路徑
    ```
    rsync -azvh 主機帳號@twnia3.nchc.org.tw:/home/主機帳號/HW1 .
    ```
    若需要下載的為**資料夾**，則須在前面的指令改為`rsync -azrvh`
    （注意：**檔案與 "." 之間需空一格**）
3. 依序輸入 **1**、**主機密碼** 與 **OTP** 後就會開始下載，下載完成後即可從本地端開啟檔案

-----------------------------

### 使用WinSCP上傳檔案
1. 若沒安裝WinSCP的同學，請至[此網址](https://winscp.net/download/WinSCP-6.5.3-Setup.exe/download)下載，點選 **Direct Download** 並點選download
![image](https://hackmd.io/_uploads/SkgMA6gcex.png)
2. 依序點選 接受 -> 下一步 -> 下一步 -> 安裝，出現以下畫面後按完成即完成安裝     
![image](https://hackmd.io/_uploads/Sysw0Te9xl.png)      

3. 開啟WinSCP

4.依照以下畫面填入或更改選項
  ![image](https://hackmd.io/_uploads/HkYnkTY_gl.png)  
   ```
   檔案協定:SFTP
   主機名稱: twnia3.nchc.org.tw
   使用者名稱: 你的國網帳號名稱
   密碼: 你的主機密碼
   ```

5. 更改完成後按下 **儲存** -> **確定** -> **登入** -> **接受**，並在跳出的視窗依序輸入 ：**1** -> **主機密碼** -> **OTP**
  
6. 連線成功後，如下圖所示，左半部是你的本機空間與路徑，右半部是你的國網空間與路徑
![image](https://hackmd.io/_uploads/ry9rY29_ee.png)

7. 請在右半部"遠端站台"處，改成檔案所在路徑(用意是要將檔案上傳到這個路徑下)      
![1](https://hackmd.io/_uploads/Sk0j5h5_lx.png)
![2](https://hackmd.io/_uploads/rkUCqnq_gx.png)

8. 在左半部(本機空間)選取要上傳的檔案，拖移到右半部(國網空間)即可將檔案上傳至國網\
   (可以使用上課講義的檔案作為練習)


### 使用WinSCP下載檔案
1. 請依照前面 [上傳檔案](#使用WinSCP上傳檔案) 的流程進行連線
2. 在左半部先移動到檔案要下載到的資料夾下
    (注意：避免到時候檔案下載到你不知道的地方去)
3. 在右半部(國網主機空間)選取要下載的檔案，**按右鍵**選擇**下載**即可將檔案下載(檔案放的位置就在你左半部顯示的資料夾路徑下)      
![image](https://hackmd.io/_uploads/HkGIhn5del.png)\
(**注意，若想要開啟檔案，請不要直接在WinSCP的本地站台點開，請回到你的電腦桌面點選剛剛儲存的路徑再去打開檔案，若直接從WinSCP的本地站台點選檔名，將會把檔案上傳到國網**）

-----------------------------
