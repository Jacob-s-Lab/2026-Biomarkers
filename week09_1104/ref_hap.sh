#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J 115_HC_hap               # Job name
#SBATCH -p ngscourse                # Partition name
#SBATCH -c 2
#SBATCH --mem=13g
#SBATCH -o 115Biomarker_hap_HC.out.log # Path to the standard output file
#SBATCH -e 115Biomarker_hap_HC.err.log
#SBATCH --mail-user=b9999999999999@gmail.com  #Email
#SBATCH --mail-type=FAIL,END

set -v -x

echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

#Please enter your username, sample name, and variant calling tool (HC or M2)
user=u9482849
sample=SRR13076390
vctool=HC
truth=/work/${user}/hap/KnownPositives_hg38_Liftover.vcf
query=/work/${user}/variantcalling/variantcallingR/${sample}.${vctool}.vcf.gz
#Reference path
REFERENCE_DIR=/opt/ohpc/Taiwania3/pkg/biology/reference

# module load old-module
module load biology
module load Python/2.7.18
module load bcftools


## create a new directory for hap

DIR_hap=/work/${user}/hap

mkdir -p ${DIR_hap}

DIR_VC_hap=${DIR_hap}/115_${vctool}_hap

mkdir -p ${DIR_VC_hap}

cd ${DIR_VC_hap}

echo "pwd for ${vctool} hap: "
pwd


echo "bcftools start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


bcftools view \
-m2 \
-M2 \
${query} \
-Oz \
-o ${DIR_VC_hap}/${sample}.${vctool}.modified.vcf.gz


bcftools index ${DIR_VC_hap}/${sample}.${vctool}.modified.vcf.gz


echo "bcftools finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


query_modified=${DIR_VC_hap}/${sample}.${vctool}.modified.vcf.gz


export HGREF=${REFERENCE_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta


echo "hap.py start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


/opt/ohpc/Taiwania3/pkg/biology/illumina_hap.py/hap.py_v0.3.15/bin/hap.py ${truth} ${query_modified} \
--filter-nonref \
-f ${DIR_hap}/High-Confidence_Regions_v1.2.bed.gz \
-T ${DIR_hap}/hg38_cds.merged.bed \
-o ${DIR_VC_hap}/output_prefix \
-r ${REFERENCE_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta \
--leftshift \
--bcftools-norm


echo "hap.py finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


echo "all finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
