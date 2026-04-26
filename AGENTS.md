# AGENTS.md

## Project Summary

- This repository is a small static personal landing page hosted on GitHub Pages.
- The page is divided into distinct domains, such as `Personal`, `Professional & Academic`, and `Contact`.
- In `index.html`, these domains are presented as grouped link blocks with visible blank-line spacing between sections. Preserve that simple index-style separation when editing or reordering links.
- There is no package manager, build pipeline, or framework.
- The main editable files are `index.html` and `assets/style.css`.
- `_config.yml` is only a minimal GitHub Pages/Jekyll setting.

## Safe Edit Areas

- `index.html`: page structure, metadata, link list, and inline translation strings.
- `assets/style.css`: layout, colors, spacing, and typography.
- `content.md`: content inventory for name, summaries, labels, and external links.
- `assets/files/`: profile image and other first-party assets.

## Avoid Editing

- `assets/fontawesome-free-6.4.2-web/` is vendored third-party code.
- Do not reformat, rename, or partially edit vendored Font Awesome files unless the task is a deliberate vendor upgrade.

## Working Rules

- Keep text UTF-8 encoded. Portuguese copy should keep proper accents.
- Prefer small, surgical edits over broad reformatting.
- Keep the site as a simple static page unless a larger refactor is explicitly requested.
- When changing profile text, section labels, or external links, update both `content.md` and `index.html`.
- Prefer HTTPS links when available.
- Keep relative asset paths stable.

## Verification

- Run `scripts/check.ps1` after making edits.
- Use `scripts/preview.ps1` to serve the site locally for manual review.
- Confirm that local `src` and `href` references in `index.html` still resolve.
- If changing icons, verify the referenced Font Awesome class exists in the vendored version.

## Definition of Done Criteria

- `index.html`, `content.md`, and `assets/style.css` remain consistent.
- No local file references are broken.
- The page still works as a single static HTML page without extra setup.
