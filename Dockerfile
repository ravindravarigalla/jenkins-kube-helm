FROM jenkins/jenkins

ENV KUBE_LATEST_VERSION="v1.10.3"
ENV KUBE_RUNNING_VERSION="1.9.3"
ENV HELM_VERSION="v2.8.1"
ENV AWSCLI=1.15.66

USER root


RUN apt-get update && \
apt-get install -y python-pip default-jdk docker apt-transport-https ca-certificates curl gnupg2 software-properties-common xmlstarlet maven && \
chown 1000 ~/ && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \ 
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" \
  && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_RUNNING_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && wget -q
https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl_latest \
  && chmod +x /usr/local/bin/kubectl_latest \
  && wget -q http://storage.googleapis.com/kubernetes-helm/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
  && chmod +x /usr/local/bin/helm \
  && pip install --upgrade pip \
  && pip install awscli==${AWSCLI} \
  && apt-get update \
  && apt-get -y install docker-ce
User 1000
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
