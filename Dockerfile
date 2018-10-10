FROM jenkins/jenkins
USER root
ENV KUBE_LATEST_VERSION="v1.10.3"
ENV KUBE_RUNNING_VERSION="v1.9.3"
ENV HELM_VERSION="v2.8.1"
ENV AWSCLI=1.15.66


RUN apt-get update  \
  && apt-get install -y python-pip curl apt-transport-https ca-certificates bash gnupg2 software-properties-common xmlstarlet \
  && chown 1000 ~/ \
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_RUNNING_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \ 
  && chmod +x /usr/local/bin/kubectl \ 
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl_latest \
  && chmod +x /usr/local/bin/kubectl_latest \ 
  && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm 
RUN pip install --upgrade pip 
RUN pip install awscli==${AWSCLI} 

USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
