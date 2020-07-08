# Python Docker Image for Nano Server

Windows Nano Server is an SKU designed for the cloud computing environment. But Nano Server is entirely different between the traditional Windows Server operating system. It is just a minimal subset of the existing Windows operating system, so many capabilities are missing.

This repository contains a Python docker image build script for Windows Nano Server.

[Docker Hub](https://hub.docker.com/repository/docker/rkttu/python-nanoserver)

## Why I make this script

I want to run a simple Python script in my Windows container environment and Windows Kubernetes environment. But currently, the official Python Windows Server image does not support the Nano server directly. It requires the Windows Server Core base image, which has about 2GiB size.

## How to use

```powershell
docker pull rkttu/python-nanoserver:3.8.3_2004
docker run -it rkttu/python-nanoserver:3.8.3_2004
```

## How to build

You can build your Nano Server-based Python image with the below command.

```powershell
$EACH_PYTHON_VERSION='3.8.2'
$EACH_WIN_VERSION='2004'
$IMAGE_TAG="${EACH_PYTHON_VERSION}_${EACH_WIN_VERSION}"

$TARGET_PYTHON_PIP_VERSION='20.1.1'
$TARGET_PYTHON_GET_PIP_URL='https://github.com/pypa/get-pip/raw/d59197a3c169cef378a22428a3fa99d33e080a5d/get-pip.py'

docker build \
    -t python-nanoserver:$IMAGE_TAG \
    --build-arg WINDOWS_VERSION=$EACH_WIN_VERSION \
    --build-arg PYTHON_VERSION=$EACH_PYTHON_VERSION \
    --build-arg PYTHON_RELEASE=$EACH_PYTHON_VERSION \
    --build-arg PYTHON_PIP_VERSION=$TARGET_PYTHON_PIP_VERSION \
    --build-arg PYTHON_GET_PIP_URL=$TARGET_PYTHON_GET_PIP_URL \
    .
```

This image includes pip and virtualenv.

## Django Example

The `django_example` directory contains how to build a Nano Server-based Django application container.

## Contribution

I tested this Docker image for Windows Nano Server 1809. If you make a docker image for another version of Windows, please make a pull request with some tests.

### Test Criteria

- The image you built should support the pip tool.
- The image you built should support the virtualenv tool.
- The image you built can install Django via a virtualenv isolated environment.
- The image you built can install AWS CLI, and it does not display .py file association missing error.
- More testing criteria are welcome!

## Updates

- Jul.8th.2020: Expand supported OS and Python v3 version range, update PIP version, and removing GitHub Actions facility.
- Mar.14th.2020: Change `PIP_CACHE_DIR` directory path to ContainerUser account.

## Roadmap

If available, I want to contribute this repository to the official Python Docker image repository. But currently, the official repository has complicated build rules for Windows images. I think the Windows image is far different than Linux, so it would be better to handle separately.
