#!/usr/bin/env bash
# Renders the résumé HTML sources to PDF at the repo root via headless Chrome.
# Real text, single column, no images: stays parseable by applicant tracking systems.
set -euo pipefail

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
REPO="$(cd "$(dirname "$0")/.." && pwd)"

render() {
  local src="$1" out="$2"
  "$CHROME" --headless --disable-gpu --no-pdf-header-footer \
    --virtual-time-budget=6000 \
    --print-to-pdf="$REPO/$out" "file://$REPO/resume/$src" 2>/dev/null
  printf "%-36s %s page(s)\n" "$out" "$(pdfinfo "$REPO/$out" | awk '/^Pages:/{print $2}')"
}

render resume-1page.html   avery-strand-resume.pdf
render resume-detailed.html avery-strand-resume-detailed.pdf
