# Comprehension methodology review

Date: **2026-10-01**. Reviewer: **Astra, max reasoning**, delegated by Codex at the operator's request. Status: **research and proposed improvements; operator disposition pending**. Scope: how agents build dependable engagement knowledge and how the auditor develops a usable mental model of that same system. No harness code or runtime trial was produced.

**Current disposition:** the sections below preserve the first-pass review. The operator subsequently selected Q-009 option 1A and supplied the lensing requirements recorded in [DEC-005](../decisions/DEC-005-comprehension-lensing.md). [The second pass](#second-pass-lensing-and-state-machines) updates the conclusions; Q-010 remains open and detailed mechanisms remain proposed.

The main recommendation is to make comprehension a repeated loop over complete audit flows: **orient → trace → challenge → reconcile → explain → reconstruct → choose the next question**. Every loop should improve both the source-linked system model and the auditor's ability to reason with it. The concrete proposal is in [the comprehension method](../design/harness-comprehension-method.md).

## Baseline and review method

Read the repository guidance, KB/question register, session and PLUR guides, DEC-001–004, the harness product/role/workflow proposal, state contracts, interface contracts, auditor guide, requirements and evaluation plan. Revisited comprehension passages in SRC-002/003 and the earlier sprint's extraction of the imported diagrams. The original images were not re-inspected during this review; their earlier recorded extraction is the basis for that comparison. Used keyword retrieval and direct files; no PLUR engine is connected.

The existing proposal already gets several fundamentals right: separate intent, observed implementation, assumptions, guarantees and unknowns; preserve contradictory evidence; organize audit units around complete flows; retain provenance and changed-premise invalidation; keep consequential judgments with the human. These are in [record contracts](../design/harness-state-and-execution.md#record-contracts), [progressive comprehension](../design/audit-harness.md#audit-stages-and-human-touchpoints), and [the auditor guide](../design/harness-auditor-guide.md#build-enough-shared-understanding). They should remain the foundation.

The weakness is methodological specificity. The documents mostly name the model's contents and ask the auditor to correct them. They say less about how an agent obtains, checks and reconciles those contents, or how an auditor becomes able to reason independently from the resulting explanation. This is a design gap, not evidence of a failed implementation.

The [accepted decisions](../kb/questions.md) remain binding only within their recorded scope. The broader architecture is still proposed under DEC-003. Completing this review accepts neither that architecture nor this amendment.

## Prioritized findings and recommendations

Priority below means order for improving the specification, not vulnerability severity.

| ID / priority | Finding in the current proposal | Proposed improvement and rationale |
|---|---|---|
| C-01 / first | FR-04/05 define useful records and flows but leave their construction procedure implicit | Specify source intake, separate intent/behavior passes, forward and backward tracing, a bounded evidence check, then reconciliation. This makes omitted work and unsupported inferences inspectable |
| C-02 / first | Source identity and controller validation establish provenance; they do not establish that a summary follows from its citation | Require a checker to reconstruct consequential claims from the cited source, search for contradictory callers/writers/configurations, and record limits. A citation to a nearby function or a second agreeing model is insufficient |
| C-03 / first | Human comprehension currently appears mainly as correcting guarantees and choosing investigations | Produce one connected explanation from the same record revisions, then offer a prediction, causal explanation or changed-condition exercise. Corrections update the common model; successful teach-back is not semantic approval or evidence of security |
| C-04 / first | Selective depth is sensible, but a polished local flow can hide an omitted global boundary | Begin with a shallow inventory of the entire known scope and reconcile entry points, critical state writers and dependencies against audit units. Keep unmodeled/unsupported areas visible while deepening one flow at a time |
| C-05 / next | Invalidation covers conclusions; the human-facing understanding can also become stale | Treat walkthroughs, diagrams, resume notes and retrieval packets as revision-bound views. Explain meaningful changes as “previous belief → new evidence → changed consequence,” including pending assumptions |
| C-06 / next | Evaluation tracks human minutes and review burden, but internalization has no distinct outcome | Evaluate source-location ability, causal prediction, changed-condition transfer, correction of a misleading summary, and resumption after interruption. Report human time and irritation alongside correctness; do not infer learning from reading time, clicks or confidence |

## Primary evidence and its limits

The following are source-backed observations. Their product consequences are proposals, not experimentally validated effects in this harness. Source intake is recorded as SRC-023–028 in [the register](../kb/sources.md#comprehension-review-primary-sources).

**Question-led program exploration.** Sillito, Murphy and De Volder catalogued 44 question types in two qualitative studies of software change work. They observed developers combining answers across tools and struggling to retain the higher-level question. This supports considering linked questions and connected source views. Their work studied maintenance, with short sessions and task/tool limitations, rather than smart-contract auditing. [Original paper, abstract and sections 6–7](https://www.cs.ubc.ca/~murphy/papers/other/asking-answering-fse06.pdf).

**Reconstructing knowledge.** Karpicke and Blunt's two experiments found better delayed conceptual performance after retrieval practice than the studied elaborative concept-mapping condition, including inference questions. Learning-time matching and delayed assessment matter to this result. It supports trying brief reconstruction with feedback; it does not establish that diagrams are unhelpful or that memorization is the right audit objective. [Original paper, experiments 1–2](https://learninglab.psych.purdue.edu/downloads/2011/2011_Karpicke_Blunt_Science.pdf).

**Explaining causal relations.** Chi and colleagues prompted 14 eighth-grade students to self-explain a circulatory-system text and compared them with ten students who reread it. The prompted group improved more, with analyses of mental models and inference. This motivates an optional “why does this step preserve the entitlement?” prompt. The small school-age sample does not establish effectiveness for expert auditors or justify quizzing every sentence. [Original paper, abstract and method](https://education.asu.edu/sites/g/files/litvpz656/files/lcl/chideleeuwchiulavancher_3.pdf).

**Control of pace.** Mayer and Chandler reported better transfer, but not retention, in two experiments with learner-controlled segments of a narrated lightning animation. That narrow result motivates controllable chunks as a pilot option; it supplies no optimal chunk size or ADHD-specific claim. This review used the indexed abstract; the served PDF did not yield extracted text. [Original article, abstract](https://tecfa.unige.ch/tecfa/teaching/methodo/Mayer_Chandler01.pdf).

**Friction has costs.** Buçinca, Malaya and Gajos studied AI-assisted nutrition choices with 199 participants. Cognitive forcing reduced overreliance relative to simple explanations, but did not significantly improve overall task performance; more effective error-reduction designs received less favorable subjective ratings. This cautions against mandatory prediction prompts everywhere. It is a layperson task with simulated assistance, not an expert-audit result. [Original paper, sections 3, 6–7](https://www.eecs.harvard.edu/~kgajos/papers/2021/bucinca21trust.pdf).

**Cheap verification can help.** Vasconcelos and colleagues' five maze studies found that task/explanation costs and benefits affected reliance; explanations sometimes reduced overreliance. Their limitations include low stakes, crowd workers and ideal explanations. A reasonable product hypothesis is to put decisive code and contradictory evidence beside a claim, making inspection easier. This evidence does not guarantee that an LLM-generated explanation is faithful. [Original paper, abstract and section 10.4](https://arxiv.org/pdf/2212.06823v2).

The learning papers and AI-reliance papers address different outcomes. Remembering a model, choosing accurately with assistance, and finding vulnerabilities are separate measurements. None of these sources validates an ADHD-specific intervention, an auditor mastery score, a prescribed study schedule, or a productivity percentage. The user's request for connected, manageable steps is a direct presentation preference; no medical inference is needed.

## Proposed method and trade-offs

The proposed method uses existing role profiles. A mapper assembles source-backed statements; a separate checking pass reconstructs important claims; a curator reconciles proposals; the same agent or a guide role presents an explanation. These are tasks, not a requirement to run four models. Begin with sequential passes and use additional workers only within approved limits.

Use one versioned knowledge model with two views: an inspectable agent/repository view and a concise auditor walkthrough. A generated document or diagram carries dependencies on its supporting records; it is not another authority. This avoids a lesson quietly diverging from the evidence used by investigators. The price is explicit reference maintenance, so persistence should concentrate on consequential, reused or disputed claims rather than every sentence an agent says.

Teach complete causal flows, then connect them through shared state, privileges and dependencies. A selected withdrawal flow should show where entitlement comes from, who may initiate it, what state changes, where control leaves the contract, how the transaction settles and which assumptions bound the description. A learner prompt concerns consequences, not symbol-name recall. The auditor can also go directly to code or supply their own model first.

The recommended stopping rule is per-unit readiness for a named investigation: sufficient evidence and reviewed semantics for that question, an auditor who can use and challenge the flow with sources available, and explicit gaps. A missing unrelated detail should not block all work. Whole-protocol understanding first is a real alternative, with a larger upfront attention/time cost; the operator should choose the desired depth policy.

Maintain an interruption bookmark with the current flow, established points, open uncertainty and next action. Offer reconstruction at a natural return or a changed premise, with current evidence immediately available. No automatic reminders, arbitrary waiting periods or durable personal ability profile are needed for this proposal. Actual corrections and audit decisions remain in their ordinary records.

## Failure modes to test in the design

| Failure | Expected response |
|---|---|
| Two agents repeat the same documentation error | Retain the common origin; check against code/configuration and a discriminating observation; do not add confidence by vote |
| A happy-path narrative omits a privileged writer or callback | Inventory reconciliation and backward tracing expose the missing edge; keep the affected flow partial until addressed |
| A good-looking citation does not support the statement | Checker marks the statement unsupported and fixes the view; historical provenance remains intact |
| Auditor repeats an incorrect explanation accurately | Recheck against sources; comprehension of a claim does not make the claim true |
| Auditor identifies a condition the agents missed | Capture it as an attributed proposal/unknown, check evidence, then revise dependent flows and explanations |
| Optional learning interaction is skipped | Continue with evidence access and ordinary semantic decisions; record no fabricated mastery or automatic failure |
| Code/configuration changes during a walkthrough | Show stale status, identify affected steps and require current revisions for any ensuing semantic decision |
| Agents create a long encyclopedia while an important premise remains unknown | Return to the selected question, surface the missing premise and timebox additional modeling |
| Source-only intake lacks a proxy target or token behavior | Mark deployment-dependent paths unresolved; teach the conditional model and retain the gap |

## Evaluation recommendation

Use the existing [pilot controls](../design/harness-evaluation.md#pilot-protocol) with matched, different audit units to reduce target-memory contamination. Compare the current document-and-correction workflow with the proposed connected walkthrough at comparable total effort. Use source-grounded rubrics prepared independently of the teaching narrative; permit alternative correct explanations and explicit unknowns. A solo trial is exploratory.

For the knowledge view, inspect a risk-stratified set of claims for citation support, missing contradictions, dependency completeness and retrieval with limits attached. Reconcile all inventoried scope elements to a unit or an explicit gap. For the human view, use a small number of realistic actions: trace an unfamiliar consequence, locate its source, identify what changes when a premise changes, and resume an interrupted flow. Check delayed understanding on a later natural return when feasible; disclose intervening exposure.

Report sampled counts, denominators, partial/unknown outcomes, active human minutes, model/tool cost, repeated corrections, interruptions and the auditor's preference. Keep notes-open performance separate from optional unaided recall. A correct answer after a hint differs from a correct independent reconstruction. Neither result changes finding acceptance or security coverage. Preselect any success threshold with the operator before a comparative pilot; no numerical improvement is claimed here.

## Questions requiring the operator's preference

These two choices are not resolved by the literature or the existing accepted decisions. The detailed options are part of the [proposed method](../design/harness-comprehension-method.md#operator-choices). They can be answered without selecting a vendor or accepting the whole harness architecture.

1. **Default interaction:** connected walkthrough with optional checkpoints (recommended); prediction-first dialogue; or concise briefing with checks only on request. The trade-off is active reconstruction versus interruption/effort.
2. **Depth before investigation:** broad orientation plus reviewed understanding of the selected flow (recommended); or review all critical flows before opening the first investigation batch. The trade-off is earlier useful investigation versus broader upfront internalization.

Resolved without asking: preserve the existing statement taxonomy; keep learning prompts separate from evidence approval; retain important audit corrections in normal records; do not create a personal learner profile; do not choose new storage/frameworks; keep learning events inside ordinary approved work and existing engagement isolation. If durable personal adaptation is later requested, its contents and retention become a separate design choice.

## Delivery and verification

Delivered this review, a concrete proposed methodology, and six primary-source register entries. This review did not rewrite the existing architecture/specification documents or original imports. Verified 26 local links across the two artifacts and source register, and checked the proposed method against FR-04/05/06/08/17/23/25 and NFR-08, plus the current authority and isolation contracts. This was document inspection and synthetic walkthrough analysis; no implementation, runtime, usability experiment or learning-effect evaluation was performed.

## Second pass: lensing and state machines

Date: **2026-10-01**. Reviewer: **Astra, max reasoning**. This pass responds to the operator's concrete direction in DEC-005. The connected walkthrough with optional checkpoints is accepted. Automated provisional seeding, purpose/flow/store/transition exploration, state-machine diagrams in the KB, progressively finer resolution and rerunnable exploration at any time are now requirements. The earlier alternatives and rationale above remain historical; they do not reopen Q-009 or resolve Q-010.

### Updated conclusion

Comprehension should be a reusable activity available throughout the audit, with its own useful outputs. Intake automatically creates the provisional starting model. Auditor and agent then apply **purpose → flows → stores → transitions** as repeatable lenses, zoom into a selected transition, save corrected knowledge and resume later. An exploration can finish by improving understanding without producing a vulnerability hypothesis.

The first-pass proposal treated diagrams mainly as explanatory views and organized comprehension around readiness for investigation. The refinement makes flow machines, store maps and exploration sessions explicit. The source-checking/contradiction loop remains the method within every lens; it is not replaced by diagram production.

### Findings and refinements

| Finding | Second-pass recommendation and consequence |
|---|---|
| A flowchart can list calls without expressing system state | Give state nodes predicates, instance identity and store dependencies; give edges actor/guard/read-write effects and outcomes. A state can be derived rather than a stored enum |
| Automated seed can appear authoritative once rendered nicely | Persist it automatically as attributed provisional knowledge, with gaps and review state; human semantic decisions remain explicit |
| “Zooming in” can reveal incompatible detail without changing the coarse account | Link child paths to parent transitions through an explicit abstraction relation; revise the parent when a child outcome no longer fits |
| One diagram can confuse persistence with temporary execution | Separate transaction-boundary lifecycle states from within-transaction execution states and link them through refinement |
| Local machines can miss shared-state and administrative influence | Map stores and cross-flow edges; investigate bounded orderings, callback paths and asynchronous handoffs without expanding a global state product |
| A chat walkthrough is difficult to resume or repeat exactly | Version the recipe; persist the session's snapshot, focus, level, cursor, completed evidence, deltas, open questions and remaining grants |
| Generated diagrams may outlive the premises they teach | Bind diagrams to record dependencies, invalidate them on change, regenerate with visible deltas, and distinguish new rendering from re-reviewed semantics |

These are proposed implementation-independent contracts in [the current method](../design/harness-comprehension-method.md). A lens changes perspective/resolution over one engagement model. It does not create another source of truth or a new permission grant.

### Primary semantic checks

Selected official sources were inspected to keep the model faithful to EVM behavior. Solidity documents that external calls share a transaction and can return control through callbacks; its exception model distinguishes propagated errors from handled call failure. Its introduction separates data lifetimes and execution/storage context. EIP-1153 specifies transaction-scoped transient storage with revert behavior. EIP-140 specifies execution rollback, including logs. These observations motivate separate lifecycle/execution views and explicit failure outcomes. [Solidity calls/exceptions](https://docs.soliditylang.org/en/v0.8.30/control-structures.html), [storage and execution context](https://docs.soliditylang.org/en/v0.8.30/introduction-to-smart-contracts.html), [EIP-1153](https://eips.ethereum.org/EIPS/eip-1153), [EIP-140](https://eips.ethereum.org/EIPS/eip-140).

[SRC-029–032](../kb/sources.md#lensing-and-evm-modeling-sources) registers these selected checks. Solidity 0.8.30 is the inspected documentation version, not a required target compiler. Each real engagement must bind its actual compiler, hardfork, deployed implementation and dependencies. No target behavior or harness integration was executed. Existing learning studies still have the transfer limitations documented in the first pass; state-machine representation itself does not establish learning or security gains.

### How the exploration runs

The recommended recipe is a versioned sequence: identify lens/focus and inputs; show the model at its current resolution; inspect sources or make an optional prediction; obtain discriminating evidence within grants; reconcile the model delta; update diagrams; checkpoint the next action. Ordinary code facts are resolved by the agent where possible. Intended behavior and other consequential semantics are routed to the auditor with affected work identified.

Automated intake can perform one or more bounded rounds. A round takes a snapshot and model revision, addresses named gaps, and returns a provisional delta, diagrams and proposed exploration entry points. Its stop rule is objective completion, a material evidence/semantic boundary or the configured budget—not an unbounded promise to model everything. Runnable refers to future orchestration of this recipe; a tool/trace step is optional, separately permitted work. It does not imply automatic exploit execution.

The auditor can enter a saved exploration from any phase. Resume validates dependencies, shows what changed and preserves historical observations. Refinement can reach statements, expressions, state effects, storage/assembly and instruction/trace detail where available. Missing data, unsupported semantics and unexplored branches remain visible; a neat diagram does not certify exhaustive state coverage.

### Example and design checks

The revised [queued-vault example](../design/harness-comprehension-method.md#synthetic-vault-walkthrough) follows one request from absent to pending, then time-derived claimability, cancellation or settlement. It connects request/accounting storage to the external token ledger. Refining claim separates intermediate effects from committed settlement and distinguishes payout rollback from a caught failure. This illustrates why a flow can span several transactions while one edge also needs a finer within-transaction model.

Add future acceptance scenarios for: a seed with unknown intent; two flows writing the same store; delegatecall with a distinct storage owner; a callback reading intermediate state; caught versus propagated payout failure; time passage without a storage write; an asynchronous message lacking a guaranteed settler; interruption during refinement; and a source change that stales a diagram. Expected results are explicit gaps, correct dependencies and resumable context, rather than a greater diagram count. The existing evaluation should still compare correctness, useful human understanding, effort and preference separately.

### Remaining question and dispositions

Only **Q-010** still requires the operator's policy preference: start investigations after broad system orientation and one reviewed flow (**recommended**), or first review all operator-defined critical flows. Both support repeated lensing and later descent to finer levels. The distinction is when security investigation may begin, not whether explorations remain available.

Resolved routinely through the existing contracts: keep current statement kinds and engagement isolation; use role profiles rather than mandatory extra models; make the seed provisional; preserve recipe/session/diagram revision dependencies; provide bounded lowest-level descent; use existing diagram presentation conventions; and keep scope/budget/evidence decisions separate from optional learning prompts. No new tool, database, or personal-profile decision is needed.

**Second-pass verification:** reviewed the revised model against the accepted DEC-005 requirements and existing authority, provenance, invalidation and approved-batch boundaries. Checked the queued-vault example for state/store/refinement consistency and explicit transaction/failure semantics. Verified 32 local links across the methodology, research and source register with no errors; SRC-029–032 each has one register row. No runtime or usability test was performed. Unrelated workspace changes were preserved.

### Subsequent operator disposition

After the second-pass report, the operator answered **“A”** to Q-010: investigations may start after broad orientation and review of the relevant flow, with exploration continuing alongside investigation and other gaps visible. [DEC-005](../decisions/DEC-005-comprehension-lensing.md) records this selection together with Q-009 and the lensing requirements. Accepted requirements and the start policy are integrated into the product and auditor guide. Detailed refinement, recipe/session and diagram lifecycle mechanisms remain proposed; the earlier open-question sections above preserve the review history.
