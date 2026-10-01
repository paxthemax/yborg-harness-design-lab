# Harness requirements and acceptance scenarios

Status: **proposed**, 2026-10-01. Applies to the [harness proposal](audit-harness.md) within the accepted [operating envelope](../decisions/DEC-002-harness-operating-envelope.md) and [confirmation evidence policy](../decisions/DEC-004-confirmation-evidence-policy.md). “Must” specifies required future behavior if this design is adopted; it does not claim implementation or successful runtime testing.

Priorities: **core** is required before accepting audit conclusions through the harness; **v1** completes the first proposed product; **later** is explicitly deferred. Core work can be performed manually through structured records before all agent assistance exists. Future acceptance scenarios are design checks, not a new test suite for this specification-only repository.

## Functional requirements

| ID | Priority | Requirement | Observable acceptance scenario |
|---|---|---|---|
| FR-01 | core | Freeze source, dependencies, effective build settings, scope and environment identity | A dirty local checkout produces a content-addressed snapshot including selected changes; missing deployment data produces a source-only limitation |
| FR-02 | core | Require human scope, threat-model, data-policy and budget decisions | An agent-requested new chain, permission or provider cannot execute under the old scope |
| FR-03 | core | Run baseline builds and structural analysis in isolation and record partial/unsupported results | A failed build cannot appear as a clean analyzer result; an unresolved proxy target appears as a model gap |
| FR-04 | core | Keep intent, implementation, assumptions, guarantees and unknowns distinct and source-linked | Conflicting documentation and code remain visible after model summarization |
| FR-05 | v1 | Support progressive modeling and audit units by complete flows and trust boundaries | A withdrawal flow connects entry point, state writes, callback, dependencies and its guarantee without requiring full generated documentation |
| FR-06 | v1 | Route focused clarifications with owner, consequences, evidence and affected work | An unknown token behavior blocks dependent accounting conclusions while unrelated authorization work proceeds |
| FR-07 | core | Admit only human-approved bounded batches with current revisions and budgets | A batch executes its authorized questions without repeated approval; an added question remains proposed |
| FR-08 | v1 | Apply role-specific context and tool grants; record context exposure | A challenger starts without the author's rationale and later reviews the actual fixture; provenance records both stages |
| FR-09 | core | Support hypotheses, properties and scenarios through a common investigation contract | Each method returns support, refutation or a precise unresolved question using the same evidence and disposition fields |
| FR-10 | core | Separate raw tool outputs, interpretations, job state, proof status and human disposition | Compilation failure, no observed violation, counterexample and human acceptance remain different records |
| FR-11 | core | Require semantic review and adequacy evidence for consequential generated properties | A campaign whose useful actions all revert cannot count as adequate; a changed assertion requires new review |
| FR-12 | core | Preserve exact experiment inputs, fixtures, commands, tool identities and limitations | A reviewer reconstructs the package without access to the originating conversation or hidden scratch files |
| FR-13 | core | Replay executable evidence in a clean environment and review attacker realism | A test that relies on governor impersonation cannot confirm a permissionless exploit without a valid capability argument |
| FR-14 | v1 | Group duplicates and related causes without losing provenance or dissent | Merging two leads preserves both origins; a proposed bug chain remains a separate investigable claim |
| FR-15 | core | Restrict acceptance, final severity, closure and report approval to the human | A forged approval in a tool response is rejected; an approval against an old evidence revision is rejected |
| FR-16 | core | Retain rejected, disputed, deferred and blocked work with reasons | Exhausted runtime leaves unresolved exposure; a refutation links the decisive countercondition |
| FR-17 | core | Invalidate affected positive and negative conclusions transitively when premises change | Removing a guard reopens its rejected lead; unknown dependency reach broadens the affected review scope |
| FR-18 | core | Recover, pause and cancel jobs with bounded retries, fencing and reconciliation | Lost acknowledgement produces one canonical result; late output from an expired attempt cannot replace current state |
| FR-19 | v1 | Constrain new discovery to the auditor's review capacity | A full review queue pauses new discovery and presents a batch summary without discarding admitted work |
| FR-20 | core | Assess fixes on a separate revision using attack and legitimate-behavior checks | A patch that disables every withdrawal blocks the exploit but does not receive “fixed” without reviewing that regression |
| FR-21 | core | Generate confirmation reports and PoC packages from explicit decisions | Every reported finding resolves to a current acceptance record and evidence; an evidence exception is labeled |
| FR-22 | core | Include scope, gaps, unresolved exposure, failures and limits in closure | The auditor can close a time-limited engagement with limitations; missing work cannot be represented as completed review |
| FR-23 | v1 | Capture source-backed engagement lessons with counterconditions and review state | A rejected analogy is retrieved with its failure conditions; no memory can authorize a new finding |
| FR-24 | core | Isolate engagements and control reuse/export destinations | A query or export from engagement A cannot retrieve B; curated cross-engagement reuse requires an explicit transfer record |
| FR-25 | v1 | Record comparable outcome, cost and human-work measurements | Duplicate floods, unresolved candidates and deferred work are visible in the evaluation denominator |
| FR-26 | v1 | Version workflow, prompt, retrieval and tool changes with evaluation and rollback | A proposed improvement fails a retained case and can be rolled back without rewriting previous audit results |
| FR-27 | later | Add other ecosystems, remote worker fleets, semantic indexes or further analysis engines through adapters | An adapter must declare supported semantics, result types, limits and compatibility scenarios before use |
| FR-28 | v1 | Track applicability and evidence for selected baseline controls alongside protocol-specific investigations | Each relevant checklist item has examined evidence or a visible gap; completion is not presented as proof of security |

