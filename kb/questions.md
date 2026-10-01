# Design questions and answers

Q-001–003 were resolved by the **lab operator** on **2026-10-01** in **DEC-001**. Q-004–006 were resolved in **DEC-002** and Q-007 in **DEC-004** during the harness design sprint. Q-008 remains proposed. Recommendations remain distinct from accepted choices.

## Q-001 — Store placement and sharing

**Status:** resolved by the lab operator on 2026-10-01; recorded in DEC-001.

**Selected:** keep the PLUR store at `memory/plur/` in this repository, isolated from other projects, with no automatic sharing.

Should the dedicated lab store live in this repository or in a separate local directory? A personal shared store is a third option if cross-project context is deliberately wanted.

**Recommendation:** the materialized `memory/plur/` directory, opened explicitly and isolated from other stores. It is easy to inspect alongside the documents. Separate local storage reduces repository churn and permits a distinct backup policy, but makes shared continuity less direct.

**Next action:** retain the existing store path and isolation settings. Any future sharing destination requires a separate operator decision. No remote is configured.

## Q-002 — Review and promotion

**Status:** resolved by the lab operator on 2026-10-01; recorded in DEC-001.

**Selected:** allow automatic learning and periodically review or correct memories. Consequential design decisions remain human-owned.

Should new reusable guidance require review before injection, or should PLUR learn automatically with periodic correction?

**Initial recommendation:** start with grounded drafts and review before injection. The operator selected automatic learning instead, accepting that memories may guide work before review. Grounding, uncertainty labels, and periodic correction remain part of the selected workflow.

**Trade-off:** automatic learning reduces review friction and can propagate an inaccurate memory until corrected. Memory activation does not establish source truth or approve a design choice.

**Next action:** apply automatic learning to the file-based workflow now; inspect host behavior when connecting PLUR. Include a brief memory review at meaningful milestones and when a correction or contradiction appears, without blocking research on a per-memory approval.

## Q-003 — Retrieval mode

**Status:** resolved by the lab operator on 2026-10-01; recorded in DEC-001.

**Selected:** keyword search first; add embeddings if retrieval needs improve.

Should the first connected store use keyword retrieval or enable local embeddings for hybrid retrieval immediately?

**Recommendation:** keyword first for the small initial corpus. Hybrid retrieval can help conceptual matches as the corpus grows, with model downloads and runtime resources to account for.

**Next action:** retain disabled embeddings and keyword retrieval. Use recurring retrieval misses as evidence for adding embeddings; provision any required tooling through mise and inspect retrieval on actual lab questions.

## Q-004 — First audit ecosystem

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-002](../decisions/DEC-002-harness-operating-envelope.md).

**Selected:** Solidity/EVM first; leave room for later adapters. Alternatives were multiple ecosystems initially or another named first ecosystem. This determines initial language, chain, analysis, and reproduction support.

**Owner:** lab operator. **Next action:** apply the EVM scope to the proposed harness and retain explicit adapter boundaries.

## Q-005 — Auditor work selection

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-002](../decisions/DEC-002-harness-operating-envelope.md).

**Selected:** approve small batches of investigations with a budget; receive evidence and blockers afterward. Alternatives were choosing every question or authorizing broad campaigns with milestone reviews.

**Owner:** lab operator. **Next action:** specify batch boundaries, interrupt conditions, and human review capacity. Exact batch size remains a pilot setting.

## Q-006 — Deployment and model access

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-002](../decisions/DEC-002-harness-operating-envelope.md).

**Selected:** local workspace with approved cloud AI providers receiving needed audit code/context. Alternatives were entirely local inference or a centrally hosted workspace.

**Owner:** lab operator. **Next action:** define controlled provider egress and engagement isolation. Provider selection and specific client data authorization are not settled by this preference.

## Q-007 — Alternative evidence for confirmation

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md).

If a serious issue has a convincing code-based argument but a runnable PoC is impractical, may the auditor confirm it with documented alternative evidence? **Selected:** allow a reasoned human exception, label the evidence class and limits, and keep clean replay as the normal route. The alternative considered required a runnable PoC for every confirmation and retained other issues as unresolved.

**Why it matters:** the strict option makes artifact checks simpler but may leave real architectural or environment-dependent issues unconfirmed. The exception puts more responsibility on explicit human reasoning and applicability review. Model agreement does not suffice under either policy.

**Owner:** lab operator. **Next action:** apply the accepted exception to confirmation/closure and report evidence routes separately. **Resolution record:** [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md); the broader architecture in [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) remains proposed.

## Q-008 — Primary harness architecture

**Status:** proposed for operator review; not accepted by the operating-envelope answers.

Should the first harness use the [evidence workbench proposal](../design/audit-harness.md), with property and scenario work as methods over shared records? [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) records alternatives, rationale and costs. This review concerns the concrete architecture, not permission to perform the already-requested design sprint.

**Owner:** lab operator. **Next action:** review, amend or accept the proposal. Engine, model/vendor and sandbox selection remain later compatibility/procurement choices; engagement budgets and data policies are intake decisions.
