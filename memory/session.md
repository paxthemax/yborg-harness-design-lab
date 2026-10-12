# Session handover

Date: **2026-10-12**. The adversarial design review is complete, and the operator answered Q-014–020 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md). A coordinated pass the same day integrated those answers and the review's fixes into the specification documents and diagrams, adding a [glossary](../design/harness-glossary.md); a fresh-context consistency review then checked the result. In a later walkthrough the operator answered Q-021–026 and accepted the architecture (Q-008) as amended; [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) records the answers. A second pass integrated them into the specification documents and diagrams the same day, so the specification is now the [accepted baseline](../design/harness-glossary.md#terms) for the implementer package. Q-027, raised by that pass's consistency review, was then answered in [DEC-010](../decisions/DEC-010-linked-variants-into-unreviewed-flows.md): option B, against the recommendation. No question in the register remains open. The operator then confirmed the judgment calls of both integration passes and asked for everything to be committed (“Confirmed, commit all.”). The work of both sessions was committed on branch `design/accepted-baseline-2026-10-12`, and at the operator's request it was fast-forward merged into `master` and pushed to `origin`.

## Remaining decisions and architecture acceptance — 2026-10-12

The operator asked for each open question to be explained in plain language with a one-sentence summary, and decided them in four rounds, with Q-008 last. [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) records the answers:

| Question | Answer | Versus recommendation |
|---|---|---|
| Q-021 | Origin label only: no communications log, documentation-independence rule or known-issue rule. The gaps are an accepted residual risk | Differs |
| Q-022 | A cross-engagement library of public material plus the auditor's sanitized lessons, with each transfer recorded | Follows |
| Q-023 | Option A with the expectations note optional. Intent recorded after exposure to the implementation is tagged | Partly |
| Q-024 | The current held-out comparison. A narrowing change that looks like an improvement is an accepted residual risk | Differs |
| Q-025 | No urgent path; urgent contact stays outside the harness | Differs |
| Q-026 | Cross-guarantee follow-ups stay inside the batch as linked variants | Follows |
| Q-008 | The architecture is accepted as amended by DEC-008 and DEC-009 | Follows |

DEC-003 is marked accepted as amended. The question register, the review's disposition section, both indexes and lab memory are updated. The Q-023 tag was kept from option A: that reading was stated to the operator, who raised no objection. The Q-024 explanation overstated the gap in the current comparison, which already measures known-defect recall on held-out cases. It was corrected in the next round, and the answer stood.

The operator then approved the integration pass ("Integrate pass OK"); see the next section.

## DEC-009 integration — 2026-10-12

**What changed.**

