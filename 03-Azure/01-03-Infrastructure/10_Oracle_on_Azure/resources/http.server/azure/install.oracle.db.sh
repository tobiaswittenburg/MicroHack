#!/bin/bash

sudo su -
# list mount points
df -h

# list the disks
lsblk
ls -alt /dev/sd*|head -1 # result: /dev/sdb1
# create a disk label
parted /dev/sdb1 mklabel gpt
parted -a optimal /dev/sdb1 mkpart primary 0GB 64GB
parted /dev/sdb1 print
mkfs -t ext4 /dev/sdb1
mkdir /u02
mount /dev/sdb1 /u02
chmod 777 /mnt/resource
curl ifconfig.io
echo "4.185.63.90 cptdazoracleoracle.germanywestcentral.cloudapp.azure.com cptdazoracleoracle" >> /etc/hosts
cat /etc/hostname # cptdazoracleoracle
sed -i 's/$/\.germanywestcentral\.cloudapp\.azure\.com &/' /etc/hostname
cat /etc/hostname # cptdazoracleoracle.germanywestcentral.cloudapp.azure.com 
firewall-cmd --zone=public --add-port=1521/tcp --permanent
firewall-cmd --zone=public --add-port=5502/tcp --permanent
firewall-cmd --reload
# create DB
sudo su - oracle
lsnrctl start
lsnrctl stop
# Create a data directory for the Oracle data files:
mkdir /mnt/resource/oradata



# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y wget unzip libaio1

# Download Oracle Database installation files
wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linux.x64-21.3.0.0.0.zip
wget https://download.oracle.com/otn_software/linux/instantclient/instantclient-sqlplus-linux.x64-21.3.0.0.0.zip

# Unzip the installation files
unzip instantclient-basic-linux.x64-21.3.0.0.0.zip
unzip instantclient-sqlplus-linux.x64-21.3.0.0.0.zip

# Move the files to /opt/oracle
sudo mkdir -p /opt/oracle
sudo mv instantclient_21_3 /opt/oracle/

# Set environment variables
echo 'export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_3:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=/opt/oracle/instantclient_21_3:$PATH' >> ~/.bashrc
source ~/.bashrc

# Download NYC Taxi & Limousine Commission - yellow taxi trip records
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet

# Install necessary tools for Parquet to CSV conversion
sudo apt-get install -y python3-pip
pip3 install pandas pyarrow

# Convert Parquet file to CSV
python3 -c "
import pandas as pd
df = pd.read_parquet('yellow_tripdata_2024-01.parquet')
df.to_csv('yellow_tripdata_2024-01.csv', index=False)
"
# Create a SQL script to load the data
cat <<EOF > load_data.sql
CREATE TABLE yellow_taxi_trips (
    VendorID NUMBER,
    tpep_pickup_datetime TIMESTAMP,
    tpep_dropoff_datetime TIMESTAMP,
    passenger_count NUMBER,
    trip_distance NUMBER,
    RatecodeID NUMBER,
    store_and_fwd_flag CHAR(1),
    PULocationID NUMBER,
    DOLocationID NUMBER,
    payment_type NUMBER,
    fare_amount NUMBER,
    extra NUMBER,
    mta_tax NUMBER,
    tip_amount NUMBER,
    tolls_amount NUMBER,
    improvement_surcharge NUMBER,
    total_amount NUMBER,
    congestion_surcharge NUMBER
);

LOAD DATA
INFILE 'yellow_tripdata_2022-01.csv'
INTO TABLE yellow_taxi_trips
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
EOF

# Execute the SQL script
sqlplus /nolog <<EOF
CONNECT your_username/your_password@your_database
@load_data.sql
EXIT;
EOF

echo "Oracle DB installation and data loading complete."