# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

paulyeo.com — a personal changelog-style website. Pure HTML/CSS/JS, no build tools, no dependencies.

## Development

Open `index.html` directly in a browser — no server required. For local testing with proper absolute paths, use any static server:

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000`.

## Architecture

```
paulyeo/
├── index.html          # Main feed — reverse-chronological list of all entries
├── entries/            # Individual entry pages
│   └── [slug].html
├── css/
│   └── style.css       # All styles (CSS custom properties, no frameworks)
└── js/
    └── main.js         # Tag filter logic only
```

`css/style.css` uses CSS custom properties defined on `:root` for all colors and sizing. No external fonts — system font stack only.

## Adding a New Entry

1. Copy `entries/hello-world.html` → `entries/your-slug.html`
2. Update: title, date, tag (`blog` / `project` / `update`), and prose content
3. Add a new `<li class="feed-item" data-tag="[tag]">` at the **top** of the `.feed` list in `index.html`

Entry HTML paths use `../css/style.css` and `../index.html` (relative to the `entries/` subdirectory).

## Tags

Three tag types, each with a corresponding CSS class and `data-tag` attribute:
- `blog` → `.tag-blog`
- `project` → `.tag-project`
- `update` → `.tag-update`
