#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J S14_HC_hap                  # Job name
#SBATCH -p ngscourse                   # Partition name
#SBATCH -c 2               
#SBATCH --mem=13g           
#SBATCH -o 115Biomarker_hap.out.log   # Path to the standard output file
#SBATCH -e 115Biomarker_hap.err.log
#SBATCH --mail-user=b999999999@gmail.com  #Email
#SBATCH --mail-type=FAIL,END   

set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

#REFERENCE_PATH=/opt/ohpc/Taiwania3/pkg/biology/reference
user=u9482849
truth=/work/${user}/KnownPositives_hg38_Liftover.vcf
query=/work/${user}/variantcalling/SRR13076390.M2.vcf.gz

REFERENCE_DIR=/opt/ohpc/Taiwania3/pkg/biology/reference

module load biology
module load Python/2.7.18
module load bcftools


#########################
# Create output folders #
#########################

DIR_hap=/work/${user}/hap
mkdir -p ${DIR_hap}

DIR_M2_hap=${DIR_hap}/SRR13076390_M2_hap
mkdir -p ${DIR_M2_hap}

cd ${DIR_M2_hap}

echo "pwd:"
pwd


################
# bcftools     #
################

echo "bcftools start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

bcftools view \
    -m2 \
    -M2 \
    ${query} \
    -Oz \
    -o ${DIR_M2_hap}/SRR13076390.M2.modified.vcf.gz

bcftools index \
    ${DIR_M2_hap}/SRR13076390.M2.modified.vcf.gz

echo "bcftools finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


################
# hap.py       #
################

query_modified=${DIR_M2_hap}/SRR13076390.M2.modified.vcf.gz

export HGREF=${REFERENCE_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta

echo "hap.py start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

/opt/ohpc/Taiwania3/pkg/biology/illumina_hap.py/hap.py_v0.3.15/bin/hap.py \
    ${truth} \
    ${query_modified} \
    --filter-nonref \
    -f /work/${user}/High-Confidence_Regions_v1.2.bed.gz \
    -o ${DIR_M2_hap}/output_prefix \
    -r ${REFERENCE_DIR}/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta \
    --leftshift \
    --bcftools-norm

echo "hap.py finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

echo "all finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
