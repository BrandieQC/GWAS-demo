## generate fasta files for proteome and transcriptome
# install gffread
sudo apt install gffread
gffread -g S_tort_YO1_2_1.HAP1.genome.fasta \
  -x S_tort_YO1_2_1.HAP1.transcripts.fasta \
  -y S_tort_YO1_2_1.HAP1.proteins.fasta \
  S_tort_YO1_2_1.HAP1.helixer.gff3


## Install and run interproscan

# first we need java >= 17
sudo apt install openjdk-17-jdk

# then nextflow
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/local/bin/
# test it
./nextflow run hello

# test interproscan (don't need to install)
nextflow run ebi-pf-team/interproscan6 \
  -r 6.0.3.0 \
  -profile docker,test \
  --datadir data \
  --interpro latest

# now run it on our genome

cd /analyzed_data/GWAS_workshop/data/interproscan
nextflow run ebi-pf-team/interproscan6 \
  -r 6.0.3.0 \
  -profile docker \
  --interpro latest \
  --datadir /analyzed_data/interproscan_data \
  --outprefix S_tort_YO1_2_1.HAP1 \
  --input ../S_tort_YO1_2_1.HAP1.proteins.fasta \
  --skip-applications COILS,HAMAP,MobiDB-lite,PIRSR 
  --goterms \ 
  --pathways

