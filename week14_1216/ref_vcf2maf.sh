#!/bin/bash
#SBATCH -A ACD115175                      # Account name/project number
#SBATCH -J vcf2maf                        # Job name
#SBATCH -p ngscourse                      # Partition Name 等同PBS裡面的 -q Queue name
#SBATCH -c 2                              # 使用的core數 請參考Queue資源設定 
#SBATCH --mem=13g                         # 使用的記憶體量 請參考Queue資源設定
#SBATCH -o vcf2maf.out.log                  # Path to the standard output file 
#SBATCH -e vcf2maf.err.log 
#SBATCH --mail-user=b99999999999@gmail.com
#SBATCH --mail-type=FAIL,END


vepfasta=/opt/ohpc/Taiwania3/pkg/biology/reference/Homo_sapiens/GATK/hg38/Homo_sapiens_assembly38.fasta

module load biology
module load SAMTOOLS/1.18

# Set required input file and working directory
user=u9482849
wkdir=/work/${user}/annotation/annotationR/
sample=SRR13076396


# Convert VCF to MAF
perl vcf2maf.pl \
    --input-vcf ${wkdir}/${sample}.M2.VEP.vcf \
    --output-maf ${sample: -2}.maf \
    --inhibit-vep \
   --tumor-id ${sample} \
   --ncbi-build GRCh38 \
   --ref-fasta ${vepfasta}
