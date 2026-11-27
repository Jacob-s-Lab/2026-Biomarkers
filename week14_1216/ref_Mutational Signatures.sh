#!/bin/bash
#SBATCH -A ACD115175
#SBATCH -J Mutational_Signatures
#SBATCH -p ngscourse
#SBATCH -c 2
#SBATCH --mem=13g
#SBATCH -o 115Biomarker_MS.out.log
#SBATCH -e 115Biomarker_MS.err.log
#SBATCH --mail-user=b9999999@gmail.com
#SBATCH --mail-type=FAIL,END

set -e -v -x
echo "start"
echo "$(date '+%Y-%m-%d %H:%M:%S')"

# Load R and GCC
module load R/4.4.1
module load gcc/10.5.0

Rscript --vanilla - <<'RSCRIPT'

# Load libraries
.libPaths(c("./R_libs", .libPaths()))
library(maftools)
library("BSgenome.Hsapiens.UCSC.hg38", quietly = TRUE)
library('NMF')
library('pheatmap')

print("Load libraries finished")
print(Sys.time())

# Merge MAF files
maf_files <- list.files("./", pattern = "\\.maf$", full.names = TRUE)
my_maf <- merge_mafs(mafs = maf_files)

print("Merge MAF files finished")
print(Sys.time())

# Generate trinucleotide mutation matrix
my_maf.tnm = trinucleotideMatrix(maf = my_maf, prefix = NULL, ref_genome = "BSgenome.Hsapiens.UCSC.hg38")

print("TrinucleotideMatrix finished")
print(Sys.time())

# Output PDF
pdf("Rplots.pdf", width = 12, height = 8)

# Estimate signatures
my_maf.sign = estimateSignatures(mat = my_maf.tnm, nTry = 3)

# Plot Cophenetic
plotCophenetic(res = my_maf.sign)

# Extract signatures
my_maf.sig = extractSignatures(mat = my_maf.tnm, n = 3)

# Compare signatures
my_maf.og30.cosm = compareSignatures(nmfRes = my_maf.sig, sig_db = "legacy")
my_maf.v3.cosm = compareSignatures(nmfRes = my_maf.sig, sig_db = "SBS")

print("CompareSignatures finished")
print(Sys.time())

# Plot cosine similarity
pheatmap::pheatmap(mat = my_maf.og30.cosm$cosine_similarities, cluster_rows = FALSE, main = "cosine similarity against validated signatures")

# Plot mutational signatures
maftools::plotSignatures(nmfRes = my_maf.sig, title_size = 1.2, sig_db = "SBS")

dev.off()

RSCRIPT

echo "Mutational Signatures Analysis finished"
echo "$(date '+%Y-%m-%d %H:%M:%S')"
