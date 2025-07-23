# Resume with Automatic PDF Build

This repository contains a LaTeX resume template that is automatically compiled into a PDF on every push using GitHub Actions.


## How to Use

### 1. Local Development

While you don't need LaTeX installed to get the final PDF, you'll want to preview your changes locally before you push. The easiest way is using the same Docker command the workflow uses.

Make sure you have [Docker](https://www.docker.com/products/docker-desktop/) installed, then run this command from the root of the repository:

```bash
docker run --rm -t --user="$(id -u):$(id -g)" -v "$(pwd):/data" leplusorg/latex latexmk -outdir=/data -pdf /data/resume.tex
