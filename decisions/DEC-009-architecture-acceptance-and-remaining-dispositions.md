# DEC-009 Architecture acceptance and remaining review dispositions

Status: **accepted for Q-008 and Q-021–026**. Date: **2026-10-12**. Decision owner: **lab operator**.

## Context

[DEC-008](DEC-008-adversarial-review-dispositions.md)'s answers were integrated into the specification, which left seven questions open:

- Q-021–024, raised by the [adversarial design review](../research/adversarial-design-review.md#decisions-for-the-operator);
- Q-025–026, registered during the integration pass;
- Q-008, the overall architecture.

The operator asked for a walkthrough. Each question came with a one-sentence summary, a plain-language explanation, its options and a recommendation, and the operator decided the questions in four rounds. Q-008 came last, so that it was decided with the other answers known.

The review's findings remain research. Only the answers below are accepted.

## Accepted answers

| Question | Operator's answer | What it establishes | Versus recommendation |
|---|---|---|---|
| Q-021 The auditee as a party | **“Origin label only”** (option B) | Statements from the auditee keep the `auditee_statement` origin, and each finding keeps its history of client responses and severity changes. Both are already specified. Nothing else is added. There is no communications log. Documentation the auditee writes during the engagement is handled like other documentation under DEC-006's documentation-first rule. Known issues remain an intake input without a handling rule | Differs: option A was recommended |
| Q-022 Cross-engagement mechanism library | **“Public + your lessons”** (option A) | A curated library of vulnerability mechanisms, each with its counterconditions, is kept outside any single engagement. It draws on public material, such as published audit reports, post-mortems and standards. It also draws on lessons that the auditor strips of client details and transfers deliberately. Each transfer is an explicit record, and the auditor decides each one, including whether the client agreement allows it. Entries guide lead generation and carry no approval authority | Follows |
| Q-023 The auditor's independent first read | Free text: **“I like option A but I want to market as an optional pre-step. If I want to provide input I will do it if not I can review what the agents find.”** | Option A, with the capture made optional. Before the walkthrough of a flow's implemented behavior, the auditor may record expectations: what should happen and what must never happen. This is never required, including for critical flows. If the auditor skips it, they review what the agents found. Intent recorded after the auditor has seen the agents' account of the implementation is tagged as such. A comparison that relies on that intent shows the tag. An optional mode lets the auditor read first while the knowledge base builds in the background. The tag is kept from option A: this reading was stated to the operator in the next round with an invitation to object, and the operator raised no objection | Partly: option A was recommended, with capture required for designated critical flows |
| Q-024 Method-improvement adoption gate | **“Current comparison”** (option B) | A workflow, prompt or retrieval change is adopted after the evaluation plan's existing comparison. The change is tried on development cases, then compared on held-out cases for useful outcomes and review burden. Known-defect recall is measured against reviewed reference defects, stochastic models get several runs, and the change can be rolled back. Nothing else is added: no hidden seeded-fault gate per vulnerability class, no sampled re-investigation of rejections, no automatic flag on narrowing changes and no pre-registered kill criteria | Differs: option A was recommended |
| Q-025 Urgent disclosure path | **“No urgent path”** (option B) | The full frozen export through `approve_export` remains the only release path. A credible urgent concern prompts the auditor's attention with its evidence and known limits, and any urgent contact with the client happens outside the harness | Differs: option A was recommended |
| Q-026 Cross-guarantee follow-ups within a batch | **“Follow inside batch”** (option A) | A follow-up may touch a different guarantee and still stay inside the current batch, provided it needs no new capability, permission, budget, attacker power or scope. It is recorded as a scenario variant linked to that guarantee and uses the parent investigation's allowance. It appears in the review packet. A follow-up that needs any of those, or that changes the meaning of a guarantee or check oracle, still returns to `authorize_work` | Follows |
| Q-008 Primary harness architecture | **“Accept as amended”** | DEC-003's evidence workbench is accepted as the architecture of the first harness, as amended by DEC-008 and the answers above | Follows |

Option labels are quoted without their “(Recommended)” suffix.

## Consequences and boundaries

**What Q-008 accepts.** It accepts the architecture in DEC-003 and the [proposal](../design/audit-harness.md), as amended, with the specification documents as the baseline for the implementer package:

- One auditor steers, and agents propose and carry out work.
- A deterministic controller enforces authority, runs jobs and keeps the canonical record. Agents cannot write canonical records.
- Approvals bind exact revisions.
- Evidence is hash-pinned, and receipts come from a trusted runner.
- Hypothesis, property and scenario investigations share versioned records.
- A finding is established by tool evidence, a fresh challenge and a human disposition. Proof status stays separate from impact.
- Context is typed knowledge with role-specific snapshots, and contradictions are retained.
- Tools are added when an investigation justifies them.
- The first build is DEC-008's walking skeleton. Its records are Git-backed and append-only, and a transactional store is a [deferred mechanism](../design/harness-state-and-execution.md#deferred-mechanisms).

**What it does not accept.** Numeric limits remain pilot settings for the operator. The store, runner or engine, model provider, sandbox technology and agent host are still to be selected, after compatibility and recovery trials. Acceptance does not start implementation, which this lab does not do.

**Accepted residual risks.** Q-021 and Q-024 decline mitigations the review proposed. Under the glossary's rule for [accepted residual risks](../design/harness-glossary.md#terms), each is stated in the specification's limits and evaluated, not silently fixed:

- **Q-021.** Documentation the auditee writes during the engagement can mirror the code, so a comparison finds no discrepancy. A real bug filed as a known issue may go uninvestigated. Contact with the auditee that preceded a disposition change leaves no record. AR-10's other fixes remain.
- **Q-024.** A method change that narrows checks can raise precision and lower review burden while it misses a class of bugs that the held-out cases do not contain. False rejections in live engagements are not measured. AR-28's other fixes remain: repeated runs, and capture of commands the auditor runs.

**Q-025 sets a boundary.** Urgent disclosure stays outside the harness, which does not record what was disclosed urgently, when, or to whom. The egress and disclosure fixes from AR-11 remain.

**Q-026 amends DEC-007.** DEC-007's acceptance "does not authorize a new question". A cross-guarantee follow-up within the existing bounds is now a linked variant rather than a new question. Agents still may not widen powers, permissions, budget, scope or meaning. The glossary's child-task definition and the loop register's routing rule change accordingly.

**Q-023 amends a detail of the DEC-005/006 interaction.** The joint walkthrough remains the default. The optional pre-step and the tag apply DEC-006's caution about code-derived design to human intent formed after exposure to the implementation.

**Q-022 keeps engagement isolation.** FR-24's isolation holds. The library is the only sanctioned channel for reusable knowledge between engagements; bundle import keeps its own `choose_import_destination` decision. Only curated public entries and the auditor's recorded transfers enter the library. How public entries are admitted is left to the integration pass.

**Supersedes:** none. **Amends:**

- DEC-003's status, from proposed to accepted as amended (Q-008);
- DEC-007's routing of cross-guarantee follow-ups (Q-026);
- the DEC-005/006 interaction detail for capturing intent (Q-023).

**Not decided:**

- numeric limits;
- the selection of tools, providers, sandbox and agent host;
- the judgment calls listed in the [handover](../memory/session.md) from the integration pass, which the operator confirmed later the same day (see below).

**Affected records:** Q-008, Q-021–026, DEC-003, DEC-005, DEC-006 and DEC-007 (which carry amendment notes), the review's disposition section, the handover and lab memory. A second coordinated pass integrated these answers into the specification documents on 2026-10-12.

**Acceptance evidence:** the operator's selections in four questionnaire rounds on 2026-10-12, quoted above. Q-023's answer is free text. **Next action:** prepare the implementer package: the first build's scope with acceptance checks, record schemas and state tables, and pilot numbers set by the operator.

**Integration note, 2026-10-12.** The integration pass settled the details this record left open. Public library entries are admitted through the same `record_transfer` decision as lessons. A lesson's transfer record stays in its source engagement, and the library entry carries only an opaque transfer reference. The tag of Q-023 is the [intent timing](../design/harness-glossary.md#terms), `before_walkthrough` or `after_walkthrough`, which the controller derives from capture times and the first recorded presentation of the unit's implemented behavior. Library decisions about public entries, revisions and retirements are made in a library scope. Each linked claim is recorded on its investigation with its own potential impact and disposition. A consistency review then raised whether a linked variant may enter a flow without a `record_flow_review` decision; that was registered as Q-027, and the operator chose option B in [DEC-010](DEC-010-linked-variants-into-unreviewed-flows.md): such a follow-up proceeds, and the packet flags it. A claim supported by a linked variant is disposed of separately in the same review. Each accepted residual risk has an evaluation scenario.

**Operator confirmation, 2026-10-12.** After both integration passes, the operator confirmed the judgment calls listed in the [handover](../memory/session.md) for the DEC-008 and DEC-009 passes: “Confirmed, commit all.” They are now accepted details of the baseline rather than proposals.
