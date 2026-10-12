# Design questions and answers

Q-001–003 were resolved by the **lab operator** on **2026-10-01** in **DEC-001**. Q-004–006 were resolved in **DEC-002** and Q-007 in **DEC-004** during the harness design sprint. Q-009–010 are resolved in **DEC-005**, Q-011 in **DEC-006**, and Q-012–013 in **DEC-007** on **2026-10-02**. Q-014–020 were resolved in **DEC-008** on **2026-10-12**, after the [adversarial design review](../research/adversarial-design-review.md) raised them, and were integrated into the specification the same day. Q-021–026, and Q-008 as an architecture accepted as amended, were resolved in **DEC-009** later that day, and a second pass integrated them the same day. Q-027, raised during that pass, was resolved the same day in **DEC-010**. Recommendations remain distinct from accepted choices.

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

**Owner:** lab operator. **Next action:** apply the accepted exception to confirmation/closure and report evidence routes separately. **Resolution record:** [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md); the broader architecture in [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) was later accepted as amended (DEC-009, 2026-10-12).

## Q-008 — Primary harness architecture

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md): accepted as amended by [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md) and DEC-009. It was proposed for operator review on 2026-10-01.

**Selected:** “Accept as amended”. DEC-009 states what acceptance covers and what it leaves to later selection.

Should the first harness use the [evidence workbench proposal](../design/audit-harness.md), with property and scenario work as methods over shared records? [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) records alternatives, rationale and costs. This review concerns the concrete architecture, not permission to perform the already-requested design sprint.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents, which now form the accepted baseline. **Next action:** prepare the implementer package. Engine, model/vendor and sandbox selection remain later compatibility/procurement choices; engagement budgets and data policies are intake decisions.

## Q-009 — Comprehension interaction default

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-005](../decisions/DEC-005-comprehension-lensing.md).

**Selected:** connected walkthrough with optional checkpoints, by the operator's answer “1A.” The subsequent feedback adds repeatable state-machine lensing requirements; it does not accept all proposed implementation mechanisms.

Should the default be a connected walkthrough with optional checkpoints, prediction-first dialogue, or a concise briefing with learning prompts only on request?

**Recommendation:** connected walkthrough with optional checkpoints. This fits the requested short, flowing explanation while offering opportunities for active reconstruction. Prediction-first adds interaction and effort; briefing-first is quicker to consume but gives less direct indication of internalization. All modes retain source access and ordinary semantic decisions. Learning responses never approve findings or prove security.

**Owner:** lab operator. **Next action:** apply the selected interaction to the second-pass lensing method. This choice does not accept the whole architecture.

## Q-010 — Comprehension depth before investigation

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-005](../decisions/DEC-005-comprehension-lensing.md).

**Selected:** broad orientation plus review of the relevant flow before investigation, by the operator's answer “A” after the second Astra Max pass. Exploration continues alongside investigation; other scope gaps stay visible.

Should investigation start after broad system orientation and reviewed understanding of the selected flow, or wait until all operator-defined critical flows have been reviewed?

**Recommendation:** broad orientation plus one reviewed flow at a time. It enables earlier useful investigations while keeping unmodeled boundaries and dependencies visible. Reviewing all critical flows first gives broader upfront internalization but delays investigation. Both require the ordinary semantic/evidence checks for the selected question; neither implies complete coverage or demands a quiz.

**Owner:** lab operator. **Next action:** apply the accepted start policy in the comprehension workflow and batch proposals. Ordinary batch authorization and relevant semantic/evidence checks still apply.

## Q-011 — Missing DESIGNED behavior

**Status:** resolved by the lab operator on 2026-10-01 in [DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md).

**Selected:** documentation-first candidate reconstruction, developed substantially with auditor input and further applicable evidence. Alternative: leave missing design unresolved until design evidence or explicit clarification supplies it. Reconstructed claims remain attributed and provisional; implementation-derived design cannot independently validate that implementation. The Astra Max consultation reported no further consequential questions before operator approval.

