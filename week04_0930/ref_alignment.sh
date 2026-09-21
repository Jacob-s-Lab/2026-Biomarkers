#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J alignment                # Job name
#SBATCH -p ngscourse                # Partition Name (equivalent to PBS's -q Queue name)
#SBATCH -c 2                        # Number of cores used (refer to Queue resource settings)
#SBATCH --mem=13g                   # Amount of memory used (refer to Queue resource settings)
#SBATCH -o 115Biomarker_alignment.out.log  # Path to the standard output file
#SBATCH -e 115Biomarker_alignment.err.log
#SBATCH --mail-user=b9999999@gmail.com    #Email
#SBATCH --mail-type=FAIL,END        # Specifies when to send email; can be NONE, BEGIN, END, FAIL, REQUEUE, ALL


set -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"


# Please enter the R1 & R2 file name and your username
user=u9482849
sampleR1=/work/u9482849/result/fastqc/SRR13076390_1.fastq.gz
sampleR2=/work/u9482849/result/fastqc/SRR13076390_2.fastq.gz
sample=SRR13076390
path1=/work/u9482849/alignment/alignmentR

mkdir -p ${path1}


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



##############################
# Mapping reads with BWA-MEM #
##############################
echo "Mapping Reads: Start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

bwa mem -M -R "@RG\tID:GP_${sample}\tSM:SM_${sample}\tPL:ILLUMINA" -t 40 -K 1000000 ${ref} ${sampleR1} ${sampleR2} > ${path1}/${sample}.sam

echo "Mapping Reads: Finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
######################################################
# Preparing for bam file  (sorting & indexing) #
######################################################
echo "preparing for bam file: start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
samtools view -@ 2 -S -b ${path1}/${sample}.sam > ${path1}/${sample}.bam
samtools sort -@ 2 ${path1}/${sample}.bam -o ${path1}/${sample}.sorted.bam
samtools index -@ 20 ${path1}/${sample}.sorted.bam
echo "bam file has already prepared"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
