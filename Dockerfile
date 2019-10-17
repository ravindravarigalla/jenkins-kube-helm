FROM jenkins/jenkins
LABEL maintainer="martin@ventx.de,hajo@ventx.de"

USER root
ENV KUBE_LATEST_VERSION v1.16.2
ENV KUBE_RUNNING_VERSION v1.13.4
ENV HELM_VERSION v2.13.1
ENV AWSCLI 1.16.261

RUN apt-get -qq -y update && apt-get -qq -y install \
    apt-transport-https \
    bash \
    ca-certificates \
    curl \
    gettext \
    gnupg2 \
    jq \
    python-pip \
    software-properties-common \
    xmlstarlet

RUN chown 1000 ~/ \
  && wget -q https://dl.bintray.com/qameta/generic/io/qameta/allure/allure/2.7.0/allure-2.7.0.tgz \
  && tar -xzvf allure-2.7.0.tgz \
  && mv allure-2.7.0 /opt/ \
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_RUNNING_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \ 
  && chmod +x /usr/local/bin/kubectl \ 
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl_latest \
  && chmod +x /usr/local/bin/kubectl_latest \ 
  && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \ 
   add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
   apt-get -qq update && apt-get -qq -y install docker-ce 

RUN pip install --upgrade pip 

RUN pip install requests awscli==${AWSCLI} 

#USER jenkins
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
