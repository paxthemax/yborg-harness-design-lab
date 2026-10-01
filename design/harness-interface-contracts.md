# Harness component and artifact contracts

Status: **proposed**, 2026-10-01. This document completes the component boundaries in the [architecture](audit-harness.md) and [state specification](harness-state-and-execution.md). It specifies observable behavior independently of programming language, transport, database, agent host or workflow engine. Operation names below are design vocabulary, not an implemented API or CLI.

## Contract conventions

The controller is authoritative for record IDs, revisions, grants and state transitions. A reference consists of an engagement ID, record ID and exact positive integer revision; references nested in a single-engagement request inherit its engagement ID unless explicitly qualified. A cross-engagement reference never grants access by itself. An artifact reference names its content hash and hash algorithm. An ID without a revision may be used to find the current record, but cannot bind an approval or execution input. Artifact hashes identify bytes, not the truth of their contents.

Each request carries a supported contract version, a producer-generated request ID, the engagement, operation, expected record revisions and typed payload. Worker requests additionally carry a controller-issued grant and attempt identity. The authenticated caller is established by the channel and checked against those references; an `actor` field supplied in a payload cannot confer authority. Human and worker channels remain separate under the [write protocol](harness-state-and-execution.md#write-and-approval-protocol).

Every mutating request has an idempotency key scoped to its engagement, authenticated principal and operation. The controller retains the key, a digest of the normalized request, and the committed result. Repeating the same request returns that result; changing its contents under the same key returns a conflict. A retry acknowledgement refers to the historical commit and also identifies whether relevant state has since changed. It does not renew a grant or make an old decision current. Store idempotency records for at least the supported retry/recovery lifetime; expired keys cannot be reused to bypass reconciliation.

An implementation publishes the serialization and hashing rules for each contract version. Dependency digests are hashes of controller-built, stored manifests of exact references; callers cannot supply an arbitrary digest instead of those references. Unknown contract versions and unsupported permission-bearing fields are rejected. Optional extensions must be namespaced, explicitly advertised and incapable of granting authority. Unknown values use a reason and status, rather than an empty string that appears complete.

## Controller operations

All writes pass the same engagement, permission, revision and budget checks. A committed response means that the requested record transition is durable; it does not mean that queued work ran successfully or that an investigation is valid.

| Operation | Allowed caller and required input | Observable result and important refusal |
|---|---|---|
| `read_snapshot` | Auditor or worker with read grant; exact snapshot or requested current view; filters and page limit | Records with revisions, applicability and provenance; a worker cannot widen its authorized engagement, context or visibility through filters |
| `submit_proposal` | Auditor or authorized worker; base references, proposed statement/question/investigation, anchors and dependencies | Attributed provisional record or revision conflict; cannot create an accepted finding, semantic approval or policy change |
| `prepare_batch` | Auditor or planning worker; questions, methods, estimates, dependencies and requested capabilities | Reviewable proposal and identified gaps; no executable grant |
| `authorize_batch` | Authenticated auditor; reviewed batch/model revisions, finite resource limits, approved tool/provider policies and rationale | Versioned authorization; refuse unresolved mandatory policy fields or changed review inputs |
| `request_job` | Controller scheduler or authorized worker; admitted question, input/context references, adapter operation and limits | Reserved resources and queued logical job; refuse a new question, unsupported capability, exhausted budget or stale authorization |
| `submit_artifacts` | Trusted broker for an identified attempt; staged files, supervisor receipt and result interpretation kept separate | Hash-checked artifact records after durable staging; incomplete or untrusted receipts remain ineligible |
| `submit_review_packet` | Auditor or authorized worker; investigation revision and supporting/refuting artifacts | Ready-for-review packet, including explicit insufficiency when necessary; packet readiness grants no acceptance |
| `record_decision` | Authenticated auditor; exact reviewed packet/dependency references, disposition, evidence route, rationale and severity basis when applicable | Human decision and new applicability; refuse stale inputs, unmet evidence policy or an agent channel |
| `revise_premise` | Auditor for reviewed intent/assumptions; workers may propose revisions through `submit_proposal` | New premise revision, affected-work list and stale applicability; preserve previous evidence and decisions |
| `pause`, `cancel`, `resume` | Auditor within the engagement; controller may enforce an automatic budget/policy stop | Recorded control transition and worker reconciliation status; resumption needs current inputs and grants |
| `prepare_export` | Auditor or reporting worker with read access; frozen record selection and proposed audience/redaction policy | Local preview and immutable content manifest; no release or new acceptance |
| `approve_export` | Authenticated auditor; preview/content identity, audience and permitted destination | Release authorization bound to those exact bytes and scope; changing content or destination requires renewed review |
| `export_bundle` | Controller acting on that authorization | Local artifact and export receipt, or an explicit failure; an external transfer requires its own authorized destination/action |

Operational events have a monotonic sequence within each engagement. A subscriber resumes from its last acknowledged cursor; duplicated events are possible and are deduplicated by event ID. A cursor older than retained event history yields `snapshot_required`, followed by a consistent snapshot and new cursor. Consumers cannot reconstruct current authorization from an incomplete event stream. Command acceptance, dispatch, execution completion, evidence eligibility and human disposition are different events.

## Agent and tool adapter boundary

Before dispatch, an adapter advertises its adapter/contract version, immutable executable or image identity where available, supported ecosystem and tool modes, input/output types, limits, dependencies, required filesystem/network capabilities, cancellation behavior, and recovery/replay support. A capability description supplied by a tool is untrusted until registered by the operator's integration policy. Repository files cannot register adapters or modify their grants.

The controller selects a compatible adapter and records that exact descriptor with the job. No compatible version means `unsupported`, with affected audit units and alternatives returned for review. Falling back to a different model, compiler, analysis mode, endpoint or tool requires policy compatibility and a new attempt/context record. It must never happen invisibly inside a receipt.

| Boundary | Input | Output and invariant |
|---|---|---|
| Controller to agent | Role profile, question, versioned context manifest, tool grant, resource envelope and stop conditions | Typed proposals, requests, blockers and concise reasoning summaries; no direct canonical-store writes or child-agent authority |
| Controller to tool broker | Registered operation, structured arguments, read snapshot, scratch location, limits, attempt and grant | Broker verifies paths/arguments and launches the fixed adapter outside the controller's record directory |
| Sandbox to receipt collector | Bounded raw streams, artifacts and observed process state | Collector supplies supervisor-derived launch/exit metadata and hashes; guest claims remain untrusted interpretation |
| Context builder to provider broker | Authorized context references, data classes, selected provider/model policy and output limit | Broker resolves approved bytes, checks current egress grant, records payload identity and returned model identity, and accounts for actual or uncertain cost |
| Local fork to RPC gateway | Approved endpoint, chain/block identity, method and parameters | Bounded permitted read response with provenance; deny live writes, redirects and unapproved fallback endpoints |
| Curator to memory interface | Attributed lesson, sources, applicability, counterconditions and review status | Engagement-local provisional lesson; cross-engagement transfer and policy changes require explicit human disposition |

Agents request provider calls using authorized context references. Arbitrary additional text or attachments must be classified and admitted by the context builder under the engagement policy before egress. A domain allowlist alone is insufficient. Provider credentials, infrastructure credentials and host secrets cannot be resolved as context references.

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
| `worker_unreachable` / `stop_unconfirmed` | Fence writes and retain the last known state; confirm termination before admitting a replacement that could exceed limits |
| `snapshot_required` | The event cursor is unusable; reload a consistent snapshot before acting on event-derived state |

Once external execution has been requested, a transport failure cannot truthfully promise that nothing happened. Its response distinguishes the controller's committed state from external execution certainty. A completed operation whose response was lost is recovered through its idempotency record, logical job and attempt receipts. A client must not invent a new logical job merely because polling timed out.

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
    "disposition": "rejected",
    "rationale": "The reviewed guard prevents this specific callback path.",
    "decisive_evidence": [
      {"record_id": "example-guard-evidence", "revision": 1}
    ],
    "applicability": "The reviewed target and premises only."
  }
}
```

If that guard changes before commit, the response is `stale_dependency`; there is no new rejection decision. If it changes after commit, retain the historical rejection and mark its current applicability stale. If the same request is delivered twice, it creates one decision. Evidence explaining a rejection does not need an acceptance evidence route; an accepted decision additionally supplies either executable confirmation or the documented alternative-evidence justification required by [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md).

## Portable report and PoC package

The minimum export contains a versioned content manifest, readable report, selected record revisions and decision rationale, artifact inventory, environment/tool description, reproduction instructions where applicable, and explicit missing/redacted material. A proposed layout is:

```text
export/
  README.md                 scope, contents, limitations and inspection steps
  manifest.json             immutable payload inventory and exact record references
  report.md                 approved findings, unresolved exposure and coverage limits
  records/                  portable structured records and dependency references
  artifacts/                immutable evidence files addressed by content hash
  reproduction/             separate fixtures and environment/command descriptions
  release-receipt.json      payload identity, human approval and export outcome
