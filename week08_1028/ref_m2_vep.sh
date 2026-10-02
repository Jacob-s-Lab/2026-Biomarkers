#!/usr/bin/sh
#SBATCH -A ACD115175                 # Account name/project number
#SBATCH -J variantcalling_M2+annotation                # Job name
#SBATCH -p ngscourse92G              # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 14                        # 使用的core數 請參考Queue資源設定
#SBATCH --mem=92g                    # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_m2_annotation.out_vc.log    # Path to the standard output file
#SBATCH -e 115Biomarker_m2_annotation.err_vc.log    # Path to the standard error ouput file
#SBATCH --mail-user=r15455017@ntu.edu.tw          # email
#SBATCH --mail-type=FAIL,END                      # 指定送出email時機 可為NONE, BEGIN, END, FAIL, REQUEUE, ALL

set -v -x
set -euo pipefail

echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# Please enter the R1 & R2 file name and your username
user=u2777445
sample=SRR13076390
path1=/work/${user}/2026Biomarker_TA/alignment/alignmentRM
OUT_DIR=/work/${user}/2026Biomarker_TA
DIR_VC=${OUT_DIR}/variantcalling/variantcallingR

mkdir -p ${DIR_VC}

echo "pwd for analysis result: "
pwd

# ------------------------------------ #
# Please don't change the script below #
# ------------------------------------ #
# Reference: Homo_sapiens_assembly38.fasta
ref=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta


####################################
# Calling variants by GATK Mutect2 #
####################################
echo "Mutect2 variants calling: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# set up the environment for variant calling
module load biology
module load Python
module load GATK/4.2.3.0

# 產出原始未過濾 VCF（供作業與 IGV 判定練習使用）
gatk --java-options "-Xmx64g" Mutect2 \
  -R ${ref} \
  -I ${path1}/${sample}.sorted.markdup.bam \
  -O ${DIR_VC}/${sample}.M2.vcf.gz \
  --native-pair-hmm-threads 6 \
  -L chr1 -L chr2 -L chr3 -L chr4 -L chr5 -L chr6 -L chr7 -L chr8 -L chr9 \
  -L chr10 -L chr11 -L chr12 -L chr13 -L chr14 -L chr15 -L chr16 -L chr17 \
  -L chr18 -L chr19 -L chr20 -L chr21 -L chr22

echo "Mutect2 variants calling: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
#---------------variants_calling_finished-------------------#


###################
# VEP annotation  #
###################
echo "+----------VEP----------+"
DIR_VP=${OUT_DIR}/VP
mkdir -p ${DIR_VP}
cd ${DIR_VP}

echo "pwd for VEP: "
pwd

## Set up the environment and path for running VEP
VEP_PATH=/opt/ohpc/Taiwania3/pkg/biology/Ensembl-VEP/ensembl-vep/vep
VEP_CACHE_DIR=/opt/ohpc/Taiwania3/pkg/biology/DATABASE/VEP/Cache
VEP_FASTA=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
BCFTOOLS=/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.13/bin/bcftools

module load Perl/5.28.1
module load old-module pkg/Anaconda3
export PATH=${PATH}:/opt/ohpc/Taiwania3/pkg/biology/HTSLIB/htslib_v1.13/bin:/opt/ohpc/Taiwania3/pkg/biology/SAMTOOLS/samtools_v1.15.1/bin

# FilterMutectCalls 即時管線：篩選 PASS 並拆分 multiallelic（不落地中間暫存檔）
echo "FilterMutectCalls, filter PASS, and split multiallelic: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

gatk --java-options "-Xmx8g" FilterMutectCalls \
  -R ${ref} \
  -V ${DIR_VC}/${sample}.M2.vcf.gz \
  -O /dev/stdout \
  | ${BCFTOOLS} view --threads 4 -f PASS -Ou \
  | ${BCFTOOLS} norm --threads 4 -m -any -Oz -o ${sample}.M2.PASS.normed.vcf.gz

${BCFTOOLS} index --threads 12 -t -f ${sample}.M2.PASS.normed.vcf.gz

echo "Filter PASS & Split multiallelic: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


INPUT_VCF=${sample}.M2.PASS.normed.vcf.gz
SAMPLE_ID=${sample}.M2.PASS.VEP
echo "INPUT VCF directory: " ${INPUT_VCF}
echo "sample ID: " ${SAMPLE_ID}

#############################
# Variant annotation by VEP #
#############################
echo "VEP annotation: start"
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
