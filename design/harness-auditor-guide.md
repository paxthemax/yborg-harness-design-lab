# Auditor workflow and review guide

Status: **proposed product documentation**, 2026-10-01. This guide describes the intended use of the [audit harness](audit-harness.md). It is a workflow contract for the future interface, not instructions for software installed in this repository. The single human auditor owns consequential decisions throughout.

## Start an engagement

Provide the code revision, scope, available documentation and deployment facts. Select the permitted providers, data classes, tools, chain-state access and finite budget. Record supported assets and intended guarantees when known. The harness records missing information explicitly and attempts its baseline build inside the approved execution boundary.

Review a short intake packet containing the exact source/dependency identity, compiler/EVM assumptions, scope exclusions, build outcome, sensitive-data policy, severity rubric and unresolved questions. A source-only engagement can proceed without deployment data. It must not imply deployment coverage. The interface explains which investigations a missing answer blocks and which can continue.

Choose retention and backup policy before collecting sensitive artifacts. Provider approval is engagement-specific: a provider permitted for one client is not automatically permitted for another. Credentials are configured through the trusted broker and never pasted into source notes, PoC files or ordinary agent context.

**Exit:** your accepted scope and policy, a pinned initial snapshot, and a visible list of gaps. A failed baseline build is a blocker or limitation to investigate, never a clean security result.

## Build enough shared understanding

The comprehension agent organizes the system into assets, actors, privileges, states, complete value flows and external dependencies. Review intent and implementation side by side. Correct critical guarantees and record uncertainties; you need not approve a generated explanation of every function before selecting useful work.

An audit unit might be “withdrawal accounting across queue, token transfer and callback,” rather than one source file. Each scoped unit has an owner, risk rationale, planned method, evidence and visible review status. Baseline controls complement these units. A checklist item with no evidence is an open gap, regardless of how many files were visited.

When documentation and code disagree, preserve both. Your answer can establish intended behavior or an assumption, but cannot change what the code currently does. Unknown intent can remain a conditional branch in the model until the affected conclusion requires a decision.

**Exit:** enough reviewed guarantees and flow information to choose the next batch, with unresolved boundaries still visible.

## Approve a small batch

The planner proposes precise questions, affected guarantees, methods, expected information gain, cost bounds and stop conditions. You can edit the questions, remove work, add a manual lead or select a less-explored unit. The initial proposed limits are three investigations, two agent workers and one heavy experiment; actual limits require your batch decision.

Approve the selected questions and finite allocation once. Ordinary permitted tool calls within that allocation proceed without repeated prompts. New scope, permissions, property meaning, attacker capabilities or additional budget return for a decision. A recommendation to spawn a child task is handled within the same grant and limits; the proposed initial child limit is zero.

The batch view shows spent, reserved and uncertain cost separately, completed work, active work and remaining review capacity. Discovery pauses when the review queue reaches its agreed capacity. A stopped or incomplete job remains visible and does not become a rejected hypothesis.

**Exit:** a version-bound batch authorization and a queue of admitted investigations.

## Answer consequential questions

Every question must state the conflict or missing fact, why it matters, a recommended option when justified, the consequence of each choice and the work that depends on it. “Unknown” remains a valid answer. The harness should resolve duplicate labels, formatting and facts directly established by available code itself.

For example: “Are transfer-fee tokens supported? If yes, this deposit guarantee must use assets actually received. If unknown, the finding stays conditional on token behavior.” Your answer updates the intended asset model and triggers review of dependent properties and conclusions. It does not dismiss contradictory execution evidence.

The interface retains your answer, its date, scope and source. Repeated questions should show the prior answer and the new conflicting evidence before requesting another decision. Silence never accepts a proposal. Unrelated work continues when it does not depend on the missing answer.

## Review an investigation

Each packet begins with a short claim and the decision requested. It then presents the affected guarantee, realistic prerequisites, supporting evidence, strongest counterargument, remaining gaps, expected impact and recommended next check. Full source, manifests and raw traces remain directly accessible.

| Your action | Required explanation and result |
|---|---|
| Request more work | Specify the missing distinguishing check; work proceeds only within a current authorization |
| Accept | Confirm applicability, prerequisites, evidence sufficiency and severity; select executable or justified alternative evidence |
| Reject | Identify the decisive countercondition and its scope; retain the lead and evidence for later change review |
| Dispute | Record the unresolved competing interpretations and what could distinguish them |
| Defer | Record why work stops now, residual concern and any revisit condition; retain it in closure review |

A tool run and a human disposition are separate. “No violation observed” is bounded negative evidence. “Proved in model” carries the model assumptions. A compilation failure is an execution failure. Neither agent agreement nor a numeric confidence score can fill missing evidence.

For a generated property, review the intended guarantee, actions/actors, units, bounds, oracle and exclusions. Check that meaningful actions succeeded and that the property responds to a reviewed relevant fault or another justified sensitivity challenge. A passing campaign in which all withdrawals revert is inadequate. Changing the oracle or allowed actions requires semantic review even if described as a test repair.

