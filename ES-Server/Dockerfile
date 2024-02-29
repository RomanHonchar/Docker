FROM ubuntu:24.04

WORKDIR /usr/src

#Repository update
RUN apt update && \
    mkdir -p /opt/ExecutionServer

#Install Mono
RUN apt install -y ca-certificates gnupg && \
    gpg --homedir /tmp --no-default-keyring --keyring /usr/share/keyrings/mono-official-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb [signed-by=/usr/share/keyrings/mono-official-archive-keyring.gpg] https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update && \
    apt install -y mono-complete

#Install dependencies
RUN apt update --fix-missing && \
    apt install -y build-essential libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev zlib1g zlib1g-dev gcc cmake

#Copy and install Pytho3
COPY Python-3.9.9/ /usr/src/Python-3.9.9/

RUN cd Python-3.9.9 && \
    ./configure --prefix=/usr --enable-optimizations && \
    make altinstall && \
    ln -s /usr/bin/python3.9 /usr/bin/python3

#Copy and install Python2
COPY Python-2.7.18/ /usr/src/Python-2.7.18/
COPY exec/packages/VirtualEnvironment/requirements.txt /opt/ExecutionServer/packages/VirtualEnvironment/

RUN cd /usr/src/Python-2.7.18 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    /usr/local/bin/python2.7 -m ensurepip && \
    /usr/local/bin/python2.7 -m pip install -r /opt/ExecutionServer/packages/VirtualEnvironment/requirements.txt && \
    ln -s /usr/local/bin/python2.7 /usr/local/bin/python

RUN /usr/local/bin/python -m pip install pip==19.2.3 -U && \
    /usr/local/bin/python -m pip install virtualenv==20.13.0 -U && \
    /usr/local/bin/python -m pip install wheel==0.37.1 -U && \
    python3 -m pip install pip==21.2.4 -U && \
    python3 -m pip install virtualenv==20.13.0 -U && \
    python3 -m pip install wheel==0.37.1 -U

#Installing ansible
RUN python3 -m pip install ansible && python3 -m pip install pywinrm

#Copy ES files and set permissions to the Start script
COPY exec/ /opt/ExecutionServer/
RUN cd /opt/ExecutionServer && chmod 755 es_start.sh

EXPOSE 5093

WORKDIR /opt/ExecutionServer

CMD ["./es_start.sh"]