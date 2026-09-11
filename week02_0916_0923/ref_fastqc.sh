#!/usr/bin/sh
#SBATCH -A ACD115175          # Account name/project number
#SBATCH -J fastqc             # Job name
#SBATCH -p ngscourse          # Partition Name (equivalent to PBS's -q Queue name)
#SBATCH -c 2                  # Number of cores used (refer to Queue resource settings)
#SBATCH --mem=13g             # Amount of memory used (refer to Queue resource settings)
#SBATCH -o out.log            # Path to the standard output file
#SBATCH -e err.log
#SBATCH --mail-user=b9999999@gmail.com   #Email
#SBATCH --mail-type=END       # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL
# For NCHC usage

set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


# Please enter your username and the R1 & R2 file name 
sampleR1=/work/b9999999/result/fastqc/SRR13076392＿1.fastq.gz
sampleR2=/work/b9999999/result/fastqc/SRR13076392＿2.fastq.gz
mkdir fastqc_SRR13076392

## Set up the environment for running fastqc
module load biology
module load FastQC


## Analyzing your sample's sequence QC by fastqc
echo "fastqc start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

#fastqc -o ./fastqc_S14 ${sampleR1} ${sampleR2} 
fastqc ${sampleR1} ${sampleR2} -o fastqc_SRR13076392

echo "fastqc finished"
