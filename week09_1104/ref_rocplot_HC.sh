#!/usr/bin/sh
#SBATCH -A ACD115175                # Account name/project number
#SBATCH -J 115_roc_HC             # Job name
#SBATCH -p ngscourse                # Partition name
#SBATCH -c 2
#SBATCH --mem=13g
#SBATCH -o 115Biomarker_roc_HC.out.log  # Path to the standard output file
#SBATCH -e 115Biomarker_roc_HC.err.log  
#SBATCH --mail-user=b9999999999999@gmail.com  #Email
#SBATCH --mail-type=FAIL,END

user=u9482849
DIR_rop=/work/${user}/rocplot/rocplot_HC
mkdir -p ${DIR_rop}
cd ${DIR_rop}

Rscript /work/${user}/rocplot/rocplot.Rscript \
hap_plot -pr \
/work/${user}/hap/115_HC_hap/output_prefix:115
