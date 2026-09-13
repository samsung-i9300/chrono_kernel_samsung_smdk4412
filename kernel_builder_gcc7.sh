#!/bin/bash


GCC32="/tmp/optane/gcc/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf"
export PATH="$PREFIX$GCC32/bin:$PATH"

export CROSS_COMPILE=arm-linux-gnueabihf-
export ARCH=arm
export SUBARCH=arm
export HEADER_ARCH=arm

#rm -rf out
mkdir out
rm -rf error.log
make O=out clean 
make mrproper

export CROSS_COMPILE=arm-linux-gnueabihf-
echo $PATH

cat arch/arm/configs/lineageos_i9300_defconfig > out/.config

make -j24 ARCH=arm O=out SUBARCH=arm O=out \
	CC="ccache arm-linux-gnueabihf-gcc" \
        LD="arm-linux-gnueabihf-ld.bfd" \
        AR="arm-linux-gnueabihf-ar" \
        AS="arm-linux-gnueabihf-as" \
        NM="arm-linux-gnueabihf-nm" \
        CROSS_COMPILE_ARM32="ccache arm-linux-gnueabihf-" \
        OBJCOPY="arm-linux-gnueabihf-objcopy" \
        OBJDUMP="arm-linux-gnueabihf-objdump" \
        STRIP="arm-linux-gnueabihf-strip" \
        CROSS_COMPILE="ccache arm-linux-gnueabihf-"
#echo $LD

# for i in $(ls patches_los16/) ; do patch -Np1 < patches_los16/$i ; done
