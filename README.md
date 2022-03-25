# Generic FOSS RTL tools
This Docker image regroups some handy tools for RTL digital design using Free Open Source Software



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



## Running on Linux Host

```
xhost && \
docker run -it --rm \
--volume="/home/$USER:/home/$USER" \
-e DISPLAY=$(DISPLAY) -v /tmp/.X11-unix/:/tmp/.X11-unix \
rtlfoss:base
```

## Running on MAC host

### Prerequisites
* install Docker for Mac
* install XQuartz

### Command line:
```
xhost + && \
docker run -it --rm \
--volume="/Users/$USER:/home/$USER" \
-e DISPLAY=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}'):0 \
rtlfoss:base
```