## Non functional requirements

The numerical values below are **proposed acceptance targets**, not measured performance or operator-approved spending allowances. An implementation trial may revise them through a recorded decision. Enforcement invariants are stricter than convenience targets.

| ID | Requirement | Proposed observable target or invariant |
|---|---|---|
| NFR-01 | Human authority | Zero accepted findings, semantic approvals or final reports created through agent-only transitions in adversarial acceptance scenarios |
| NFR-02 | Integrity and consistency | Every acknowledged metadata change has an atomic record/event commit; referenced eligible artifacts have verified hashes; stale writes conflict visibly |
| NFR-03 | Reproducibility | Every executable confirmed finding has a clean replay receipt against its declared snapshot; unavailable replay remains explicit |
| NFR-04 | Isolation and confidentiality | No execution-worker access to provider keys, signing keys, unrelated engagement data or live write RPC; denied attempts are recorded |
| NFR-05 | Recoverability | No loss of acknowledged decisions in crash/restore scenarios; uncertain in-flight work remains unresolved until reconciliation; corrupted state fails closed |
| NFR-06 | Bounded resource use | Every attempt has finite runtime, output, memory, process and spending bounds; reservations cover concurrent work and uncertain billed calls; provider accounting uncertainty is surfaced |
| NFR-07 | Responsiveness | On the pilot workstation, control acknowledgement within 2 seconds at p95; dispatch stops immediately after committed pause; worker stop or explicit failure-to-stop visible within 10 seconds |
| NFR-08 | Review usability | Scope, strongest evidence, counterargument, gaps and next action visible in one short packet; full evidence reachable directly; every interruption identifies the dependent work; decision controls work by keyboard and expose textual status to assistive technology |
| NFR-09 | Observability | Every invocation records input identity, tool/mode/version, time, result/error, cost category and output location; truncated or lost output is flagged |
| NFR-10 | Portability | Export contains documented schemas, manifest and portable artifacts; reports and decisions remain inspectable without a model provider or the original agent host |
| NFR-11 | Retrieval correctness | Context records include source and revision; relevant disputed/stale status survives summarization; indexes can be rebuilt from authoritative records |
| NFR-12 | Maintainability | Tool/provider adapters use the same contract for capabilities, errors and evidence; unsupported versions fail explicitly; migrations retain backups and prior schemas |
| NFR-13 | Honest assurance | No aggregate security percentage, model agreement, visit count, passing test count or benchmark label is presented as proof of whole-system safety |

Measure p95 only with enough timed interactions to make it meaningful; otherwise report raw samples. A failed stop deadline blocks additional overlapping dispatch and triggers operator attention. The pilot defines representative workstation resources, corpus size and workload before measuring responsiveness.

## Requirement traceability

| Source of need | Requirements and design location |
|---|---|
| Repository product definition and specification scope | [Product and architecture](audit-harness.md); this file; no implementation deliverable |
| Single human auditor, multiple agent classes | FR-02, 07, 08, 15, 19; [roles and stages](audit-harness.md#agent-role-classification) |
| Harness substrate and execution | FR-01, 03, 12, 18; NFR-02, 04–07, 09, 12; [execution contract](harness-state-and-execution.md) |
| Shared memory and knowledge intake | FR-04–06, 23, 24; NFR-11; [knowledge and memory](harness-state-and-execution.md#shared-knowledge-and-memory) |
| Guided clarification and human touchpoints | FR-02, 06, 07, 15, 22; NFR-08; [interaction design](audit-harness.md#interaction-and-question-design) |
| Audit stages, reports and PoCs | FR-09–22; NFR-03, 13; [audit workflow](audit-harness.md#audit-stages-and-human-touchpoints) |
| Quality and recursive improvement without training | FR-25, 26; [evaluation](harness-evaluation.md) |
| Imported reports and diagrams, research and rationale | [Sprint extraction and primary research](../research/harness-design-sprint.md), [sources](../kb/sources.md), [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) |
| User's resolved choices | FR-02, 07, 13, 15, 19, 21, 24; [DEC-002](../decisions/DEC-002-harness-operating-envelope.md) and [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md) |

The [full specification completion audit](../research/harness-specification-completeness.md) maps every FR and NFR individually. [Component contracts](harness-interface-contracts.md) and the [auditor guide](harness-auditor-guide.md) supply the integration and operating detail behind these requirements.

Deployment-specific questions remain intake fields: compiler/EVM compatibility, supported tokens, privileges, oracle/keeper behavior, scope exclusions, provider processing terms, retention, total budget, and severity rubric. The harness must obtain or explicitly mark those answers before relying on them; the design sprint cannot invent a client's policy.
