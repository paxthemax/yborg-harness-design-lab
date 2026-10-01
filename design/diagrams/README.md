# Harness diagram release

Open [the HTML gallery](index.html). HTML files are the current editable diagrams: standalone HTML and inline CSS, with no JavaScript, SVG, external fonts or runtime dependencies. Narrow screens stack the cards vertically. PNGs are desktop exports of those same files.

| Diagram | HTML | PNG |
|---|---|---|
| Harness architecture | [HTML](harness-architecture.html) | [PNG](harness-architecture.png) |
| Investigation lifecycle | [HTML](investigation-lifecycle.html) | [PNG](investigation-lifecycle.png) |
| Premise change flow | [HTML](premise-change-flow.html) | [PNG](premise-change-flow.png) |

## Layout rationale

The operator requested replacing the SVG diagrams with pure HTML and clearer layouts. Architecture now uses authority layers and explicit handoff descriptions. Investigation work uses a main path followed by human outcomes, interruptions and freshness review. Premise changes use six chronological steps with actor routes. This reduces crossing connectors while retaining the original information paths and guards.

The architecture remains proposed under DEC-003; this presentation update does not accept it. The `.mmd` files and `mermaid-config.json` remain as historical diagram sources. Current documentation embeds PNGs and links to HTML; the earlier SVG exports have been replaced.

## Regenerate PNGs

With Chromium available, run from the repository root:

```bash
bash design/diagrams/export-png.sh
```

The script renders local files only and uses a temporary browser profile. The released sizes are 1400 × 1820, 1400 × 1640 and 1400 × 1450 respectively. Inspect exports after changing content or spacing; increase viewport height if content grows. No harness code or build/test pipeline is introduced.

All three released PNGs were visually inspected for readable text and complete framing on 2026-10-01.

## DESIGNED/IMPLEMENTED update — 2026-10-01

Regenerated all three HTML/PNG diagrams for DEC-006. Architecture shows distinct behavioral views and comparison records; lifecycle shows documentation-first intake and comparison at every lens feeding deviations and design-risk questions; premise changes revalidate either model and preserve earlier discrepancy rationale. DEC-006 process acceptance is distinct from the proposed DEC-003 architecture.

All three updated exports were visually inspected for readable text and complete framing.
