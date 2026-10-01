# PLUR assessment for the design lab

Research date: **2026-10-01**. Evidence: primary documentation and source inspection. Runtime installation and behavior have **not** been evaluated.

The operator selected PLUR as substrate and guide. The design recommendation is to use its memory primitives while retaining source evidence and design reasoning in repository documents. PLUR is not the mechanism that decides which harness architecture the operator has accepted.

## Sources and version boundary

The inspected public repository snapshot is `434ca65e71243a303bee9b0661f5f3bd11558682`, committed 2026-10-01. Core, CLI, and MCP package manifests at that snapshot identify version `0.21.0`. This identifies the inspected source; it does not verify the npm release or installed behavior. A temporary checkout was used outside the lab.

| Evidence | Use |
|---|---|
| [PLUR overview](https://plur.ai/) | Product positioning and memory lifecycle |
| [Website engram specification](https://plur.ai/spec.html) | Conceptual guide; distinguish living prose from the implementation |
| [Versioned standard](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/spec/ENGRAM-STANDARD-v1.md) | Format and interoperability requirements |
| [Machine-readable schema](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/spec/engram.schema.json) | Starter record compatibility |
| [Implementation schema](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/schemas/engram.ts) | Concrete enum values, anchors, attribution, and extension fields |
| [Benchmark methodology](https://plur.ai/benchmark.html) | Bound the supplier's retrieval and agent-impact claims |

Pin sources when the implementation detail matters. Recheck the schema and integration surfaces before installing another version. The imported harness reports were read as supplied material; their primary sources were not re-verified in this task.

## Principles worth adopting

PLUR distinguishes reusable assertions from timestamped events. It offers portable memory records and retrieval weighted by task relevance, usage, and recency. The lab can use that distinction to keep standing guidance small while preserving session history. These concepts guide the proposed architecture; they do not establish a measured benefit for this repository. [Engram specification](https://plur.ai/spec.html).

Use one assertion per engram, attach its grounding source, and capture events as episodes. Keep transient work state in a handover document. Avoid promoting raw conversation, whole reports, and speculative design options into standing instructions.

Human-readable records make inspection and correction practical. Retrieval feedback helps evaluate whether a memory was useful in a particular task. Repetition and positive feedback still do not validate an external claim or approve a design choice.

## Implementation details that change this design

### Approval uses commitment, not an assumed candidate pipeline

The website describes staged candidates and human review. The implementation schema notes that normal code paths assign `active` and `retired`; candidate and dormant statuses remain in the format for reserved/legacy use. Learning defaults to active status and non-draft commitment. [Schema](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/schemas/engram.ts), [learning implementation](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/index.ts).

Draft commitment is explicitly excluded from automatic injection, while recall stays available for review. It supports quarantining incomplete or disputed guidance. The operator selected automatic learning with periodic correction, so routine grounded memories use a non-draft commitment and may be injected before review. The implementation detail is source-grounded, not a runtime guarantee verified here. [Injection implementation](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/inject.ts).

The MCP learning tool exposes commitment, but excludes `knowledge_anchors` and `structured_data` from its input. Its promote operation changes status without clearing draft commitment. Complete file-based creation is the initial route; MCP-created incomplete records need enrichment before automatic activation. This is a grounding step, not a human approval gate. Ordinary CLI learning lacks the same commitment controls. [MCP tools](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/mcp/src/tools.ts), [CLI promotion](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/cli/src/commands/promote.ts).

### Physical store selection and scope selection have different jobs

The CLI supports `--path`; MCP accepts `PLUR_PATH`. Project `.plur.yaml` supplies scope/domain and possible remote routing, not the dedicated storage path used here. Constructor discovery can add nearby stores; `PLUR_AUTO_DISCOVER=0` disables that discovery. [CLI store selection](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/cli/src/plur.ts), [MCP entry point](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/mcp/src/index.ts), [project configuration](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/project-config.ts).

Personal-family scopes can be visible in project-filtered reads. The recommendation is a dedicated lab store with no personal or engagement mounts, plus an explicit project scope for each memory. [Scope design and defaults](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/docs/KNOWN_ISSUES.md).

### Drafts, pins, feedback, and decay need different interpretations

Injection checks draft approval and temporal applicability before selecting relevant content. Pinned content is still budget-limited, and omitted pins are reported. Critical repository constraints should consequently be read directly as part of session bootstrap. [Injection implementation](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/inject.ts).

Some feedback/recurrence paths can advance commitment on non-draft records. The lab's actual approval remains in decision records and `structured_data.lab`; commitment alone cannot prove operator acceptance. Draft feedback does not supply approval. [Feedback implementation](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/feedback.ts), [recurrence configuration](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/schemas/config.ts).

### Backup includes history

PLUR's provenance ADR distinguishes semantic state in YAML from observational events in history JSONL. Derived observational edges use that history. Retain engrams, episodes, and history; treat indexes as derived artifacts. [ADR-0002](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/docs/adr/ADR-0002-derived-state-provenance.md).

Episodes are logically appended, but the implementation loads and atomically rewrites a YAML array under a file lock. That is not a tamper-proof event log. External hand edits need stopped writers and preservation of prior records. [Episode implementation](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/episodes.ts).

### Local retrieval can have setup and integration costs

The configuration supports disabling embeddings and choosing YAML storage. Embeddings can require a model download and additional runtime resources. Start with keyword retrieval for the small seed store, then compare hybrid retrieval on actual lab tasks if the operator selects it. [Configuration schema](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/core/src/schemas/config.ts).

CLI injection includes an extra learning protocol by default. The documented command disables it with `--no-with-default-protocol`, so the lab controls its own capture cadence. This flag applies to that CLI surface; do not assume every adapter shares the behavior. [CLI injection](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/packages/cli/src/commands/inject.ts).

## Evidence and sharing limits

PLUR reports retrieval recall separately from answer quality. Its agent-impact benchmark compares the full context/tool setup and excludes ties from its headline win rate. Those results do not measure this lab's decision quality, source fidelity, or operator time saved. The benchmark also reports added latency. Use its metrics as ideas for a local pilot, without importing its headline outcomes as expected benefits. [Benchmark methodology](https://plur.ai/benchmark.html).

Private visibility is a sharing posture within PLUR. Personal sync can include private memories, and ordinary repository publication bypasses PLUR's filters. Choose a destination and review actual files before sharing. The starter config contains no remote or credentials. [Sync semantics](https://github.com/plur-ai/plur/blob/434ca65e71243a303bee9b0661f5f3bd11558682/README.md#syncing-across-devices).

## Recommendation, operator choice, and follow-up

The initial proposal recommended review before memory activation. The operator selected automatic learning with periodic review/correction instead, along with the isolated repository-local store and keyword retrieval. DEC-001 preserves that trade-off and the questionnaire answers. The imported architecture recommendation is now an active, unreviewed suggestion with attribution; its activation does not select the primary harness architecture. Explicit operator constraints and accepted policy choices are recorded as grounded memories.

Before connecting PLUR to an agent host, select a version through mise, review the host's injection and automatic-learning behavior, and inspect a disposable store for schema loading, draft exclusion, correct path/scope, and recovery. No agent-host configuration, trust grant, installation, or PLUR runtime check has been performed for this design.

## Deliverable inspection

The original five starter engrams were parsed and validated against the pinned upstream JSON Schema using temporary validation packages through mise-managed uv. The configuration, episode data, and knowledge-card front matter were parsed; grounding paths, approval metadata, local links, heading anchors, and pinned upstream file paths were inspected. All three import fingerprints match the original inputs. The original architecture diagram was rendered with the existing mise-managed Mermaid tool and visually inspected. Subsequent policy updates are recorded in the session handover.

Independent completeness review returned `done` after corrections to the documented MCP write surface and a standing instruction's grounding anchor. These checks establish document/data consistency. They do not establish PLUR runtime behavior or automatic enforcement of the proposed operating contract.
