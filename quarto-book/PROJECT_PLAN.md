# r4wrds Quarto Book Migration Plan

## 1. Project goals
- Deliver a single Quarto Book (`r4wrds`) that unifies the intro and intermediate curricula while keeping all current learning assets (text, sidebars, collapsible Q&A, worksheets, datasets, scripts, figures).
- Modernize the publishing stack by leveraging Quarto book features (chapter structure, cross references, callouts, margin notes, executable code cells) without losing any context or interactivity.
- Improve maintainability by centralizing assets, removing duplicated content between courses, and documenting the new workflow.

## 2. Scope, constraints, and assumptions
- **Scope** includes porting every module currently in `intro/` and `intermediate/`, consolidating overlapping lessons, refreshing navigation, ensuring the new book can render locally (`quarto render` / `quarto preview`) and deploy to Netlify via GitHub, and making the `quarto-book/` directory entirely self-contained (all data/images/scripts are copied inside).
- **Out of scope** for this sprint: new pedagogy/content, video production, changes to external data sources beyond Quarto compatibility work, and pixel-perfect UX parity (e.g., the custom landing-page animation).
- **Constraints & assumptions**
  - Stick to Quarto Book best practices (YAML `book` project, `_quarto.yml`, `_book/` output).
  - Prioritize clarity over mimicry: minimal styling is acceptable so long as the educational content is intact; no need to port the Distill-specific animations/scripts.
  - All interactive flourishes (sidebars, collapsible answers, footnotes, callouts) must be reimplemented using Quarto shortcodes/callouts/margin notes.
  - Prefer R-based execution (renv/targets) but allow future Python chapters; structure book for multilingual chunks.

## 3. Deliverables
1. `quarto-book/` project scaffold with `_quarto.yml`, chapter `.qmd` files, shared `_extensions/` if needed, supporting assets (data, images, code, exercises), and no external asset dependencies.
2. Content mapping document showing where each intro/intermediate module lands in the new book outline.
3. Fully migrated chapters with verified code execution and parity of contextual elements.
4. README covering local build/preview steps and Netlify deployment from GitHub (build command, publish directory, env requirements).
5. Automated build instructions (CI script) and Netlify-ready render command.
6. Launch checklist & retro notes for the next iteration.

## 4. Work breakdown

### Phase A — Discovery & Information Architecture
- Inventory intro + intermediate modules, assets, and dependencies; capture in a tracking sheet (include sidebars/Q&A/footnotes requirements).
- Draft combined book outline (parts/chapters/appendices) using Quarto structure.
- Define navigation, cross references, and numbering scheme; confirm with stakeholders.

### Phase B — Project Scaffold
- Initialize Quarto Book (`quarto create-project --type book` or manual scaffold) inside `quarto-book/`.
- Configure `_quarto.yml` with metadata, TOC, sidebar, margin content, search, and output directory.
- Set up shared assets folders (`data`, `figures`, `code`, `exercises`) and copy reusable resources from existing courses so the project is self-contained.
- Document build workflow in `README.md`, including local prerequisites (R, Quarto CLI, package manager), commands for `quarto render`/`quarto preview`, and deployment steps targeting Netlify (build command + publish directory).

### Phase C — Content Migration
- For each legacy module:
  1. Copy or rewrite `.Rmd` content into `.qmd` chapters while updating front matter and chunk options.
  2. Convert legacy widgets (collapsible panels, Q&A) into Quarto callouts (`::: {.callout-tip}` / `collapse="true"`) or margin notes.
  3. Recreate sidebars using Quarto margin notes/`sidebar` blocks; port footnotes to Markdown footnote syntax.
  4. Test code chunks with Quarto render; capture any data or package requirements.
- Track completion status per chapter (Not started → Drafted → Verified → Reviewed).

### Phase D — Self-contained assets & Light Styling
- Verify every chapter references assets stored inside `quarto-book/`; copy/transform any straggling data, figures, or worksheets and update paths.
- Provide lightweight Quarto theme tweaks (fonts/colors) sufficient for readability without replicating Distill-specific layouts or animations.
- Rebuild essential navigation aids (landing page, part introductions, learning objectives, exercises, worksheet links) using Quarto-native components only.

### Phase E — Quality Assurance
- Automated checks: `quarto check`, spell-check, link-check, and validation of R package dependencies.
- Manual review for consistency of terminology, numbering, and callouts.
- Stakeholder review of sample chapters before full migration completion.

### Phase F — Deployment & Handoff
- Decide on final hosting path (replace existing site vs. subdirectory); update deployment scripts accordingly and configure Netlify site settings (repo, branch, `quarto render` build command, `quarto-book/_book/` publish directory, build env).
- Document local preview + Netlify deployment workflow in README and optionally setup a Netlify deploy badge.
- Provide migration report summarizing differences, new workflows, and remaining backlog items.
- Archive Distill version (tag release) for reference.

## 5. Risks & mitigation
- **Risk:** Loss of contextual cues (Q&A, footnotes) during migration.  
  **Mitigation:** Maintain a checklist per module to confirm each contextual element is ported; add automated tests (search for `::: {.callout}` etc.).
- **Risk:** Build failures due to package drift.  
  **Mitigation:** Pin dependencies via `renv` or `pak`, include reproducibility instructions, run renders in clean environment.
- **Risk:** Scope creep when combining courses.  
  **Mitigation:** Approve outline early, freeze scope after content mapping, capture extras in backlog.

## 6. Next actions
1. Approve this plan and desired outline fidelity.
2. Inventory legacy modules/assets and produce the content mapping artifact.
3. Scaffold the Quarto Book project once outline is confirmed.
4. Begin migration in priority order (highest enrollment modules first) while running QA in parallel.
