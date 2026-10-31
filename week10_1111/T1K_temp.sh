#!/usr/bin/sh
#SBATCH -A ACD115175 
#SBATCH -J HLA_typing_T1K
#SBATCH -p ngscourse92G
#SBATCH -c 14
#SBATCH --mem=92g
#SBATCH -o HLA_typing_T1K.out.log
#SBATCH -e HLA_typing_T1K.err.log
#SBATCH --mail-user=b99999999@ntu.edu.tw
#SBATCH --mail-type=FAIL,END

set -v -x

# Please enter your username and sampleID
user=u2777445
sampleID=SRR13076390
mkdir -p /work/${user}/HLA_typing
sampleR1=/work/${user}/result/fastqc/${sampleID}_1.fastq.gz
sampleR2=/work/${user}/result/fastqc/${sampleID}_2.fastq.gz


T1K_PATH=/opt/ohpc/Taiwania3/pkg/biology/T1K/T1K_v1.0.5

${T1K_PATH}/run-t1k \
-1 ${sampleR1} \
-2 ${sampleR2} \
-t 12 \
--preset hla \
-f /work/${user}/T1K/hlaidx_dna_seq.fa \
--od /work/${user}/HLA_typing \
-o ${sampleID}
