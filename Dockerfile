FROM ubuntu:18.04

ENV ansible_version=2.9.6 \
    sops_version=v3.5.0 \
    packer_version=1.5.4 \
    terraform_version=0.12.24

RUN apt update \
    && apt install -yqq \
    curl \
    wget \
    unzip \
    python3-pip \
    make 

RUN pip3 install ansible==${ansible_version}

RUN wget --quiet https://github.com/mozilla/sops/releases/download/${sops_version}/sops-${sops_version}.linux -O /bin/sops \
    && chmod +x /bin/sops 

RUN wget --quiet https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip \
    && unzip packer_${packer_version}_linux_amd64.zip -d /bin \
    && rm -rf packer_${packer_version}_linux_amd64.zip

RUN wget --quiet https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip \
    &&  unzip terraform_${terraform_version}_linux_amd64.zip -d /usr/local/bin \
    && rm -rf terraform_${terraform_version}_linux_amd64.zip

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && apt-get install google-cloud-sdk -y

RUN rm -rf /var/cache/apt/archives


