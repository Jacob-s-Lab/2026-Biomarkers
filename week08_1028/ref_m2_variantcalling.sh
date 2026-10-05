#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J m2_variantcalling                # Job name
#SBATCH -p ngscourse                # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                        # 使用的core數 請參考Queue資源設定
#SBATCH --mem=13g                   # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_m2_variantcalling.out_al.log               # Path to the standard output file
#SBATCH -e 115Biomarker_m2_variantcalling.err_al.log
#SBATCH --mail-user=r15455017@ntu.edu.tw
#SBATCH --mail-type=FAIL,END


set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


############################
# Sample / path definition #
############################
# Please enter the R1 & R2 file name and your username
user=u2777445
sample=SRR13076390
path1=/work/${user}/alignment/alignmentRM
path2=/work/${user}/variantcalling/variantcallingR

mkdir -p ${path1}
mkdir -p ${path2}


# ------------------------------------ #
# Please don't change the script below #
# ------------------------------------ #
## Reference: Homo_sapiens_assembly38.fasta
ref=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
# Create the environment for variant calling
module load biology
module load BWA/0.7.17
module load SAMTOOLS/1.18
set -euo pipefail


####################################
# Calling variants by GATK Mutect2 #
####################################
echo "Mutect2 variants calling: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# set up the environment for variant calling
# GATK_PATH=/opt/ohpc/Taiwania3/pkg/biology/GATK/gatk_v4.2.3.0
module load biology
module load Python
module load GATK/4.2.3.0

gatk Mutect2 \
  -R ${ref} \
  -I ${path1}/${sample}.sorted.markdup.bam \
  -O ${path2}/${sample}.M2.vcf.gz \
  -L chr1 -L chr2 -L chr3 -L chr4 -L chr5 -L chr6 -L chr7 -L chr8 -L chr9  \
  -L chr10 -L chr11 -L chr12 -L chr13 -L chr14 -L chr15 -L chr16 -L chr17  \
  -L chr18 -L chr19 -L chr20 -L chr21 -L chr22

echo "Mutect2 variants calling: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
#---------------Mutect2_variants_calling_finished-------------------#
