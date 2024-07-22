FROM ubuntu:latest

COPY ./rizinrc /root/.rizinrc

RUN apt update -y && \
    apt install -y build-essential jq strace ltrace curl wget rubygems gcc dnsutils netcat-traditional \
    neovim gdb python3-full python3-pip python3-dev file libssl-dev libffi-dev wget git make procps \
    libpcre3-dev libdb-dev libxt-dev libxaw7-dev tmux && \
    pip3 install --break-system-packages capstone requests pwntools r2pipe unicorn ropper meson ninja && \
    mkdir /tools && \
    cd /tools && git clone https://github.com/JonathanSalwan/ROPgadget && \
    cd /tools && git clone https://github.com/niklasb/libc-database && \
    cd /tools && git clone --recurse-submodules https://github.com/rizinorg/rizin && \
    cd rizin && meson build && ninja -C build && ninja -C build install

RUN cd /tools && git clone https://github.com/pwndbg/pwndbg && cd pwndbg && ./setup.sh 

# binja only
RUN cd /tools && wget https://github.com/Vector35/debugger/releases/download/0.1/debugger-linux.zip && unzip debugger-linux.zip -d debugger && rm -rf debugger-linu*.zip

WORKDIR /pwn

EXPOSE 31337
