# Python Docker Image for Nano Server

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Windows Nano Server is an SKU designed for the cloud computing environment. But Nano Server is entirely different between the traditional Windows Server operating system. It is just a minimal subset of the existing Windows operating system, so many capabilities are missing.

This repository contains a Python docker image build script for Windows Nano Server.

**Container Registries:**
- [Docker Hub](https://hub.docker.com/repository/docker/rkttu/python-nanoserver)
- [GitHub Container Registry](https://github.com/rkttu/python-nanoserver/pkgs/container/python-nanoserver) (Automated builds)

## Why I make this script

I want to run a simple Python script in my Windows container environment and Windows Kubernetes environment. But currently, the official Python Windows Server image does not support the Nano server directly. It requires the Windows Server Core base image, which has about 2GiB size.

## How to use

The images are automatically built and published to GitHub Container Registry (GHCR) with the latest Python versions.

### Pull from GitHub Container Registry (Recommended)

```powershell
# Pull a specific Python version with Windows version
docker pull ghcr.io/rkttu/python-nanoserver:3.12.3_ltsc2025

# Pull latest build for a Python version (uses latest Windows version - ltsc2025)
docker pull ghcr.io/rkttu/python-nanoserver:3.12.3

# Run the container
docker run -it ghcr.io/rkttu/python-nanoserver:3.12.3_ltsc2025
```

### Pull from Docker Hub (Legacy)

```powershell
docker pull rkttu/python-nanoserver:3.8.3_2004
docker run -it rkttu/python-nanoserver:3.8.3_2004
```

### Available Tags

Images are tagged in the format: `{python_version}_{windows_version}`

- Python versions: Latest stable releases for each minor version (e.g., 3.9.x, 3.10.x, 3.11.x, 3.12.x, 3.13.x)
- Windows versions: `ltsc2025`, `ltsc2022`, `ltsc2019`

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

## Automated CI/CD Pipeline

This repository now includes an automated CI/CD pipeline that:

- **Automatically tracks new Python releases**: Checks the [Python CPython repository tags](https://github.com/python/cpython/tags) daily for new stable versions
- **Builds images for multiple Windows versions**: Creates Docker images for Windows Server LTSC 2025, LTSC 2022, and LTSC 2019
- **Publishes to GitHub Container Registry**: Automatically pushes built images to GHCR with appropriate tags
- **Supports manual triggers**: Can be manually triggered via GitHub Actions with custom Python and Windows versions

### How it works

1. **Scheduled runs**: The workflow runs daily at 2 AM UTC to check for new Python versions
2. **Version detection**: Fetches the latest stable release for each Python minor version (3.9.x, 3.10.x, 3.11.x, etc.)
3. **Matrix build**: Builds images in parallel for each Python version and Windows version combination
4. **Testing**: Each built image is tested to verify Python, pip, and virtualenv are working correctly
5. **Publishing**: Successfully built and tested images are pushed to GHCR with tags like `3.12.3_ltsc2025`, `3.12.3_ltsc2022`, `3.12.3_ltsc2019`, and `3.12.3` (for ltsc2025)

### Manual workflow trigger

You can manually trigger a build with specific versions:

1. Go to the [Actions tab](../../actions/workflows/build-and-push.yml)
2. Click "Run workflow"
3. Optionally specify Python versions (comma-separated, e.g., `3.11.9,3.12.3`)
4. Optionally specify Windows versions (default: `ltsc2025,ltsc2022,ltsc2019`)

## Updates

- Nov.2025: Added automated CI/CD pipeline with daily Python version tracking and GHCR publishing.
- Jul.8th.2020: Expand supported OS and Python v3 version range, update PIP version, and removing GitHub Actions facility.
- Mar.14th.2020: Change `PIP_CACHE_DIR` directory path to ContainerUser account.

## Roadmap

If available, I want to contribute this repository to the official Python Docker image repository. But currently, the official repository has complicated build rules for Windows images. I think the Windows image is far different than Linux, so it would be better to handle separately.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
