# Resume with Automated PDF Releases

This repository contains my personal resume, written in LaTeX. It uses a GitHub Actions workflow to automatically compile the source code into a PDF and publish it as a new **GitHub Release** whenever a version tag is pushed.


## How to Create a New Release (For Maintainer)

This workflow is designed to create a new release when a Git tag is pushed.

### Step 1: Local Development & Previewing

Before creating a new version, you'll want to preview your changes.

1.  **Edit `resume.tex`**: Make your desired changes to the LaTeX source file.
2.  **Preview Locally (Requires Docker)**: To compile the PDF on your machine, ensure you have [Docker](https://www.docker.com/products/docker-desktop/) installed and run the following command from the repository root:
    ```bash
    docker run --rm -t --user="$(id -u):$(id -g)" -v "$(pwd):/data" leplusorg/latex latexmk -outdir=/data -pdf /data/resume.tex
    ```
    This will generate a `resume.pdf` in the current directory for you to review.

### Step 2: Commit and Tag the New Version

Once you are satisfied with the PDF preview, commit your changes and create a version tag.

1.  **Commit the changes**:
    ```bash
    git add resume.tex
    git commit -m "Update: [Describe your changes here]"
    ```

2.  **Create a new Git tag**: The tag **must start with `v`** (e.g., `v1.0`, `v2.5`, `v2024.05.16`). Use semantic versioning or a date-based scheme.
    ```bash
    # Example: Creating tag v1.1
    git tag v1.1
    ```

### Step 3: Push to GitHub to Trigger the Release

Push both your commits and the new tag to GitHub. This will trigger the workflow.

```bash
# Push the commit(s)
git push

# Push the tag
git push origin v1.1

```
---

## Getting the Latest Resume

The easiest way to get the most up-to-date version of my resume is from the **[Releases Page](https://github.com/YOUR_USERNAME/YOUR_REPOSITORY/releases)**.

1.  Go to the [Releases Page](https://github.com/YOUR_USERNAME/YOUR_REPOSITORY/releases).
2.  The release at the top will be marked "Latest".
3.  Under the **Assets** section of that release, download the `resume.pdf` file.