- The [glossary](../design/harness-glossary.md) adds the terms accepted baseline, linked variant, mechanism library, library transfer, expectations pre-step, read-first mode and intent timing, with the values `before_walkthrough`/`after_walkthrough` and `public_reference`/`transfer`. The child-task definition now defers to linked variants.
- The [state contract](../design/harness-state-and-execution.md) adds mechanism-library entry and library transfer records and a library permission row. It adds intent timing to statements and comparisons, and a linked guarantee to scenario variants and findings. Review packets group linked variants, and decisions dispose of each linked claim separately. The threat model states the Q-021 accepted residual risk and a sanitization threat.
- The [component contracts](../design/harness-interface-contracts.md) extend `record_transfer` to library admissions and point `adopt_method_version` at the held-out comparison. They admit linked variants in `request_job`, add the pre-step to `capture_input` and add intent timing to the report's coverage section.
- [Requirements](../design/harness-requirements.md) add FR-42 (library) and FR-43 (pre-step and intent timing) and amend FR-07, 24, 26 and 35: 43 FRs and 15 NFRs. The [completion audit](../research/harness-specification-completeness.md#dec-009-integration-amendment--2026-10-12) maps them.
- The [product proposal](../design/audit-harness.md) is marked accepted as amended. It adds a library component and generator, the urgent-disclosure boundary and the linked-variant rule, and gives Q-021 and Q-024 their accepted-residual-risk entries. Two headings were renamed: "Architecture" and "Delivery sequence".
- Parallel forks updated the auditor guide, comprehension method, loop register and evaluation plan. The plan adds an evaluation scenario for each new residual risk. The forks also updated the diagrams: badges now read "ACCEPTED · DEC-009", the workflow diagram gained the pre-step, linked variants and library transfers, and the workflow viewport went to 3120 (PNG 2880 × 6240). All PNGs were re-exported and visually inspected.

**Judgment calls made during the pass,** confirmed by the operator on 2026-10-12 (“Confirmed, commit all.”):

- Public library entries are admitted through the same `record_transfer` decision as lessons.
- A lesson's transfer record stays in its source engagement, and the library entry carries only an opaque reference.
- Intent timing is derived, not self-reported. It is `before_walkthrough` only if captured before the first recorded presentation of the unit's implemented behavior. A recorded presentation is an interface or trusted-screen view of its IMPLEMENTED records or KB diagrams, including the seed's preliminary diagrams, or the start of an exploration round. What an agent says in conversation is not seen.
- A claim supported by linked variants is recorded as a linked claim on the investigation. It has its own potential impact, disposition and proof status, decided in the same review. Its finding names the guarantee it affects, and linked variants appear in that guarantee's audit unit.
- Decisions about public library entries, revisions and retirements are made in a library scope, so no library entry carries an engagement reference.
- The pass first applied DEC-005's flow-review gate to linked variants as a provisional option A. Q-027 was then answered with B (DEC-010): a linked variant may enter an unreviewed flow, its packet flags those claims, and the gate still governs batch authorization (FR-32).
- An exhausted allowance stops a linked follow-up and keeps it as a proposed lead.
- Q-021's risk appears in each report's limits. Q-024's concerns method changes, so it is stated in the specification and evaluation plan rather than in reports.
- The library is built after the walking skeleton, starting with public entries.
- The detailed comprehension and loop mechanics entered the baseline through Q-008's acceptance, not through separate decisions.

**Verification.**

- 700 local links in 43 files resolve.
- The 58 requirement IDs (43 FRs and 15 NFRs) are unique, and each is mapped in the completion audit.
- Every table row has its header's column count, and the JSON example parses.
- No edited diagram has duplicate IDs, scripts or SVG, and the memory YAML parses.

A fresh-context consistency review found ten problems, and nine were fixed:

- Library decisions now have their own scope, so no entry names its source engagement.
- Linked claims are first-class records.
- The "only channel" wording is limited to reusable knowledge, since bundle import is a separate path.
- Intent timing is anchored on a recorded first presentation, and read-first mode is recorded.
- The meaning-change exclusion is in every linked-variant definition.
- The report's accepted-residual-risk section is listed everywhere, with one Q-021 text.
- Stale "proposed" wording is corrected.
- DEC-004–007 carry amendment notes.
- Index wording follows the glossary.

The tenth was a design question, Q-027, which the operator answered in DEC-010. No runtime or human review was performed.

**Next action:**

1. Prepare the implementer package: the first build's scope and acceptance checks, JSON Schemas and state tables, and pilot numbers set by the operator.
2. Optionally, a human expert read.

## Adversarial design review — 2026-10-12

Read [the review](../research/adversarial-design-review.md). Four passes attacked the specification: the main thread, plus delegated red-team, specification-integrity and practitioner-walkthrough reviewers. Every finding cites file:line, and all delegated findings were re-verified against the text.

[K-008](../kb/claims/K-008-unenforced-semantic-gates.md) records the cross-cutting conclusion: the custody mechanisms hold up, but the semantic gates do not. Agents detect their own crossings: consequential versus syntactic change, setup versus attacker power, rejected versus exhausted, and the completeness of packets and reports. The only other check is one auditor with no capacity model. The design also gives less weight to discovery than to defensibility: prior-vulnerability knowledge, composition across flows, the breadth of the attacker model and upgrade safety.

**Operator answers in DEC-008:**

| Question | Answer |
|---|---|
| Q-014 | Agent self-report; AR-01 is an accepted risk |
| Q-015 | Broad default attacker, with privileged roles trusted |
| Q-016 | Full impact scaling, including the guard-removed rerun |
| Q-017 | Evidence first for High/Critical decisions |
| Q-018 | Reuse the agent tool, with input captured outside the model, batched confirmation on a trusted screen and per-engagement confinement |
| Q-019 | Probes and tiers |
| Q-020 | Walking skeleton |

The answers differ from the review's recommendations on Q-014 and, in part, Q-015. Q-018 adopts a refinement offered during the walkthrough. Q-021–024 can follow: the auditee as a party (decide before the record model freezes), a mechanism library, the auditor's independent first read, and an adoption gate (decide before any pilot).

**Lab records.** L-01: the operator kept the revised `imports/README.md:11` wording and approved the earlier edit. L-02: dated corrections are appended to the verification record, the completion audit and the comprehension review.

## Specification integration — 2026-10-12

**What changed.**

- [harness-glossary.md](../design/harness-glossary.md) is new. It fixes the stage numbering 01–08 and the allowed values, including the impact-scaled disposition table.
- The [state contract](../design/harness-state-and-execution.md) adds records for scenario variants, captured input, review packets, display receipts, dependency probes and snapshot diffs, plus typed work authorizations (`intake`, `exploration`, `batch`, `revalidation`, `method_evaluation`). It also adds the walking-skeleton deferral table, probe-based freshness tiers, a positive control for High/Critical executable rejections, and an expanded threat model that states the Q-014 accepted residual risk.
- The [component contracts](../design/harness-interface-contracts.md) add 13 human decision kinds, including `record_flow_review`, the High/Critical evidence-first presentation, new error codes, an updated worked request example and agent-tool eligibility conditions.
- [Requirements](../design/harness-requirements.md) now hold FR-01–41 and NFR-01–15. FR-29–41 and NFR-14–15 are new; amended rows are noted in the [completion audit](../research/harness-specification-completeness.md#dec-008-integration-amendment--2026-10-12).
- The product proposal, auditor guide, loop register, comprehension method and evaluation plan follow the glossary. All five diagrams were re-exported and visually inspected; the lifecycle diagram is now 1400 × 1800 and the workflow diagram 2880 × 6200 (2880 × 6240 after the DEC-009 pass).

**Judgment calls made during the pass.** These fit the selected answers; the operator confirmed them on 2026-10-12 (“Confirmed, commit all.”):

- The automatic probe, PoC and property reruns use a `revalidation` work authorization.
- The mechanical carry-forward attestation is required before closure or export.
- A refutation whose positive control shows no violation supports neither `rejected` nor `no_finding_within_bounds`.
- Precision excludes `triaged_out` and `no_finding_within_bounds` results.
- A child task stays inside its parent's investigation question, which preserves DEC-007 and leaves Q-026 open. Q-026 was later answered in DEC-009: cross-guarantee follow-ups within existing bounds stay in the batch as linked variants, so this definition changes at integration.

**Newly registered:** Q-025, an urgent-disclosure path, and Q-026, whether follow-ups that cross guarantees stay inside a batch. Both are open.

**Verification.**

- 581 local links in 41 files resolve.
- All 56 requirement IDs are unique, in the catalog and in the completion audit.
- The JSON example parses.
- No diagram has duplicate IDs, scripts or SVG, and the memory YAML parses.
- A fresh-context consistency review found 20 problems, all fixed, including a child-task definition that would have contradicted DEC-007.

No runtime or human review was performed.

**Next action, before any implementation handoff:**

1. Operator decisions: made later the same day in DEC-009 (see above).
2. An implementer package: the first build's remaining functional scope and its acceptance checks, JSON Schemas and state tables, and pilot numbers set by the operator (decision-load ceiling, capacities, budgets, the threshold for listing rejections).
3. Optionally, one human expert read of the integrated specification.

Any implementation starts with compatibility trials: agent-tool input capture, sandbox egress, tool versions and the recovery scenarios. Accepting Q-008 (DEC-009) does not start implementation.

## New flow diagrams, authority and loops — 2026-10-02

The flow-diagram review was completed on 2026-10-02. DEC-007 resolves Q-012–013: the auditor approves questions and constraints, agents draft and test scenarios, and the auditor reviews one combined packet after testing and the agent challenge. Earlier consequential questions still interrupt. A new standalone HTML diagram and a visually inspected PNG name eight loops.

Read [the analysis and issue triage](../research/flow-diagram-review.md), [accepted DEC-007](../decisions/DEC-007-human-agent-workflow.md) and [ownership/loop contract](../design/harness-workflow-loops.md). Both new imports in `imports/flows/` were visually inspected, registered as SRC-033–034 and preserved byte-for-byte. Their external product, tool, dataset and effectiveness claims were not verified. Two consequential workflow issues were asked individually and resolved; eight direct fixes reconcile authority, phase ordering, evidence routes, loop semantics and failure handling with existing decisions.

The [HTML workflow](../design/diagrams/human-agent-audit-flow.html) and [2880 × 5700 PNG](../design/diagrams/human-agent-audit-flow.png) label L0 intake rounds, L1 comprehension, L2 scenario iteration, L3 experiments, L4 evidence follow-up, L5 audit steering, L6 change/fix revalidation and L7 method improvement. L2 is expanded with its inner L3 loop; each process has an owner, entry/return, exit and finite allowance in the textual register. Agent authorship does not permit changing question meaning, attacker powers, scope, permissions or budget. The harness records execution; human judgment establishes the disposition.

Accepted choices are integrated into product, auditor guide, state and requirements documents. Detailed loop mechanics remain proposed; no exact loop count, numerical limits, database/engine or overall architecture was separately accepted. No harness implementation or runtime tests were added. The earlier Astra Max reviews below are historical work, not a request to delegate this review.

Delivery inspection: 338 local references in 20 new/changed documents resolve; HTML IDs are unique; PNG dimensions and unchanged import fingerprints are confirmed; the desktop export is fully framed. Memory IDs and new record shapes were inspected (18 engrams, 13 episodes); a full YAML/schema check was not performed because the current Python environment lacks the parser.

## Comprehension review

Read [the review](../research/comprehension-methodology-review.md) and [proposed method](../design/harness-comprehension-method.md). The recommendation is a repeated flow: orient, trace, challenge, reconcile, explain, reconstruct, and choose the next question. Source-linked engagement records and auditor walkthroughs use the same revisions; whole-system gaps remain visible during selective depth. Six primary studies are registered as SRC-023–028 with transfer limits; no expert-audit or ADHD-specific effectiveness is established.

The operator selected Q-009 option 1A: connected walkthrough with optional checkpoints. [DEC-005](../decisions/DEC-005-comprehension-lensing.md) also records the supplied requirements: automated intake KB seed and exploration rounds, joint purpose/flow/store/transition lenses, progressively finer state-machine diagrams, conclusions written to the KB and explorations runnable at any time. The second Astra Max pass elaborates provisional seed rounds, state predicates/guards/store effects, semantic refinement, transaction/callback/rollback distinctions, repeatable recipes and resume/diagram freshness. These detailed mechanisms remain proposed. The operator subsequently selected Q-010 option A: start investigations after broad orientation and review of the relevant flow; keep other gaps visible and continue exploration alongside investigation.

No personal learner profile, new framework, storage selection or runtime implementation is introduced. Accepted requirements and the investigation-start policy are integrated into the product and auditor guide; detailed state/refinement and recipe mechanisms remain proposed. K-006 captures a provisional distinction between evidence support and understanding; standing lab memory policy remains applicable. The accepted lensing requirements are recorded separately from provisional synthesis.

Concurrent workspace edits to core design documents and diagram formats appeared during the review; they were preserved, not attributed to or changed by this task.

## Current deliverable

Start with the [harness proposal](../design/audit-harness.md), then the [state and execution contract](../design/harness-state-and-execution.md), [component/artifact contracts](../design/harness-interface-contracts.md), [auditor guide](../design/harness-auditor-guide.md), [requirements](../design/harness-requirements.md), and [evaluation plan](../design/harness-evaluation.md). Four primary standalone HTML diagrams and matching PNG releases live in [the diagram gallery](../design/diagrams/index.html), alongside the separate clean architecture export; original Mermaid sources are retained as historical references. The [completion audit](../research/harness-specification-completeness.md) maps the repository scope and every FR/NFR to its specification evidence and records later amendments separately.

The [sprint research](../research/harness-design-sprint.md) covers all three reports and all eleven diagrams, selected primary-source checks, new substrate/security/evaluation research, alternatives and synthetic walkthroughs. [SRC-006–022](../kb/sources.md#sprint-primary-sources) are seventeen primary-source records; this is not exhaustive revalidation of every citation in the imports. The original imported reports, images and simple image manifest remain unchanged; the operator approved the revised `imports/README.md` wording on 2026-10-12 (DEC-008).

## Operator choices

- [DEC-002](../decisions/DEC-002-harness-operating-envelope.md), Q-004–006: Solidity/EVM first; small auditor-approved investigation batches; local workspace with approved cloud AI providers receiving needed context.
- [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md), Q-007: allow justified auditor-approved alternative evidence when a runnable PoC is impractical; clean replay remains the normal route.
- [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md), Q-008: the evidence workbench architecture was **accepted as amended** by DEC-008 and [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) on 2026-10-12. Acceptance does not select a database, engine, model, sandbox or numeric budget.

The user authorized a research/design sprint, resolution of trivial inconsistencies, and completion of the full specification/documentation set. No harness code is requested or built. Nontrivial choices have been asked as focused questions; further implementation/procurement questions remain visible in the proposal and question register.

## Lab memory continuity

[DEC-001](../decisions/DEC-001-knowledge-and-memory.md) remains accepted: repository-local isolated `memory/plur/`, no automatic sharing, automatic learning with periodic review/correction, keyword retrieval first. The [lab memory design](../design/knowledge-and-memory.md) remains separate from the new harness's operational-state proposal.

The store contains 23 engrams: sixteen instruction/decision-backed records, one imported recommendation, and six source-backed synthesis lessons. [K-003–008](../kb/README.md) cover resumption/authority, refutation freshness, property adequacy, comprehension versus evidence, loop boundaries and unenforced semantic gates. All synthesis has null approval fields and remains unreviewed. Earlier scope/instruction records remain applicable; “lab first” was completed before this separate harness task.

PLUR is not installed or connected by this work. No hooks, trust grants, sync destinations, or global agent settings were changed. Retrieval and memory updates were performed directly on files. Tooling remains managed through mise; temporary document verification packages and previews are outside the repository.

## Diagram presentation update

The operator requested replacing the three design SVG diagrams with pure HTML and clearer layouts, released as HTML and PNG. Completed on 2026-10-01: layered architecture with labeled handoffs, main investigation path with separate outcomes/returns, and a six-step premise-change sequence. Current documents embed PNGs and link to standalone responsive HTML. SVG exports were replaced; original Mermaid sources remain. See [release notes and regeneration instructions](../design/diagrams/README.md). All three PNG exports were visually inspected for readable text and complete framing. This changes presentation only; DEC-003/Q-008 remain proposed.

## Verification and next action

The initial sprint reviews and final full-spec independent review returned `done`. The last review compared actual documents with the repository scope, all 28 FRs, all 13 NFRs and Q-004–007. Component operations/errors, adapter behavior, portable export/import, auditor failure states and individual requirement coverage are complete. All 41 requirement IDs occur once in the matrix; the synthetic JSON request parses; all 294 local links/anchors and structured memory pass inspection. Original imports remain unchanged and the three current rendered diagrams were visually checked. Results and limits are recorded in [delivery verification](../research/harness-sprint-verification.md).

**Next action:** the new flow analysis, two focused operator decisions and HTML/PNG deliverable are complete. No question from this flow comparison remains unanswered. The detailed loop contract is available for further operator review; Q-008 was later accepted as amended (DEC-009, 2026-10-12), which does not start implementation. Framework/tool selection should follow the compatibility and recovery scenarios if implementation is later requested.

## Earlier work retained

The earlier session established the lab knowledge/memory design and schema-compatible PLUR-format seeds; its rationale and verification limits remain in [the PLUR assessment](../research/plur-assessment.md), DEC-001 and the earlier episodes. The later diagram-cataloging task preserved image bytes and produced descriptive filenames. The operator asked for a simple manifest with image links/descriptions, so identifiers, old filenames and fingerprints were removed from that manifest. The current sprint preserves that format and keeps extraction notes in research.

## DESIGNED/IMPLEMENTED process approval — 2026-10-01

The operator requested an Astra Max consultation, resolved its sole clarification, then approved the revised process in [DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md). DESIGNED starts with documentation and develops substantially through auditor input and applicable evidence; IMPLEMENTED remains independently grounded. Every lens compares both with explicit correspondence, coverage and discrepancy records; both implementation deviations and design weaknesses feed investigation. Candidate reconstructions remain attributed/provisional and cannot supply circular conformity evidence. The consultation and rationale are retained in research/designed-implemented-consultation.md. No further consequential questions remained. Core proposal, method, records, auditor guide, FR-04/05 and evaluation are updated. No implementation or architecture acceptance is implied; Q-008 remains open. Property-origin classification from the preceding discussion remains unadopted.

## Diagram refresh for DEC-006 — 2026-10-01

Updated all three current HTML diagrams and regenerated their PNG exports. Architecture shows separate behavioral views and comparison records; lifecycle shows intake/lensing feeding deviation and design-risk investigations; premise changes show revalidation after either model changes. All three exports were visually inspected: text and footers are fully framed and readable. Updated regeneration dimensions and release notes. Historical Mermaid sources remain historical.

## Clean architecture submission image — 2026-10-01

At the operator’s request, created `design/diagrams/harness-architecture-clean.html` and a visually inspected 2800 × 3200 PNG export. The image contains architecture only, omitting proposal/decision labels, download/navigation links and surrounding notes. Existing diagram releases remain available. No architecture acceptance or external submission occurred.
