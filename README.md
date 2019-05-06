# Description

Jenkins master image with awscli, bash, curl, docker, helm, jq and kubectl installed.

Based on: [jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins/)

## Docker Hub

[ventx/jenkins-kube-helm](https://cloud.docker.com/u/ventx/repository/docker/ventx/jenkins-kube-helm)


# Docker image

* OS: Debian
* Version: Strech


# Installed Packages via apt

* [bash](https://packages.debian.org/stretch/bash)
* [curl](https://packages.debian.org/stretch/curl)
* [jq](https://packages.debian.org/stretch/jq)


# Installed Packages via apt (PPA)

* [docker-ce](https://download.docker.com/linux/debian/dists/stretch/stable/)


# Installed Packages (pip)

* [awscli](https://pypi.org/project/awscli/) `1.16.152`


# Installed Packages (go binaries)

* [helm|](https://helm.sh/) `2.13.1`
* [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) `1.11.6`
* [kubectl_latest](https://kubernetes.io/docs/reference/kubectl/kubectl/) `1.13.4`
