# PLUR store guide

This directory contains **PLUR-format data** for the selected lab memory policy. The agent can use these files directly; PLUR's engine and host integration are not connected. The inspected source version is documented in [the assessment](../../research/plur-assessment.md).

## Files and seed authority

- `engrams.yaml`: nine memories grounded in explicit repository/operator instructions and decisions, one unreviewed imported recommendation, and three unreviewed source-backed design lessons.
- `episodes.yaml`: timestamped records of scope clarifications, deliveries, and operator decisions, with source paths in their summaries.
- `config.yaml`: keyword retrieval, automatic learning/capture enabled, and no remote stores.
- Future `history/`: PLUR observational and lifecycle events, retained with the store when the engine is connected.

Each engram carries a repository-relative `knowledge_anchors.path` and `structured_data.lab`. Treat those paths as relative to the repository root when reading grounding documents. They are document locators, not instructions to change PLUR's store root. Use the root as the working directory for the commands below.

Seed metadata distinguishes explicit instructions from imported recommendations. `approved_by: lab-operator` identifies the decision role supplied in this session, not a cryptographically verified identity. Approval dates record the instruction date; they do not claim that the operator reviewed the exact paraphrased YAML text.

## Manual use now

Read `AGENTS.md`, [the handover](../session.md), [the KB guide](../../kb/README.md), and task-relevant documents. Inspect `engrams.yaml` as an additional context aid. Read a recommendation's grounding card and disposition before relying on it for a design choice. Write episodes only for events that actually occurred.

Automatically record useful reusable lessons without individual approval. Use `status: active`, normally `commitment: leaning`, and `review_status: unreviewed`; keep approval fields null. Preserve source and rationale. A memory may guide work before periodic review, but an active recommendation remains a recommendation until the operator makes the design decision. Use draft commitment for incomplete grounding or disputed guidance needing quarantine. Feedback and activation scores do not supply operator approval.

The agent can create complete records directly in these files while engine writers are stopped. Include a brief memory review at meaningful milestones and after corrections or contradictions; ordinary capture continues between reviews. This is the current automatic-learning workflow, without claiming that changing the config starts an unattended learning service.

## Connecting later through mise

Select and pin the CLI/MCP version after checking its distribution against the source/schema contract. Manage required tools through mise. No PLUR package has been added to `mise.toml` and no global agent configuration has been changed.

Once a matching CLI is available in the mise environment, these commands show the intended path and retrieval settings:

```bash
# Run from the repository root, inside the mise environment.
PLUR_AUTO_DISCOVER=0 plur --path "$PWD/memory/plur" status
PLUR_AUTO_DISCOVER=0 plur --path "$PWD/memory/plur" --fast inject \
  'Resume design work using the accepted lab memory policy' \
  --budget 2000 --no-with-default-protocol
```

These are integration examples, not executed commands or evidence of successful retrieval. `--fast` selects the keyword injection path; the config also disables embeddings. All manual learning calls must supply `project:framework-design-lab` explicitly. Ordinary CLI learning does not expose draft commitment in the inspected version.

Create complete automatically learned records by following the shape in `engrams.yaml`, choosing a unique ID, and supplying statement, source, anchors, and lab metadata. A future complete core writer can avoid hand edits. MCP `plur_learn` accepts scope, commitment, source text, and visibility, but not `knowledge_anchors` or `structured_data`. An integration using MCP should create incomplete records as draft, complete the grounding through a safe enrichment step, then activate them automatically with `commitment: leaning`. That step needs no per-memory operator approval. Set `visibility: private` and `project:framework-design-lab` explicitly.

For a dedicated MCP process, set `PLUR_PATH` to the absolute path of this directory and `PLUR_AUTO_DISCOVER` to `0` in that host's local configuration. Do not rely on a project `.plur.yaml` to select the physical store. Inspect automatic host capture and enrichment against the selected policy. An optional project scope configuration or folder trust grant must be evaluated for the chosen host; none is supplied here.

## Periodic review and correction

1. Open grounding records for memories that are misleading, contradicted, stale, or consequential. Keep any actual operator design disposition in its canonical decision record.
2. Stop PLUR writers before hand-editing its YAML arrays. Preserve every unrelated record and the old version when changing a substantive assertion.
3. Correct, retire, or qualify inaccurate memories. Complete grounded drafts and activate them automatically when suitable. Record operator approval only when it actually occurred; use locked guidance for explicit standing instructions or decisions. A corrected fact gets explicit supersession links where appropriate.
4. Inspect the resulting schema and persisted record before claiming the edit succeeded. Retain an episode describing the transition and its document reference.

`plur_promote`/CLI `promote` changes status; it does **not** clear draft commitment. Do not treat a successful promotion response as operator approval. `structured_data.lab` is a lab convention, not a PLUR-enforced authorization mechanism. Tool access and agent instructions still determine who can write.

## Backup, recovery, and sharing

Preserve engrams, episodes, and history with their grounding documents. Keep derived indexes, model caches, locks, tokens, and machine-specific trust/folder grants out of repository publication. The allowlist in `.gitignore` includes only the named starter files and future history; review history before sharing because it may contain task context.

A private PLUR visibility value does not prevent ordinary filesystem or repository exposure. Configure a sync remote only after the operator selects its destination and sharing policy. In a corrupted or conflicted store, stop writes, preserve the damaged file, and recover from a reviewed backup; an empty store is not a repair for an unreadable one.
