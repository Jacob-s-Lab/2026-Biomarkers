#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J 115_roc_HCvsM2           # Job name
#SBATCH -p ngscourse                # Partition name
#SBATCH -c 2
#SBATCH --mem=13g
#SBATCH -o 115Biomarker_roc_HCvsM2.out.log  # Path to the standard output file
#SBATCH -e 115Biomarker_roc_HCvsM2.err.log  
#SBATCH --mail-user=b9999999999999@gmail.com  #Email
#SBATCH --mail-type=FAIL,END

user=u9482849
DIR_hap=/work/${user}/hap
DIR_rop=${DIR_hap}/rocplot/rocplot_HCvsM2
mkdir -p ${DIR_rop}
cd ${DIR_rop}

Rscript ${DIR_hap}/rocplot/rocplot.Rscript \
hap_plot -pr \
${DIR_hap}/115_HC_hap/output_prefix:HC  ${DIR_hap}/115_M2_hap/output_prefix:M2
