---
name: resume-pdf
description: Export a resume to PDF with custom styling. Use when asked to regenerate or export a resume PDF.
allowed-tools: Bash, Read, Glob
argument-hint: "[resume-directory]"
---

# Export Resume to PDF

Regenerate the resume PDF from markdown using md-to-pdf.

## Usage

Pass the resume directory as an argument: `/resume-pdf resume/v1` (or any `resume/v*` path).
If no argument is given, ask which resume version to export.

## Steps

1. Confirm the target directory (e.g., `resume/v1/`, `resume/v1-google/`)
2. Run the export command from the project root:
   ```
   npx md-to-pdf $ARGUMENTS/resume.md
   ```
3. Verify the output file exists at `$ARGUMENTS/resume.pdf`
4. Report the file size and confirm success
