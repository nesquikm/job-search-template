#!/bin/bash
# Build resume PDF using WeasyPrint (for v5+ resumes without YAML frontmatter)
# Usage: build-pdf.sh <resume-dir>
set -e

DIR="${1:?Usage: $0 <resume-dir>}"
MD="$DIR/resume.md"
CSS="$DIR/resume-style.css"
PDF="$DIR/resume.pdf"

if [ ! -f "$MD" ]; then echo "Error: $MD not found"; exit 1; fi
if [ ! -f "$CSS" ]; then echo "Error: $CSS not found"; exit 1; fi

CSS_ABS="$(cd "$(dirname "$CSS")" && pwd)/$(basename "$CSS")"
HTML_BODY=$(npx marked < "$MD")

cat > /tmp/resume-export.html << HTMLEOF
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="file://${CSS_ABS}">
</head>
<body>
${HTML_BODY}
</body>
</html>
HTMLEOF

weasyprint /tmp/resume-export.html "$PDF" -p
echo "OK: $(wc -c < "$PDF" | tr -d ' ') bytes → $PDF"
