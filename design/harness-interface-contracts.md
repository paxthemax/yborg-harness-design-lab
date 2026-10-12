# Harness component and artifact contracts

Status: **[accepted baseline](harness-glossary.md#terms)**, 2026-10-12: the architecture was accepted as amended in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md). First proposed 2026-10-01; amended 2026-10-12 to integrate [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), DEC-009 and the [adversarial review](../research/adversarial-design-review.md)'s fixes. This document completes the component boundaries in the [architecture](audit-harness.md) and [state specification](harness-state-and-execution.md). It specifies observable behavior independently of programming language, transport, database, agent host or workflow engine. Operation names below are design vocabulary, not an implemented API or CLI. Names and allowed values follow the [glossary](harness-glossary.md).

## Contract conventions

The controller is authoritative for record IDs, revisions, grants and state transitions. A reference consists of an engagement ID, record ID and exact positive integer revision; references nested in a single-engagement request inherit its engagement ID unless explicitly qualified. A cross-engagement reference never grants access by itself. An artifact reference names its content hash and hash algorithm. An ID without a revision may be used to find the current record, but cannot bind an approval or execution input. Artifact hashes identify bytes, not the truth of their contents.

Each request carries a supported contract version, a producer-generated request ID, the engagement (or, for decisions about the mechanism library itself, the library scope), operation, expected record revisions and typed payload. Worker requests additionally carry a controller-issued grant and attempt identity. The authenticated caller is established by the channel and checked against those references; an `actor` field supplied in a payload cannot confer authority. Human and worker channels remain separate under the [write protocol](harness-state-and-execution.md#write-and-approval-protocol). Human decisions come only from the trusted decision screen. Each carries a decision kind and a display-receipt reference. The controller recomputes the inbound-link digest and evidence watermark itself, from the reviewed packet's revision, rather than accepting them from the caller.

Every mutating request has an idempotency key scoped to its engagement, authenticated principal and operation. In the walking skeleton, the controller detects a repeated key against its committed records. Once the [deferral trigger](harness-state-and-execution.md#deferred-mechanisms) for idempotency records is met, it also retains the key, a digest of the normalized request, and the committed result. Repeating the same request returns that result; changing its contents under the same key returns a conflict. A retry acknowledgement refers to the historical commit and also identifies whether relevant state has since changed. It does not renew a grant or make an old decision current. Store idempotency records for at least the supported retry/recovery lifetime; expired keys cannot be reused to bypass reconciliation.

An implementation publishes the serialization and hashing rules for each contract version. Dependency digests are hashes of controller-built, stored manifests of exact references; callers cannot supply an arbitrary digest instead of those references. Unknown contract versions and unsupported permission-bearing fields are rejected. Optional extensions must be namespaced, explicitly advertised and incapable of granting authority. Unknown values use a reason and status, rather than an empty string that appears complete.

## Controller operations

All writes pass the same engagement, permission, revision and budget checks. A committed response means that the requested record transition is durable; it does not mean that queued work ran successfully or that an investigation is valid.

| Operation | Allowed caller and required input | Observable result and important refusal |
|---|---|---|
| `read_records` | Auditor or worker with read grant; exact record revisions or the requested current view, which may include admitted mechanism-library entries; filters and page limit | Records with revisions, applicability and provenance; a worker cannot widen its authorized engagement, context or visibility through filters |
| `submit_proposal` | Auditor or authorized worker; base references, proposed statement, clarification, investigation, library transfer or interpretation of captured input, with anchors and dependencies | Attributed provisional record or revision conflict; cannot create an accepted finding, semantic approval, confirmed interpretation, library entry or policy change |
| `register_snapshot` | Auditor or intake worker; source, dependency and deployment identity | New target snapshot, its snapshot diff, and dependency probes re-run within the engagement's `revalidation` authorization, with their freshness results; no decision changes |
| `capture_input` | Capture channel only: a hook or wrapper that the model cannot alter; an optional purpose and audit unit that the auditor supplies, such as the [expectations pre-step](harness-glossary.md#terms) for a flow | Verbatim, hashed captured-input record; workers and the agent tool cannot call it |
| `prepare_work` | Auditor or planning worker; work kind, investigations, methods, estimates, dependencies and requested capabilities | Reviewable proposal and identified gaps, including lead-generator coverage and whether a high-value multi-step or cross-flow question is included; no executable grant |
| `authorize_work` | Auditor on the trusted decision screen; work kind (`intake`, `exploration`, `batch`, `revalidation` or `method_evaluation`), reviewed revisions, finite resource limits, attacker charter, approved tool/provider policies, rationale with its authorship, and display receipt | Versioned work authorization; refuse unresolved mandatory policy fields, changed review inputs, or a batch whose relevant flow has no `record_flow_review` decision (DEC-005) |
| `request_job` | Controller scheduler or authorized worker; admitted investigation, input/context references, adapter operation and limits | Reserved resources and queued logical job; refuse a new investigation question, a child task beyond its limit, an unsupported capability, an exhausted budget or a stale authorization. A [linked variant](harness-glossary.md#terms) is admitted under the parent investigation's grant and allowance (DEC-009, Q-026), including into a flow without a `record_flow_review` decision (DEC-010, Q-027) |
| `submit_artifacts` | Trusted broker for an identified attempt; staged files, supervisor receipt and result interpretation kept separate | Hash-checked artifact records after durable staging; incomplete or untrusted receipts remain ineligible |
| `submit_review_packet` | Authorized worker or auditor; investigation revision and the packet contents defined in the state contract | `ready_for_review` only when complete, otherwise `packet_incomplete` naming the missing items; readiness grants no acceptance |
| `record_decision` | Auditor on the trusted decision screen; [decision kind](#human-decision-kinds), exact reviewed references, display receipt and the kind's required inputs | Human decision and new applicability; refuse stale inputs, a missing display receipt, unmet evidence requirements, a bulk request or an agent channel |
| `revise_premise` | Auditor on the trusted decision screen, for reviewed intent and assumptions, with a display receipt and rationale authorship; workers propose revisions through `submit_proposal` | New premise revision, affected-work list and probe re-runs; previous evidence and decisions preserved |
| `pause`, `cancel`, `resume` | Auditor within the engagement; controller may enforce an automatic budget/policy stop | Recorded control transition and worker reconciliation status; resumption needs current inputs and grants |
| `prepare_export` | Auditor or reporting worker with read access; frozen record selection and proposed audience/redaction policy | Local preview and immutable content manifest. The preview lists each required item the selection omits; each needs an audience or redaction reason. It includes the controller-generated scope, coverage, unresolved-item, assumption, accepted-residual-risk and structured finding sections. No release or new acceptance |
| `approve_export` | Auditor on the trusted decision screen; preview/content identity, audience, permitted destination, display receipt and rationale authorship | Release authorization bound to those exact bytes and scope; refuse unexplained required-set omissions, or material about an unfixed finding that conflicts with the audience's disclosure constraints; changing content or destination requires renewed review |
| `export_bundle` | Controller acting on that authorization | Local artifact and export receipt, or an explicit failure; an external transfer requires its own authorized destination/action |
| `import_bundle` | Auditor; bundle bytes | Verification in quarantine with execution disabled; the destination is chosen by a `choose_import_destination` decision |

Operational events have a monotonic sequence within each engagement. Event cursors are deferred in the walking skeleton until more than one process consumes events (see [deferred mechanisms](harness-state-and-execution.md#deferred-mechanisms)). A subscriber resumes from its last acknowledged cursor; duplicated events are possible and are deduplicated by event ID. A cursor older than retained event history yields `snapshot_required`, followed by a consistent snapshot and new cursor. Consumers cannot reconstruct current authorization from an incomplete event stream. Command acceptance, dispatch, execution completion, evidence eligibility and human disposition are different events.

### Human decision kinds

Every human-only action other than work authorization, premise revision and export approval goes through `record_decision` with one of these kinds. Those three keep their own operations because they bind resources, premises and exact bytes respectively. They still take the same inputs as a decision: the authenticated trusted-screen channel, a display receipt for the reviewed revisions, and a rationale with its authorship recorded.

| Kind | Required inputs | Controller checks |
|---|---|---|
| `accept_scope_and_policy` | Scope and exclusions; threat model with the narrowed default attacker charter and the trusted-role premise; data, disclosure and retention policy; severity rubric; potential-impact threshold for listing rejections in reports; budget; capacity settings | No mandatory field left unresolved |
| `answer_clarification` | Clarification revision; the answer, which may be "unknown"; captured-input reference | The answer is recorded as intent or an assumption, never as observed behavior |
| `confirm_interpretations` | Agent-proposed statements, each linked to captured input; a confirm, edit or reject choice for each | Each item is decided separately within the batch |
| `approve_semantics` | Property or check-oracle revision; actions, bounds and exclusions | Stale if the oracle or the action space changed after review |
| `record_flow_review` | Flow or audit-unit revision; the reviewed DESIGNED/IMPLEMENTED comparison, gaps and assumptions | Sets the unit's review status to `reviewed` for those revisions. A batch on that flow cannot be authorized without it (FR-32) |
| `dispose_investigation` | Review packet revision; disposition, given separately for each linked claim with its own potential impact; severity for `accepted`; evidence route and DEC-004 fields where they apply; decisive evidence and the positive control where required | The [disposition table](harness-glossary.md#dispositions-and-evidence); the High/Critical presentation order shown by the display receipt; each linked claim checked against its own potential impact |
| `attest_carry_forward` | Snapshot pair; probe results | Covers only conclusions whose probes are unchanged; recorded as mechanical |
| `reaffirm` | One conclusion; new evidence or reason | One conclusion per decision |
| `assess_fix` | Finding; fix snapshot; attack and legitimate-behavior evidence; client response | Attack status and legitimate-behavior status recorded separately |
| `close_engagement` | Closure review with the required-set results | No unexplained required item |
| `record_transfer` | Admission, revision or retirement of a [mechanism library](harness-glossary.md#terms) entry. Admission takes an engagement lesson revision, decided in its source engagement, or a public reference, decided in the library scope, together with the sanitized text; a lesson also needs the auditor's confirmations that client details are removed and that the client agreement allows reuse. Revision and retirement are decided in the library scope | Reusable knowledge moves between engagements only through this record (DEC-009, Q-022); bundle import uses `choose_import_destination`. A lesson transfer without both confirmations is refused. The entry carries only an opaque reference to a lesson's transfer record and never names its source engagement |
| `adopt_method_version` | Method change; evaluation evidence | The evaluation plan's held-out comparison (DEC-009, Q-024) |
| `choose_import_destination` | Verified bundle; destination engagement; whether imported conclusions stay historical or need revalidation | Imported identifiers gain no authority |
| `retention_action` | Material; policy basis | Dependent records marked unavailable |

**Packet presentation (DEC-008, Q-017).** For potential High or Critical decisions, the trusted screen first shows the evidence, the challenger's verbatim counterargument and the evidence-quality fields. It reveals the agent's proposed disposition only after the auditor has opened those sections, and the display receipt records the order. For every other decision, the packet keeps DEC-007's combined layout. In all cases the challenger and author positions appear verbatim, never as a synthesized summary. Linked variants appear grouped by the guarantee they touch. Each linked claim gets its own disposition in the same review, and its own potential impact decides its presentation order and evidence requirement (DEC-009, Q-026). A linked claim whose flow has no `record_flow_review` decision is flagged as concerning an unreviewed flow (DEC-010, Q-027).

## Agent and tool adapter boundary

Before dispatch, an adapter advertises its adapter/contract version, immutable executable or image identity where available, supported ecosystem and tool modes, input/output types, limits, dependencies, required filesystem/network capabilities, cancellation behavior, and recovery/replay support. A capability description supplied by a tool is untrusted until registered by the operator's integration policy. Repository files cannot register adapters or modify their grants.

The controller selects a compatible adapter and records that exact descriptor with the job. No compatible version means `unsupported`, with affected audit units and alternatives returned for review. Falling back to a different model, compiler, analysis mode, endpoint or tool requires policy compatibility and a new attempt/context record. It must never happen invisibly inside a receipt.

| Boundary | Input | Output and invariant |
|---|---|---|
| Controller to agent | Role profile, investigation question, versioned context manifest, tool grant, resource envelope and stop conditions. A challenger's initial context excludes provisional statements on the challenged path, and can strip comments and NatSpec for a comment-blind pass | Typed proposals, requests, blockers and concise reasoning summaries; no direct canonical-store writes or child-task authority |
| Agent tool to capture channel | The auditor's typed input in the agent tool | Verbatim captured-input record. The agent tool runs confined per engagement with its memory off, and cannot write to the channel, its hooks or its own configuration |
| Controller to trusted decision screen | Bound record revisions and the decision kind's inputs | Rendered records with bidirectional-control, zero-width and confusable characters shown visibly; High/Critical packets in evidence-first order; a display receipt for each decision |
| Controller to tool broker | Registered operation, structured arguments, read snapshot, scratch location, limits, attempt and grant | Broker verifies paths/arguments and launches the fixed adapter outside the controller's record directory |
| Sandbox to receipt collector | Bounded raw streams, artifacts and observed process state | Collector supplies supervisor-derived launch/exit metadata and hashes; guest claims remain untrusted interpretation |
| Context builder to provider broker | Authorized context references, data classes, selected provider/model policy and output limit | Broker resolves approved bytes, checks current egress grant, records payload identity and returned model identity, and accounts for actual or uncertain cost |
| Local fork to RPC gateway | Approved endpoint, chain/block identity, method and parameters | Bounded permitted read response with provenance; deny live writes, redirects and unapproved fallback endpoints |
| Curator to memory interface | Attributed lesson, sources, applicability, counterconditions and review status | Engagement-local provisional lesson; a transfer to the mechanism library needs a `record_transfer` decision, and policy changes need an explicit human disposition |

Agents request provider calls using authorized context references. Arbitrary additional text or attachments must be classified and admitted by the context builder under the engagement policy before egress. Material in the live-exploitable, unpatched data class goes only to the providers the engagement approves for it, with minimal context. A domain allowlist alone is insufficient. Provider credentials, infrastructure credentials and host secrets cannot be resolved as context references.

A tool result includes its declared mode, one of the [result types](harness-state-and-execution.md#state-transitions), relevant bounds, exit status, output/artifact references, truncation/loss flags and limitations. A result parser failing on an otherwise completed process yields `inconclusive` or `error`; it cannot infer no violation from absent structured output. Cancellation is acknowledged separately from confirmed process termination. An adapter unable to prove termination prevents replacement work that would exceed resource limits.

## Errors and reconciliation

Errors contain a stable code, the affected operation/reference, a plain-language reason, whether anything committed, and an allowed next action. Details must not leak secrets or another engagement's existence. Retrying must obey the current grant and budget even when an error is transient.

| Code | Meaning and next action |
|---|---|
| `invalid_request` / `unsupported_contract` | No transition committed; correct the request or choose a compatible registered adapter |
| `permission_denied` / `grant_expired` | No new capability exercised; obtain an appropriate human decision or stop |
| `revision_conflict` / `stale_dependency` | Read current eligible state and review the difference; do not silently substitute current references into an old approval |
| `idempotency_conflict` | A key was reused for different contents; reconcile the earlier operation before issuing a genuinely new request |
| `budget_exhausted` / `review_capacity_reached` | Do not dispatch new work; return completed/partial work and a proposed next batch |
| `artifact_incomplete` / `integrity_failure` | Quarantine the material; preserve the failure and request recovery or a new artifact; never mark it eligible |
| `unsupported` / `execution_failed` | Record the precise capability gap or failed attempt; repair or another method needs an authorized request |
| `outcome_unknown` | An external request may have run or incurred cost; preserve its reservation and reconcile before retrying under the [job contract](harness-state-and-execution.md#durable-jobs-and-resource-limits) |
| `worker_unreachable` / `stop_unconfirmed` | Retain the last known state, and fence the worker's writes once leases exist; confirm termination before admitting a replacement that could exceed limits |
| `snapshot_required` | The event cursor is unusable; reload a consistent record view before acting on event-derived state |
| `packet_incomplete` | The review packet lacks a required list or artifact, such as a refuting record, a failed attempt, a variant or a verbatim challenge; nothing becomes `ready_for_review` until it is supplied |
| `display_required` | The decision cites revisions with no display receipt, or a High/Critical packet was decided before its evidence sections were opened; render and review before deciding |
| `evidence_requirement_unmet` | The disposition's evidence requirement is not met, for example a missing positive control or an evidence route below what the potential impact requires; supply the evidence or choose another disposition |
| `egress_denied` | A sandbox, fetch or upstream request fell outside the egress policy; the attempt is recorded and nothing was sent |

Once external execution has been requested, a transport failure cannot truthfully promise that nothing happened. Its response distinguishes the controller's committed state from external execution certainty. A completed operation whose response was lost is recovered through its committed record (or its idempotency record, once those exist), logical job and attempt receipts. A client must not invent a new logical job merely because polling timed out.

## Synthetic request example

This example illustrates a human decision request. Every ID is fictional; there is no actual finding or approval. The authenticated human identity comes from the decision channel. The controller resolves the complete dependency manifest and validates it at commit time.

```json
{
  "contract_version": 1,
  "request_id": "example-request-17",
  "idempotency_key": "example-decision-17",
  "engagement_id": "example-engagement",
  "operation": "record_decision",
  "expected_revisions": [
    {"record_id": "example-investigation", "revision": 4},
    {"record_id": "example-review-packet", "revision": 2},
    {"record_id": "example-dependencies", "revision": 3}
  ],
  "payload": {
    "decision_kind": "dispose_investigation",
    "display_receipt": {"record_id": "example-display-receipt", "revision": 1},
    "disposition": "rejected",
    "potential_impact": "high",
    "rationale": "The reviewed guard prevents this specific callback path.",
    "rationale_authorship": "agent_drafted_edited",
    "decisive_evidence": [
      {"record_id": "example-guard-evidence", "revision": 1}
    ],
    "positive_control": {"record_id": "example-guard-removed-rerun", "revision": 1},
    "applicability": "The reviewed target and premises only."
  }
}
```

The review packet's revision binds the inbound-link digest and evidence watermark that the controller computed when it built the packet.

- **Changes before commit.** If the guard changes, or refuting evidence is linked to the investigation, the response is `stale_dependency`; there is no new rejection decision.
- **Evidence requirements.** The potential impact is `high`, so the controller also requires the guard-removed rerun to show the violation; otherwise the response is `evidence_requirement_unmet`. A request whose display receipt does not cover these revisions, or shows the proposed disposition opened before the evidence, returns `display_required`.
- **Changes after commit.** If the guard changes later, the historical rejection is retained and the next snapshot's probes set its freshness.
- **Repeated delivery.** If the same request is delivered twice, it creates one decision.

A rejection needs decisive-evidence references, plus the positive control when the claim is executable and its potential impact is High or Critical. An acceptance instead supplies the evidence route its potential impact requires: a clean replay, or the documented alternative-evidence justification under [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md), for Medium and above; a code argument with anchors for Low and Info.

## Portable report and PoC package

The minimum export contains a versioned content manifest, readable report, selected record revisions and decision rationale, artifact inventory, environment/tool description, reproduction instructions where applicable, and explicit missing/redacted material. A proposed layout is:

```text
export/
  README.md                 scope, contents, limitations and inspection steps
  manifest.json             immutable payload inventory and exact record references
  report.md                 approved findings, unresolved exposure, assumptions and trust
                            premises, coverage limits, appendices
  records/                  portable structured records and dependency references
  artifacts/                immutable evidence files addressed by content hash
  reproduction/             separate fixtures and environment/command descriptions
  release-receipt.json      payload identity, human approval and export outcome
```

Filenames are illustrative; the contract is that a recipient can locate and verify each required item without the original conversation, provider or agent host. The manifest names schema version, engagement/snapshot identity, record revisions, artifact paths and hashes, evidence routes, required tools, redactions, missing dependencies and limits. It also names the controller-computed required set and the reason each absent item is absent.

The report's structured sections are generated from records rather than written as prose:

- scope;
- coverage, with the reviewed revision for each audit unit and the intent timing of the auditor intent behind each comparison;
- unresolved items;
- assumptions and trust premises, each with the conclusions that depend on it;
- accepted residual risks, stated as limits;
- for each finding, its severity, prerequisites, affected code, evidence route, client response and fix label.

Its appendices list rejections above the engagement's threshold, `no_finding_within_bounds` results with their bounds, and `triaged_out` leads. Counts of alternative-route confirmations and failed attempts appear beside the findings. Relative paths stay inside the bundle. Imported record IDs are scoped to their original engagement and cannot acquire authority in a new one.

Freeze the content manifest and report before approval. The human decision binds their payload identity, intended audience and destination. The release receipt then references that approval and payload; it is outside the hashed payload to avoid a self-referential approval/hash cycle. A new redaction, evidence update or audience change creates a new preview and authorization. The recipient checks the payload hashes and decision references; a checksum is not a signature or proof of authenticity. No public signing infrastructure is selected by this proposal.

Each executable PoC is a test bound to a local fork or local chain, never a script that can broadcast. It identifies the following separately:

- original target bytes, kept apart from fixtures;
- tool and dependency versions, working directory and structured command arguments;
- required secret placeholders;
- expected observation, observed trace and clean-replay receipt;
- all declared setup powers.

Forked cases include chain/block identity and the touched fork state (accounts, code and storage slots), so they replay without archive access; the archive reference is kept as provenance. Instructions warn through concrete prerequisites when a package cannot currently replay; no missing secret or archive data is replaced by a silent mock.

Alternative-evidence findings include the reviewed argument, why execution was impractical, what remains untested and the full attempt history, including any failed replay of the same claim and how the decision addressed it. They never include a fabricated reproduction command.

Restore/import parses metadata and verifies artifacts in quarantine with execution disabled. Bundle contents cannot install tooling, authorize a provider, restore an active worker capability or publish a report. After validation, an auditor explicitly chooses the destination engagement and whether imported conclusions remain historical reference material or need revalidation. Backup restoration follows the stronger [consistent snapshot and recovery contract](harness-state-and-execution.md#permissions-and-isolation).

## Compatibility and conformance

An adapter or host integration is eligible only after demonstrating scoped reads/writes, denied capability expansion, unsupported-mode handling, bounded resource use, cancellation, duplicate delivery, ambiguous completion, artifact provenance and portable replay for its declared capabilities. Mark unavailable capabilities explicitly; an adapter need not pretend to support every investigation method.

An agent tool is eligible only after demonstrating five things:

- input capture outside the model's control, through a hook or a terminal wrapper;
- one confined instance per engagement;
- host memory turned off;
- no write access to its own hooks or configuration;
- provider calls only through the provider broker, with no raw provider keys in the tool.

An execution sandbox is eligible only after demonstrating default-deny egress.

These checks supplement the [control and recovery scenarios](harness-evaluation.md#control-and-recovery-scenarios). Contract-version migration requires a preserved backup, validated conversion of references and dispositions, and a reversible or explicitly unsupported downgrade path. Migrating a record must not turn provisional analysis into accepted evidence or revive expired capabilities. No migration or runtime conformance check was executed in this specification repository.
