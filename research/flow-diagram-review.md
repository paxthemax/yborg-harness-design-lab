# Imported flow review: human work, agent work and loops

Date: **2026-10-02**. Scope: visual inspection of both images in `imports/flows/`, comparison with DEC-002/004/005/006 and the existing proposed specification, followed by two operator decisions in [DEC-007](../decisions/DEC-007-human-agent-workflow.md). No external implementation, vendor, dataset-size or effectiveness claim in either image was verified.

## Source observations

| Source | What the image shows | Useful contribution | Limit when applying it here |
|---|---|---|---|
| SRC-033 · [Hybrid audit](../imports/flows/flow-hybridaudit.png) | Human source gathering and scoping; agent summaries; collaborative analysis; human comprehension; agent testing; human testing review; agent evaluation; hybrid reporting. Arrows return comprehension gaps to analysis, test refinements to testing, and new hypotheses to analysis | Explicit human understanding and visible feedback from evidence to hypotheses | “Hybrid” does not specify who authors scenarios or decides outcomes. Source boxes mix supplied material with human activity. Every stage appears serial; separate testing review adds a mandatory handoff |
| SRC-034 · [GodAudit](../imports/flows/flow-godaudit.png) | Human launch; agent-oriented phases 0–9; deterministic host controls; per-contract/finding loops, PoC repair cycles and fuzzing repetition; disagreement escalation; human review/filing; a continuous improvement return | Separates agent output from observed execution and makes several repeated processes visible | The image's strict phase order, optional mid-run human participation, automatic queues and host “ground truth” language do not establish this lab's required authority boundary. Numerical claims and tool behavior are unverified |

These are observations about visible content. The ownership allocation and eight-loop taxonomy below are this lab's synthesis. Neither imported flow is adopted wholesale.

## What existing decisions already settle

Small batches of questions and budgets need human approval; routine permitted steps inside them do not (DEC-002). Joint comprehension can recur at any stage, and investigation can start after broad orientation and review of its relevant flow (DEC-005). Every lens compares DESIGNED with IMPLEMENTED, preserving uncertainty and design weaknesses as well as deviations (DEC-006). Finding acceptance and severity remain human judgments; documented alternative evidence is possible when a runnable PoC is impractical (DEC-004).

Consequently, strict all-system phase ordering, agent/host confirmation and PoC-only acceptance would conflict with existing direction. Reconciling those differences in the new synthesis needs no new policy choice. The original pixels remain intact.

## Issue triage and disposition

“Consequential” below means a workflow choice requiring the operator. “Direct fix” means an editorial correction or reconciliation with an existing decision in the derived documents; it is not a claim that the source image itself has been edited.

| ID | Issue and consequence | Triage | Disposition |
|---|---|---|---|
| F-01 | “Collaborative analysis” leaves required human scenario authorship unspecified | Consequential · human effort/autonomy | Asked Q-012. Operator chose approved questions/constraints followed by agent-authored scenarios and evidence review; DEC-007 |
| F-02 | Human testing review before challenge creates an additional mandatory handoff | Consequential · review cadence | Asked Q-013. Operator chose one combined packet after testing and challenge, with earlier consequential interruptions; DEC-007 |
| F-03 | Host PASS/FAIL or model consensus can be mistaken for security adjudication | Direct fix · authority ambiguity | Show deterministic execution receipts separately from human applicability, sufficiency, disposition and severity; consistent with DEC-004 and existing state contract |
| F-04 | Strict sequential phases and a first/last-only human path obscure repeatable comprehension and batch selection | Direct fix · conflict with accepted direction | Show joint lensing at any time, human approval of every new batch, and explicit returns; DEC-002/005/006 |
| F-05 | “Loop” conflates new scenarios, test repair, evidence follow-up and future method improvement | Direct fix · missing labels/contracts | Define L0–L7 with entry, owner, repeated work, return, exit, bounds and output in the [loop register](../design/harness-workflow-loops.md#loop-register) |
| F-06 | Retry caps or “coverage converges” can be read as proof that an investigation is complete | Direct fix · unsupported assurance | End with evidence, a bounded negative result or unresolved status; finite limits stop work and never imply safety. Preserve loop history and the next discriminating check |
| F-07 | Reporting appears to require a reproducible PoC for every finding | Direct fix · conflict with accepted evidence policy | Show clean replay as the normal route and the explicit human alternative-evidence route from DEC-004 |
| F-08 | New hypotheses, method lessons or automatic replanning can silently expand a grant | Direct fix · authority leak | A new question returns to proposed work; the next batch requires approval. Lessons stay attributed and provisional; standing workflow changes require evaluation/adoption under the existing improvement proposal |
| F-09 | Neither flow clearly distinguishes an unchanged fixture repair from changed test meaning or a changed target | Direct fix · invalid comparison risk | L3 preserves approved meaning; changed premises return for a decision, changed source/model revisions enter L6. Fix assessment retains old evidence and tests legitimate behavior |
| F-10 | Human/agent labels omit the source-versus-action distinction and execution-failure outcomes | Direct fix · notation and completeness | Sources enter an agent intake step after scope/policy approval. Every loop can stop as blocked, failed, cancelled or budget-limited without becoming rejected or safe |

All two consequential issues raised by this comparison are resolved. The eight direct fixes are applied to the synthesis. Q-008 overall architecture acceptance remains a separate existing question; this review does not ask it again or infer its answer.

## Resulting work allocation

The human establishes the audit question, its meaning and limits, understands the relevant flow with assistance, selects batches and adjudicates the combined evidence. Agents do the detailed candidate generation, tracing, experiments and challenge within those boundaries. The harness supplies controlled execution and accountable records. Manual code reading, hypotheses, traces or tests from the auditor can enter the same record at any time; they do not bypass the evidence contract.

The [diagram](../design/diagrams/human-agent-audit-flow.html) expands the **scenario loop**: draft and trace → probe → challenge → refine the next permitted variant. The inner experiment loop changes a fixture or search attempt without silently changing the claim. A new causal question returns to batch selection; a changed premise returns to comprehension/revalidation. A follow-up after human review is a separate return, so the diagram does not imply per-iteration human approval.

The [workflow contract](../design/harness-workflow-loops.md) supplies the complete ownership matrix, loop register, exact interruption conditions and a synthetic example. Stable stage and loop IDs appear in both HTML and PNG.

## Validation and limits

Both source images were visually inspected and their SHA-256 fingerprints registered as SRC-033–034. The editable diagram is standalone HTML/CSS, exported locally to PNG. Release inspection is recorded in [the diagram notes](../design/diagrams/README.md). This is a specification review, not execution of the depicted harness, a security assessment of GodAudit or a validation of audit effectiveness. Imported vendor/tool claims remain source claims.

Document inspection found no missing targets or anchors in 338 local references across 20 new/changed Markdown and HTML documents, and no duplicate HTML IDs. The PNG header confirms 2880 × 5700 pixels; visual inspection found all labels, return paths and the footer fully framed. Both imported fingerprints remain unchanged. Whitespace inspection passed. Memory has 18 unique engram IDs and 13 unique episode IDs; new records were inspected against the existing shape. A YAML parser was unavailable in the current Python environment, so no full schema-validation claim is made.
