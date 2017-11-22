#!/bin/bash

# Set up the Jetstream CentOS image to search the SRA

set -e

cd /tmp

yum -y install tbb tbb-devel samtools

rm -f sratoolkit.*
wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.8.2-1/sratoolkit.2.8.2-1-centos_linux64.tar.gz
tar xf sratoolkit.2.8.2-1-centos_linux64.tar.gz
mkdir /usr/local/sratoolkit
mv sratoolkit.2.8.2-1-centos_linux64  /usr/local/sratoolkit
ln -s /usr/local/sratoolkit/sratoolkit.2.8.2-1-centos_linux64 /usr/local/sratoolkit/current

echo 'export PATH=$PATH:/usr/local/sratoolkit/current/bin' > /etc/profile.d/sra.sh

rm -f bowtie2*
wget https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.3.1/bowtie2-2.3.1-linux-x86_64.zip 
unzip bowtie2-2.3.1-linux-x86_64.zip
mkdir /usr/local/bowtie2
mv bowtie2-2.3.1 /usr/local/bowtie2/
ln -s /usr/local/bowtie2/bowtie2-2.3.1/ /usr/local/bowtie2/current
echo 'export PATH=$PATH:/usr/local/bowtie2/current' > /etc/profile.d/bowtie2.sh

rm -f bowtie2-2.3.1-linux-x86_64.zip sratoolkit.2.8.2-1-centos_linux64.tar.gz

# install rapsearch
git clone https://github.com/zhaoyanswill/RAPSearch2.git
cd RAPSearch2/
./install
cd ..
mv RAPSearch2/ /usr/local/

echo 'export PATH=$PATH:/usr/local/RAPSearch2/bin' > /etc/profile.d/rapsearch.sh



