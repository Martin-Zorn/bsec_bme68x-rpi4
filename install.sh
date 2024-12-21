#!/bin/sh

set  -e

echo 'Build binary'
./make.sh

echo 'Copy state file to /var/opt/bsec_bme68x'
mkdir -p /var/opt/bsec_bme68x

if [ -d "/var/opt/bsec_bme68x/bsec_iaq.state" ]; then
  echo 'bsec_iaq.state already exists'
else 
    cp ./bsec_iaq.state /var/opt/bsec_bme68x
fi

echo 'Copy config file to /etc/bsec_bme68x'
mkdir -p /etc/bsec_bme68x
cp ./bsec_iaq.config /etc/bsec_bme68x

echo 'Copy binary to /usr/local/bin'
cp ./bsec_bme68x /usr/local/bin

echo 'Check and optionally create python venv'
venv_dir=/var/opt/bsec_bme68x/.venv

if [ -d "${venv_dir}" ]; then
  echo '${venv_dir} already exists'
else 
    echo 'Creating python venv'
    python3 -m venv ${venv_dir}
fi

echo 'Install python requirements'
source ${venv_dir}/bin/activate
pip install -r requirements.txt
deactivate

echo 'Copy influxdb config to /etc/bsec_bme68x'
cp ./bsec_bme68x-influx.ini /etc/bsec_bme68x

echo 'Copy influx python script to /usr/local/bin'
cp ./bsec_bme68x-influx.py /usr/local/bin

echo 'Copy systemd service file to /etc/systemd/system'
cp ./bsec_bme68x.service /etc/systemd/system

echo 'Starting service'
systemctl daemon-reload

echo 'Done'



