# paulyeo.com

Personal website — changelog-style feed of projects, writing, and updates.

## Adding an entry

```bash
./new-entry.sh "My Title" [blog|project|update] "Mon YYYY"
```

Example:
```bash
./new-entry.sh "Shipped something new" project "Mar 2025"
```

This creates `entries/[slug].html` and inserts the feed item in `index.html`. Then:
1. Write content in the `.prose` div of the new entry file
2. Update the excerpt in `index.html`
3. `git add . && git commit -m "Add: My Title" && git push`

## Local preview

Open `index.html` in a browser, or run a local server:

```bash
python3 -m http.server 8000
```
