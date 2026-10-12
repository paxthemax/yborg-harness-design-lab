# Harness diagram release

Open [the HTML gallery](index.html). HTML files are the current editable diagrams: standalone HTML and inline CSS, with no JavaScript, SVG, external fonts or runtime dependencies. Narrow screens stack the cards vertically. PNGs are desktop exports of those same files.

| Diagram | HTML | PNG |
|---|---|---|
| Harness architecture | [HTML](harness-architecture.html) | [PNG](harness-architecture.png) |
| Investigation lifecycle | [HTML](investigation-lifecycle.html) | [PNG](investigation-lifecycle.png) |
| Premise change flow | [HTML](premise-change-flow.html) | [PNG](premise-change-flow.png) |
| Human/agent workflow and loops | [HTML](human-agent-audit-flow.html) | [PNG](human-agent-audit-flow.png) |

## Layout rationale

The operator requested replacing the SVG diagrams with pure HTML and clearer layouts. Architecture now uses authority layers and explicit handoff descriptions. Investigation work uses a main path followed by human outcomes, interruptions and freshness review. Premise changes use six chronological steps with actor routes. This reduces crossing connectors while retaining the original information paths and guards.

On 2026-10-01 the architecture remained proposed under DEC-003, and this presentation update did not accept it; DEC-009 accepted it as amended on 2026-10-12. The `.mmd` files and `mermaid-config.json` remain as historical diagram sources. Current documentation embeds PNGs and links to HTML; the earlier SVG exports have been replaced.

## Regenerate PNGs

With Chromium available, run from the repository root:

```bash
bash design/diagrams/export-png.sh
```

The script renders local files only and uses a temporary browser profile. The first three released sizes are 1400 × 1820, 1400 × 1800 and 1400 × 1450 respectively. The human/agent workflow uses a 1440 × 3120 viewport at scale 2, producing 2880 × 6240 pixels. The clean architecture export uses a 1400 × 1600 viewport at scale 2, producing 2800 × 3200 pixels, and can be regenerated alone with `bash design/diagrams/export-png.sh harness-architecture-clean`. Inspect exports after changing content or spacing; increase viewport height if content grows. No harness code or build/test pipeline is introduced.

To regenerate only the new flow:

```bash
bash design/diagrams/export-png.sh human-agent-audit-flow
```

All three released PNGs were visually inspected for readable text and complete framing on 2026-10-01.

## DESIGNED/IMPLEMENTED update — 2026-10-01

Regenerated all three HTML/PNG diagrams for DEC-006. Architecture shows distinct behavioral views and comparison records; lifecycle shows documentation-first intake and comparison at every lens feeding deviations and design-risk questions; premise changes revalidate either model and preserve earlier discrepancy rationale. DEC-006 process acceptance is distinct from the proposed DEC-003 architecture.

All three updated exports were visually inspected for readable text and complete framing.

## Clean architecture export — 2026-10-01

[High-resolution PNG](harness-architecture-clean.png) and [editable HTML](harness-architecture-clean.html) contain only the architecture title, components and handoffs. Proposal/decision labels, introductory notes, footer and navigation links are omitted at the operator’s request. The PNG is rendered at 2800 × 3200 pixels (1400 × 1600 viewport, device scale factor 2) and was visually inspected for complete framing and readable text. This export does not alter design dispositions.

## Human/agent flow and loop export — 2026-10-02

Created a fourth primary diagram from the two new imports and accepted DEC-007 choices. The vertical workflow uses explicit human, agent, joint and deterministic-tool roles. L0–L7 label intake rounds, comprehension, scenario refinement, experiment iteration, evidence follow-up, audit steering, revalidation and method improvement. The scenario route is expanded; hypothesis/property methods share the same authorization and evidence gates. Return paths show their endpoints and conditions.

The 2880 × 5700 PNG was visually inspected: all stages, side rails, loop labels and the footer are fully framed, with no observed text overlap. Chromium required execution outside the filesystem sandbox because its startup socket was denied there; rendering used the local HTML and a temporary browser profile. Original imports and earlier diagram exports were preserved. The accepted interaction is recorded in [DEC-007](../../decisions/DEC-007-human-agent-workflow.md); detailed loop contracts and DEC-003 architecture remain proposed.

## DEC-008 integration update — 2026-10-12

All five HTML diagrams were updated for [DEC-008](../../decisions/DEC-008-adversarial-review-dispositions.md) and the vocabulary in the [glossary](../harness-glossary.md):

| Diagram | What changed |
|---|---|
| Architecture (both exports) | The trusted decision screen, an agent tool confined per engagement with input captured outside the model, probes and the snapshot diff, the required-set report check, and default-deny egress |
| Lifecycle | The six dispositions, packet completeness, and probe-based freshness |
| Premise-change flow | Snapshot diff, probe tiers, refusal of stale or undisplayed approvals, and the labelled carry-forward attestation |
| Human/agent workflow | Stage 04 "Authorize work", captured input, recorded variants, evidence-first packets for High/Critical, the six outcomes, the probe-based L6 route, and charter narrowing at stage 01 |

The lifecycle and workflow content outgrew their earlier viewports, so their export heights were raised to 1800 and 3100 CSS pixels after measuring each rendered page's content. The export script now also covers the clean architecture image.

All five PNGs were re-exported and visually inspected: text is readable, nothing overlaps, and every page is fully framed with a bottom margin. The architecture remains proposed under DEC-003.

## DEC-009 integration update — 2026-10-12

The diagrams were updated for [DEC-009](../../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), which accepts the architecture as amended, and for the new [glossary](../harness-glossary.md) terms:

| Diagram | What changed |
|---|---|
| Architecture (both exports) | The status badge reads "Accepted · DEC-009", and the context builder also draws on admitted mechanism-library entries (the clean export has no badge) |
| Lifecycle and premise-change flow | The status badge reads "Accepted · DEC-009" |
| Human/agent workflow | The policy note cites DEC-009 and the linked variant. Stage 03 offers the optional expectations pre-step, with intent recorded afterwards tagged. L2 keeps a cross-guarantee follow-up that needs nothing new as a linked variant, L7 adds sanitized transfers to the mechanism library, and the footer names the accepted baseline |
| Gallery index | The accepted design is described, and numeric limits are noted as proposals |

The workflow content grew by about 18 CSS pixels, so its export height was raised from 3100 to 3120 to keep its bottom margin. The other export heights still frame their content.

All five PNGs were re-exported and visually inspected. Text is readable, nothing overlaps, and every page is fully framed with a bottom margin. The architecture PNG is 1400 × 1820, the lifecycle 1400 × 1800, the premise-change flow 1400 × 1450, the workflow 2880 × 6240 and the clean architecture 2800 × 3200.
