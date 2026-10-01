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
| Component architecture and substrate | [Architecture](../design/audit-harness.md#proposed-architecture), rendered diagram, [write protocol](../design/harness-state-and-execution.md#write-and-approval-protocol) and [component contracts](../design/harness-interface-contracts.md) specify responsibilities, trusted boundaries, state ownership and integration behavior |
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
| FR-28 | [Baseline controls](../design/audit-harness.md#proposed-architecture), [unit review](../design/harness-auditor-guide.md#build-enough-shared-understanding) | Control applicability, evidence, exclusions and gaps alongside protocol guarantees |

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

The [evaluation plan](../design/harness-evaluation.md#pilot-protocol) retains its five-step pilot, eleven control/recovery scenarios, three synthetic walkthroughs and metric definitions. The [delivery sequence](../design/audit-harness.md#proposed-delivery-sequence) retains its four future stages. The [adapter checks](../design/harness-interface-contracts.md#compatibility-and-conformance), [interface states](../design/harness-auditor-guide.md#interface-behavior-and-failure-states), example request and package layout are specifications, not executed commands or passing runtime tests. The lab's PLUR integration command examples remain explicitly unexecuted; connecting that engine was not added to this objective.

## Open choices and completion disposition

Q-008 remains the operator's review of the architecture, with alternatives and consequences in [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md). Runtime engine, database implementation, sandbox and provider/model selection remain governed by declared contracts and later compatibility/procurement checks. Actual client budgets, data policies, deployment scope and severity rubrics remain engagement intake decisions. These are explicitly allocated decisions, not silently chosen defaults or missing product behavior.

No implementation, integration, deployment, publication, benchmark gain or architectural acceptance is claimed by completing the specification. The current integrity checks pass: all 294 local links/anchors resolve, all 41 requirement IDs appear exactly once in the matrix, the synthetic JSON request parses, structured memory validates, and all sixteen imported files remain unchanged. The three current SVGs were reopened and visually checked against the source diagrams and described flows.

The final independent reviewer re-read the actual documents against the repository scope, all 28 FRs, all 13 NFRs and the accepted operator choices, returning **`done`** with no actionable omissions or contradictions. Main-thread review also checked the contracts, examples, authority boundaries and continuity, including the engagement-reference clarification. The full specification/documentation objective is complete; Q-008 and any later implementation remain separate next steps.
