FROM google/cloud-sdk:latest
FROM tenable/terrascan:1.16.0 as terrascan
FROM ubuntu:latest
RUN apt-get update -y && \
    apt-get install unzip -y && \
    apt-get install python3 -y && \
    apt-get install wget -y && \
    apt-get install vim -y && \
    apt-get install curl -y && \
    apt-get install git -y && \
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get_helm.sh && ./get_helm.sh && \
    wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip && \
    unzip terraform_1.1.9_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    terraform --version && \
    apt-get install -y apt-transport-https ca-certificates gnupg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && \
    apt-get install -y google-cloud-sdk && \
    apt-get update && apt-get install google-cloud-sdk-gke-gcloud-auth-plugin && \
    curl https://sdk.cloud.google.com | bash
