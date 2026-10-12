# Full harness specification completion audit

Date: **2026-10-01**. Objective: **complete the full spec and docs for the harness**. Review status: **complete; independent review returned `done`**. Architectural disposition: **proposed**, subject to DEC-003; the accepted narrower choices remain DEC-001, DEC-002 and DEC-004.

## What completion means

The source of truth is [AGENTS.md](../AGENTS.md), the operator's request to extend the imported research into a proposed harness design, the persistent documentation objective, and the recorded answers in [the question register](../kb/questions.md). This repository delivers specifications and their research/decision record. It expressly excludes harness implementation, model training and full automation.

Completion therefore requires a coherent specification of the full in-scope product, interfaces, states, auditor interactions and outcomes, supported by retained research and inspectable rationale. Each functional and non-functional requirement needs defined behavior and an observable future acceptance scenario. The documents must be navigable, internally consistent, preserve original imports, and leave accepted decisions distinct from recommendations. A proposal can be complete before its architecture is accepted; acceptance must not be inferred from the request to finish the documents.

This audit checks the actual document content against those requirements. Link checks, schema validation and independent review are supporting evidence; none alone proves substantive coverage. Runtime scenarios are specified future work, rather than claims that the harness already passes them. Choosing a particular implementation library, procuring a provider and running a pilot are outside this documentation objective.

## Repository and operator scope