**Owner:** lab operator. **Next action:** apply the accepted comparison process and evaluate its future runtime scenarios. Overall architecture acceptance was Q-008, accepted as amended in DEC-009.

## Q-012 — Required human scenario design

**Status:** resolved by the lab operator on 2026-10-02 in [DEC-007](../decisions/DEC-007-human-agent-workflow.md).

For the scenario loop, how much scenario design should be a required part of the auditor's work within each approved batch?

**Selected:** “Approve the investigation questions and constraints; let agents draft and test the scenarios, then review their evidence”. The alternative and initial recommendation was to jointly frame each attack sequence and success condition before agent refinement. The operator chose agent scenario authorship within explicit human boundaries. New questions, consequential semantics, attacker powers, permissions and spending still require the appropriate human decision.

**Owner:** lab operator. **Next action:** apply agent scenario drafting and bounded refinement in the [workflow and loop register](../design/harness-workflow-loops.md). Required human understanding and final adjudication remain intact.

## Q-013 — Human testing-review checkpoint

**Status:** resolved by the lab operator on 2026-10-02 in [DEC-007](../decisions/DEC-007-human-agent-workflow.md).

The hybrid diagram puts a human testing review before agents challenge the results. Should that be a mandatory checkpoint?

**Selected:** “Review one combined packet after testing and agent challenge; interrupt earlier for consequential questions (Recommended)”. The alternative was a separate mandatory human testing review before challenge. The selected cadence reduces routine handoffs and presents support, counterevidence and test adequacy together; intermediate inspection remains available.

**Owner:** lab operator. **Next action:** use the combined review packet and explicit early-interruption rules in the [workflow and loop register](../design/harness-workflow-loops.md). Overall architecture acceptance was Q-008, accepted as amended in DEC-009.

## Q-014 — Mechanical envelope for agent-authored scenarios

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-01--agents-classify-their-own-semantic-changes) raised it the same day.

**Selected:** “Agent self-report” (option B). DEC-007 stays as written: agents classify their own changes and the challenger reviews setup powers. AR-01 is an accepted residual risk.

Should each admitted investigation carry a structured semantic envelope that the controller enforces against a trusted power ledger built from fixture syntax and runner traces? The envelope would hold the guarantee, pinned check-oracle units, attacker charter, permitted setup powers, mocks and input domains.

**Options:**
- **(A, recommended)** Mechanical envelope; a mismatch blocks `ready_for_review` or relabels the evidence as a stress assumption.
- (B) Keep agents' self-classification, with challenger review.
- (C) Human approval of each scenario's setup powers before execution, which partly reverses DEC-007.

**Why it matters:** today only the agents they constrain detect DEC-007's boundaries. Option A trades batch-authoring effort and some false positives for enforcement, and settles the FR-11/DEC-007 conflict.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** none in the specification. AR-01 is stated as an accepted risk in the threat model, the product proposal and the report limits, and the pilot measures it.

## Q-015 — Default attacker charter

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-21--the-default-attacker-model-excludes-core-evm-adversary-powers-and-trusted-roles-are-not-attack-surface) raised it the same day.

**Selected:** “Broad, roles trusted”. The default is a broad permissionless EVM attacker, narrowed per engagement. Privileged roles are trusted unless the auditor raises them, so there is no automatic centralization review.

Should batches start from a broad default EVM adversary that the auditor narrows (ordering within a block, flash-loan capital, multiple accounts, griefing spend, oracle-update timing within stated feed behavior), plus a trusted-role dimension?

**Options:**
- **(A, recommended)** Broad default that the auditor narrows, plus honest, faulty or compromised privileged roles and a centralization section in the report.
- (B) Narrow default that the auditor expands for each batch.
- (C) No default; the auditor writes each charter.

**Why it matters:** with the current narrow example charter, MEV, ordering and oracle-timing attacks are never tried, or each one needs an interrupt. Combined with Q-014's gate, a narrow default multiplies interruptions.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** none in the specification.

