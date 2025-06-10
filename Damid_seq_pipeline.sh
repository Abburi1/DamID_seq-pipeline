#!/bin/bash
#DamID_pipeline.R
#Author : Prakeerthi Abburi
#Purpose : Identifying DNA binding sites for transcription factor and other chromatin proteins

#Exist on error
set -e

#-----------------------
#Step1: Prepare folders
#-----------------------
mkdir -p genome fastq/raw fastq/processed fastq/raw/fastqc fastq/processed/trim_log sam_deault

#-----------------------
#Step2: Quality Control using fastqc
#-----------------------
echo "Running fastqc..."
cd fastqc/raw
fastqc -t 16 *fastq.gz -o fastqc
cd ../..

#-----------------------
#Step3: Genome Indexing using Bowtie2
#-----------------------
echo "Indexing genome...."
cd genome
bowtie2-build dmel-all-chromosome-r6.48.fasta.gz dmel_r6.48
cd..

#-----------------------
#Step4: Trimming using Trimmomatic
#-----------------------
echo "trimming reads..."
TrimmomaticSE -threads 16 -phred33 -trimlog processed/trim_log/dam_sample2.log Raw/dam_sample2.fastq.gz processed/dam_sample2_trimmed.fastq.gz HEADCROP:10 

#-----------------------
#Step5: Aligning with Bowtie2 using damidseq_pipeline
#-----------------------
echo "Running damidseq_pipeline..."
damidseq_pipeline --gatc_frag_file=/home/Desktop/gatc/Dmel_BDGP6.GATC.gff.gz /home/Desktop/*.fastq.gz --bowtie2_genome_dir=/home/Desktop/Dm_r6.48/dmel_r6.48 --dam=/home/Desktop/fastq/Dam/Dam_control1.fastq.gz


#-----------------------
#Step5: Calling peaks
#-----------------------
echo "Running find_peaks..."
find_peaks (bedgraph file)

#-----------------------
#Step6: Annotating peak file
#-----------------------
echo "Running peaks2genes..."
peaks2genes --genes_file home/Desktop/DmR6.genes.gff.gz /home/Desktop/Dam_control_2_REP2/peak_analysis.Pol2-vs-Dam.gatc.2022-12-01.11-45-10/Pol2-vs-Dam.gatc-FDR0.01.peaks.gff 


echo "DamID_pipeline completed!.."
