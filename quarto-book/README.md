# r4wrds Quarto Book

This directory contains a self-contained Quarto Book version of the r4wrds curriculum (intro + intermediate), including the course data/assets needed to render the book.

## Developer guide (concise)

### Prereqs

- R (recommended: recent release) + RStudio
- Quarto CLI
- Required R packages (installed once): the course uses packages like `tidyverse`, `sf`, `mapview`, `shiny`, etc. Install on demand based on render errors.

### Preview locally

```bash
cd quarto-book
quarto preview
```

### Full render

```bash
cd quarto-book
quarto render
```

### `here()` / working directory notes

- The book runs chapters from their own folder (`execute-dir: file`), so chapter-relative paths work.
- For interactive work inside the original lesson folders, open:
  - `intro/WRDS_intro.Rproj`
  - `intermediate/WRDS_intermediate.Rproj`

## Netlify deploy (GitHub)

- Base directory: `quarto-book`
- Build command: `bash scripts/netlify-build.sh` (downloads Quarto, then renders)
- Publish directory: `_book`
- `netlify.toml` in this folder encodes the same settings.