## Q-016 — Evidence bar by potential impact

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-02--the-evidence-bar-is-asymmetric-and-not-scaled-to-impact) raised it the same day.

**Selected:** “Full impact scaling” (option A).

Should dispositions and evidence requirements scale with potential impact in both directions, rather than requiring clean replay to accept while requiring only a rationale to reject?

**Options:**
- **(A, recommended)** Three dispositions:
  - `triaged_out` for low potential impact;
  - `no_finding_within_bounds` with its bounds recorded;
  - `rejected`, which requires decisive evidence and, for executable claims with potential High/Critical impact, a positive control.

  Scenario variants become records. Low/Info findings are accepted on a source argument by default.
- (B) Require decisive-evidence references and list rejections at closure only.
- (C) Unchanged.

**Why it matters:** false negatives are the costly audit error, and rejection is currently the cheapest disposition. Uniform record weight also turns quick triage into boilerplate. Option A reframes DEC-004 for low-impact findings.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** none in the specification.

## Q-017 — Adjudication order for high-impact decisions

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-05--the-single-human-authority-is-positioned-to-rubber-stamp-and-the-record-would-not-show-it) raised it the same day.

**Selected:** “Evidence first” (option A).

For decisions with potential High/Critical impact, should the auditor see the evidence, the verbatim counterargument and the evidence-quality fields before the agent's proposed disposition?

**Options:**
- **(A, recommended)** Evidence first, proposed disposition after, and rationale authorship recorded.
- (B) Keep DEC-007's packet and record rationale authorship only.
- (C) No dispositions proposed by agents.

**Why it matters:** the design shields the challenger from anchoring but anchors the only human authority. NFR-01 cannot detect rubber-stamping. Option A amends a detail of DEC-007's packet.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** none in the specification.

## Q-018 — Conversation channel and agent host

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-06--the-reused-agent-interface-is-both-the-humans-conversation-channel-and-an-untrusted-worker) raised it the same day.

**Selected:** “Reuse tool, capture input”, a refinement between options A and B that was offered during the walkthrough. Keep the agent tool and capture typed input verbatim outside the model. Agent interpretations count only after batched confirmation in a trusted screen, which also renders the exact packet for approval. The tool runs confined per engagement, with its memory off.

Where do the auditor's statements in joint lensing become human-authored records, and how is a reused agent host confined?

**Options:**
- **(A, recommended)** A harness-owned conversation surface that:
  - captures the auditor's statements verbatim;
  - has the auditor confirm agent interpretations in batches;
  - records a display receipt for each bound packet.

  Any reused host is confined per engagement, with its persistence off.
- (B) Reuse an existing agent interface; conversational statements are re-entered in a separate authenticated UI.
- (C) Treat the agent chat as the human channel; not recommended.

**Why it matters:** DEC-005's conversational exploration conflicts with the separate human channel and with engagement isolation. This choice also shapes Q-008's substrate.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** during compatibility trials, check that the chosen tool supports out-of-model capture; otherwise use a terminal wrapper.

## Q-019 — Invalidation precision

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-12--conservative-invalidation-produces-review-storms-that-resolve-into-false-reaffirmation) raised it the same day.

**Selected:** “Probes and tiers” (option A).

Should conclusions carry re-evaluable dependency probes, with freshness tiers that let unchanged probes carry conclusions forward mechanically?

**Options:**
- **(A, recommended)** Probes and tiers, with mechanical carry-forward under one attestation. Unknown reach is flagged but does not block, and bulk human reaffirmation is never recorded as review.
- (B) Current conservative widening, with human justification for each retained conclusion.
- (C) Unit-level invalidation only.

**Why it matters:** on realistic code, conservative widening makes most of the engagement stale after a small update. The resulting bulk reaffirmation records reviews that did not happen.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** none in the specification.

## Q-020 — Build order for the proposed architecture

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-26--the-core-is-distributed-systems-grade-before-the-value-hypothesis-is-tested) raised it the same day.

