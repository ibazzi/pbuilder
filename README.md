# pbuilder #

package builder for my routers

## Build ##

```bash
$ autoconf
$ ./configure --with-arm-toolchain=/home/user/dev/toolchains/toolchain-arm_cortex-a9_gcc-6.1.0_musl-1.1.15_eabi/bin \
              --with-mips-toolchain=/home/user/dev/toolchains/toolchain-mips_34kc_gcc-6.1.0_musl-1.1.15/bin \
              --with-mipsel-toolchain=/home/user/dev/toolchains/toolchain-mipsel_74kc+dsp2_gcc-6.1.0_musl-1.1.15/bin \
              --with-install-dir=/home/user/dev/build \
              --with-tarballs=/home/user/dev/tmp
# build all packages
$ ARCH=arm make
# for single package
$ ARCH=arm make opennhrp
# or you can export ARCH first
$ export ARCH=arm
$ make
$ make nano
```
