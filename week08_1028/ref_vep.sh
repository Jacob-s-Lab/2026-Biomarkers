#!/usr/bin/sh
#SBATCH -A ACD115175                 # Account name/project number
#SBATCH -J annotation                # Job name
#SBATCH -p ngscourse92G              # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14                        # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g                    # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_annotation.out.log    # Path to the standard output file
#SBATCH -e 115Biomarker_annotation.err.log    # Path to the standard error ouput file
#SBATCH --mail-user=r15455017@ntu.edu.tw          # email
#SBATCH --mail-type=FAIL,END                      # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# Please enter the R1 & R2 file name and your username
user=u2777445
sample=SRR13076390

# 建立對應先前分析成果的目錄參數
OUT_DIR=/work/${user}/
DIR_VC=${OUT_DIR}/variantcalling/variantcallingR

echo "pwd for analysis reault: "
pwd

# ------------------------------------ #
# Please don't change the script below #
# ------------------------------------ #
# Reference: Homo_sapiens_assembly38.fasta
ref=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta

# 載入 samtools 環境以供 CRAM 轉換使用
module load biology
module load SAMTOOLS/1.18

###################
# VEP annotation  #
###################
echo "+----------VEP----------+"
# Create a new directory for variant calling
DIR_VP=${OUT_DIR}/annotation/annotationR
mkdir -p ${DIR_VP}
cd ${DIR_VP}

echo "pwd for VEP: "
pwd

## Set up the environment and path for running VEP
VEP_PATH=/opt/ohpc/Taiwania3/pkg/biology/Ensembl-VEP/ensembl-vep/vep
VEP_CACHE_DIR=/opt/ohpc/Taiwania3/pkg/biology/DATABASE/VEP/Cache
VEP_FASTA=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
BCFTOOLS=/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.13/bin/bcftools

module load biology
module load Perl/5.28.1
module load old-module pkg/Anaconda3
export PATH=${PATH}:/opt/ohpc/Taiwania3/pkg/biology/HTSLIB/htslib_v1.13/bin:/opt/ohpc/Taiwania3/pkg/biology/SAMTOOLS/samtools_v1.15.1/bin
set -euo pipefail

# split multiallelic
echo "split multiallelic: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
${BCFTOOLS} norm -m -any ${DIR_VC}/${sample}.HC.vcf.gz \
    -Oz \
    -o ${sample}.HC.normed.vcf.gz
${BCFTOOLS} index -t -f ${sample}.HC.normed.vcf.gz
echo "Split multiallelic: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


INPUT_VCF=${sample}.HC.normed.vcf.gz
SAMPLE_ID=${sample}.HC.VEP
echo "INPUT VCF directory: " ${INPUT_VCF}
echo "sample ID: " ${SAMPLE_ID}
#############################
# Variant annotation by VEP #
#############################
echo "VEP annotaion: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

${VEP_PATH} --cache --offline \
    --cache_version 108 \
    --dir_cache ${VEP_CACHE_DIR} \
    --assembly GRCh38 \
    --fasta ${VEP_FASTA} \
    --fork 12 \
    -i ${INPUT_VCF} \
       --check_existing \
    --af_gnomade \
    --af_gnomadg \
    --vcf \
    -o ${SAMPLE_ID}.vcf \
    --force_overwrite

echo "VEP annotation: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# Generate tsv
echo -e "CHROM\tPOS\tREF\tALT\tDP\t$(${BCFTOOLS} +split-vep -l ${SAMPLE_ID}.vcf | cut -f 2 | tr '\n' '\t' | sed 's/\t$//')" > ${SAMPLE_ID}.tsv
${BCFTOOLS} +split-vep -f '%CHROM\t%POS\t%REF\t%ALT\t%DP\t%CSQ\n' -A tab ${SAMPLE_ID}.vcf >> ${SAMPLE_ID}.tsv

awk 'NR==1 || ($1 ~ /^chr[1-9]$|^chr10$/) {
    gsub(/,.*$/, "", $6)
    print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" $9 "\t" $10 "\t" $34 "\t" $44 "\t" $50 "\t" $54
}' ${SAMPLE_ID}.tsv > ${SAMPLE_ID}_filtered.tsv

echo "Format changing & column filtering: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

printf "##############################################################################\n"
printf "###              Work completed: $(date '+%Y-%m-%d %H:%M:%S')              ###\n"
printf "##############################################################################\n"
