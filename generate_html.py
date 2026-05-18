import markdown

with open('reports/project_report.md', 'r') as f:
    report_md = f.read()

with open('reports/defense_slides.md', 'r') as f:
    slides_md = f.read()

html_template = """
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {{ padding: 50px; line-height: 1.6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }}
        pre {{ background: #f4f4f4; padding: 15px; border-radius: 5px; }}
        h1, h2, h3 {{ color: #2c3e50; margin-top: 30px; }}
        table {{ width: 100%; border-collapse: collapse; margin-bottom: 20px; }}
        th, td {{ border: 1px solid #ddd; padding: 12px; text-align: left; }}
        th {{ background-color: #f8f9fa; }}
        @media print {{
            .no-print {{ display: none; }}
            body {{ padding: 0; }}
            .page-break {{ page-break-before: always; }}
        }}
    </style>
</head>
<body>
    <div class="container">
        <div class="no-print alert alert-info">
            This page is formatted for printing. Press <b>Ctrl+P</b> (or Cmd+P) and select "Save as PDF" for your final submission.
        </div>
        {content}
    </div>
</body>
</html>
"""

report_html = markdown.markdown(report_md, extensions=['fenced_code', 'tables'])
slides_html = markdown.markdown(slides_md, extensions=['fenced_code', 'tables'])

with open('reports/project_report.html', 'w') as f:
    f.write(html_template.format(title="Project Report", content=report_html))

with open('reports/defense_slides.html', 'w') as f:
    f.write(html_template.format(title="Defense Slides", content=slides_html))