```

Filenames are illustrative; the contract is that a recipient can locate and verify each required item without the original conversation, provider or agent host. The manifest names schema version, engagement/snapshot identity, record revisions, artifact paths and hashes, evidence routes, required tools, redactions, missing dependencies and limits. Relative paths stay inside the bundle. Imported record IDs are scoped to their original engagement and cannot acquire authority in a new one.

Freeze the content manifest and report before approval. The human decision binds their payload identity, intended audience and destination. The release receipt then references that approval and payload; it is outside the hashed payload to avoid a self-referential approval/hash cycle. A new redaction, evidence update or audience change creates a new preview and authorization. The recipient checks the payload hashes and decision references; a checksum is not a signature or proof of authenticity. No public signing infrastructure is selected by this proposal.

Each executable PoC identifies original target bytes separately from fixtures, tool/dependency versions, working directory, structured command arguments, required secret placeholders, expected observation, observed trace, clean-replay receipt, and all setup powers. Forked cases include chain/block identity and archive requirements. Instructions warn through concrete prerequisites when a package cannot currently replay; no missing secret or archive data is replaced by a silent mock. Alternative-evidence findings include the reviewed argument, why execution was impractical and what remains untested instead of fabricating a reproduction command.

Restore/import parses metadata and verifies artifacts in quarantine with execution disabled. Bundle contents cannot install tooling, authorize a provider, restore an active worker capability or publish a report. After validation, an auditor explicitly chooses the destination engagement and whether imported conclusions remain historical reference material or need revalidation. Backup restoration follows the stronger [consistent snapshot and recovery contract](harness-state-and-execution.md#permissions-and-isolation).

## Compatibility and conformance

An adapter or host integration is eligible only after demonstrating scoped reads/writes, denied capability expansion, unsupported-mode handling, bounded resource use, cancellation, duplicate delivery, ambiguous completion, artifact provenance and portable replay for its declared capabilities. Mark unavailable capabilities explicitly; an adapter need not pretend to support every investigation method.

These checks supplement the [control and recovery scenarios](harness-evaluation.md#control-and-recovery-scenarios). Contract-version migration requires a preserved backup, validated conversion of references and dispositions, and a reversible or explicitly unsupported downgrade path. Migrating a record must not turn provisional analysis into accepted evidence or revive expired capabilities. No migration or runtime conformance check was executed in this specification repository.
