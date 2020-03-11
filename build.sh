#!/usr/bin/env bash
TARGET_PYTHON_VERSION=(3.7.4 3.8.2)
TARGET_WINDOWS_VERSION=(1809)

TARGET_PYTHON_PIP_VERSION=20.0.2
TARGET_PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/d59197a3c169cef378a22428a3fa99d33e080a5d/get-pip.py

for EACH_PYTHON_VERSION in "${TARGET_PYTHON_VERSION[@]}"
do
    for EACH_WIN_VERSION in "${TARGET_WINDOWS_VERSION[@]}"
    do
        IMAGE_TAG=$EACH_PYTHON_VERSION\_$EACH_WIN_VERSION
        docker build \
            -t python-nanoserver:$IMAGE_TAG \
            --build-arg BUILD_WINDOWS_VERSION=$EACH_WIN_VERSION \
            --build-arg BUILD_PYTHON_VERSION=$EACH_PYTHON_VERSION \
            --build-arg BUILD_PYTHON_RELEASE=$EACH_PYTHON_VERSION \
            --build-arg BUILD_PYTHON_PIP_VERSION=$TARGET_PYTHON_PIP_VERSION \
            --build-arg BUILD_PYTHON_GET_PIP_URL=$TARGET_PYTHON_GET_PIP_URL \
            .
    done
done
