Date：20260916 & 20260923  
Language：[EN](#Fantastic-Genomic-Biomarkers-and-Where-to-Find-Them-Practical-Course-part-II) / [中文](#生物標記物與它們的產地實作課程二)  

# Fantastic Genomic Biomarkers and Where to Find Them Practical Course (Part II)


## Main Content of This Course
 Thinlinc download and connect NCHC 

## Tool Overview
 ThinLinc (Local Software): Provides a graphical interface for remote server operations, suitable for tasks requiring a desktop environment.

## Step 1: Download ThinLinc
1. Download software: ThinLinc
  - Download and install the version corresponding to your computer from the [ThinLinc official website](https://www.cendio.com/thinlinc/download/).      
  ![image](https://hackmd.io/_uploads/rJPh0U_dlg.png)
2. Ensure that [NCHC OTP is enabled](###Logging-into-NCHC).

 
### Step 2: Using ThinLinc to Log into NCHC, Access the Remote Host, and Open Terminal
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

* The ThinLinc login screen is as follows:      
 ![image](https://hackmd.io/_uploads/rJmiJgtuxl.png)
 
1. Enter the login node `t3-c4.nchc.org.tw` in the server field.
2. Enter your "NCHC supercomputer account" in the username field.
3. Enter "1"or"3" in the password field, then press enter to log in.
   (**Note: Do not enter the supercomputer password or iService password here!**)
4. Enter your "NCHC supercomputer password" 
   (**Note: This is the supercomputer password, not the iService password!**)     
![image](https://hackmd.io/_uploads/rJTPkYEhA.png)

5. Use your mobile app to obtain the OTP.
Enter the OTP just obtained (**This is not the supercomputer password or the iService password!**), this step should be down twice!      
![image](https://hackmd.io/_uploads/rkAY1YVnC.png)

6. After successfully logging in, click "Forward" and "OK."
![image](https://hackmd.io/_uploads/H133yFVnA.png)
![image](https://hackmd.io/_uploads/Hy3-gtVhC.png)

7. After logging in, click on the top left "Activities" to see nine dots (Show Applications) appear on the left. Click on it, then select Xfce Terminal.    
![image](https://hackmd.io/_uploads/HktElt42C.png)      
   **If the system logs you out after a period of inactivity, you will need to repeat the login process**

  
### Step 3: Entering the Remote Host file `/work`
1. In the terminal, use the `cd` command to navigate to your directory under the `/work` path on the host:
 ```
 cd /work/{your_username}
 ```
2. Use the `pwd` command to verify if you are in the correct directory.

> [!IMPORTANT]
> #### Commands Lecture
> `cd` is a commonly used command in command-line tools. It stands for change directory and is used to switch the current working directory in a terminal or command-line interface.
> Usage of `cd`:
> ```
> cd [directory path]# Switch to the specified directory
> cd ..               # Move up to the parent directory
> cd ~                # Return to the user's home directory
> cd                  # Used without arguments, it will switch the current directory back to the user's home directory
> cd -                # Switch back to the previous working directory
> ```
> 
> - ⚠️ **There is a "space" between the command and the path. Do not type it as "cd/work/{your_username}".** The same applies to the following code as well.
>    - Tip: Use your mouse to select and confirm if there is a space.
> - ⚠️ If you copy the command, make sure to check if anything needs to be modified!
> - ⚠️ Replace {your_username} entirely with your supercomputer account. **Do not include the {} symbols! Also, do not delete the /**. The same applies to the following code as well.

> [!IMPORTANT]
> #### Commands Lecture
> ``pwd`` print working directory, is used to display the full path of the current working directory. It is especially useful when working in multi-level directories, allowing you to check your current location at any time.


---------------------------------------------
---------------------------------------------


# 生物標記物與它們的產地實作課程(二)

## 本次課程主要內容
 Thinlinc下載並連結國網

## 工具概述
 ThinLinc（local 軟體）：用於透過圖形化介面遠端操作伺服器，適合處理需要桌面環境的工作

## Step 1:下載 ThinLinc
### 下載ThinLinc
1. 下載需要用到的軟體：ThinLinc
- 在[ThinLinc官網](https://www.cendio.com/thinlinc/download/)下載您的電腦相對應的版本並安裝即可
![image](https://hackmd.io/_uploads/rJPh0U_dlg.png)

2. 確認[國網OTP是否已啟用](###登入國網)

### Step 2: 使用ThinLinc登入國網、進入遠端主機、開啟終端機 (terminal)
> [!CAUTION]
> 依照以下步驟仍無法登入時，請先確認：
> > (1) 如果出現Permission denied (keyboard-interaction)，請確認當時是否有填寫老師給你的表單，如果沒有請立馬填寫、通知助教\
> > (2) 是否有到iservice網站啟用OTP認證\      
> > (3) 登入時，輸入的東西順序是否正確\      
> > (4) 主機帳號密碼是否輸錯 (注意：跟iservice帳號密碼不一樣)\     
> > (5) 釐清大小寫/中英切換/全形半形字切換問題 (Mac使用者更需注意)\
>        
> **若上述問題都排除後，仍無法登入，請通知老師or助教，千萬不要硬登！會被鎖起來！！！**      
  
- ThinLinc登入畫面如下      
  ![](https://i.imgur.com/XvGJFXA.png)

1. 請在server輸入登入節點`t3-c4.nchc.org.tw`
2. 請在username 輸入「國網主機帳號」
3. 請在password 輸入「**1**」，再按 enter 登入 
   (**注意：這裡不是輸入主機密碼、不是iservice密碼！！！**)
4. 請輸入「國網主機密碼」
   (**注意：是輸入主機密碼、不是iservice密碼！！！**)
    ![](https://hackmd.io/_uploads/r1zwCwdOxe.png)
5. 手機app取得OTP請在此輸入剛剛取得的 OTP (**不是主機密碼！！！不是iservice密碼！！！**)
    ![image](https://hackmd.io/_uploads/H1B9CPdOxl.png)
6. 成功登入後，請點選 「Forward」、「OK」
   ![image](https://hackmd.io/_uploads/H12_8P__gx.png)
   ![image](https://hackmd.io/_uploads/BJzFIwOuxl.png)

7. 登入之後，點選左上角 Activitives 後會看到左邊出現九個點 (Show Applications)，點進去之後，選擇 Xfce Terminal
   ![image](https://hackmd.io/_uploads/SyT2p5I80.png)
 
    **小提醒：如果過一陣子沒有使用，系統會自動跳出，這時候再重新操作登入流程**

### Step 3: 進入遠端主機的資料夾 `/work`

1. 在terminal利用 `cd` 指令，進入自己的主機、位於 `/work` 路徑下的空間

    ```
    cd /work/{your_username}
    ```

2. 使用 `pwd` 可查看所在位置是否正確

> [!IMPORTANT]
> #### 命令小學堂
> ``cd`` 是命令列工具中的一個常用指令，全稱為 change directory，用來在終端或命令列中切換當前工作目錄
> `cd`的用法:
> ```
> cd [目錄路徑] #切換到指定目錄
> cd ..        #返回上一級目錄
> cd ~         #回到使用者主目錄
> cd           #直接使用，會將當前目錄切換回使用者的主目錄
> cd -         #這會將當前目錄切換到上一次使用的目錄
> ```
>
> * ⚠️ **指令跟路徑之間有"空白"，不要輸成"cd/work/{your_username}"**，後面的程式碼也是一樣
>    * 小技巧：用滑鼠選取、確認一下有無空白\
> * ⚠️ **如果直接複製指令碼、記得看一下是否有要改的地方！！！**\
> * ⚠️ **請將 `{your_username}` 整個改成你的主機帳號，不要把"{}"也打入！也請不要把"/"刪掉！** 後面的程式碼也是一樣

> [!IMPORTANT]
> #### 命令小學堂
> ``pwd``print working directory，用來顯示當前所在的工作目錄的完整路徑，特別是在多層目錄中工作時，可以隨時查看當前的位置
