# DEC-003 Harness architecture proposal

Status: **accepted as amended** on 2026-10-12 in [DEC-009](DEC-009-architecture-acceptance-and-remaining-dispositions.md); proposed 2026-10-01. Decision owner: **lab operator**. This record proposed the architecture; the narrower choices in [DEC-002](DEC-002-harness-operating-envelope.md) and [DEC-004](DEC-004-confirmation-evidence-policy.md) had already been accepted. The sections below are preserved as proposed, and the amendments are in [DEC-008](DEC-008-adversarial-review-dispositions.md) and DEC-009.

## Decision to consider

Use a persistent evidence workbench for one human auditor, with hypothesis, property and scenario investigations sharing an enforceable controller, versioned semantic records and immutable evidence. [The specification](../design/audit-harness.md) makes the recommendation concrete. [The sprint research](../research/harness-design-sprint.md) preserves source observations and rationale.

## Alternatives and recommendation

| Design choice | Recommendation | Alternatives and trade-off |
|---|---|---|
| Primary workflow | Evidence workbench with three investigation methods | Property-first improves reusable specifications but costs setup effort; scenario-first suits composition risks but needs strong feasibility models |
| Control | Deterministic controller with agents proposing actions | Prompt-only orchestration is smaller but cannot enforce authority; a distributed agent planner introduces coordination and recovery complexity |
| Persistence | Transactional metadata with immutable file artifacts and portable exports | Files-only can support a narrow single-writer prototype; a graph/distributed database adds cost before query needs are established |
| Job execution | Local runner contract; evaluate a small runner and LangGraph before choosing | Temporal offers durable workflow primitives with a larger operational footprint; none removes the need for application permission checks |
| Context | Typed knowledge plus role-specific snapshots and retained contradictions | A shared mutable summary is easier to write but can spread mistaken premises and erase disagreement |
| Verification | Tool evidence, fresh challenge and human disposition; proof status separate from impact | Model voting can surface disagreement but cannot establish truth |
| Initial expansion | Add tools when an investigation justifies them | Mandatory use of every scanner/fuzzer increases setup and review cost without demonstrated added contribution |

## Consequences

This design puts effort into evidence and control before broad parallelism. It retains negative results and makes changed assumptions costly in a visible way: affected conclusions must be reconsidered. The records can improve continuity but can also become bureaucratic overhead. The pilot must measure whether their value exceeds maintenance and triage costs.

Suggested numeric limits, database choice, runner choice and sandbox technology remain proposals. The architecture can be reviewed without choosing every vendor or implementation library. Approved cloud processing is a design envelope, not authorization for arbitrary transfers of client data.

The [component contracts](../design/harness-interface-contracts.md) and [auditor guide](../design/harness-auditor-guide.md) complete the proposed integration and operating behavior. They define transport-independent operations, adapter/error handling, portable evidence packages and decision flows without selecting a vendor or claiming implementation. Completing these documents does not change this decision's proposed status.

## Disposition and next action

- **Accepted architecture:** the evidence workbench, as amended by DEC-008 and DEC-009. As amended, persistence starts as Git-backed append-only records with schema validation, and a transactional store is a deferred mechanism (DEC-008, Q-020).
- **Recommendation author:** Codex, based on the recorded research and operator constraints.
- **Operator decision/date:** “Accept as amended”, 2026-10-12, recorded in DEC-009 with what acceptance covers and excludes.
- **Related questions:** Q-007 resolved in DEC-004 for alternative evidence policy; Q-008 was resolved in DEC-009 on 2026-10-12. Q-014–020, resolved in [DEC-008](DEC-008-adversarial-review-dispositions.md) on 2026-10-12, set constraints the architecture incorporated before Q-008 was decided: agent self-report for scenario changes, a broad default attacker, impact-scaled dispositions, evidence-first packets, captured human input, dependency probes and a walking-skeleton build order.
- **Supersedes:** none. DEC-001 remains the accepted lab memory policy; DEC-002 remains the accepted harness operating envelope.
- **Next action:** prepare the implementer package; DEC-009 is integrated into the specification documents. Runtime framework/tool selection follows compatibility and recovery trials if implementation is later authorized.