For an attack scenario, check attacker control, setup privileges, capital and liabilities, final committed state, and victim impact. Distinguish ordinary setup from powers the attacker really has. Loss of availability can matter without attacker profit. Fixtures that edit target storage or impersonate an administrator must not silently support a permissionless claim.

**Exit:** a revision-bound human decision, or a visible unresolved item with a next action.

## Choose the evidence route

For executable confirmation, inspect the separate target and fixture identities, expected violation, actual trace and clean replay in a fresh environment. A test intentionally asserting the presence of a vulnerability can pass; judge its meaning, not its exit code alone.

When a runnable PoC is impractical, [the accepted policy](../decisions/DEC-004-confirmation-evidence-policy.md) permits you to confirm using a documented alternative argument. The packet must explain why execution is impractical, why the argument establishes the issue, the relevant code/model anchors, realistic prerequisites, counterevidence and remaining limits. The report labels that route explicitly. An unsupported concern remains unresolved.

Severity follows the engagement's impact rubric. Evidence strength and severity remain distinct: a potentially critical concern with insufficient support stays a potentially critical unresolved concern, rather than automatically becoming a confirmed low-severity finding.

## Pause, resume and review changes

Pause stops new dispatch and reports what is stopping, already completed or still uncertain. Partial logs and artifacts remain available. If termination cannot be confirmed, the interface names the affected work and prevents overlapping replacements that could violate limits. Cancellation does not erase evidence or uncertain provider charges.

On resumption, the controller reconciles outstanding attempts and checks source, premise, policy and grant freshness. A timeout alone does not justify another execution. A grant that expired while paused needs renewed authorization before further work.

When code, configuration or an assumption changes, inspect the affected-work list. Both findings and rejected leads can become stale. The old decision stays attached to its original revision. If dependencies are incomplete, the harness broadens review rather than claiming the change is irrelevant. An approval screen that became stale must show the change and require a fresh decision.

For a supplied fix, evaluate the new revision separately. Rerun the old witness and relevant legitimate behavior, then inspect adjacent paths and configuration changes. A patch that stops a theft by disabling all withdrawals has not established a satisfactory fix. Record fixed, partly fixed, not fixed or not assessed with evidence and residual issues.

## Close and export

Review accepted findings alongside deferred/disputed items, blocked work, exclusions, unsupported behavior and unexamined units. You may close a time-limited engagement with explicit limitations; closing cannot mark unperformed work complete. The report states the exact reviewed revision and, where applicable, observation block/time.

Review the frozen export preview and choose its intended audience and authorized destination. Confirm each finding's evidence route and each redaction or unavailable artifact. An export can be a local package; publication or delivery to a third party is a separate action requiring the selected destination. Later changes generate a new report version.

The [portable package contract](harness-interface-contracts.md#portable-report-and-poc-package) specifies what the recipient receives. The package must remain understandable without the originating conversation or provider. Redactions can restrict independent reproduction and must say so.

After closure, review scoped lessons and recurring failures. Automatic capture may preserve provisional guidance with sources and counterconditions. It cannot transfer client context to another engagement or change standing permissions and evidence policy. Proposed workflow improvements are evaluated under the [improvement plan](harness-evaluation.md#adoption-and-controlled-improvement).

## Interface behavior and failure states

The interface keeps the active engagement and snapshot visible, separates work state from disposition and freshness, and avoids a single misleading “verified” badge. It uses textual status and reasons as well as color. Decision controls must be keyboard operable, expose their labels and current state to assistive technology, and keep focus on the resulting decision or conflict explanation. Logs and long source excerpts remain available without obscuring the requested decision.

| State | What the auditor sees and can do |
|---|---|
| Empty engagement | Required intake fields, known unknowns and the next setup action; no fabricated progress |
| Work running | Question, attempt identity, bounded progress, costs and stop controls; no invented time-to-completion |
| Waiting for an answer | One decision, affected work and current evidence; unrelated work status remains visible |
| Provider unavailable | Pending/failed or uncertain calls and retained reservations; retry or a compatible provider change needs current policy and budget |
| Tool unsupported | Exact capability gap and alternate investigation methods; no clean result inferred |
| Stale packet or conflict | Prior and current premise/evidence, affected decision and re-review action; acceptance disabled until reconciled |
| Corrupt or incomplete evidence | Quarantined material, limits and recovery options; confirmation blocked for the affected claim |
| Review queue full | Completed packets and a concise reconciliation view; discovery paused without dropping admitted work |
| Export unavailable or redacted | Missing material and the resulting assurance/replay limits; no claim of a complete portable package |

These are proposed interaction requirements. A future UI trial must inspect these states with an auditor, including keyboard access and readable long evidence. This repository contains the workflow specification and diagrams, not a rendered application.
