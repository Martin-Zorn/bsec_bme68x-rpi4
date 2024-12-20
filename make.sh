#!/bin/sh

#set -x
set  -eu

. ./make.config

if [ ! -d "${BSEC_DIR}" ]; then
  echo 'BSEC directory missing.'
  exit 1
fi

if [ ! -d "${CONFIG_DIR}" ]; then
  mkdir "${CONFIG_DIR}"
fi

STATEFILE="${CONFIG_DIR}/bsec_iaq.state"
if [ ! -f "${STATEFILE}" ]; then
  touch "${STATEFILE}"
fi

echo 'Patching...'
dir="./src/bsec2-6-1-0_generic_release_22102024"
patch='patches/bsec2-6-1-0.diff'
if patch -N --dry-run --silent -d "${dir}/" \
 < "${patch}" 2>/dev/null
then
 patch -d "${dir}/" < "${patch}"
else
 echo 'Already applied.'
fi

echo 'Compiling...'
gcc -Wall -Wno-unused-but-set-variable -Wno-unused-variable -static \
  -std=gnu99 \
  -fcommon \
  -g \
  -I./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/src/bme68x \
  -I./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/src/inc \
  -I./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/examples/bsec_iot_example \
  -I./src/bsec2-6-1-0_generic_release_22102024/algo/bsec_IAQ/inc \
    ./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/src/bme68x/bme68x.c \
    ./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/src/bme68x/bme68x_defs.h \
    ./src/bsec2-6-1-0_generic_release_22102024/examples/BSEC_Integration_Examples/examples/bsec_iot_example/bsec_integration.c \
    ./bsec_bme68x.c \
  -L"./src/bsec2-6-1-0_generic_release_22102024/algo/bsec_IAQ/bin/RaspberryPi/PiFour_Armv8" -lalgobsec \
  -lm -lrt \
  -o bsec_bme68x
echo 'Compiled.'

cp "./src/bsec2-6-1-0_generic_release_22102024/algo/bsec_IAQ/config/bme680/bme680_iaq_33v_3s_28d/bsec_iaq.config" "${CONFIG_DIR}"/
echo 'Copied config.'