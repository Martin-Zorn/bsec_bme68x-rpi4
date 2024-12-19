# bsec_bme68x-rpi4

Fork of [bsec_bme680-homie](https://github.com/alaub81/bsec_bme680-homie).
Works with Raspberry Pi 4 and BSEC version 2.6.1.0.

Here you can find a complete small application, which uses the [Bosch Sensortec Environmental Cluster](https://www.bosch-sensortec.com/software-tools/software/bsec/) (BSEC) to read out the data from the BME68x Sensor and publish it to a MQTT Broker. The MQTT publishing is homie MQTT conventional, so you could use it as an IoT Device for your SmartHome. All you need is to download the [BSEC Library](https://www.bosch-sensortec.com/software-tools/software/bsec/) from the Bosch homepage, and this git repository. 

# Requirements
* BME68x Sensor
* Raspberry Pi (4)

# Installation
Please download the [BSEC Library](https://www.bosch-sensortec.com/software-tools/software/bsec/) to `./src`.

## compiling the C application
Please use make.sh.

# Configuration

## Systemd Service

# Sensor Output


