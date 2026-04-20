#!/usr/bin/env bash
# Convert a markdown file to PDF via python-markdown + WeasyPrint.
# Usage: md-to-pdf.sh <input.md> [output.pdf]
# If output is omitted, writes alongside the input with .pdf extension.

set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <input.md> [output.pdf]" >&2
  exit 1
fi

input="$1"
output="${2:-${input%.md}.pdf}"

if [[ ! -f "$input" ]]; then
  echo "Input not found: $input" >&2
  exit 1
fi

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
css="$script_dir/style.css"

# Render markdown -> HTML with system python, then pipe HTML to the WeasyPrint
# CLI (which lives in its own uv-managed venv and doesn't have python-markdown).
html=$(python3 - "$input" "$css" <<'PY'
import sys
from pathlib import Path
import markdown

input_path, css_path = sys.argv[1], sys.argv[2]
md_text = Path(input_path).read_text(encoding="utf-8")
body = markdown.markdown(
    md_text,
    extensions=["tables", "fenced_code", "attr_list", "md_in_html"],
)
css = Path(css_path).read_text(encoding="utf-8") if Path(css_path).is_file() else ""
print(f"""<!DOCTYPE html>
<html lang="en">
<head><meta charset="utf-8"><title>{Path(input_path).stem}</title>
<style>{css}</style></head>
<body>{body}</body>
</html>""")
PY
)

base_url="$(cd "$(dirname "$input")" && pwd)/"
printf '%s' "$html" | weasyprint --base-url "$base_url" - "$output"
echo "$output"
