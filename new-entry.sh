#!/usr/bin/env bash
set -e

TITLE="$1"
TAG="$2"
DATE="$3"

# ── Validate args ────────────────────────────────────────────────────────────

if [ -z "$TITLE" ] || [ -z "$TAG" ] || [ -z "$DATE" ]; then
  echo "Usage: ./new-entry.sh \"Title\" [blog|project|update] \"Mon YYYY\""
  echo "Example: ./new-entry.sh \"My New Post\" blog \"Mar 2025\""
  exit 1
fi

if [ "$TAG" != "blog" ] && [ "$TAG" != "project" ] && [ "$TAG" != "update" ]; then
  echo "Error: tag must be blog, project, or update"
  exit 1
fi

# ── Generate slug ────────────────────────────────────────────────────────────

SLUG=$(echo "$TITLE" \
  | tr '[:upper:]' '[:lower:]' \
  | tr -cs 'a-z0-9' '-' \
  | sed 's/^-//;s/-$//')

ENTRY_FILE="entries/${SLUG}.html"

if [ -f "$ENTRY_FILE" ]; then
  echo "Error: $ENTRY_FILE already exists"
  exit 1
fi

# ── Create entry HTML file ───────────────────────────────────────────────────

cat > "$ENTRY_FILE" <<HTMLEOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="${TITLE}">
  <title>${TITLE} — Paul Yeo</title>
  <link rel="stylesheet" href="../css/style.css">
</head>
<body>

  <header>
    <div class="container">
      <a href="../index.html" class="wordmark">Paul Yeo</a>
      <nav>
        <a href="https://github.com/paulyeo21" target="_blank" rel="noopener">GitHub</a>
        <a href="https://linkedin.com/in/paulyeo" target="_blank" rel="noopener">LinkedIn</a>
        <a href="mailto:paulyeo21@gmail.com">Contact</a>
      </nav>
    </div>
  </header>

  <main>
    <div class="container">

      <a href="../index.html" class="back-link">← Back</a>

      <div class="entry-header">
        <div class="entry-meta">
          <span class="tag tag-${TAG}">${TAG}</span>
          <span class="entry-date">${DATE}</span>
        </div>
        <h1 class="entry-page-title">${TITLE}</h1>
      </div>

      <div class="prose">
        <p>Write your content here.</p>
      </div>

    </div>
  </main>

  <footer>
    <div class="container">
      <a href="mailto:paulyeo21@gmail.com">paulyeo21@gmail.com</a>
      <div class="footer-links">
        <a href="https://github.com/paulyeo21" target="_blank" rel="noopener">GitHub</a>
        <a href="https://linkedin.com/in/paulyeo" target="_blank" rel="noopener">LinkedIn</a>
      </div>
    </div>
  </footer>

</body>
</html>
HTMLEOF

# ── Prepend feed item to index.html ─────────────────────────────────────────

TMPFILE=$(mktemp)
cat > "$TMPFILE" <<ITEMEOF

        <li class="feed-item" data-tag="${TAG}">
          <span class="entry-date">${DATE}</span>
          <div class="entry-content">
            <span class="tag tag-${TAG}">${TAG}</span>
            <a href="entries/${SLUG}.html" class="entry-title">${TITLE}</a>
            <p class="entry-excerpt">Add your excerpt here.</p>
          </div>
        </li>
ITEMEOF

awk -v f="$TMPFILE" \
  '/<!-- ── Add new entries at the top ── -->/{print; while((getline line < f)>0) print line; close(f); next}1' \
  index.html > index.html.tmp

mv index.html.tmp index.html
rm "$TMPFILE"

# ── Done ─────────────────────────────────────────────────────────────────────

echo ""
echo "  Created : $ENTRY_FILE"
echo "  Updated : index.html"
echo ""
echo "  Next:"
echo "    1. Write content in the .prose div of $ENTRY_FILE"
echo "    2. Update the excerpt in index.html"
echo "    3. git add . && git commit -m \"Add: ${TITLE}\" && git push"
echo ""