| Required scope | Authoritative specification evidence and inspection result |
|---|---|
| Framework product definition | [Product boundary](../design/audit-harness.md#product-boundary) defines user, inputs, outputs, ecosystem, intended value and exclusions |
| Functional and non-functional requirements | [Requirements](../design/harness-requirements.md) defines 28 FRs and 13 NFRs, priority boundaries, scenarios/invariants and the status of numerical targets |
| Component architecture and substrate | [Architecture](../design/audit-harness.md#architecture), rendered diagram, [write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol) and [component contracts](../design/harness-interface-contracts.md) specify responsibilities, trusted boundaries, state ownership and integration behavior |
| Interaction flows | [Stages and touchpoints](../design/audit-harness.md#audit-stages-and-human-touchpoints), [auditor guide](../design/harness-auditor-guide.md), lifecycle and premise-change diagrams include ordinary decisions, failures, interruption, resumption and closure |
| Several classes of agents under one auditor | [Role classification](../design/audit-harness.md#agent-role-classification) specifies inputs, outputs and authority exclusions; [controller operations](../design/harness-interface-contracts.md#controller-operations) keeps human-only actions outside worker channels |
| Shared memory and knowledge base | [Operational memory](../design/harness-state-and-execution.md#shared-knowledge-and-memory) separates evidence, semantic knowledge, working context and lessons; [lab memory](../design/knowledge-and-memory.md) remains distinct under DEC-001 |
| Knowledge intake and systematization | [Record contracts](../design/harness-state-and-execution.md#record-contracts) and the first two [auditor stages](../design/harness-auditor-guide.md#start-an-engagement) define snapshot identity, intent/implementation distinctions, flow units, unknowns and progressive review |
| Guided clarification | [Question design](../design/audit-harness.md#interaction-and-question-design) and [answering questions](../design/harness-auditor-guide.md#answer-consequential-questions) require consequences, dependencies, prior evidence and an unknown option |
| Audit stages, methods and human touchpoints | [Three investigation methods](../design/audit-harness.md#three-investigation-methods), [review workflow](../design/harness-auditor-guide.md#review-an-investigation) and state guards cover admission through adjudication without autonomous final acceptance |
| Confirmation reports and PoCs | [Outcome contract](../design/audit-harness.md#confirmation-reports-and-poc-packages) and [portable package](../design/harness-interface-contracts.md#portable-report-and-poc-package) define contents, evidence routes, revision identity, redaction, replay prerequisites and release authority |
| Quality and recursive improvement | [Evaluation plan](../design/harness-evaluation.md) defines adequacy, control scenarios, three worked cases, baseline comparison, metric denominators, held-out evaluation and rollback without training |
| All existing research and diagrams internalized | [Extraction record](harness-design-sprint.md#what-the-reports-contribute) accounts for each of three reports and eleven diagrams, including conflicts, adaptations and attribution limits |
| Extended independent research and retained rationale | [Primary findings](harness-design-sprint.md#primary-research-findings), [source register](../kb/sources.md#sprint-primary-sources) and [alternatives](../decisions/DEC-003-harness-architecture-proposal.md#alternatives-and-recommendation) preserve seventeen selected primary-source records, observations, recommendations and access limits |
| EVM first; extensible later | [Product scope](../design/audit-harness.md#product-boundary) and [adapter contract](../design/harness-interface-contracts.md#agent-and-tool-adapter-boundary) apply DEC-002 without claiming other ecosystems already supported |
| Approve small investigation batches | [Batch workflow](../design/harness-auditor-guide.md#approve-a-small-batch) and batch/job records bind questions, budget, context and limits to a human decision; numerical starting values remain proposals |
| Local workspace with approved cloud providers | [Permissions](../design/harness-state-and-execution.md#permissions-and-isolation) and provider boundary keep canonical state local and control context, credentials, provider policy and uncertain spending |
| Alternative evidence accepted when PoC impractical | [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md), [evidence acceptance](../design/harness-evaluation.md#evidence-acceptance) and [auditor evidence routes](../design/harness-auditor-guide.md#choose-the-evidence-route) agree on explicit human justification and limitations |
| Preserve imports, decisions and continuity | Original imports are fingerprint-checked; [decisions](../kb/questions.md), [PLUR store](../memory/plur/README.md) and [handover](../memory/session.md) retain dispositions and scope; no automatic sharing or architecture acceptance was added |
| Resolve trivial internal issues; surface material choices | Research records corrections and routine contract elaborations; Q-004–007 preserve the operator's actual answers and Q-008 keeps the proposed architecture visible for review |
| Respect repository scope and tooling | Deliverables are documents, diagrams and memory data; runtime code is absent. Existing mise-managed tools render/inspect documents, with temporary checks outside the repository |

## Functional requirement coverage

“Covered” here means the required behavior and acceptance scenario are specified. It does not mean that a future implementation has passed the scenario. The requirement catalog remains authoritative for priority and its observable acceptance scenario.

| Requirement | Specification evidence | What is defined |
|---|---|---|
| FR-01 | [Records](../design/harness-state-and-execution.md#record-contracts) | Target, dirty files, dependencies, compiler/EVM and deployment/fork identity; source-only limits |
| FR-02 | [Intake](../design/harness-auditor-guide.md#start-an-engagement), [operations](../design/harness-interface-contracts.md#controller-operations) | Human scope, threat model, data policy and finite budget before capability use |
| FR-03 | [Isolation](../design/harness-state-and-execution.md#permissions-and-isolation), [adapter boundary](../design/harness-interface-contracts.md#agent-and-tool-adapter-boundary) | Isolated baseline build and honest unsupported/partial results |
| FR-04 | [Knowledge](../design/harness-state-and-execution.md#shared-knowledge-and-memory) | Separate source-linked intent, implementation, assumptions, guarantees and contradictions |
| FR-05 | [Shared understanding](../design/harness-auditor-guide.md#build-enough-shared-understanding) | Flow-based units and selective depth with all scoped boundaries and gaps retained |
| FR-06 | [Clarification](../design/harness-auditor-guide.md#answer-consequential-questions) | Focused questions, consequences, ownership and dependent work; unrelated work continues |
| FR-07 | [Batch admission](../design/harness-auditor-guide.md#approve-a-small-batch) | Once-per-batch authorization bound to questions, revisions and limits |
| FR-08 | [Roles](../design/audit-harness.md#agent-role-classification), [context records](../design/harness-state-and-execution.md#record-contracts) | Role-specific grants, exposure manifests and initially separate challenge context |
| FR-09 | [Methods](../design/audit-harness.md#three-investigation-methods) | Hypothesis, property and scenario work over common evidence/disposition records |
| FR-10 | [State transitions](../design/harness-state-and-execution.md#state-transitions) | Work state, disposition, evidence quality, freshness, raw output and result type separated |
| FR-11 | [Evidence acceptance](../design/harness-evaluation.md#evidence-acceptance) | Semantic review, meaningful actions, oracle independence and adequacy challenge |
| FR-12 | [Record contract](../design/harness-state-and-execution.md#record-contracts), [package contract](../design/harness-interface-contracts.md#portable-report-and-poc-package) | Reconstructable experiment inputs, outputs, tool versions, commands and limitations |
| FR-13 | [Replay](../design/harness-state-and-execution.md#replay-and-semantic-validity) | Fresh environment, target identity, fixture review and realistic attacker prerequisites |
| FR-14 | [Write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol), [reporting role](../design/audit-harness.md#agent-role-classification) | Reversible clustering with origins/dissent retained and new causal chains investigated |
| FR-15 | [Decision protocol](../design/harness-state-and-execution.md#write-and-approval-protocol), [operations](../design/harness-interface-contracts.md#controller-operations) | Authenticated human adjudication and exact revision checks at commit |
| FR-16 | [Review actions](../design/harness-auditor-guide.md#review-an-investigation) | Rejected, disputed, deferred and blocked work retain reasons, evidence and exposure |
| FR-17 | [Invalidation](../design/harness-state-and-execution.md#evidence-invalidation-and-revision-changes) | Positive and negative conclusions become stale transitively; incomplete edges widen review |
| FR-18 | [Durable jobs](../design/harness-state-and-execution.md#durable-jobs-and-resource-limits), [reconciliation](../design/harness-interface-contracts.md#errors-and-reconciliation) | Reservations, attempts, leases, fencing, recovery, pause/cancel and uncertain calls |
| FR-19 | [Batch view](../design/harness-auditor-guide.md#approve-a-small-batch) | Review-capacity limit pauses discovery and preserves admitted work |
| FR-20 | [Change and fix review](../design/harness-auditor-guide.md#pause-resume-and-review-changes) | Separate patch identity, attack replay, legitimate behavior and residual issues |
| FR-21 | [Reports and packages](../design/harness-interface-contracts.md#portable-report-and-poc-package) | Decision-backed confirmations, labeled exceptions and inspectable reproduction artifacts |
| FR-22 | [Closure](../design/harness-auditor-guide.md#close-and-export) | Frozen scope, unresolved exposure, exclusions, failures and approved report audience |
| FR-23 | [Lessons](../design/harness-state-and-execution.md#shared-knowledge-and-memory) | Source-backed, scoped provisional lessons with counterconditions and no decision authority |
| FR-24 | [Isolation](../design/harness-state-and-execution.md#permissions-and-isolation), [import/export](../design/harness-interface-contracts.md#portable-report-and-poc-package) | Engagement boundaries, explicit transfer destinations, redaction and inert import |
| FR-25 | [Metrics](../design/harness-evaluation.md#metrics-and-denominators) | Outcome, cost, workload, duplication and unresolved-item denominators |
| FR-26 | [Improvement](../design/harness-evaluation.md#adoption-and-controlled-improvement) | Versioned changes, held-out comparison, disposition and rollback without label rewriting |
| FR-27 | [Adapter boundary](../design/harness-interface-contracts.md#agent-and-tool-adapter-boundary) | Later ecosystem/engine expansion has a declared semantic/capability contract; implementation intentionally deferred |
| FR-28 | [Baseline controls](../design/audit-harness.md#architecture), [unit review](../design/harness-auditor-guide.md#build-enough-shared-understanding) | Control applicability, evidence, exclusions and gaps alongside protocol guarantees |

## Non-functional requirement coverage

| Requirement | Specification evidence | Invariant or target defined |
|---|---|---|
| NFR-01 | [Write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol) | Agent-only transitions cannot approve semantic conclusions or reports |
| NFR-02 | [Writes](../design/harness-state-and-execution.md#write-and-approval-protocol), [request conventions](../design/harness-interface-contracts.md#contract-conventions) | Atomic records/events, staged artifacts, version conflicts and idempotency |
| NFR-03 | [Replay](../design/harness-state-and-execution.md#replay-and-semantic-validity) | Clean receipt for executable confirmation; unavailable replay and exceptions explicit |
| NFR-04 | [Isolation](../design/harness-state-and-execution.md#permissions-and-isolation) | No worker secrets, unrelated engagement access or live write RPC; external policy enforcement |
| NFR-05 | [Recovery](../design/harness-state-and-execution.md#durable-jobs-and-resource-limits), [backup](../design/harness-state-and-execution.md#permissions-and-isolation) | Preserve acknowledged decisions, reconcile uncertain work, restore hashes and fail closed on corruption |
| NFR-06 | [Resources](../design/harness-state-and-execution.md#durable-jobs-and-resource-limits) | Finite allocations cover concurrent work, retries, process descendants and uncertain calls |
| NFR-07 | [NFR catalog](../design/harness-requirements.md#non-functional-requirements), [pause workflow](../design/harness-auditor-guide.md#pause-resume-and-review-changes) | Proposed acknowledgement/stop deadlines and visible failed stop; measurement conditions stated |
| NFR-08 | [Review packet](../design/harness-auditor-guide.md#review-an-investigation), [interface states](../design/harness-auditor-guide.md#interface-behavior-and-failure-states) | Concise decisions, accessible controls/status and direct evidence access across failures |
| NFR-09 | [Records](../design/harness-state-and-execution.md#record-contracts), [adapter output](../design/harness-interface-contracts.md#agent-and-tool-adapter-boundary) | Invocation identity, mode, timings, errors, cost category and missing/truncated output |
| NFR-10 | [Portable package](../design/harness-interface-contracts.md#portable-report-and-poc-package) | Provider-independent readable records, manifests, artifacts, redaction and recovery limits |
| NFR-11 | [Memory](../design/harness-state-and-execution.md#shared-knowledge-and-memory), [invalidation](../design/harness-state-and-execution.md#evidence-invalidation-and-revision-changes) | Provenance, revision and disputed/stale status survive retrieval and summarization |
| NFR-12 | [Compatibility](../design/harness-interface-contracts.md#compatibility-and-conformance) | Common adapter contracts, explicit unsupported versions and preserved migration history |
| NFR-13 | [Evaluation](../design/harness-evaluation.md#metrics-and-denominators), [outcomes](../design/audit-harness.md#confirmation-reports-and-poc-packages) | No counts, agreement, benchmark labels or aggregate percentages imply universal security |

## Artifact and verification audit

The six harness specification documents are the product proposal, state/execution contract, component/artifact contract, auditor guide, requirements and evaluation plan. Their three diagrams comprise component/trust boundaries, investigation lifecycle and premise-change interaction, each with editable Mermaid and rendered SVG. The research/source/decision/knowledge/memory documents preserve the rationale and continuity behind them.

The [delivery verification record](harness-sprint-verification.md) records inspection commands, results and limits. The temporary integrity inspector is reviewed for its actual scope: unchanged imported bytes, local paths/heading anchors, PLUR engram schema and grounding, YAML/card parsing, ID consistency, and SVG structure. It does not test the harness or prove the normative text correct. The main-thread content review and independent completeness review supply the substantive comparison above.

The [evaluation plan](../design/harness-evaluation.md#pilot-protocol) retains its five-step pilot, eleven control/recovery scenarios, three synthetic walkthroughs and metric definitions. The [delivery sequence](../design/audit-harness.md#delivery-sequence) retains its four future stages. The [adapter checks](../design/harness-interface-contracts.md#compatibility-and-conformance), [interface states](../design/harness-auditor-guide.md#interface-behavior-and-failure-states), example request and package layout are specifications, not executed commands or passing runtime tests. The lab's PLUR integration command examples remain explicitly unexecuted; connecting that engine was not added to this objective.

## Open choices and completion disposition

Q-008 remains the operator's review of the architecture, with alternatives and consequences in [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md). Runtime engine, database implementation, sandbox and provider/model selection remain governed by declared contracts and later compatibility/procurement checks. Actual client budgets, data policies, deployment scope and severity rubrics remain engagement intake decisions. These are explicitly allocated decisions, not silently chosen defaults or missing product behavior.

No implementation, integration, deployment, publication, benchmark gain or architectural acceptance is claimed by completing the specification. The current integrity checks pass: all 294 local links/anchors resolve, all 41 requirement IDs appear exactly once in the matrix, the synthetic JSON request parses, structured memory validates, and all sixteen imported files remain unchanged. The three current SVGs were reopened and visually checked against the source diagrams and described flows.

The final independent reviewer re-read the actual documents against the repository scope, all 28 FRs, all 13 NFRs and the accepted operator choices, returning **`done`** with no actionable omissions or contradictions. Main-thread review also checked the contracts, examples, authority boundaries and continuity, including the engagement-reference clarification. The full specification/documentation objective is complete; Q-008 and any later implementation remain separate next steps.

## DESIGNED/IMPLEMENTED amendment — 2026-10-01

[DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md) extends FR-04/05 with documentation-first design construction, auditor/evidence refinement, two inspectable models and comparison at each lens. The comprehension method defines the process; state contracts define correspondence/comparison/discrepancy records; the auditor guide defines presentation; evaluation adds eight future scenarios. Existing revision, approval, retrieval and export contracts apply. This amendment was checked directly for terminology, record coverage and local links; the earlier independent completion review did not review this later amendment. Architecture remains proposed.

## Flow ownership amendment — 2026-10-02

[DEC-007](../decisions/DEC-007-human-agent-workflow.md) accepts agent scenario authorship under approved questions/constraints and combined human evidence review after testing and agent challenge. FR-07/09/15 and the product, state contract and auditor guide now express that behavior. The [workflow/loop contract](../design/harness-workflow-loops.md) supplies ownership, L0–L7 entries/returns/exits, shared iteration bounds and a synthetic routing example. [The source review](flow-diagram-review.md) retains ten triaged issues and both operator answers. This amendment is a direct document/diagram review; the earlier independent completion review did not assess it. No runtime acceptance scenario was executed.

## Correction — 2026-10-12

The artifact audit above describes the diagrams as they stood when it was written on 2026-10-01: three diagrams, each with editable Mermaid and a rendered SVG. Later that day the SVG exports were replaced by standalone HTML diagrams with PNG releases ([diagram notes](../design/diagrams/README.md)). The Mermaid files remain as historical sources. A fourth primary diagram, the human/agent workflow, was added on 2026-10-02, alongside a clean architecture export, and no SVG diagrams remain. The link and requirement counts above are those of the original inspection. The [adversarial design review](adversarial-design-review.md) did not re-run this completion audit.

## DEC-008 integration amendment — 2026-10-12

The coordinated specification pass integrated [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md) and the [adversarial review](adversarial-design-review.md)'s fixes within the existing direction. It added the [glossary](../design/harness-glossary.md), thirteen functional requirements (FR-29–41) and two non-functional requirements (NFR-14–15), and it amended FR-06–09, 11, 13, 15–18, 20–22, 24–26 and NFR-04, 08 and 13 in place. The requirement catalog has 41 FRs and 15 NFRs. The original matrix above maps FR-01–28 and NFR-01–13 as they stood on 2026-10-01; for amended rows, the requirement catalog's current text prevails.

| Requirement | Specification evidence | What is defined |
|---|---|---|
| FR-29 | [Automated intake](../design/harness-comprehension-method.md#automated-intake-and-successive-rounds), [work authorization record](../design/harness-state-and-execution.md#record-contracts) | Bounded seeding rounds under an `intake` authorization; provisional status of seeded statements |
| FR-30 | [Diagram lifecycle](../design/harness-comprehension-method.md#diagram-lifecycle-in-the-knowledge-base) | State-machine diagrams bound to record dependencies, with freshness and semantic deltas |
| FR-31 | [Runnable explorations](../design/harness-comprehension-method.md#runnable-and-resumable-explorations), [walkthrough](../design/harness-comprehension-method.md#6-walk-the-auditor-through-the-causal-story) | Repeatable, resumable recipes; connected walkthrough with optional checkpoints |
| FR-32 | [State transitions](../design/harness-state-and-execution.md#state-transitions), [controller operations](../design/harness-interface-contracts.md#controller-operations) | Admission requires a recorded relevant-flow review; `authorize_work` refuses otherwise |
| FR-33 | [Glossary](../design/harness-glossary.md#terms), [engagement record](../design/harness-state-and-execution.md#record-contracts), [methods](../design/audit-harness.md#three-investigation-methods) | Broad default attacker charter narrowed per engagement; trusted-role premise reported |
| FR-34 | [Whole-system outline](../design/harness-comprehension-method.md#1-establish-the-whole-system-outline), [snapshot and audit-unit records](../design/harness-state-and-execution.md#record-contracts) | Deterministic inventory, vendored-dependency verification, auditor review coverage |
| FR-35 | [Lead generation](../design/audit-harness.md#three-investigation-methods), [`prepare_work`](../design/harness-interface-contracts.md#controller-operations) | Generator classes per unit with coverage and a depth requirement; cross-engagement library open as Q-022 |
| FR-36 | [Composition](../design/harness-comprehension-method.md#composition-across-flows), [audit-unit kinds](../design/harness-glossary.md#value-tables) | Interference matrix; `composition` and `system_invariant` units |
| FR-37 | [State machines, stores and refinement](../design/harness-comprehension-method.md#state-machines-stores-and-refinement) | Conservation relations, units and decimals, rounding direction |
| FR-38 | [Threat model and isolation](../design/harness-state-and-execution.md#permissions-and-isolation), [replay validity](../design/harness-state-and-execution.md#replay-and-semantic-validity) | Steering and suppression threats, visible deceptive characters, ingestion flags, environment-sensitive results |
| FR-39 | [Write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol), [`capture_input` and decision kinds](../design/harness-interface-contracts.md#human-decision-kinds) | Verbatim captured input, batched confirmation, display receipts |
| FR-40 | [Write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol), [review packet record](../design/harness-state-and-execution.md#record-contracts) | Unreviewed agent statements listed; conditional decisions |
| FR-41 | [Write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol) | Auditor-run artifacts through a wrapper, or labelled with an untrusted receipt |
| NFR-14 | [Pilot protocol](../design/harness-evaluation.md#pilot-protocol), [metrics](../design/harness-evaluation.md#metrics-and-denominators) | Canary packets and decision-quality reporting against an operator-set target |
| NFR-15 | [Pilot protocol](../design/harness-evaluation.md#pilot-protocol), [interaction design](../design/audit-harness.md#interaction-and-question-design) | Decision inventory and an operator-set ceiling per engagement-day |

The amended rows draw on the same documents:

- **Dispositions** (FR-16): the [glossary](../design/harness-glossary.md#dispositions-and-evidence).
- **Probes and the snapshot diff** (FR-17): [invalidation](../design/harness-state-and-execution.md#evidence-invalidation-and-revision-changes).
- **The walking skeleton** (FR-18): [deferred mechanisms](../design/harness-state-and-execution.md#deferred-mechanisms).
- **Fix statuses** (FR-20): the glossary and the [auditor guide](../design/harness-auditor-guide.md#pause-resume-and-review-changes).
- **Reports and packages** (FR-21, FR-22): the [package contract](../design/harness-interface-contracts.md#portable-report-and-poc-package).
- **Isolation** (FR-24, NFR-04): [permissions](../design/harness-state-and-execution.md#permissions-and-isolation).

Still open, and not specified as decided: Q-008 and Q-021–026. The accepted residual risk from Q-014 is stated in the [product proposal](../design/audit-harness.md#accepted-residual-risks). This amendment was checked with link and requirement-ID inspections; the 2026-10-01 independent completion review did not assess it.

## DEC-009 integration amendment — 2026-10-12

A second coordinated pass integrated [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md). In it the operator accepted the architecture as amended (Q-008) and answered Q-021–026. The pass added two functional requirements, FR-42 and FR-43, and amended FR-07, 24, 26 and 35 in place. The requirement catalog has 43 FRs and 15 NFRs. The original 2026-10-01 audit text above is preserved; this section supersedes its statements about open choices.

| Requirement | Specification evidence | What is defined |
|---|---|---|
| FR-42 | [Mechanism library and library transfer](../design/harness-glossary.md#terms), [library records](../design/harness-state-and-execution.md#record-contracts), [library permissions](../design/harness-state-and-execution.md#permissions-and-isolation), [`record_transfer`](../design/harness-interface-contracts.md#human-decision-kinds) | A curated cross-engagement library of public entries and the auditor's sanitized lessons; the auditor's two confirmations for each lesson transfer; no entry names its source engagement |
| FR-43 | [Expectations pre-step, read-first mode and intent timing](../design/harness-glossary.md#terms), [system statement and comparison records](../design/harness-state-and-execution.md#record-contracts), [comprehension choices](../design/harness-comprehension-method.md#operator-choices) | An optional pre-step that blocks nothing when skipped, and read-first mode; `before_walkthrough` or `after_walkthrough`, derived from the first recorded presentation of the unit's implemented behavior and shown with comparisons and in the report |

The amended rows draw on these documents:

- **Linked variants** (FR-07): the [glossary](../design/harness-glossary.md#terms), the [scenario-variant and decision records](../design/harness-state-and-execution.md#record-contracts) and the [loop register](../design/harness-workflow-loops.md#loop-register).
- **The library as the only channel for reusable knowledge between engagements** (FR-24): [permissions](../design/harness-state-and-execution.md#permissions-and-isolation).
- **Adoption on the held-out comparison** (FR-26): the [evaluation plan](../design/harness-evaluation.md#adoption-and-controlled-improvement).
- **Library retrieval as a lead generator** (FR-35): [lead generation](../design/audit-harness.md#three-investigation-methods).

Q-021 and Q-024 add accepted residual risks. They are stated in the [product proposal](../design/audit-harness.md#accepted-residual-risks), each with an evaluation scenario. Q-025 sets a boundary: urgent disclosure stays outside the harness. Q-027, registered during this pass, was decided the same day in [DEC-010](../decisions/DEC-010-linked-variants-into-unreviewed-flows.md), described below. Numeric limits and the selection of store, runner, model provider, sandbox and agent host remain proposals, as the [accepted baseline](../design/harness-glossary.md#terms) defines. This amendment was checked with link and requirement-ID inspections; the 2026-10-01 independent completion review did not assess it.

## DEC-010 amendment — 2026-10-12

The operator chose option B for Q-027 in [DEC-010](../decisions/DEC-010-linked-variants-into-unreviewed-flows.md). A linked variant may enter a flow that has no `record_flow_review` decision, and the review packet flags its claims as concerning an unreviewed flow. FR-32 is amended in place; batch authorization still requires the flow review. The rule appears in the [glossary](../design/harness-glossary.md#terms), the [state contract](../design/harness-state-and-execution.md#record-contracts), the [component contracts](../design/harness-interface-contracts.md#controller-operations), the [product proposal](../design/audit-harness.md#interaction-and-question-design), the [auditor guide](../design/harness-auditor-guide.md) and the [loop register](../design/harness-workflow-loops.md#loop-register). No question in the register remains open. This amendment was checked with link and requirement-ID inspections.
