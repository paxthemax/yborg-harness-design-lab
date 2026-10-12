# DEC-007 Human and agent work within an approved batch

Status: **accepted for Q-012–013**. Date: **2026-10-02**. Decision owner: **lab operator**.

## Context

The operator imported two flow diagrams and requested analysis of the human/agent boundary, explicit loop labels, triage of issues and an HTML diagram with a PNG export. [The review](../research/flow-diagram-review.md) preserves their observations and dispositions. The diagrams are references, not instructions or accepted architectures.

Existing decisions already establish small human-approved batches (DEC-002), human evidence acceptance and an alternative-evidence route (DEC-004), repeated joint comprehension (DEC-005), and distinct DESIGNED/IMPLEMENTED views (DEC-006). Two remaining interaction choices were presented separately.

## Q-012 — Scenario authorship

**Accepted answer:** “Approve the investigation questions and constraints; let agents draft and test the scenarios, then review their evidence”.

The alternative was to require the auditor to jointly frame each scenario's attack sequence and success condition before agent refinement and execution. That was the initial recommendation; the operator selected greater agent autonomy within the approved batch.

The auditor approves the investigation question and its constraints: relevant guarantee, attacker capabilities, scope, permissions, budget and stop conditions. Agents may draft causal attack sequences, derive checks from those premises, vary permitted inputs/orderings, trace, test, challenge and refine without a separate human authoring checkpoint for each scenario. The auditor can contribute a manual scenario at any time; doing so is optional.

This does not authorize a new question, expanded attacker powers, changed guarantee/oracle meaning, new permissions or additional spend. A consequential missing premise or boundary change returns as one focused question. Drafting a check against an established meaning differs from deciding a new meaning. The resulting evidence and adequacy still require human review before a finding is accepted.

## Q-013 — Testing review cadence

**Accepted answer:** “Review one combined packet after testing and agent challenge; interrupt earlier for consequential questions (Recommended)”.

The alternative was the hybrid import's separate mandatory human testing review before the agent challenge. The accepted choice reduces routine handoffs and lets the auditor examine supporting evidence and the strongest counterargument together.

Agents prepare tests and evidence, challenge the claim and prerequisites, inspect fixture adequacy, and arrange clean replay when executable confirmation is sought. The auditor then reviews one combined packet containing the claim, test/scenario meaning, supporting and refuting evidence, execution receipts, limitations, impact and a proposed disposition. The auditor may inspect intermediate work on demand. Consequential questions interrupt earlier; the batch is not required to finish before a blocking question is raised.

## Consequences and boundaries

- Human work concentrates on scope, shared understanding, meaningful constraints, batch selection, consequential questions, evidence adjudication, final severity and release.
- Agent work covers candidate generation and bounded investigation iterations, including negative evidence and unresolved results. Agents do not accept or reject a finding on the auditor's behalf.
- The deterministic harness enforces grants, revisions and limits and records execution. These receipts establish what ran; the auditor assesses applicability and meaning.
- The [workflow and loop register](../design/harness-workflow-loops.md) elaborates these choices. Loop IDs and presentation are a design synthesis; exact iteration limits remain engagement/batch settings.

**Supersedes:** the two competing interaction options in this review; no earlier accepted decision is superseded. **Not decided:** overall architecture Q-008, runtime/vendor choices or fixed numeric budgets. No implementation is authorized by this process decision.

**Later amendments, 2026-10-12:** [DEC-008](DEC-008-adversarial-review-dispositions.md) (Q-017) puts the evidence and the challenger's verbatim counterargument before the proposed disposition in packets for potential High/Critical decisions. [DEC-009](DEC-009-architecture-acceptance-and-remaining-dispositions.md) (Q-026) keeps a follow-up into another guarantee that needs nothing new, and changes no meaning, inside the batch as a linked variant, rather than treating it as a new question. DEC-009 also accepted the overall architecture as amended (Q-008).
