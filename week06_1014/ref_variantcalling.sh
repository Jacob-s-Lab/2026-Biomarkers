#!/usr/bin/sh
#SBATCH -A ACD115175                     # Account name/project number
#SBATCH -J variantcalling                # Job name
#SBATCH -p ngscourse                     # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                             # 使用的core數 請參考Queue資源設定
#SBATCH --mem=13g                        # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_variantcalling.out_vc.log                    # Path to the standard output file
#SBATCH -e 115Biomarker_variantcalling.err_vc.log                    # Path to the standard error output file
#SBATCH --mail-user=b999999999999@gmail.com    #Email
#SBATCH --mail-type=FAIL,END


set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

############################
# Sample / path definition #
############################
# Please enter the R1 & R2 file name and your username
user=u9482849
sample=SRR13076390
path1=/work/${user}/alignment/alignmentR
path2=/work/${user}/alignment/alignmentRM
path3=/work/${user}/variantcalling/variantcallingR

mkdir -p ${path1}
mkdir -p ${path2}
mkdir -p ${path3}


# ------------------------------------ #
# Please don't change the script below #
# ------------------------------------ #

## Reference: Homo_sapiens_assembly38.fasta
ref=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
# Create the environment for alignment and variant calling
module load biology
module load BWA/0.7.17
module load SAMTOOLS/1.18
set -euo pipefail

###################
# Mark duplicates #
###################
echo "Mark duplicates: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

PICARD=/work/opt/ohpc/Taiwania3/pkg/biology/Picard/picard_v2.27.4/share/picard-2.27.4-0/picard.jar

java -jar ${PICARD} MarkDuplicates \
	-I  ${path1}/${sample}.sorted.bam \
	-O  ${path2}/${sample}.sorted.markdup.bam \
	-M  ${path2}/${sample}_markdup_metrics.txt \
	--CREATE_INDEX true

echo "Mark duplicates: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


############################################
# Calling variants by GATK HaplotypeCaller #
############################################
echo "Variants calling: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# set up the environment for variant calling
# GATK_PATH=/opt/ohpc/Taiwania3/pkg/biology/GATK/gatk_v4.2.3.0
module load biology
module load Python
module load GATK/4.2.3.0

gatk HaplotypeCaller \
	-R ${ref} \
	-I ${path2}/${sample}.sorted.markdup.bam \
	-O ${path3}/${sample}.HC.vcf.gz
echo "Variants calling: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
