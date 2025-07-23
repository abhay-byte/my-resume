# LaTeX Resume with Fully Automated PDF Releases

This repository contains my personal resume, written in LaTeX. It uses a GitHub Actions workflow to **fully automate** the release process.

Every time a change to `resume.tex` is pushed to the `main` branch, the workflow will automatically:
1.  Generate a new version tag based on the current date and time (e.g., `v2024.05.16.1430`).
2.  Create a new GitHub Release with this tag.
3.  Compile the latest `resume.tex` into a PDF.
4.  Attach the `resume.pdf` to the new release.


## Getting the Latest Resume

The most up-to-date version of my resume is always available from the **[Releases Page](https://github.com/abhay-byte/my-resume/releases)**.

1.  Go to the [Releases Page](https://github.com/abhay-byte/my-resume/releases).
2.  The release at the top is the newest one.
3.  Under the **Assets** section of that release, download the `resume.pdf` file.



## How to Update the Resume 

The process is now extremely simple.

### Step 1: Edit the Resume

Make your desired changes to the `resume.tex` file. You can preview your changes locally if you have Docker installed by running:

```bash
docker run --rm -t --user="$(id -u):$(id -g)" -v "$(pwd):/data" leplusorg/latex latexmk -outdir=/data -pdf /data/resume.tex
