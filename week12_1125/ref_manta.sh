#!/usr/bin/sh
#SBATCH -A ACD115175                      # Account name/project number
#SBATCH -J manta_thalassemia_hg38         # Job name
#SBATCH -p ngscourse                      # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                              # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=13g                         # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o 115Biomarker_manta.out.log                  # Path to the standard output file 
#SBATCH -e 115Biomarker_manta.err.log 
#SBATCH --mail-user=b99999999@ntu.edu.tw
#SBATCH --mail-type=FAIL,END

set -v -x

##set required input file and working directory
user=u2777445
wkdir=/work/${user}/SV
sampleID=thalassemia
ref_file=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta
ref=hg38
recal_input=${wkdir}/NGS1_20170103B.hs38DH.dedup.postalt.sorted.BQSR_chr16.bam
confident_region=${wkdir}/GRCh38_HG2-T2TQ100-V1.1_stvar.benchmark.bed


##set working directory
mkdir -p ${wkdir}
cd ${wkdir}

mkdir -p ${wkdir}/filter
mkdir -p ${wkdir}/raw


##set tool path
MANTA_ANALYSIS_PATH="/opt/ohpc/Taiwania3/pkg/biology/Manta/Manta_v1.6.0"
BCFTOOLS_PATH="/opt/ohpc/Taiwania3/pkg/biology/BCFtools/bcftools_v1.13/bin"
VCFTOOLS_PATH="/opt/ohpc/Taiwania3/pkg/biology/VCFtools/vcftools_v0.1.16/bin"
BGZIP_PATH="/opt/ohpc/Taiwania3/pkg/biology/HTSLIB/htslib_v1.13/bin"


##run Manta caution: --referenceFasta can't use $ref_file as input !! so I change to REF for sed replacement directly
${MANTA_ANALYSIS_PATH}/bin/configManta.py \
--bam  "${recal_input}" \
--referenceFasta "${ref_file}" \
--runDir ${wkdir} 

${wkdir}/runWorkflow.py -j 2


cp ${wkdir}/results/variants/* ${wkdir}/raw/
rm -rf ${wkdir}/results
rm -rf workflow* workspace/ runWorkflow.py*

cd ${wkdir}/filter

##decompress the gvcf file 
$BGZIP_PATH/bgzip -d ${wkdir}/raw/diploidSV.vcf.gz 


##ID specification by sed
sed -e '/^#/n' -e 's/\([^[:space:]]*\)/m\1/3' ${wkdir}/raw/diploidSV.vcf > ${sampleID}_${ref}_manta.vcf

##filtration for quality, svtype, genotype, svlen and confident region 
##deletion
$BCFTOOLS_PATH/bcftools filter -i 'INFO/SVTYPE="DEL" && FILTER="PASS" && INFO/SVLEN <= -50 && INFO/SVLEN >= -114200 ' ${sampleID}_${ref}_manta.vcf > ${sampleID}_${ref}_manta_del_pass.vcf

sed -i '/0\/0/d' ${sampleID}_${ref}_manta_del_pass.vcf

$VCFTOOLS_PATH/vcftools --vcf ${sampleID}_${ref}_manta_del_pass.vcf \
--bed "${confident_region}" \
--out ${sampleID}_${ref}_manta_del_pass_filtered --recode --recode-INFO-all


##insertion
$BCFTOOLS_PATH/bcftools filter -i 'INFO/SVTYPE="INS" && FILTER="PASS"' ${sampleID}_${ref}_manta.vcf > ${sampleID}_${ref}_manta_ins_pass.vcf

sed -i '/0\/0/d' ${sampleID}_${ref}_manta_ins_pass.vcf

$VCFTOOLS_PATH/vcftools --vcf ${sampleID}_${ref}_manta_ins_pass.vcf \
--bed "${confident_region}" \
--out ${sampleID}_${ref}_manta_ins_pass --recode --recode-INFO-all
