FROM ubuntu:14.04

RUN apt-get update

# Install base packages
RUN apt-get install -y \
    build-essential \
    curl \
    git \
    unzip \
    wget \
    zsh

# oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
RUN cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
RUN chsh -s /bin/zsh

RUN chsh -s /usr/bin/zsh
RUN cd /root

# Tools
RUN mkdir ~/packages
WORKDIR ~/packages

# Python and friends
RUN apt-get install -y python-numpy python-sympy python-crypto python-pip
RUN apt-get install -y ipython bpython

# Volatility
RUN wget http://downloads.volatilityfoundation.org/releases/2.5/volatility_2.5.linux.standalone.zip
RUN unzip volatility_2.5.linux.standalone.zip
RUN ln -s ~/packages/volatility_2.5.linux.standalone/volatility_2.5_linux_x64 /bin/volatility

# John the ripper
RUN apt-get install -y john

# ROPGadget
RUN pip install capstone
RUN pip install ropgadget

# Binjitsu
RUN apt-get install -y python2.7 python-dev
RUN pip install --upgrade git+https://github.com/binjitsu/binjitsu.git

# GDB and PEDA
RUN apt-get install -y gdb
RUN git clone https://github.com/longld/peda.git ~/peda
RUN echo "source ~/peda/peda.py" >> ~/.gdbinit

WORKDIR /ctf