**Selected:** “Walking skeleton” (option A). This is input to Q-008, not its acceptance. Because Q-014 declined the semantic envelope, the skeleton keeps the other three invariants.

Should Q-008's architecture be staged as a walking skeleton that keeps the invariants on minimal machinery before the full controller is built? The invariants are: agents cannot write canonical records, approvals are bound to revisions, receipts are trusted, and Q-014's semantic envelope is enforced.

**Options:**
- **(A, recommended)** Walking skeleton, adding each deferred mechanism when an observed failure justifies it.
- (B) Build the core as specified.
- (C) Files-only manual prototype.

**Why it matters:** 18 of the 28 FRs are core, and they include distributed-systems machinery for at most two workers. The pilot that tests the workbench hypothesis would come late.

**Owner:** lab operator. **Integrated:** 2026-10-12 in the specification documents. **Remaining action:** define the first build's remaining functional scope in the implementer package. Q-008 was later accepted as amended in DEC-009.

## Q-021 — The auditee as a modeled party

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-10--the-auditee-is-not-a-modeled-party) raised it the same day.

**Selected:** “Origin label only” (option B). The communications log, the independence rule for documentation the auditee writes during the engagement and the known-issue rule are not adopted. Their failure scenarios become accepted residual risks.

Should auditee statements and documentation have their own origin and independence rules?

**Options:**
- **(A, recommended)** An auditee origin and a communications log. Documentation the auditee writes during the engagement is treated as non-independent, and known issues never close investigations.
- (B) Origin tagging and client-response records only.

**Why it matters:** documentation that mirrors the code hides discrepancies, and auditee answers can be stored as the auditor's own judgment. Option A narrows DEC-006's documentation-first rule for auditee-written documentation.

**Owner:** lab operator. **Integrated:** 2026-10-12; the accepted residual risk and its evaluation scenario are stated in the specification. **Remaining action:** none in the specification.

## Q-022 — Cross-engagement mechanism library

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-19--lead-generation-is-under-specified-and-the-workbenchs-own-failure-mode-has-no-countermeasure) raised it the same day.

**Selected:** “Public + your lessons” (option A).

Should the harness maintain a curated vulnerability-mechanism library with counterconditions across engagements, and under what confidentiality rules?

**Options:**
- **(A, recommended)** Public sources plus auditor-sanitized lessons, added through explicit transfer records.
- (B) Public sources only.
- (C) Engagement-local only, as now.

**Why it matters:** most vault findings are known patterns where the documentation and the code agree, so comparing designed and implemented behavior alone does not raise them. FR-24's isolation and client confidentiality constrain the options.

**Owner:** lab operator. **Integrated:** 2026-10-12. Public entries are admitted through the same `record_transfer` decision as lessons, and a lesson's transfer record stays in its source engagement. **Remaining action:** none in the specification; the library is built after the walking skeleton.

## Q-023 — The auditor's independent first read

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-08--the-auditors-independent-read-is-displaced-by-the-agents-seed) raised it the same day.

**Selected:** Free text: “I like option A but I want to market as an optional pre-step. If I want to provide input I will do it if not I can review what the agents find.” This is option A with the capture of expectations made optional. The tag on intent recorded after exposure to the implementation, and the optional read-first mode, are kept.

Should the auditor's expectations for designated critical flows be captured before the IMPLEMENTED walkthrough?

**Options:**
- **(A, recommended)** Expectations captured first for critical flows, a provenance tag on intent recorded after exposure to the implementation, and an optional "auditor reads first" intake mode.
- (B) Provenance tag only.
- (C) Unchanged.

**Why it matters:** DEC-006 bars code-derived design from validating conformity. Human intent formed after reading an agent's account of the code carries the same risk. Option A amends a detail of the DEC-005/006 interaction.

**Owner:** lab operator. **Integrated:** 2026-10-12; the tag is the derived intent timing, `before_walkthrough` or `after_walkthrough`. **Remaining action:** none in the specification.

