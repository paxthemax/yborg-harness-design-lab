# Comprehension through repeatable lenses

Status: **operator requirements accepted; detailed method proposed**, 2026-10-01, second Astra Max pass. [DEC-005](../decisions/DEC-005-comprehension-lensing.md) records the connected walkthrough with optional checkpoints, automated knowledge seeding, state-machine flow diagrams, and repeatable exploration through purpose, flows, stores and progressively finer transitions. The mechanisms below are recommendations implementing that direction. Q-010 accepts investigation after broad orientation and review of the relevant flow; the broader architecture remains proposed under [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md).

The harness first creates a provisional knowledge base. Auditor and agent then examine the same system through four lenses: **purpose → flows → stores → transitions**, returning to any lens at any time and increasing resolution on the selected subject. Each exploration leaves inspectable knowledge and helps the auditor reason about that knowledge. [The review](../research/comprehension-methodology-review.md#second-pass-lensing-and-state-machines) preserves first-pass rationale and the second-pass refinements. No harness runtime or learning-effect evaluation is provided here.

## What the two outcomes mean

**Engagement knowledge:** another permitted worker or the returning auditor can locate the relevant claim, inspect its exact source, see its limits and contradictions, and determine whether it still applies. The stored explanation is useful only while those dependencies remain visible.

**Auditor understanding:** with sources available, the auditor can follow the causal path, identify a guarantee and its assumptions, predict a meaningful consequence, and say where to look to challenge it. Optional unaided reconstruction can help learning; fluent recall is not a prerequisite for ordinary audit authority.

These outcomes are distinct from semantic approval, a validated property, an accepted finding and security coverage. Reading, agreeing with or successfully repeating a walkthrough cannot create any of those dispositions.

## The four lenses and their resolution

A lens is a repeatable way to inspect a selected part of the system. It changes the question and view, not the target revision or evidence authority. Start with the following sequence during intake; later sessions may enter directly at a flow, store, transition or changed premise.

| Lens | Connected question for the auditor | Persisted result |
|---|---|---|
| Purpose | What is this system for: a vault, lender, exchange, or something else; what do its users expect? | Source-attributed purpose, actors, assets, guarantees, domain terms and uncertainties |
| Flows | What can happen from entry to settlement, and what states can each actor/position/request occupy? | Parameterized flow state machines, initial/terminal predicates, transitions and lifecycle diagrams |
| Stores | Where does each fact or asset live; who reads or changes it; which flows share it? | Store/ownership map linked to state predicates and transition read/write sets |
| Transitions | What enables this change, who can cause it, and what happens along every relevant outcome? | Guards, ordered effects, external boundaries, failure paths, evidence and child refinements |

The first diagrams are deliberately coarse. Refine a selected edge from business action to contract interaction, function/branch, statement/expression and state effect, down to storage slot, assembly, bytecode instruction or trace step when available and relevant. Link each child view back to its parent edge. There is no fixed source-only ceiling: “lowest level” means the lowest available evidence for the selected subject; unsupported decoding or missing deployment data is an explicit boundary. Offer further descent even after the current question is resolved. A session need not enumerate every opcode in the protocol.

At every level the auditor can ask “what lives here?”, “what can change this?”, “show the next state”, “go one level deeper”, or “show how this connects to another flow.” Return to the parent view with the corrected summary after descending. Broad scope gaps stay visible beside this local focus.

## DESIGNED and IMPLEMENTED behavior

[DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md) accepts two separately inspectable models as the organizing structure of comprehension. **DESIGNED** describes intended purpose, flows, logical states, stores, transitions, permissions, accounting, required outcomes and exceptions. **IMPLEMENTED** describes actual code/configuration behavior, reachable paths, guards, state effects, external interactions and failure outcomes, grounded in source analysis or execution evidence with that distinction explicit.

Seed DESIGNED from documentation first, then develop it substantially with auditor input and further applicable evidence throughout the audit. Preserve documented claims, auditor clarifications, inferred candidates and adopted audit assumptions distinctly. Missing or conflicting design remains visible. Code/tests/domain knowledge may suggest provisional reconstructions for review; code-derived reconstruction cannot independently demonstrate conformity. Documentation first does not permanently outrank applicable later evidence, and an adopted premise does not retrospectively prove original developer intent.

At **every lens**, inspect both models and compare the selected subject: required vs available behavior, designed constraints vs reachable outcomes, implemented paths without established design explanation, and design obligations without examined implementation. Trace both directions. Map semantic correspondence before declaring a mismatch; one logical state/store/transition may map to several implementation elements or transactions. Carry assumptions, timing, exceptions, failure paths and abstraction limits into the comparison.

Persist each comparison and discrepancy using the [record contracts](harness-state-and-execution.md#record-contracts). Side-by-side model views and a compact table show designed claim, implemented behavior, conditions, evidence, unresolved issue and next action. Missing design evidence, unexamined implementation and examined comparisons with no observed discrepancy remain distinct; an empty discrepancy list cannot imply review. Deeper lensing may reveal discrepancies hidden by coarse views.

Discrepancies feed proposed investigations, not automatic findings. Also challenge the design against security objectives and the threat model where implementation conforms. Changes to either model invalidate affected correspondence, comparison, discrepancy and investigation applicability without deleting history. Relevant-flow review exposes the comparison premises/gaps needed for its investigation; other flows may remain incomplete under DEC-005.

## Automated intake and successive rounds

Under the intake's approved read/analysis capabilities and finite budget, the model seeds the engagement KB automatically: inventory sources, extract provisional purpose/flow/store/transition records, attach anchors and uncertainty, and generate preliminary diagrams. Missing documentation does not stop structural seeding; inferred intent is labeled provisional. Build/analyzer failure produces partial results and gaps.

Each round consumes a frozen snapshot and the previous knowledge revision. It prioritizes missing connections and consequential contradictions, checks selected claims against sources, and emits a bounded delta plus proposed explorations for the auditor. Another round runs only within the current budget/round limit and for a named gap or refinement; “more to discover” is not an unlimited loop. Stop with a useful seed or an explicit partial seed, remaining gaps, and a resumable exploration entry point. Exact limits are engagement settings, not a research-derived optimum.

Automatic publication means **available as attributed provisional knowledge**, not human-reviewed semantics. Agents may persist grounded observations and proposals through the existing controller without per-record permission. A seed cannot silently accept a guarantee, resolve disputed intent or authorize an investigation. Human and agent can start exploring before every seed gap is resolved. Under the accepted Q-010 policy, security investigation may begin after broad orientation and review of its relevant flow, subject to ordinary batch authorization and semantic/evidence checks; other gaps stay visible.

## The method inside each lens

The first-pass loop still applies within each exploration: orient, trace, challenge, reconcile, explain, optionally reconstruct, then choose the next focus. The following steps describe how each lens produces reliable knowledge and a connected human explanation.

### 1. Establish the whole-system outline

Start with the pinned intake snapshot. Inventory contracts and relevant dependencies, entry points, assets and accounting units, actors/roles, privileged changes, external integrations, deployment/configuration facts and lifecycle phases. Include initialization, upgrade, pause/emergency and exit/settlement behavior where applicable. Every inventoried in-scope element maps to an audit unit or an explicit unmodeled gap; unknown external targets remain unknown.

Use a compact system map to answer: what does the protocol promise, where does value live, who can change its rules, and which outside behavior does it rely on? Record the auditor's existing notes and terms when supplied. Agents may prepare structure before this review, but broad vulnerability narratives need not precede the auditor's initial orientation.

This pass establishes breadth, not completed review. Reconcile the inventory against available compiler/structural results and documents; record failures and unsupported constructs. Inventory completeness is itself bounded by available sources. The map should visibly distinguish known scope, excluded scope and unresolved boundaries.

**Output:** scope index, initial actors/assets/state/dependency views, candidate audit units and open gaps. **Next:** select one complete flow whose understanding matters to the next audit decision.

### 2. State the selected flow's question and intended behavior

Select a flow using value at risk, trust-boundary complexity, novelty, uncertainty and dependence of planned work. Keep an untouched-area reminder so repeatedly studying the most familiar path does not hide the rest of the scope.

Frame a causal question such as “How does a user turn a recorded entitlement into a final payout?” Extract documented intent independently of the implementation narrative. Distinguish developer documentation, an auditor's policy choice and an unconfirmed inference. Missing intent becomes an unknown or explicit conditional branch.

Draft the relevant guarantee with actors, assets/units, preconditions, timing, exceptions and fees/rounding when material. A proposed guarantee retains review status. Existing code behavior cannot by itself define what should be guaranteed.

**Output:** selected audit unit, intent statements, candidate guarantee and questions. **Next:** determine what the current implementation actually does.

### 3. Trace behavior in both directions

The mapping agent traces forward from entry points through guards, reads, writes, internal/external calls, callbacks and final settlement. It also traces backward from critical balances, permissions and value-transfer effects to their writers, configuration setters, inbound callers and preconditions. This second direction can reveal influences missing from the obvious happy path.

For the selected path, capture the following in a flow view:

| Aspect | What the agent must establish or mark unknown |
|---|---|
| Start | Who acts, with which permissions, balances, prior state and transaction history |
| State | Which state is read/written, its units and owner, and which other paths can alter it |
| Order | Relevant operations before/after each external interaction; intermediate and final conditions |
| Boundary | External code/configuration, controllable inputs, callback/reentry possibilities and assumptions |
| End | Payout, debt, ownership or settlement result; failures, partial progress and later transactions |
| Limits | Unresolved targets, dynamic dispatch, assembly, unsupported analysis and unexamined branches |

For EVM units, explicitly resolve inheritance/modifiers and proxy/delegatecall implementation and storage context when relevant. Identify mutable governance/oracle/token parameters, rounding and precision, and asynchronous or multi-transaction phases rather than forcing every flow into one call. The target's actual compiler/chain semantics and dependency versions bound all claims.

Each consequential statement cites snapshot identity plus symbol/range or tool/trace evidence. A source-reading interpretation is labeled as such in provenance; it is not presented as an observed execution. A static graph is a navigation aid, not proof that all runtime paths are modeled. Claims of completeness such as “only this function writes the balance” require a bounded enumeration and its limitations.

**Output:** implementation statements, connected flow steps, dependency edges and explicit gaps. **Next:** challenge the weakest or most consequential links before relying on the model.

### 4. Check predictions and challenge the model

Before running a check, state what each competing interpretation predicts. Choose the cheapest discriminating evidence: inspect a writer/caller, examine pinned configuration, follow a branch, or run a small trace/state example when permitted. Record expected and observed results separately. A comprehension probe uses existing grants and budgets; new capabilities, new investigation scope or consequential experiment semantics follow the ordinary approval contract.

A checking pass receives the same source snapshot and the question, initially without the mapper's explanatory narrative where practical. It reconstructs critical steps and searches for a defeating condition, omitted state writer or boundary. It then compares the proposed statements and their citations. Record shared sources and prior context; role separation does not establish statistical independence.

Check two things explicitly: **does the source support this claim, and what would make it false or inapplicable?** A normal-path trace demonstrates that execution under its setup; it does not prove a universal guarantee. If evidence remains unavailable, preserve the competing models and specify the needed observation.

**Output:** supported/unsupported interpretations, counterconditions, evidence references and focused unresolved questions. **Next:** reconcile these into records that every role can use.

### 5. Reconcile two versioned behavioral models

The curator submits attributed changes through the existing controller. Preserve the established system-statement kinds: **intent, observed implementation, assumption, guarantee, unknown**. An inference or hypothesis carries origin and review status in the relevant statement/question/investigation record; it does not require replacing this taxonomy.

A contradiction links both statements with their applicability and sources. Do not average them into a smooth story. Human intent/assumption decisions remain human-owned; observed code behavior cannot be overwritten by an answer about intent. Differences can yield an ordinary clarification, a design-risk question or a proposed investigation.

Reconcile the unit with the whole-system index: shared state, shared roles, external dependencies, guarantee conflicts and unmodeled edges. Carry these links into retrieval. Commit a minimal change summary: what was learned, what was corrected, what remains open and which work depends on it.

**Output:** current source-linked records plus a readable revision-bound view. **Next:** use those exact records to build the auditor's understanding.

### 6. Walk the auditor through the causal story

The accepted default is a short connected walkthrough with optional checkpoints. Start with “where we are, why this matters, and where value/state is now.” Highlight the current node, relevant stores and next edge. Explain why the transition leads to the following state. Introduce a term when needed; keep stable names and one running example.

The first view shows purpose, a compact flow diagram, the important guarantee and one material uncertainty. Deeper views reveal stores and transition effects, then code/evidence and competing interpretations. Generate diagrams into the KB as part of each flow's record view; a large combined graph remains optional. Every consequential step links back to the same record revisions used by agents. No new unsupported fact may be added simply to make the lesson easier.

At a meaningful boundary, offer one optional activity: predict the next state, explain why a guard matters, or consider one changed condition. Supply prompt feedback with source links. The auditor may instead inspect code, correct the account, ask for an analogy, request greater depth, or skip the activity. Do not stop after every sentence waiting for “continue.” A material semantic question uses the normal question route; an optional learning prompt has no approval effect.

The auditor's response can expose an agent error. Treat disagreement as a candidate model correction, not automatically as a learner mistake. Capture consequential corrections with attribution; check the evidence and update affected views. If the agent cannot ground its feedback, mark the answer unresolved rather than grading from its own narrative.

**Output:** reviewed corrections and a useful human-facing view; optional learner notes explicitly supplied by the auditor. **Next:** continue another lens or level, finish the current comprehension objective, or propose an investigation where useful.

### 7. Hand off, resume and revisit

Close the flow with what was learned, its guarantee, remaining uncertainty and the next useful focus. An exploration may end with a better system model and no vulnerability hypothesis. When it suggests an investigation, the auditor authorizes that work through the existing small-batch decision; explaining a flow does not authorize a batch.

Save an engagement bookmark: current flow and revision, key established points, unresolved premise, next step and links. At a later return, first show meaningful changes and what still holds. Offer a brief reconstruction if useful; reveal evidence immediately on request. A changed source/premise invalidates affected walkthroughs and diagrams as well as investigations.

The loop continues across flows. New findings may require relearning part of the system. Keep a concise “we previously thought → evidence now shows → therefore this changes” record rather than silently editing the old understanding out of history.

## State machines, stores and refinement

Model a flow as an abstraction over the relevant system state, parameterized by its subject: for example user, position, request ID or message ID. A node such as `claimable(request)` has a stated predicate over stores and environment; it need not correspond to a Solidity enum. A function is not automatically one transition, and an event is not automatically a persistent state. Record overlapping or incomplete predicates explicitly; do not imply a finite exhaustive model of the global EVM.

These are proposed structured details of existing audit-unit/system-statement records, with the existing identity, provenance, revision, review and freshness fields:

| Element | Required semantic detail |
|---|---|
| Flow model | Purpose, instance key, scope, abstraction level, state dimensions, start/end predicates, guarantees, omitted behavior and related flows |
| State node | Predicate and store dependencies; stable transaction-boundary state or intermediate execution state; unknown/overlapping cases |
| Transition | Trigger/entry point, permitted actor, source/destination predicates, guard, read/write sets, ordered effects, external interaction, return/failure outcomes and evidence |
| Store | Logical fact/asset and units; physical owner/location when known; lifetime; readers/writers; access rules; configuration version; derivation or external trust assumptions |
| Refinement | Parent state/edge, child states/edges, projection back to the parent, preserved assumptions, new distinctions and remaining unmodeled cases |

Store discovery covers persistent contract state and native/token balances; transaction-local transient storage; call-local memory/calldata/stack where relevant; configuration, proxy targets and permissions; and external contracts, oracles, messages and off-chain dependencies. Keep the asset's custodian, the code executing and the storage owner distinct. Mark logs/indexes as observations or derived stores, not substitutes for authoritative current state. Solidity documents different data lifetimes and delegatecall's use of the caller's context; transient storage also has call-revert behavior. Pin actual compiler/hardfork support. [Solidity 0.8.30](https://docs.soliditylang.org/en/v0.8.30/introduction-to-smart-contracts.html#storage-transient-storage-memory-and-the-stack), [EIP-1153](https://eips.ethereum.org/EIPS/eip-1153).

Refinement is a semantic relationship, not only visual zoom. Explain how the child path's inputs, outcomes and store effects project onto the parent edge. Internal child steps may leave the coarse state unchanged. If a new branch cannot be represented honestly by the parent, revise the parent rather than hiding the discrepancy. The claimed relation is source-backed and reviewable; no formal refinement proof is implied.

### Transaction boundaries and intermediate states

Keep two linked views. The lifecycle view shows persistent states between transactions, including waiting, cancellation and later settlement. The execution view refines one transaction into guards, effects, calls, possible callbacks and returns. Solidity contract-to-contract calls are part of the same transaction; control may reenter before the original call returns. Other ordinary transactions do not interleave into that call stack. A callback can therefore encounter an intermediate state absent from the lifecycle diagram. [Solidity calls](https://docs.soliditylang.org/en/v0.8.30/control-structures.html#external-function-calls).

A reverting call rolls back its effects and those of its descendants; the caller may handle failure and continue. An uncaught top-level execution failure rolls back the transaction's application effects, including its execution logs. Draw separate caught-failure and whole-execution rollback outcomes where relevant. Do not show a failed payout as a committed settlement, or claim a revert undoes earlier transactions or consumed gas. This is an application-state projection, not a claim that inclusion and fee accounting never occurred. [Solidity exceptions](https://docs.soliditylang.org/en/v0.8.30/control-structures.html#error-handling-assert-require-revert-and-exceptions), [EIP-140](https://eips.ethereum.org/EIPS/eip-140), [gas semantics](https://docs.soliditylang.org/en/v0.8.30/introduction-to-smart-contracts.html#gas).

### Composition across flows

Connect flows through shared stores, permissions, triggers and assumptions. An upgrade changes code/delegation dependencies; a price update changes guards/calculations; a deposit changes accounting consumed by withdrawal. A proposed model needs those influences even if its first lesson follows one user's happy path.

Explore bounded compositions selected by shared effects: both feasible transaction orders, a nested callback into a sibling flow, or request → external processing → later settlement. Represent asynchronous messages, time passage, oracle updates and off-chain actions as environment or separate-transaction transitions with provenance and trust/finality assumptions. Cross-transaction progress requires an explicit actor/trigger; eventual settlement is not inferred from a drawn arrow. Avoid eagerly expanding the Cartesian product of all flow states; retain cross-flow dependencies and mark unexplored compositions.

## Runnable and resumable explorations

“Runnable” means the future harness can instantiate a versioned exploration recipe with tasks, views, evidence checks, human interaction and persistent outputs. It does not mean every exploration executes a test or exploit. Read-only source navigation may suffice; any tool execution uses ordinary grants and receipts.

| Contract | Required content |
|---|---|
| Recipe | Stable ID/version; lens/objective; required inputs; ordered agent/human activities; allowed evidence operations; outputs; budget and stop conditions |
| Session | Recipe version; exact snapshot/model references; focal flow/store/transition and level; current step; completed task/evidence IDs; provisional deltas; unresolved questions; pending human decision; budget/grant references; resume bookmark |
| Round result | New/corrected/contradicted records; updated diagrams; remaining gaps; suggested next focus; precise scope of what was examined |

The auditor can start “Explore purpose,” “Map this flow,” “Map this store,” or “Refine this transition” from intake, a KB diagram, investigation evidence, fix review or a resume note. The initial workflow traverses all four lenses; a later recipe can begin at its relevant level. The session reuses existing evidence where current, and creates a new run record rather than silently treating a prior run as current.

Each step follows **show the current model → inspect or predict → seek evidence → reconcile a delta → checkpoint**. Optional prediction may be skipped. The agent resolves code facts itself where evidence suffices and asks the auditor only for consequential semantics, missing intent or a desired change of focus. A human correction may reveal a model fault, so feedback remains grounded in sources.

Stop or checkpoint when the current objective is answered at its chosen resolution, the auditor redirects/pauses, available evidence ends, a material semantic question blocks this branch, or budget is exhausted. Record unresolved boundaries and the next discriminating check. Finishing a recipe does not mark a flow secure or all levels examined.

On resume, validate snapshot/dependency freshness and show the last established point plus what changed. Preserve completed observations, fence stale work and rebase proposed deltas through existing revision controls. Changed input creates a linked continuation/run; do not overwrite the historical path. Waiting for an answer does not imply agreement; unrelated explorations can continue within authorization.

## Diagram lifecycle in the knowledge base

Every modeled flow has a diagram view and a textual state/transition table. Include node/edge IDs, lens and resolution, target/model revisions, assumptions, omitted branches, review status and freshness. Unknown edges and provisional inferences must be visibly distinguishable from grounded implementation statements and reviewed semantics; color alone is insufficient.

Generate diagrams from the structured flow/store/transition references, with editable layout kept separately from semantic records. The current repository's HTML/PNG presentation convention is a suitable initial rendering path; no new diagram vendor or graph database is required. Clicking/selecting a node or edge in a future interface opens sources, store effects, child refinements and the corresponding exploration recipe. Standalone exports supply equivalent links and readable tables.

Store the rendering's dependency manifest and generation identity. Changed code, configuration, premise, state abstraction or referenced record marks dependent diagrams/walkthroughs stale. Regeneration produces a new view and a visible semantic delta; fresh rendering does not imply human re-review. Preserve older diagrams with their revision identity for comparison. Missing dependency edges require conservative wider review under the existing invalidation contract.

Diagram checks verify that displayed predicates/edges match the referenced records, failed paths are not drawn as successful completion, intermediate and committed states are labeled, the layout does not hide unknown branches, and child views have parent links. Visual clarity and semantic validity are separate checks.

## Agent responsibilities and persisted artifacts

Use existing profiles: intake/comprehension maps, challenger checks, curator reconciles, and comprehension or synthesis presents. A single worker may perform separate passes with recorded context; extra workers are an optional resource choice. The planner owns the proposed sequence within approved limits, while the auditor owns substantive semantics and investigation selection.

Persist artifacts only when they support a decision, future retrieval, change detection or return to work. The following are logical views over existing records, not a new database selection:

| View/artifact | Contents and canonical backing |
|---|---|
| System index | Scope inventory, units, ownership, coverage gaps; backed by engagement, snapshot and audit-unit records |
| Flow model and diagrams | State predicates, transitions, read/write effects, actors, outcomes and child refinements; references versioned statements and evidence |
| Store map | Logical facts/assets, owner/location/lifetime, readers/writers, privileges, external dependencies and related flows |
| Guarantee/assumption view | Intended promise, reviewed semantics, prerequisites, exceptions, questions and counterevidence |
| Terminology map | Domain term ↔ code symbol ↔ asset/unit, with sources and aliases for keyword lookup |
| Question/dependency view | Conflicts, unanswered issues, owner, next check, affected work and source dependencies |
| Auditor walkthrough | A derived explanation/diagram with generation identity and exact record dependencies |
| Exploration session and resume note | Recipe/version, current lens/focus/level, completed steps, deltas, pending decision and next action; links to durable evidence |

The future engagement workspace can render these as reviewable repository documents, for example an index and one Markdown page per flow with source links. Filenames and serialization are illustrative; the canonical controller record remains authoritative if that architecture is adopted. Workers propose updates rather than editing accepted records or the immutable target checkout. Rebuilding a view must preserve dissent, review state and freshness.

The design-lab repository stores this methodology and its research. Actual client/system knowledge belongs to its engagement, not this lab's PLUR store. No automatic cross-engagement or lab copying is introduced. Use keyword retrieval over IDs, symbols, domain terms, assets and flows; include contradiction, limits and stale status with each retrieved claim. Add indexing complexity only when demonstrated misses justify it.

Presentation pacing and optional reconstruction need no permanent personal ability score. Store audit corrections, explicit preferences and ordinary progress when necessary for the engagement; do not infer or persist medical/attention profiles. Any later request for durable personalized learning requires its own scope and retention choice.

## Readiness and quality checks

The accepted start policy is broad orientation followed by review of the relevant flow, with exploration continuing alongside investigation. For a named investigation, the detailed readiness checks below remain proposed:

1. The flow and relevant boundary/state dependencies are source-linked; unsupported areas are explicit.
2. The relevant guarantee and consequential assumptions have the ordinary human review required by the existing design, or the investigation explicitly aims to resolve them and avoids dependent conclusions meanwhile.
3. The auditor has had a usable explanation or equivalent direct source review and can identify the proposed question, its reason and its limiting premises. This is a human judgment, not an agent-administered pass/fail quiz.
4. Remaining gaps appear in the batch proposal; authorization is bound to current revisions and permissions.

Whole-system review is not inferred from one ready unit. Known unmodeled boundaries remain visible at every handoff. A skipped learning activity does not mark the unit unreviewed when equivalent source work has supplied the needed understanding. Conversely, successful reconstruction cannot compensate for missing implementation evidence or semantic review.

Before presenting a flow as current, check source support for its consequential steps, forward/backward links, contradictions, scope gaps, dependency freshness and consistency between explanation and underlying records. A reviewer should be able to remove the prose and still locate the evidence that supports the account. Quality sampling supplements, rather than replaces, checks for the specific claims on which a consequential decision depends.

## Synthetic vault walkthrough

This invented queued-withdrawal vault illustrates the recipe and its diagram semantics. It is not a deployed target, source observation or executed PoC. Assume a fixed-rate asset/claim model, a positive withdrawal delay and cancellable requests; real pricing, fee and asset behavior would need evidence.

**Automated seed.** Intake creates provisional units for deposit, withdrawal request, claim, cancellation and administration; lists their source needs; and drafts a per-request state machine. Auditor review can correct its purpose or boundaries without regenerating an encyclopedia.

**Purpose lens.** “This vault holds assets. Users create claims by depositing, then request and later collect a payout. We are following one withdrawal request.” This establishes the subject and connects deposits to the withdrawal flow.

**Flow lens.** The readable outline below is the content a KB diagram renders. State names are predicates, not an assertion that these exact enum values exist:

| From | Transition/trigger | To |
|---|---|---|
| Absent request | Owner requests withdrawal in a successful transaction | Pending request |
| Pending | Environment time reaches the stored unlock time; no required storage write | Claimable |
| Pending or Claimable | Owner cancels in a successful transaction | Cancelled |
| Claimable | Authorized claim succeeds and settles payout | Settled |
| Claimable | Claim execution reverts | Claimable application state, with failed attempt retained |

The separate paused/unpaused configuration affects claim guards; it need not duplicate every request node. Pending and Claimable may share the same stored status and differ only by time. The diagram marks that derived distinction. All other branches remain explicitly outside this miniature example.

**Store lens.** “The request stores its owner, locked claim, unlock time and status in the vault's storage context. The token contract stores the actual asset balances. Pause/configuration has its own privileged writers.” A proxy, if present, requires identifying the address owning storage separately from the code implementation. Link deposit, cancellation and administration through the stores they share or influence.

**Transition lens.** Refine Claimable → Settled into checks → mark request settled/consume claim → external transfer → successful return. These are hypothetical child steps within one transaction. At the external-call boundary, show what a reachable callback would read. If payout failure propagates, tentative request/accounting changes roll back. If actual code instead catches failure and commits, the parent model needs a different outcome; “Settled” must not conceal the missing payout.

**Deeper lens and checkpoint.** The auditor chooses the transfer edge and asks for exact expressions, balance deltas, storage effects, then an instruction/trace view if needed and available. The recipe records the cursor, cited evidence or missing source, and the corrected abstraction. Optional prompt: “Which stores must agree before we call this settled?” A correct answer is a learning observation, not a finding approval.

**Return later.** A changed pause rule or token premise marks affected transitions and diagrams stale. Reopening the saved exploration presents the previous belief and new evidence, then resumes at the affected edge. A proposed callback or failed-payout investigation enters the normal batch queue; the exploration itself grants no new execution authority.

## Evaluation and integration

The [review's evaluation proposal](../research/comprehension-methodology-review.md#evaluation-recommendation) compares model quality and human understanding separately, with effort and preference retained. Add scenarios for a provisional seed with missing source, wrong storage owner, callback-visible intermediate state, caught versus propagated failure, time-derived state, cross-flow writer, interrupted refinement and stale diagram regeneration. These are proposed future checks, not tests executed in this specification repository.

This amendment elaborates FR-04/05/06/08/17/23/25 and NFR-08. Accepted DEC-005 requirements and the investigation-start policy are integrated into the product and auditor guide with their precise disposition. Detailed state/refinement, recipe/session and diagram lifecycle contracts remain proposed pending review; their adoption should extend the relevant record/view contracts, evaluation and completion matrix together. Preserve existing evidence-policy, authority, isolation and approved-batch rules.

## Operator choices

**Interaction default, Q-009: resolved.** The operator selected **connected walkthrough, optional checkpoints** in DEC-005. The earlier prediction-first and briefing-first alternatives remain in the first-pass review for rationale; there is no need to ask this choice again.

**Depth before investigations, Q-010: resolved.** The operator selected **A: start after broad orientation and review of the relevant flow**. Other flows and gaps remain visible, and exploration or deeper refinement continues alongside investigation. The alternative of reviewing all critical flows first is retained in the review rationale. This choice does not itself authorize work or accept every detailed readiness mechanism.
