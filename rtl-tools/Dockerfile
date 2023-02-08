# start from the official Arch base image
FROM archlinux:base

# non-root user and credentials
ARG RUNNER_NAME

# set environment variables
ENV RUNNER=${RUNNER_NAME} \
    RUNNER_PWD=${RUNNER_NAME}

RUN \
    echo "upgrade base image + a few tweeks" &&\
    pacman-key --init && \
    pacman --noconfirm -Syy archlinux-keyring && pacman --noconfirm -Su && \
    pacman --noconfirm -S \
    sudo \
    nano \
    wget \
    base-devel \
    openssh \
    sshpass \
    sshfs \
    screen \
    git \
    net-tools \
    rclone \
    rsync \ 
    gtk3 && \
    \
    echo "create non-root user" &&\
    groupadd sudo && echo "%sudo   ALL=(ALL) ALL" >> /etc/sudoers && \
    useradd -m ${RUNNER} && echo ${RUNNER}:${RUNNER_PWD} | chpasswd && usermod -aG sudo ${RUNNER_PWD} && \
    \
    echo "setup mainline RTL FOSS tools" && \
    pacman --noconfirm -S \
    riscv64-elf-binutils \
    riscv64-elf-gcc \
    riscv64-elf-gdb \
    riscv64-elf-newlib \
    yosys \
    verilator \
    iverilog \
    gtkwave && \
    \
    echo "package cleanup to save space" &&\
    pacman --noconfirm -Scc

# Makepkg needs a standard user to build
USER ${RUNNER}
WORKDIR /home/${RUNNER}

# Build required AUR pakages as ${RUNNER}
# 1) Git version of GHDL for ghdl-yosys-plugin support
# 2) The actual ghdl-yosys-plugin
RUN \
    echo ${RUNNER_PWD} | sudo -S pacman --noconfirm -S gcc-ada boost && \
    \
    git clone https://aur.archlinux.org/ghdl-gcc-git.git && cd ghdl-gcc-git && \
    makepkg --noconfirm && echo ${RUNNER_PWD} | sudo -S pacman --noconfirm -U ghdl-gcc-git*.pkg.tar.zst &&  cd ../ && rm -rf ghdl-gcc-git && \
    \
    git clone https://aur.archlinux.org/ghdl-yosys-plugin-git.git && cd ghdl-yosys-plugin-git &&\
    makepkg --noconfirm && echo ${RUNNER} | sudo -S pacman --noconfirm -U ghdl-yosys-plugin-git*.pkg.tar.zst && cd ../ && rm -rf ghdl-yosys-plugin-git && \
    \
    echo ${RUNNER_PWD} | sudo -S pacman --noconfirm -Scc

USER root
