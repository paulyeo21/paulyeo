# paulyeo.com

Personal website — changelog-style feed of projects, writing, and updates.

## Adding an entry

```bash
./new-entry.sh "Title" [blog|project|update] "Mon YYYY" "Content."
```

Example:
```bash
./new-entry.sh "Shipped something new" project "Mar 2025" "Launched the new dashboard. It's faster and simpler."
```

This creates `entries/[slug].html`, inserts the feed item in `index.html`, and fills in both the excerpt and entry body. Then just:

```bash
git add . && git commit -m "Add: Shipped something new" && git push
```

For longer posts, edit the `.prose` div in the entry file before committing.

## Local preview

Open `index.html` in a browser, or run a local server:

```bash
python3 -m http.server 8000
```
