# DEC-008 Adversarial review dispositions

Status: **accepted for Q-014–020 and lab-record items L-01–L-02**. Date: **2026-10-12**. Decision owner: **lab operator**.

## Context

The operator requested an [adversarial design review](../research/adversarial-design-review.md) of the harness specification. The review registered eleven questions. The operator then went through the seven bearing on Q-008 in four rounds. Each question came with its options, trade-offs and a recommendation, and the operator selected one answer for each.

The review's findings remain research. Only the answers below are accepted.

Q-021–024 remain open, as do Q-025–026, which were registered after these answers, and Q-008, the overall architecture. The answers and the review's fixes within the existing direction were integrated into the specification documents on 2026-10-12.

## Accepted answers

| Question | Operator's answer | What it establishes | Versus recommendation |
|---|---|---|---|
| Q-014 Scenario-change enforcement | **“Agent self-report”** | DEC-007 stays as written: agents classify their own scenario and fixture changes, the challenger agent reviews setup powers, and the auditor sees them in the combined packet. There is no mechanical envelope or power ledger, so AR-01 is an accepted residual risk. FR-11's "consequential" is determined by that classification and the challenger review | Differs: mechanical check was recommended |
| Q-015 Default attacker charter | **“Broad, roles trusted”** | The default attacker is a permissionless EVM adversary, which the auditor narrows for each engagement. It may use multiple accounts and attacker contracts, flash-loan capital within real liquidity, transaction ordering within a block, timing around oracle updates within the feed's rules, griefing spend and any callback the protocol permits. Privileged roles are trusted unless the auditor raises them, and no automatic centralization review takes place | Partly: role review was recommended in addition |
| Q-016 Evidence bar | **“Full impact scaling”** | Two dispositions are added. `triaged_out` covers low potential impact: a one-line dismissal, listed in an appendix, making no assurance claim. `no_finding_within_bounds` records its bounds and is never a refutation. `rejected` requires decisive-evidence references. Rejecting an executable claim with potential High/Critical impact also requires a rerun against a disposable copy with the cited guard removed, and that rerun must show the violation; otherwise the result is `inconclusive`. Low/Info findings may be accepted on a code argument with anchors. Medium and above need a clean replay or DEC-004's alternative evidence | Follows |
| Q-017 Adjudication order | **“Evidence first”** | For potential High/Critical decisions, the packet shows the evidence, the challenger's verbatim counterargument and the evidence quality before the agent's proposed verdict. For every decision, the record states whether the rationale was agent-drafted and what the auditor changed | Follows |
| Q-018 Conversation channel and agent host | **“Reuse tool, capture input”** | The auditor keeps an existing agent tool for joint exploration. A hook or wrapper that the model cannot alter captures the auditor's typed input verbatim as human-authored records. Agent interpretations become intent or assumptions only after batched confirmation in a small trusted screen. The same screen renders the exact packet for approval and records the display. The agent tool runs confined per engagement, with its memory off | Follows the recommendation as refined during the walkthrough; the review had proposed a harness-owned surface |
| Q-019 Invalidation precision | **“Probes and tiers”** | Consequential conclusions record dependency probes that can be re-run: hashes of cited code, structural query results, and PoC and property reruns. After a change the controller assigns one of four tiers: `carried_forward_mechanical` (one attestation, listed in the report), `affected` (recheck), `possibly_affected` (flagged, not blocking) or `reaffirmed_by_human`. A bulk human reaffirmation is never recorded as individual review. This replaces the proposed conservative widening rule | Follows |
| Q-020 Build order | **“Walking skeleton”** | When the architecture is built, the first version is the smallest one that keeps the invariants: agents cannot write canonical records, approvals bind exact revisions, and receipts come from a trusted runner. It includes the Q-016–019 choices. It runs as one local process with one job at a time, Git-backed append-only records checked against schemas, hash-pinned evidence and process-group termination. Leases, fencing, idempotency stores, event cursors, migrations and remote workers are added only when an observed failure needs them. This is input to Q-008, not its acceptance | Follows |

## Lab-record dispositions

- **L-01: keep the revised wording.** The operator kept the revised sentence at `imports/README.md:11`: “Agents may structure semantics as appropriate, preserving original inputs and distinguishing source claims from design decisions.” This approves an edit made in the uncommitted tree during the 2026-10-02 session, which had no record. The original sentence, in initial commit `f122fb9`, was “Agents are allow to structure semantics as they see fit.”
- **L-02: dated corrections.** Dated correction notes are appended to the research records with stale statements, and their original text is preserved.

## Consequences and boundaries

- **Q-014 and Q-015.** Agents and the challenger remain the only detectors of semantic boundary crossings, as described in [K-008](../kb/claims/K-008-unenforced-semantic-gates.md); the operator accepted this risk. The broad default charter avoids interrupting the auditor for ordering, MEV and oracle-timing variants. "Privileged roles are trusted" is an adopted trust premise, so the report must list it in its assumptions section (AR-15).
- **Q-016** changes how DEC-004 applies. Its alternative-evidence exception now governs Medium and above, where a runnable PoC is impractical; Low/Info findings default to a code argument. DEC-004 is otherwise unchanged.
- **Q-017** amends DEC-007's packet for potential High/Critical decisions only. Packet completeness and verbatim challenger text still apply as specification fixes.
- **Q-018** puts conditions on the "existing agent interface" in the substrate recommendation. Input is captured outside the model, consequential interpretations are confirmed on the trusted screen, and the tool is confined per engagement. Whether a candidate tool supports out-of-model capture is to be checked during compatibility trials. If it does not, a terminal wrapper is the fallback.
- **Q-019** replaces the conservative widening rule proposed in the state contract. How completely the probes cover a conclusion's dependencies becomes a reported limit.
- **Q-020** reorders the proposed delivery sequence and FR priorities around a walking skeleton. Q-008 remains the decision on the architecture itself.

**Supersedes:** none. **Amends:** DEC-007's packet order for potential High/Critical decisions (Q-017) and DEC-004's application to Low/Info findings (Q-016). **Not decided:** Q-008, Q-021–026, numeric limits, and the selection of tools, providers, sandbox and agent host. **Affected records:** Q-014–020, the review, K-008, the handover and lab memory. The specification documents were updated in the coordinated pass of 2026-10-12.

**Acceptance evidence:** the operator's selections in four focused questionnaire rounds on 2026-10-12, quoted above as option labels. **Next action:** decide Q-021 before the record model is frozen, Q-024 before any pilot, and Q-025–026 when convenient, then Q-008. Prepare the implementer package: the v0 scope, record schemas and state tables, and the pilot numbers set by the operator.

**Later disposition:** later on 2026-10-12 the operator answered Q-021–026 and accepted Q-008 as amended, recorded in [DEC-009](DEC-009-architecture-acceptance-and-remaining-dispositions.md).
