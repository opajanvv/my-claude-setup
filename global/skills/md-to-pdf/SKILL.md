---
name: md-to-pdf
description: Convert a Markdown file to PDF via python-markdown + WeasyPrint. Use when asked to convert a .md to .pdf or generate a PDF from a document.
---

# md-to-pdf

A single bash script renders Markdown to PDF via python-markdown + WeasyPrint, writing the PDF alongside the source file (or to a specified path).

## Usage

```bash
~/.claude/skills/md-to-pdf/md-to-pdf.sh <input.md> [output.pdf]
```

- Without `output.pdf`, writes alongside the input (`foo.md` -> `foo.pdf`).
- Styling lives in `style.css` next to the script. Edit that to change layout — not the script.
- Tables, fenced code, and `attr_list` extensions are enabled. Page break: `<!-- pagebreak -->` renders as `<hr>`; for a hard page break use `<div class="pagebreak"></div>`.

## Requirements

`weasyprint` (`/home/jan/.local/bin/weasyprint`) and `python3 -c "import markdown"` must be available — both are already installed on this system.
