# paulyeo.com

Personal website — changelog-style feed of projects, writing, and updates.

## Adding an entry

1. Copy `entries/hello-world.html` → `entries/your-slug.html`
2. Update the title, date, tag, and content
3. Add a new `<li>` at the top of the `.feed` list in `index.html`:

```html
<li class="feed-item" data-tag="blog">
  <span class="entry-date">Mar 2025</span>
  <div class="entry-content">
    <span class="tag tag-blog">blog</span>
    <a href="entries/your-slug.html" class="entry-title">Your Title</a>
    <p class="entry-excerpt">One or two sentence excerpt.</p>
  </div>
</li>
```

Tags: `blog`, `project`, `update`

## Local preview

Open `index.html` in a browser, or run a local server:

```bash
python3 -m http.server 8000
```
