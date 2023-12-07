FROM jenkins/jenkins:lts
USER root
RUN mkdir -p /var/lib/apt/lists/partial && chmod 755 /var/lib/apt/lists/partial
RUN apt-get update
RUN apt-get install -y awscli
COPY credentials /root/.aws/
COPY config /root/.aws/
RUN chmod 600 /root/.aws/config
RUN chmod 600 /root/.aws/credentials
RUN apt-get install wget
RUN apt-get install unzip
RUN wget --quiet https://releases.hashicorp.com/terraform/1.6.4/terraform_1.6.4_linux_amd64.zip
RUN unzip terraform_1.6.4_linux_amd64.zip
RUN mv terraform /usr/bin
RUN curl -LO https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.7/2022-10-31/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN cp kubectl /usr/local/bin
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
RUN mv /tmp/eksctl /usr/local/bin

#Install java
RUN wget https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz
RUN tar -xvf openjdk-13.0.1_linux-x64_bin.tar.gz
RUN mv jdk-13.0.1 /usr/local/bin

#Install Maven
RUN apt-get install maven -y
