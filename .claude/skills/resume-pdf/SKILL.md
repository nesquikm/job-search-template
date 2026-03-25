---
description: Export a resume to PDF with custom styling. Use when asked to regenerate or export a resume PDF.
user_invocable: true
allowed-tools: Bash(bash *), Bash(npx md-to-pdf *)
---

# Export Resume to PDF

Regenerate the resume PDF from markdown.

## Usage

Pass the resume directory as an argument: `/resume-pdf resume/v1` (or any `resume/v*` path).
If no argument is given, ask which resume version to export.

## Engine Selection

There are two PDF engines available. Detect automatically:

- **WeasyPrint** — if `resume.md` has NO YAML frontmatter (no `pdf_options:`). Better ATS text extraction, smaller files. Requires `weasyprint` and `npx marked` installed.
- **md-to-pdf** — if `resume.md` starts with YAML frontmatter containing `pdf_options:`. Uses Chrome/Puppeteer.

## Steps — WeasyPrint

1. Confirm the target directory (e.g., `resume/v1/`, `resume/v1-company/`)
2. Run the bundled build script:
   ```bash
   bash ${CLAUDE_SKILL_DIR}/scripts/build-pdf.sh $ARGUMENTS
   ```
3. Verify the output file exists at `$ARGUMENTS/resume.pdf`
4. **Read the PDF** to verify it is exactly 1 page. If it overflows, adjust CSS spacing and regenerate.
5. Report the file size and confirm success

## Steps — md-to-pdf

1. Confirm the target directory (e.g., `resume/v1/`, `resume/v1-company/`)
2. Run the export command from the project root:
   ```bash
   npx md-to-pdf $ARGUMENTS/resume.md
   ```
3. Verify the output file exists at `$ARGUMENTS/resume.pdf`
4. **Read the PDF** to verify it is exactly 1 page. If it overflows, adjust CSS spacing and regenerate.
5. Report the file size and confirm success

## Important

- **Run one PDF at a time.** Do NOT chain multiple calls with `&&` or run them in parallel — both engines can stall when multiple instances launch concurrently.
- **Always verify page count** after generating — resumes must be exactly 1 page.
