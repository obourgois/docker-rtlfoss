# Generic FOSS RTL tools

These Docker image build scripts package up into a docker image some handy tools for RTL digital design using bleeding edge versions of Free Open Source Software.
The goal is for RTL development using FOSS in CI environements or on Linux machines with distros where up-to-date packages are simply not available.  The packages used are
from the Archlinux distro (including the AUR) as this rolling distro has been found to have just the right mix between stability and up-to-date versions


## FOSS software

### verilator
* very fast verilog RTL simulator that converts to C++ code

### icarus
* a more classic verilog RTL simulator

### ghdl
* VHDL RTL simulator

### gtkwave
* waveform viewer used by FOSS RTL simulators

### yosys
* an interesting open source synthesis tool.

### riscv gnu toolchain
* to compile RISC-V code for RTL cores


## Building the image
The makefile will build an image and tag it **rtl-tools:foss**

```bash
cd rtl-tools
make build
```

## Running the image

If it doesn't exist, the makefile will build a slightly modified image where the internal
"runner" user will get it's UID and GID mapped to current user.  It will then launch with current user's
credentials in current user's home.  This is safer than running as root and files can be shared between user's home
and the container.  The image will be tagged **rtl-tools:foss_username**

```bash
cd rtl-tools
make run
```
