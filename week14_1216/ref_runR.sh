#!/usr/bin/sh
#SBATCH -A ACD115175                      # Account name/project number
#SBATCH -J runMAFR         # Job name
#SBATCH -p ngscourse                      # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                              # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=13g                         # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_runMAFR.out.log                  # Path to the standard output file 
#SBATCH -e 115Biomarker_runMAFR.err.log 
#SBATCH --mail-userb999999999999@gmail.com
#SBATCH --mail-type=FAIL,END


# Please change your username
user=u9482849
sample=96
DIR_MAF=/work/${user}/MAF

# Setting environment
module load biology
module load R/4.4.1
module load gcc/10.5.0

cd ${DIR_MAF}

Rscript --vanilla ${DIR_MAF}/MutationSignature.R ${sample}