## Q-024 — Method-improvement adoption gate

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-28--evaluation-cannot-falsify-the-architecture-and-rewards-persuading-the-same-auditor) raised it the same day.

**Selected:** “Current comparison” (option B). The four safeguards are not adopted. A narrowing change that looks like an improvement becomes an accepted residual risk.

What must a workflow, prompt or retrieval change pass before adoption?

**Options:**
- **(A, recommended)** All of:
  - a hidden, human-curated seeded-fault set for each vulnerability class;
  - sampled re-investigation of rejections with positive controls;
  - flags on any change that narrows a check;
  - kill criteria pre-registered for the core hypotheses.
- (B) The current held-out comparison.

**Why it matters:** precision is computed from the same auditor's decisions. A change that silently drops a lead class can therefore look like an improvement.

**Owner:** lab operator. **Integrated:** 2026-10-12; the accepted residual risk and its evaluation scenario are stated in the specification. **Remaining action:** none in the specification.

## Q-025 — Urgent disclosure path

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-11--egress-and-disclosure-channels-can-leak-exploit-knowledge) raised it the same day.

**Selected:** “No urgent path” (option B). Urgent contact stays outside the harness.

If the harness finds a likely critical issue in a live deployment, should a minimal urgent-advisory artifact exist that the auditor can release with one approval, ahead of the full frozen export?

**Options:**
- **(A, recommended)** A minimal advisory: affected deployment, mechanism, prerequisites and contact. It is released through `approve_export` to a named destination; the full report follows later.
- (B) No urgent path. The full export is the only release, and urgent contact happens outside the harness.

**Why it matters:** today a credible urgent concern only prompts the auditor's attention, and the only release path is the full frozen export. Option A adds a release path; it never adds an external action or extra permissions.

**Owner:** lab operator. **Integrated:** 2026-10-12. **Remaining action:** none.

## Q-026 — Cross-guarantee follow-ups within a batch

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md), after the [adversarial design review](../research/adversarial-design-review.md#ar-20--cross-flow-composition-and-system-wide-properties-fall-between-audit-units) raised it the same day.

**Selected:** “Follow inside batch” (option A). This amends DEC-007's routing detail.

When an agent's follow-up touches a different guarantee but needs no new capability, should it stay inside the current batch rather than returning to batch approval as a new investigation question?

**Options:**
- **(A, recommended)** Keep it in the batch, within the existing permissions and budget, and record it as a linked variant.
- (B, current rule) Return it to `authorize_work` as a proposed investigation question.

**Why it matters:** option A catches cross-flow effects sooner but stretches DEC-007's rule that agents may not open new investigation questions. Option B keeps the boundary but interrupts the auditor and slows work on cross-flow effects. The specification followed B until DEC-009.

**Owner:** lab operator. **Integrated:** 2026-10-12 as linked variants. **Remaining action:** none in the specification.

## Q-027 — Linked variants into unreviewed flows

**Status:** resolved by the lab operator on 2026-10-12 in [DEC-010](../decisions/DEC-010-linked-variants-into-unreviewed-flows.md), after the fresh-context consistency review of the DEC-009 integration raised it the same day.

**Selected:** “Proceed, flagged” (option B).

May a linked variant follow an effect into a flow that has no `record_flow_review` decision yet?

**Options:**
- **(A, recommended)** No. DEC-005's flow-review gate applies, and the follow-up is retained as a proposed lead until that flow is reviewed.
- (B) Yes. The review packet flags that the flow is unreviewed.

**Why it matters:** DEC-005 starts investigations only after the relevant flow has been reviewed, and DEC-009 lets linked variants cross into another guarantee without a new batch approval. Option A keeps DEC-005's gate intact but can stall follow-ups into flows that have not been walked through yet. Option B surfaces cross-flow effects sooner, but produces evidence about a flow the auditor has not reviewed. The specification followed A provisionally until DEC-010.

**Owner:** lab operator. **Integrated:** 2026-10-12. **Remaining action:** none in the specification.
