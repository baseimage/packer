FROM ubuntu:18.04

RUN apt update \
    && apt install -yqq \
    curl \
    wget \
    unzip \
    python3-pip \
    && wget --quiet https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.linux -O /bin/sops \
    && chmod +x /bin/sops \
    && wget --quiet https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip \
    && unzip packer_1.5.4_linux_amd64.zip -d /bin \
    && pip3 install ansible==2.9.6

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && apt-get install google-cloud-sdk -y \
    && rm -rf /var/cache/apt/archives


