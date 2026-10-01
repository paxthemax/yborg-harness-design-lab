# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A **design lab**, not a codebase. The deliverable is a *specification* (plus the research and decision record behind it) for an AI-agent harness that audits smart contract systems for security vulnerabilities. No harness code is built here, and there is no build, lint or test step.

The harness being specified:
- orchestrates several classes of AI agents, each with a role in the audit process
- is steered by a single human auditor, who is looped in on key decisions
- produces audit outcomes: confirmation reports and PoCs

The specification is expected to cover:
- framework product definition
- functional and non-functional requirements
- component architecture
- interaction flows

The repo also warehouses what is learned about building such a harness, along with the design process and its decisions. Keep research findings and decision rationale, not just final spec text.

## Scope

In scope:
- the harness substrate
- shared memory / knowledge base design
- intake and systematization of knowledge about the system under audit
- guided clarification questions for the human auditor
- audit stages and flows
- agent role classification
- human-in-the-loop touchpoints
- audit outcomes (reports, PoCs)
- quality and recursive-improvement measurement

Out of scope (don't drift into these):
- model training and training-data preparation
- full automation of the audit process. The human auditor stays in the loop by design.

## Working here

- The human operator guides the design. Surface open questions and trade-offs for them to decide rather than settling design choices silently.
- Tooling is managed by mise (`mise.toml`; currently only `codex`). Diagrams can be rendered with `mmdc`, per the global instructions.

## Knowledge and session continuity

- Start with `kb/README.md`, `memory/session.md`, and the questions relevant to the task. These link to the source register, research, decisions, and proposed specifications.
- Keep source-backed observations, interpretations, hypotheses, recommendations, and operator decisions distinct. A recommendation in an import is not an accepted design choice.
- Use `memory/plur/README.md` for the PLUR workflow. Automatically record useful source-backed lessons and periodically review or correct memory; design acceptance still requires an operator decision. If PLUR is unavailable, use the files directly.
- Preserve original imports and decision rationale. Update the handover after meaningful work and keep open trade-offs visible for the operator.
- Store memory at `memory/plur/`, isolated from other projects, with no automatic sharing. Start with keyword retrieval and add embeddings when retrieval needs justify them. Follow DEC-001 and the recorded dispositions when extending the working design.
