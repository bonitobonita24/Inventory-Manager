#!/bin/bash

echo "=== Log a Lesson to .cline/memory/lessons.md ==="
echo ""
echo "Type? [1=🔴 gotcha  2=🟡 fix  3=🟤 decision  4=⚖️ trade-off  5=🟢 change]"
read TYPE_NUM
case $TYPE_NUM in
	1) ICON="🔴 gotcha" ;;
	2) ICON="🟡 fix" ;;
	3) ICON="🟤 decision" ;;
	4) ICON="⚖️ trade-off" ;;
	5) ICON="🟢 change" ;;
	*) ICON="🟢 change" ;;
esac

echo "Short title (e.g. 'Docker daemon requires WSL2 not devcontainer'):"
read TITLE

echo "Affected files (comma-separated, or 'none'):"
read FILES

echo "Keywords (e.g. 'docker, wsl2, devcontainer'):"
read CONCEPTS

echo "What happened and why does it matter? (one paragraph):"
read NARRATIVE

DATE=$(date +%Y-%m-%d)
ENTRY="
## $DATE — $ICON $TITLE
- Type:      $ICON
- Phase:     manual entry
- Files:     $FILES
- Concepts:  $CONCEPTS
- Narrative: $NARRATIVE
"

echo -e "$ENTRY" >> .cline/memory/lessons.md
echo ""
echo "✅ Lesson logged to .cline/memory/lessons.md"
