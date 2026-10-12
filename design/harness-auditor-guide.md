# Auditor workflow and review guide

Status: **accepted baseline**: the architecture was accepted as amended in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) on 2026-10-12. First proposed as product documentation on 2026-10-01; amended 2026-10-12 for [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md) and DEC-009. This guide describes the intended use of the [audit harness](audit-harness.md). It is a workflow contract for the future interface, not instructions for software installed in this repository. The single human auditor owns consequential decisions throughout. Names and allowed values follow the [glossary](harness-glossary.md).

## Start an engagement

Provide the code revision, scope, available documentation and deployment facts. Select the permitted providers, data classes, tools, chain-state access and finite budget. Record supported assets and intended guarantees when known. The harness records missing information explicitly and attempts its baseline build inside the approved execution boundary. Reference material is prefetched at intake, or later fetched only from exact URLs you approve. Agents compose no queries against outside sites, and the target's own domains count as auditee-controlled.

Accept scope and policy with one `accept_scope_and_policy` decision. It records the threat model, which starts from the [default attacker charter](harness-glossary.md#terms):

- multiple accounts and attacker contracts;
- flash-loan capital within real liquidity;
- transaction ordering within a block;
- timing around oracle updates within the feed's rules;
- griefing spend and permitted callbacks.

You narrow the charter to what this engagement's attackers can really do. Privileged roles are trusted unless you raise them; that premise is recorded as an assumption and printed in the report's assumptions section (DEC-008, Q-015). The same decision sets:

- the data and disclosure policy, including the live-exploitable data class;
- the severity rubric, the potential-impact threshold for listing rejections in the report, and the budget;
- capacity settings for reviews, clarifications and decisions;
- an engagement time plan that allocates effort per unit, with reserves for code updates and reporting.

Review a short intake packet containing the exact source/dependency identity, compiler/EVM assumptions, scope exclusions, build outcome, sensitive-data policy, severity rubric and unresolved clarifications. It also shows:

- the scope inventory, derived deterministically from compiler artifacts: contracts, external and public functions, modifiers, storage variables, assembly blocks, and low-level call and delegatecall sites;
- each vendored dependency compared with its upstream release and marked modified or unmodified;
- content flagged at ingestion as suspicious. This includes instruction-like text addressed to AI or auditors, and bidirectional-control, invisible or confusable characters, which the trusted decision screen renders visibly;
- the result of running the project's own test suite with coverage, whose failures and untested branches become candidate leads.

A source-only engagement can proceed without deployment data. It must not imply deployment coverage. The interface explains which investigations a missing answer blocks and which can continue.

Choose retention and backup policy before collecting sensitive artifacts. Provider approval is engagement-specific: a provider permitted for one client is not automatically permitted for another. Credentials are configured through the trusted broker and never pasted into source notes, PoC files or ordinary agent context.

**Exit:** your accepted scope and policy, including the narrowed attacker charter and the trust premises, a pinned initial snapshot, the inventory, and a visible list of gaps. A failed baseline build is a blocker or limitation to investigate, never a clean security result.

## Build enough shared understanding

The accepted [comprehension direction](../decisions/DEC-005-comprehension-lensing.md) starts with automated KB seeding and one or more exploration rounds. With the agent, move through purpose → flows → stores → transitions, identifying flow state machines and saving diagrams and conclusions in the KB. Use connected walkthroughs with optional checkpoints, then descend into selected transitions at increasing resolution. Explorations can be repeated, resumed or entered from any audit stage; the [lensing method](harness-comprehension-method.md) specifies the detailed mechanics.

The comprehension agent organizes the system into assets, actors, privileges, states, complete value flows and external dependencies. Review **DESIGNED** and **IMPLEMENTED** behavior side by side at every lens. Start DESIGNED with documentation, then develop it with your input and applicable evidence. Inspect mapped states/transitions, conditions and discrepancies; distinguish missing design evidence, unexamined implementation and examined comparisons with no observed discrepancy. Inferred design candidates retain their provenance and require review; code-derived candidates cannot independently validate conformity. Your clarification cannot overwrite observed implementation. Propose investigations of deviations and of design weaknesses even where both models agree. Correct critical guarantees and record uncertainties; you need not approve a generated explanation of every function before selecting useful work.

Talk to the agent in your usual agent tool. A hook or wrapper that the model cannot alter captures your typed input verbatim (DEC-008, Q-018). The agent may turn what you said into a statement, such as “fee-on-transfer tokens unsupported”. That statement stays a proposal until you confirm, edit or reject it in a batch on the trusted decision screen, with a `confirm_interpretations` decision. An agent's paraphrase never becomes your clarification. An answer the auditee gives through you keeps the `auditee_statement` origin rather than becoming your own judgment. Documentation the auditee writes during the engagement is handled like any other documentation, and no log of client contacts is kept (DEC-009, Q-021). Because such documentation can mirror the code, a comparison against it may find no discrepancy; this is an accepted residual risk.

Before the walkthrough of a flow's implemented behavior, you may record your expectations: what should happen and what must never happen. This [expectations pre-step](harness-glossary.md#terms) is optional for every flow, including critical ones; if you skip it, you review what the agents found. Your note goes through the same capture path with the flow named, and any agent interpretation of it still needs your batched confirmation. In [read-first mode](harness-glossary.md#terms), you read the documentation and code first while the knowledge base builds in the background, and the agents' account of implemented behavior waits until you end it. The controller derives the [timing](harness-glossary.md#terms) of each intent statement you record, `before_walkthrough` or `after_walkthrough`, from capture times and the first recorded presentation of the flow's implemented behavior, which includes viewing the seed's preliminary diagrams; it is never self-reported. A comparison that relies on `after_walkthrough` intent shows the tag (DEC-009, Q-023).

An audit unit might be “withdrawal accounting across queue, token transfer and callback,” rather than one source file. A unit can also be:

- a `composition` of flows that write the same store;
- a `system_invariant` such as solvency or conservation;
- `upgrade_and_storage_layout`, which is mandatory for proxied systems.

The store map generates composition items mechanically from shared written stores, configuration writers and callback entry points, and each gets a review status. Each scoped unit has an owner, risk rationale, planned method, lead-generator coverage, evidence, the revision it was reviewed at and a visible review status. Baseline controls complement these units. A checklist item with no evidence is an open gap, regardless of how many files were visited. So is an in-scope function that maps to no unit or that you never reviewed.

For accounting flows, the stores and transitions lenses add three tables:

- a value-conservation relation for each flow;
- the units and decimals of each store;
- the rounding direction of each arithmetic operation, naming who benefits.

When documentation and code disagree, preserve both. Your answer can establish intended behavior or an assumption, but cannot change what the code currently does. Unknown intent can remain a conditional branch in the model until the affected conclusion requires a decision.

**Exit:** enough reviewed guarantees and flow information to choose the next batch, with unresolved boundaries still visible.

The operator selected investigation after broad orientation and review of the relevant flow. You can approve that flow's investigation without waiting for every critical flow to be reviewed; other gaps remain visible and exploration continues alongside investigation. Ordinary batch authorization and the relevant semantic/evidence checks still apply, and `authorize_work` refuses a batch whose relevant flow has no recorded review (FR-32).

## Approve a small batch

The planner proposes precise investigation questions, affected guarantees, methods, expected information gain, cost bounds and stop conditions. The proposal shows which lead generators have run for each unit:

- DESIGNED/IMPLEMENTED discrepancies;
- applicable standards;
- an attack-vector sweep;
- upstream diffs;
- the project's own test suite;
- baseline controls;
- matching entries from the cross-engagement [mechanism library](harness-glossary.md#terms), with their counterconditions (DEC-009, Q-022).

It includes at least one question on a high-value guarantee whose causality is multi-step or crosses flows. You can edit the questions, remove work, add a manual lead or select a less-explored unit.

The initial proposed limit is three investigations per batch. In the walking skeleton, jobs run one at a time; two concurrent agent workers and one heavy experiment remain the proposed starting point once parallel workers are added. Actual limits require your decision.

Authorize the selected investigations and a finite allocation once, with an `authorize_work` decision of kind `batch`. The other kinds are `intake` for work such as seeding rounds, `exploration`, `revalidation` for the automatic probe, PoC and property reruns after a change, and `method_evaluation`. A standing charter is a batch authorization with a validity window, for recurring local work under explicit ceilings, such as an overnight fuzzing campaign. Ordinary permitted tool calls within an allocation proceed without repeated prompts. New scope, permissions, property meaning, attacker capabilities beyond the narrowed charter, or additional budget return for a decision.

L2 scenario variants, including linked variants, and L3 experiment jobs inside an investigation are not child tasks; they share the investigation's allowance. A child task is an additional task, such as a parallel sub-investigation, inside the parent's approved investigation question. It needs room under the child-task limit, which is proposed to start at zero. A follow-up into a different guarantee stays in the batch as a [linked variant](harness-glossary.md#terms) when it needs no new capability, permission, budget, attacker power or scope (DEC-009, Q-026). It may enter a flow you have not reviewed, and the packet then flags its claims as concerning an unreviewed flow (DEC-010, Q-027). The agent classifies the follow-up and the challenger reviews it, as for other scenario changes. The controller still refuses anything beyond the grant, and when the parent's allowance runs out the follow-up stops and stays a proposed lead. Other work outside the investigation question, or a follow-up that changes a guarantee's or check oracle's meaning, is a new investigation question and comes back to you through `authorize_work`.

The batch view shows spent, reserved and uncertain cost separately, completed work, active work and remaining review capacity. Discovery pauses when the review queue reaches its agreed capacity. A stopped or incomplete job remains visible and does not become a rejected hypothesis.

**Exit:** a version-bound work authorization and a queue of admitted investigations.

Under [DEC-007](../decisions/DEC-007-human-agent-workflow.md), approve the investigation questions and constraints, then let agents draft and test the scenarios. You can contribute a scenario or manual experiment at any time; no required co-authoring checkpoint is added for each sequence. Agents derive checks from the approved guarantees and attacker charter. A changed success criterion, check-oracle meaning or capability returns as a consequential clarification. See the [workflow and eight named loops](harness-workflow-loops.md).

## Answer consequential questions

Every clarification must state the conflict or missing fact, why it matters, a recommended option when justified, the consequence of each choice and the work that depends on it. “Unknown” remains a valid answer. The harness should resolve duplicate labels, formatting and facts directly established by available code itself.

Clarifications wait in a queue with a capacity you set. They are ordered by priority, and duplicates are coalesced into one. When the queue is full, lower-priority clarifications wait without being dropped. Questions only the client can answer are exported as one batch rather than one message at a time.

For example: “Are transfer-fee tokens supported? If yes, this deposit guarantee must use assets actually received. If unknown, the finding stays conditional on token behavior.” Your answer updates the intended asset model and triggers review of dependent properties and conclusions. It does not dismiss contradictory execution evidence.

You record an answer with an `answer_clarification` decision. The interface retains it with its date, scope and source, linked to your captured input. A repeated clarification should show the prior answer and the new conflicting evidence before requesting another decision. Silence never accepts a proposal. Unrelated work continues when it does not depend on the missing answer.

## Review an investigation

The accepted default in DEC-007 is one combined packet after testing and agent challenge. It includes scenario/test meaning, adequacy and counterevidence; a separate human testing review before challenge is optional. Consequential clarifications interrupt as soon as they block useful work, and intermediate inspection remains available.

Each packet begins with a short claim and the decision requested. It then presents the affected guarantee, realistic prerequisites, supporting evidence, the strongest counterargument, remaining gaps, expected impact and the recommended next check. Full source, manifests and raw traces remain directly accessible. The packet also contains:

- every refuting or contradicting record, every failed attempt and every scenario variant with its outcome, so nothing an agent pruned is hidden;
- the challenger's and author's positions verbatim, never as a synthesized summary;
- how independent the challenge was: whether the same model or provider was used, and which premises were shared;
- any agent statements in the decision's dependency closure that no human has reviewed. Your decision is recorded as conditional on them unless you review or accept them;
- linked variants, grouped by the guarantee they touch. Each [linked claim](harness-glossary.md#terms), a claim that linked variants support about that guarantee, gets its own potential impact and disposition in the same review (DEC-009, Q-026). A linked claim about a flow you have not reviewed is flagged (DEC-010, Q-027).

For a decision with potential High or Critical impact, the trusted decision screen shows the evidence, the challenger's counterargument and the evidence-quality fields first. It reveals the agent's proposed disposition only after you have opened them (DEC-008, Q-017). By default, potential impact is the higher of the agent's estimate and yours, and `unknown` counts as `high`. You may set it below the agent's estimate only by recording a reason. Every decision is individual: there is no bulk disposition. The record notes whether the rationale was agent-drafted and what you changed.

| Your action | Required explanation and result |
|---|---|
| Request more work | Specify the missing distinguishing check; work proceeds only within a current authorization |
| Accept | Confirm applicability, prerequisites, evidence sufficiency and severity. The evidence route must match the potential impact; see [choosing the evidence route](#choose-the-evidence-route) |
| Reject | Cite decisive evidence for the countercondition and its scope. For an executable claim with potential High or Critical impact, a positive control must also show the violation once the cited guard is removed. If the rerun shows no violation, rejection is refused, and that refutation cannot support `no_finding_within_bounds` either: request more work, dispute or defer. The lead and evidence are retained for later change review |
| No finding within bounds | Record the methods, variants, budget, attacker charter and assumptions examined. This is a bounded examination, never a refutation |
| Triage out | Confirm a potential impact of `low` or `info` and give a one-line reason. The lead goes to an appendix and supports no assurance claim |
| Dispute | Record the unresolved competing interpretations and what could distinguish them |
| Defer | Record why work stops now, the residual concern and any revisit condition. The item is retained in closure review |

The glossary's [disposition table](harness-glossary.md#dispositions-and-evidence) is authoritative for these requirements, and the controller enforces them when you decide.

A tool run and a human disposition are separate. “No violation observed” is bounded negative evidence. “Proved in model” carries the model assumptions. A compilation failure is an execution failure. Neither agent agreement nor a numeric confidence score can fill missing evidence.

For a generated property, review the intended guarantee, actions/actors, units, bounds, check oracle and exclusions. Check that meaningful actions succeeded and that the property responds to a reviewed relevant fault or another justified sensitivity challenge. A passing campaign in which all withdrawals revert is inadequate. Changing the check oracle or allowed actions requires semantic review even if described as a test repair.

For an attack scenario, check attacker control, setup privileges, capital and liabilities, final committed state, and victim impact. Distinguish ordinary setup from powers the attacker really has. Loss of availability can matter without attacker profit. Fixtures that edit target storage or impersonate an administrator must not silently support a permissionless claim.

Agents declare the setup powers a fixture uses, and the challenger reviews that declaration. The harness does not check it mechanically; this is an accepted residual risk (DEC-008, Q-014). Inspect the fixture itself, because you are the final check on setup realism.

**Exit:** a revision-bound human decision, or a visible unresolved item with a next action.

## Choose the evidence route

The route depends on potential impact (DEC-008, Q-016). For Low and Info findings, a `code_argument` with source anchors suffices by default, and a stronger route is always allowed. For Medium and above, use executable confirmation or the alternative argument described below.

For executable confirmation, inspect the separate target and fixture identities, expected violation, actual trace and clean replay in a fresh environment. A test intentionally asserting the presence of a vulnerability can pass; judge its meaning, not its exit code alone.

When a runnable PoC is impractical for a Medium-or-above finding, [the accepted policy](../decisions/DEC-004-confirmation-evidence-policy.md) permits you to confirm using a documented alternative argument. The packet must explain why execution is impractical, why the argument establishes the issue, the relevant code/model anchors, realistic prerequisites, counterevidence and remaining limits. It also carries the full attempt history. If a replay of the same claim failed, your decision must address that failure, or the route is refused. The report labels the route explicitly and counts alternative-route confirmations and failed attempts. An unsupported concern remains unresolved.

Severity follows the engagement's impact rubric. Evidence strength and severity remain distinct: a potentially critical concern with insufficient support stays a potentially critical unresolved concern, rather than automatically becoming a confirmed low-severity finding.

## Pause, resume and review changes

Pause stops new dispatch and reports what is stopping, already completed or still uncertain; in the walking skeleton it terminates the running job's process group. Partial logs and artifacts remain available. If termination cannot be confirmed, the interface names the affected work and prevents overlapping replacements that could violate limits. Cancellation does not erase evidence or uncertain provider charges.

On resumption, the controller reconciles outstanding attempts and checks source, premise, policy and grant freshness. A timeout alone does not justify another execution. A grant that expired while paused needs renewed authorization before further work.

When code or configuration changes, register the new snapshot. The controller produces a snapshot diff and re-runs the dependency probes recorded with each conclusion (DEC-008, Q-019). Each conclusion lands in one freshness tier:

- **`carried_forward_mechanical`:** the probes are unchanged. Before closure or export, you sign one labelled `attest_carry_forward` decision covering all of them; until then they count as carried forward but unattested. The report shows them as carried forward mechanically, never as your review.
- **`affected`:** a probe changed, and the conclusion is listed for recheck at stage 04.
- **`possibly_affected`:** the probes cannot establish the conclusion's reach. It is flagged and listed in the report, but other work is not blocked.

Findings and rejected leads alike can be affected. The old decision stays attached to its original revision, and `reaffirm` decisions are made one conclusion at a time. When an assumption or intent changes rather than code, `revise_premise` records the change and triggers the same probe re-runs.

Every change in the diff maps to a fix assessment, a reviewed audit unit or an unreviewed-change gap printed beside the fix status. The diff covers functions, modifiers, inheritance, storage layout, dependencies and compiler settings, compared with the previous snapshot and, when known, the deployed implementation. If the inputs behind an approval screen changed, the screen must show the change and require a fresh decision.

For a supplied fix, evaluate the new revision separately with an `assess_fix` decision. Rerun the old witness and relevant legitimate behavior, then inspect adjacent paths and configuration changes. Record the attack status and the legitimate-behavior status separately: a patch that stops a theft by disabling all withdrawals is `regressive`, not fixed. When the client declines to fix, record `acknowledged` with the client's response. A scoped fix review covers the diff and the listed findings and labels everything else as not re-reviewed at that revision. Legitimate-use checks are mandatory for Critical, High and Medium findings and sampled for Low. The report shows the derived label (`fixed`, `attack_blocked_only`, `partly_fixed`, `regressive`, `not_fixed`, `acknowledged` or `not_assessed`) with evidence and residual issues.

## Close and export

Review accepted findings alongside deferred and disputed items, affected and possibly affected conclusions, blocked work, exclusions, unsupported behavior, unexamined units and unreviewed changes. The controller computes the required set, and any required item you leave out needs an audience or redaction reason. You may close a time-limited engagement with explicit limitations through a `close_engagement` decision; closing cannot mark unperformed work complete. The report states the reviewed revision for each audit unit and, where applicable, the observation block/time.

Review the frozen export preview and choose its intended audience and authorized destination. The preview lists any required items the selection omits.

- **Generated from records:** the controller produces the scope, coverage, unresolved-item, assumption and accepted-residual-risk sections and each finding's structured fields; agent-drafted prose fills in only the narrative.
- **Assumptions and trust premises:** this section lists each adopted assumption with the conclusions that depend on it, including that privileged roles are trusted unless you raised them.
- **Accepted residual risks:** the limits state that agents classify their own scenario changes and that only the challenger and you check those classifications (DEC-008, Q-014). They also state that documentation the auditee wrote during the engagement was handled like other documentation and may mirror the code, that known issues were assessed only where an investigation covered them, and that contact with the auditee was not recorded (DEC-009, Q-021).
- **Appendices:** these list rejections above the engagement's threshold, `no_finding_within_bounds` results with their bounds, and `triaged_out` leads.

Confirm each finding's evidence route and each redaction or unavailable artifact. Approval is refused when material about an unfixed finding conflicts with the audience's disclosure constraints. An export can be a local package; publication or delivery to a third party is a separate action requiring the selected destination. Later changes generate a new report version. There is no urgent release path. If a likely critical issue affects a live deployment, contact the client outside the harness; the full frozen export remains the only release, and the harness keeps no record of that contact (DEC-009, Q-025).

The [portable package contract](harness-interface-contracts.md#portable-report-and-poc-package) specifies what the recipient receives. The package must remain understandable without the originating conversation or provider. Each PoC is a test bound to a local fork or local chain, never a broadcastable script, and includes the fork state it touches so that it replays without archive access. Redactions can restrict independent reproduction and must say so.

After closure, review scoped lessons and recurring failures. Automatic capture may preserve provisional guidance with sources and counterconditions. It cannot transfer client context to another engagement or change standing permissions and evidence policy. A lesson reaches the cross-engagement [mechanism library](harness-glossary.md#terms) only through your `record_transfer` decision. Agents may propose the transfer; you supply the sanitized text and confirm that client details are removed and that the client agreement allows reuse. The library never names the source engagement (DEC-009, Q-022). Proposed workflow improvements are evaluated under the [improvement plan](harness-evaluation.md#adoption-and-controlled-improvement) and adopted on its held-out comparison (DEC-009, Q-024).

## Interface behavior and failure states

The interface keeps the active engagement and snapshot visible, separates work state from disposition and freshness, and avoids a single misleading “verified” badge. It uses textual status and reasons as well as color, and renders deceptive characters visibly. Decision controls must be keyboard operable, expose their labels and current state to assistive technology, and keep focus on the resulting decision or conflict explanation. Logs and long source excerpts remain available without obscuring the requested decision.

| State | What the auditor sees and can do |
|---|---|
| Empty engagement | Required intake fields, known unknowns and the next setup action; no fabricated progress |
| Work running | Question, attempt identity, bounded progress, costs and stop controls; no invented time-to-completion |
| Waiting for a clarification | One clarification, the affected work and current evidence; the status of unrelated work remains visible |
| Clarification queue full | Queued clarifications by priority, with duplicates coalesced; lower-priority items wait without being dropped; work that depends on them stays blocked |
| Interpretations awaiting confirmation | Agent-proposed statements beside the captured input they came from; you confirm, edit or reject each in one batch; unconfirmed items stay proposals |
| Provider unavailable | Pending/failed or uncertain calls and retained reservations; retry or a compatible provider change needs current policy and budget |
| Tool unsupported | Exact capability gap and alternate investigation methods; no clean result inferred |
| Changed inputs or conflict | Prior and current premise/evidence, newly linked evidence, the affected decision and the re-review action; acceptance disabled until reconciled |
| Change registered | The snapshot diff and probe results by freshness tier; the mechanical carry-forward attestation to sign; `affected` items listed for recheck at stage 04; `possibly_affected` items flagged |
| Packet incomplete | The missing lists or artifacts by name; the packet is not ready for review until they are supplied |
| Evidence requirement unmet | What the chosen disposition still needs, such as a positive control or a stronger evidence route; supply it, request more work, dispute or defer |
| Suspicious content flagged | Instruction-like text or deceptive characters, rendered visibly with their locations; acknowledging a flag grants nothing |
| Corrupt or incomplete evidence | Quarantined material, limits and recovery options; confirmation blocked for the affected claim |
| Review queue full | Completed packets and a concise reconciliation view; discovery paused without dropping admitted work |
| Export unavailable or redacted | Missing material and the resulting assurance/replay limits; no claim of a complete portable package |

These interaction requirements are part of the accepted baseline. A future UI trial must inspect these states with an auditor, including keyboard access and readable long evidence. This repository contains the workflow specification and diagrams, not a rendered application.
