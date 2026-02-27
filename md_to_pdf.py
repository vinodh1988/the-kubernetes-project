#!/usr/bin/env python3
"""Convert all Markdown files in a codebase to PDF files.

- Recursively scans a root directory for `.md` files.
- Converts each Markdown file to a PDF.
- Stores converted PDFs in an output folder (default: `documents`) while preserving
  the original relative folder structure.

Dependencies:
    pip install markdown reportlab

Usage:
    python md_to_pdf.py
    python md_to_pdf.py --root . --output documents --overwrite
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

try:
    import markdown
except ImportError:
    markdown = None

try:
    from reportlab.lib.pagesizes import A4
    from reportlab.lib.styles import getSampleStyleSheet
    from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer
except ImportError:
    A4 = None
    getSampleStyleSheet = None
    Paragraph = None
    SimpleDocTemplate = None
    Spacer = None


def check_dependencies() -> None:
    missing = []
    if markdown is None:
        missing.append("markdown")
    if SimpleDocTemplate is None:
        missing.append("reportlab")

    if missing:
        joined = ", ".join(missing)
        print(f"Missing required package(s): {joined}", file=sys.stderr)
        print("Install with: pip install markdown reportlab", file=sys.stderr)
        raise SystemExit(1)


def markdown_file_to_pdf(source_file: Path, target_file: Path) -> None:
    md_text = source_file.read_text(encoding="utf-8", errors="replace")

    html = markdown.markdown(md_text)

    styles = getSampleStyleSheet()
    normal_style = styles["Normal"]
    heading_style = styles["Heading2"]

    story = []
    title = source_file.stem
    story.append(Paragraph(title, heading_style))
    story.append(Spacer(1, 10))

    blocks = [block.strip() for block in html.split("\n\n") if block.strip()]
    for block in blocks:
        safe_block = block.replace("<pre>", "").replace("</pre>", "")
        safe_block = safe_block.replace("<code>", "<font name='Courier'>")
        safe_block = safe_block.replace("</code>", "</font>")
        story.append(Paragraph(safe_block, normal_style))
        story.append(Spacer(1, 6))

    target_file.parent.mkdir(parents=True, exist_ok=True)
    doc = SimpleDocTemplate(str(target_file), pagesize=A4)
    doc.build(story)


def convert_all_markdown(root: Path, output_dir: Path, overwrite: bool) -> tuple[int, int, int]:
    converted = 0
    skipped_existing = 0
    failed = 0

    output_dir = output_dir.resolve()

    for md_file in root.rglob("*.md"):
        resolved_md = md_file.resolve()

        if output_dir in resolved_md.parents:
            continue

        relative = md_file.relative_to(root)
        pdf_relative = relative.with_suffix(".pdf")
        target_pdf = output_dir / pdf_relative

        if target_pdf.exists() and not overwrite:
            skipped_existing += 1
            continue

        try:
            markdown_file_to_pdf(md_file, target_pdf)
            converted += 1
            print(f"Converted: {md_file} -> {target_pdf}")
        except Exception as exc:
            failed += 1
            print(f"Failed: {md_file} ({exc})", file=sys.stderr)

    return converted, skipped_existing, failed


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert all Markdown files in a repository into PDFs in a documents folder."
    )
    parser.add_argument(
        "--root",
        default=".",
        help="Root directory to scan for Markdown files (default: current directory).",
    )
    parser.add_argument(
        "--output",
        default="documents",
        help="Output directory for generated PDFs (default: documents).",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite existing PDF files.",
    )
    return parser.parse_args()


def main() -> int:
    check_dependencies()

    args = parse_args()
    root = Path(args.root).resolve()
    output = Path(args.output)

    if not output.is_absolute():
        output = root / output

    if not root.exists() or not root.is_dir():
        print(f"Invalid root directory: {root}", file=sys.stderr)
        return 1

    output.mkdir(parents=True, exist_ok=True)

    converted, skipped_existing, failed = convert_all_markdown(
        root=root,
        output_dir=output,
        overwrite=args.overwrite,
    )

    print("\nSummary")
    print(f"Converted: {converted}")
    print(f"Skipped existing: {skipped_existing}")
    print(f"Failed: {failed}")

    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
