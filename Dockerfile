FROM jenkins/jenkins
USER root
ENV KUBE_LATEST_VERSION="v1.11.6"
ENV KUBE_RUNNING_VERSION="v1.11.6"
ENV HELM_VERSION="v2.11.0"
ENV AWSCLI=1.15.66


RUN apt-get update  \
  && apt-get install -y python-pip curl apt-transport-https ca-certificates bash gnupg2 software-properties-common xmlstarlet gettext jq \
  && chown 1000 ~/ \
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
   apt-get update && apt-get -y install docker-ce 
RUN pip install --upgrade pip 
RUN pip install requests awscli==${AWSCLI} 

#USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
