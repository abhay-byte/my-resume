# LaTeX Documents with Automated PDF Releases

This repository uses a GitHub Actions workflow to **fully automate** the building and releasing of PDF documents from LaTeX source files.

Every time a change to **any `.tex` file** is pushed to the `main` or `master` branch, the workflow will automatically:

1.  Generate a new version tag based on the current date and time (e.g., `v2024.05.16.1430`).
2.  Create a new GitHub Release with this tag.
3.  Find all `.tex` files in the repository's root directory.
4.  Compile each `.tex` file into a PDF, named with the format `YYYY-MM-DD-original_filename.pdf`.
5.  Attach all the generated PDFs to the new release as assets.

## Getting the Latest Documents

The most up-to-date versions of all documents are always available from the **[Releases Page](https://github.com/abhay-byte/my-resume/releases)**.

*(Note: Remember to update the link above to point to your own repository's releases page!)*

1.  Go to the [**Releases Page**](https://github.com/abhay-byte/my-resume/releases).
2.  The release at the top of the page is the newest one.
3.  Under the **Assets** section of that release, you will find all the compiled PDF files (e.g., `2024-05-16-resume.pdf`, `2024-05-16-cover-letter.pdf`, etc.).

## How to Use This Repository

The process is extremely simple: just manage your `.tex` files.

### Step 1: Add or Edit LaTeX Files

Add, edit, or remove any `.tex` files in the root of the repository. For example, you could have `resume.tex`, `cover_letter.tex`, and `project_portfolio.tex`.

### Step 2: Push Your Changes

Commit and push your changes to the `main` or `master` branch. The GitHub Actions workflow will handle the rest!

### (Optional) Step 3: Previewing PDFs Locally

If you want to compile the `.tex` files on your local machine to preview them, you can run the following command in your terminal. This command mimics the behavior of the GitHub workflow.

**Prerequisite:** You must have [Docker](https://www.docker.com/products/docker-desktop/) installed.

```bash
# This script finds all .tex files and compiles them into date-coded PDFs.
for file in *.tex; do
  BASENAME=$(basename "$file" .tex)
  OUTPUT_NAME="$(date +'%Y-%m-%d')-${BASENAME}"
  echo "--- Compiling ${file} to ${OUTPUT_NAME}.pdf ---"
  
  docker run --rm --user="$(id -u):$(id -g)" --net=none -v "$(pwd):/data" leplusorg/latex \
    latexmk -outdir=/data -pdf -jobname="${OUTPUT_NAME}" "/data/${file}"
done
