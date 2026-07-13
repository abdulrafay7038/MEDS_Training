#!/bin/bash

set -euo pipefail   # Exit on error, undefined variables, and pipe failures

mkdir -p output     # Create output directory if it doesn't exist

REPORT_FILE="output/report.html"  # HTML report output file

echo "Generating report..."

# Start HTML file
cat > "$REPORT_FILE" << EOF
<html>
<head>
<title>RISC-V Log Report</title>
</head>
<body>

<h1>RISC-V Log Analysis Report</h1>

<table border="1">
<tr>
<th>Log File</th>
<th>Status</th>
</tr>
EOF

# Loop through log files safely
for file in test_data/*.log; do

    # Skip if no matching files exist
    [ -e "$file" ] || continue

    # Run analyzer and decide status based on exit code
    if ./scripts/analyze.sh "$file" > /dev/null 2>&1; then
        STATUS="PASS"
    else
        STATUS="FAIL"
    fi

    # Append row to HTML report
    echo "<tr><td>$file</td><td>$STATUS</td></tr>" >> "$REPORT_FILE"

done

# Close HTML file
cat >> "$REPORT_FILE" << EOF
</table>
</body>
</html>
EOF

echo "Report saved to $REPORT_FILE"
