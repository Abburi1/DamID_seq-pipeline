# DamID_pipeline for identifying binding sites for Transcription factors and chromatin proteins

This repository contains an bash script for performing DamID_pipeline using terminal

## Overview
This pipeline:
- Processes raw FASTQ files
- Aligns them to reference genome
- Calls enriched regions
- Maps them to the nearby genes 

## Input
- Fastq files (test and Dam-only control files)
- Reference genome in .fasta format  
- Gene annotation file in .gff or .gtf format 
- GATC fragment file containing all the methylated coordinates


## Output
- bedgraph files showing methylation signals
- gff file containing enriched peaks
- csv file containing the gene list called from peak calling

## How to Run

1. Open terminal
2. Set your working directory to the project folder
3. Run the script: Damid_seq_pipeline.sh

source("scripts/Damid_seq_pipeline.sh")
