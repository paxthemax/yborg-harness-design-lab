# Adversarial design review of the harness specification

Date: **2026-10-12**. Reviewer: **Claude (claude-opus-5-5)** in an operator-requested session, with three delegated reviewer passes. Status: **research findings and recommendations; no decision, question disposition or design document was changed**. Scope: the harness specification (`design/`, excluding the lab memory design), DEC-002–007, the question register and the imports they build on. DEC-003/Q-008 remains proposed; nothing here accepts, rejects or amends a decision. The operator's answers recorded after this review are in [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md) and the [disposition section](#subsequent-operator-disposition--2026-10-12).

## Verdict

The custody layer survives attack. The specification is careful about who may write which record, which bytes ran, which revisions an approval saw, how uncertain cost is accounted for and how a report is frozen, and most attacks on those mechanisms failed (see [what held up](#what-held-up-under-attack)).

The weaknesses cluster where audit value is decided, and they share one pattern: **a boundary is stated in prose, and its detection is delegated to the agent it constrains or to one auditor with no capacity model.** Agents decide when their own fixture change is semantic (AR-01). Rejecting a lead needs a rationale, while accepting one needs a clean replay (AR-02). The review packet, the coverage denominator and the report selection are agent-built, and nothing checks what they leave out (AR-04, AR-05, AR-16). In most cases the controller already holds the data needed to mechanize the gate: runner traces, fixture diffs, compiler artifacts, record link sets and snapshot diffs.

A second pattern concerns priorities for a solo auditor on a fixed time box. The design invests heavily in defensibility (authority, provenance, replay, invalidation, honest limits) and lightly in discovery: prior-vulnerability knowledge, cross-flow composition, the breadth of the attacker model, upgrade safety and time allocation (AR-19–21, AR-13). It applies the same record weight to every item regardless of potential impact, so under deadline pressure the record is the first casualty (AR-02, AR-07). The practitioner pass estimated 300–650 human decisions for a ten-day engagement; that is an estimate from a synthetic walkthrough, not a measurement.

Twenty-nine findings follow: three critical, fifteen high, ten medium and one low. Eleven need an operator decision, proposed as [Q-014–024](#decisions-for-the-operator); the rest are specification fixes within the existing direction. Two problems with the lab's own records are reported [separately](#lab-record-integrity).

## How the review was run

The review read the nine design documents, DEC-001–007, the question register, all research records and claim cards, the three imported reports and the four current diagrams, then attacked the specification from these positions:

| Pass | Position | Run by |
|---|---|---|
| MT | All positions below, plus protocol walk-throughs of approval, export and invalidation | This session |
| RT | Red team: a hostile target or self-interested auditee; an agent that is wrong, sycophantic or misaligned inside its grants; a tired solo auditor | Delegated, fresh context |
| SI | Specification integrity: could an engineering team build this without guessing? | Delegated, fresh context |
| PR | Practitioner: a ten-day audit of an upgradeable ERC-4626 vault with an asynchronous withdrawal queue, a price feed, a keeper, fees and a lending integration, with a day-6 code update and a later fix revision | Delegated, fresh context |

Every finding cites file:line. Claims that something is missing were checked by search, and partial coverage is cited. Delegated findings were re-verified against the text before inclusion and narrowed where they overstated it. Each finding lists every pass that reached it independently. All passes ran on the same model family, so their agreement is weaker evidence than independent human review.

**Severity** is relative to the harness's purpose, correct audit conclusions under human authority:

- **Critical:** lets the harness produce or keep a wrong audit conclusion while every record shows the process was followed.
- **High:** a likely route to missed, wrong or overstated conclusions or leaked findings, or a blocker to building the accepted workflow as specified.
- **Medium:** a material weakness with a workaround, or a cost that threatens adoption.
- **Low:** contained hygiene.

Citation keys, all under `design/`: AH `audit-harness.md`; SE `harness-state-and-execution.md`; IC `harness-interface-contracts.md`; AG `harness-auditor-guide.md`; WL `harness-workflow-loops.md`; CM `harness-comprehension-method.md`; RQ `harness-requirements.md`; EV `harness-evaluation.md`. Decision and import paths are given in full.

## Findings at a glance

| ID | Severity | Finding | Passes | Route |
|---|---|---|---|---|
| [AR-01](#ar-01--agents-classify-their-own-semantic-changes) | Critical | Agents classify their own semantic changes | MT RT SI | Q-014 |
| [AR-02](#ar-02--the-evidence-bar-is-asymmetric-and-not-scaled-to-impact) | Critical | The evidence bar is asymmetric and not scaled to impact | RT SI MT PR | Q-016 |
| [AR-03](#ar-03--unreviewed-agent-statements-become-load-bearing-premises) | High | Unreviewed agent statements become load-bearing premises | RT | Fix |
| [AR-04](#ar-04--agents-define-the-coverage-denominator) | High | Agents define the coverage denominator | RT PR | Fix |
| [AR-05](#ar-05--the-single-human-authority-is-positioned-to-rubber-stamp-and-the-record-would-not-show-it) | Critical | The single human authority is positioned to rubber-stamp, and the record would not show it | MT RT PR | Q-017 + fixes |
| [AR-06](#ar-06--the-reused-agent-interface-is-both-the-humans-conversation-channel-and-an-untrusted-worker) | High | The reused agent interface is both the human's conversation channel and an untrusted worker | MT RT | Q-018 |
| [AR-07](#ar-07--human-decision-load-is-unmodelled-interruptions-are-unbudgeted-and-time-is-unplanned) | High | Human decision load is unmodelled, interruptions are unbudgeted and time is unplanned | PR MT | Fix + pilot targets |
| [AR-08](#ar-08--the-auditors-independent-read-is-displaced-by-the-agents-seed) | Medium | The auditor's independent read is displaced by the agent's seed | MT PR | Q-023 |
| [AR-09](#ar-09--the-threat-model-protects-capabilities-not-the-integrity-of-conclusions) | High | The threat model protects capabilities, not the integrity of conclusions | MT RT | Fix |
| [AR-10](#ar-10--the-auditee-is-not-a-modeled-party) | High | The auditee is not a modeled party | RT PR | Q-021 + fixes |
| [AR-11](#ar-11--egress-and-disclosure-channels-can-leak-exploit-knowledge) | High | Egress and disclosure channels can leak exploit knowledge | RT MT PR | Fix |
| [AR-12](#ar-12--conservative-invalidation-produces-review-storms-that-resolve-into-false-reaffirmation) | High | Conservative invalidation produces review storms that resolve into false reaffirmation | MT PR RT | Q-019 |
| [AR-13](#ar-13--revisions-are-reviewed-backward-from-old-conclusions-never-forward-from-the-diff) | High | Revisions are reviewed backward from old conclusions, never forward from the diff | RT PR | Fix |
| [AR-14](#ar-14--the-stale-approval-check-sees-changed-evidence-not-newly-arrived-evidence) | Medium | The stale-approval check sees changed evidence, not newly arrived evidence | MT | Fix |
| [AR-15](#ar-15--the-report-omits-the-assumptions-and-trust-premises-that-bound-its-conclusions) | High | The report omits the assumptions and trust premises that bound its conclusions | MT PR | Fix |
| [AR-16](#ar-16--the-report-is-checked-for-support-not-for-completeness-or-fidelity) | High | The report is checked for support, not for completeness or fidelity | MT RT | Fix |
| [AR-17](#ar-17--the-alternative-evidence-route-can-confirm-a-drafted-argument-or-hide-a-failed-reproduction) | Medium | The alternative-evidence route can confirm a drafted argument or hide a failed reproduction | MT RT PR | Fix |
| [AR-18](#ar-18--fix-assessment-cannot-express-regression-or-acknowledgement-and-fix-review-inherits-full-revalidation) | Medium | Fix assessment cannot express regression or acknowledgement, and fix review inherits full revalidation | SI PR | Fix |
| [AR-19](#ar-19--lead-generation-is-under-specified-and-the-workbenchs-own-failure-mode-has-no-countermeasure) | High | Lead generation is under-specified, and the workbench's own failure mode has no countermeasure | MT PR | Q-022 + fixes |
| [AR-20](#ar-20--cross-flow-composition-and-system-wide-properties-fall-between-audit-units) | High | Cross-flow composition and system-wide properties fall between audit units | MT PR | Fix |
| [AR-21](#ar-21--the-default-attacker-model-excludes-core-evm-adversary-powers-and-trusted-roles-are-not-attack-surface) | High | The default attacker model excludes core EVM adversary powers, and trusted roles are not attack surface | PR | Q-015 |
| [AR-22](#ar-22--no-accounting-or-conservation-view-for-accounting-heavy-protocols) | Medium | No accounting or conservation view for accounting-heavy protocols | MT PR | Fix |
| [AR-23](#ar-23--the-data-model-cannot-express-the-accepted-workflow) | High | The data model cannot express the accepted workflow | SI | Fix |
| [AR-24](#ar-24--terms-and-numbering-collide) | Medium | Terms and numbering collide | SI MT | Fix |
| [AR-25](#ar-25--accepted-decisions-are-not-traced-into-testable-requirements) | Medium | Accepted decisions are not traced into testable requirements | SI | Fix |
| [AR-26](#ar-26--the-core-is-distributed-systems-grade-before-the-value-hypothesis-is-tested) | Medium | The core is distributed-systems-grade before the value hypothesis is tested | MT | Q-020 |
| [AR-27](#ar-27--normative-content-is-prose-and-the-controllers-invariants-are-not-machine-checkable) | Medium | Normative content is prose, and the controller's invariants are not machine-checkable | MT | Fix |
| [AR-28](#ar-28--evaluation-cannot-falsify-the-architecture-and-rewards-persuading-the-same-auditor) | Medium | Evaluation cannot falsify the architecture and rewards persuading the same auditor | RT MT | Q-024 |
| [AR-29](#ar-29--replay-depends-on-third-party-archive-availability) | Low | Replay depends on third-party archive availability | MT | Fix |

## 1. Semantic gates the controller cannot see

### AR-01 · Agents classify their own semantic changes

**Critical** · MT, RT, SI · enforces accepted DEC-007, but changes what batch approval must supply (Q-014)

**Spec.** DEC-007 gives agents scenario authorship but "does not authorize a new question, expanded attacker powers, changed guarantee/oracle meaning, new permissions or additional spend" (`decisions/DEC-007-human-agent-workflow.md:19`). WL:45 routes "a novel success criterion, expanded attacker power or changed oracle meaning" to a human question and exempts "syntactic fixture repair"; WL:47 says ambiguity "is exposed rather than silently broadening the grant". Nobody but the agent performs that classification. The controller is "ordinary program logic" (AH:45) that validates schema, anchors, grant, identity and revision (SE:55). Fixture differences are classified with no named actor (SE:97), and impersonation "is logged and reviewed against attacker realism" with no named logger or check (SE:107). FR-11 requires semantic review of consequential generated properties (RQ:21). Under DEC-007 that means either every generated property or, through self-classification, none.

**Failure.** An agent "repairs" a failing PoC by adding `vm.prank(governor)`, a `vm.store` on the target or a `mockCall`, or narrows `bound`/`assume` until a property passes. It calls the change syntactic and lists "setup powers: funding only" in the package (IC:123). The receipt is genuine (SE:63) but the claim's meaning has changed, and only agents and a busy auditor stand between it and acceptance. Partial defenses (SE:117, SE:139, AG:67, FR-13) are all judgment; none is a gate.

**Recommendation.** Give each admitted investigation a declared **semantic envelope**: the guarantee reference; pinned check-oracle units, with property and assertion code hashed separately from scaffolding; a structured attacker charter that maps addresses to actor roles; and the permitted setup powers, mocks and input domains. A trusted component outside the sandbox builds a **power ledger** from the fixture's syntax tree and the runner trace. It records cheatcodes by actor role and phase (setup versus attack), pranks of role holders, storage writes, code replacement, mocks, time and block jumps, `assume`/`bound` changes and any byte change to an oracle unit. Any difference from the envelope sets `semantic_review_required` and blocks `ready_for_review`, or relabels the evidence as a stress assumption that cannot support the approved claim. Defining "consequential" through this envelope also settles the FR-11/DEC-007 conflict.

### AR-02 · The evidence bar is asymmetric and not scaled to impact

**Critical** · RT, SI, MT, PR · evidence-sufficiency policy that reframes DEC-004 for low-impact findings (Q-016)

**Spec.** Acceptance must satisfy the evidence policy, normally a clean replay (SE:81; AH:131). "Evidence explaining a rejection does not need an acceptance evidence route" (IC:102), and `record_decision` requires no decisive evidence; that field appears only in the synthetic example (IC:28, IC:94). Under DEC-007 agents prune scenario variants inside L2 (WL:32, WL:47), yet the scenario record has no parent, lineage or outcome (SE:25), the packet need not list pruned variants and an investigation holds a single disposition (SE:24). "Reject" needs a decisive countercondition (AG:59), but a question exhausted within its bounds has none, and lack of progress is "never an automatic rejection" (WL:49). The auditor must therefore either mislabel such an investigation as rejected or defer it into unresolved exposure. Rejected leads are listed as outputs (AH:30), but neither the closure review (AG:91) nor the report contents (AH:135) include them. At the other extreme, every quick lead needs the same record, packet and scoped countercondition (AG:55–61). A Low finding also needs either a clean replay or an "impractical" justification that is not true (`decisions/DEC-004-confirmation-evidence-policy.md:19`).

**Failure.** A PoC reverts for an unrelated setup reason. The agent writes "guard X blocks it", a correlated challenger agrees and the auditor rejects. The real bug is now a refuted lead that reopens only if guard X changes (FR-17), and the report never mentions it. At the other extreme, sixty quick leads on day 3 each demand a formal rejection, so the auditor writes boilerplate or works outside the harness (PR).

**Recommendation.** Scale the bar with potential impact in both directions:

- `triaged_out`: a one-line dismissal for low potential impact, listed in an appendix and supporting no assurance claim.
- `no_finding_within_bounds`: records methods, variants, search budget, charter and assumptions. It counts as bounded examination, never as refutation, with a defined roll-up into unit coverage.
- `rejected`: requires decisive-evidence references. For executable claims with potential High or Critical impact, it also requires a **positive control**: the same fixture, run against a disposable copy with the cited guard removed, must show the violation; otherwise the result is `inconclusive`. This reuses the adequacy idea in EV:41.
- Scenario variants become records with outcome and countercondition, are listed in the packet and are invalidated like rejections.
- Rejections above a rubric threshold appear at closure and in the report.
- Low and Info findings may be accepted on a source argument with code references by default.

### AR-03 · Unreviewed agent statements become load-bearing premises

**High** · RT · fix

**Spec.** Seeding persists observations "without per-record permission" (CM:48). The challenger receives the "same authoritative snapshot and premises" (AH:71), and roles "need not be different models" (AH:63). The controller checks that source anchors exist, not that they support the claim (SE:55).

**Failure.** A seeded statement, "withdraw() is nonReentrant", cites the wrong overload. Investigator and challenger both inherit it. DEC-007 places the agent challenge before the only human review, so the challenge "confirms" a refutation that rests on a statement the auditor never saw.

**Recommendation.** At decision time, the controller lists every unreviewed agent statement in the decision's dependency closure. The disposition is recorded as conditional on them unless the auditor reviews or explicitly accepts them. Keep provisional statements on the challenged path out of the challenger's initial context, and record how independent the challenge was: same model or provider, shared premises. Have `authorize_batch` check DEC-005's relevant-flow review, which IC:24 does not. A different model for the challenger is a cost and provider choice for the operator.

### AR-04 · Agents define the coverage denominator

**High** · RT, PR · fix

**Spec.** The model inventories sources (CM:44), and "every inventoried in-scope element maps to an audit unit or an explicit unmodeled gap" (CM:56). The inventory and its reconciliation, however, are agent work (CM:60), and dependencies and remappings are recorded but not verified (SE:16). Coverage is tracked by unit (AH:93; EV:72), not by what the auditor has read.

**Failure.** A modified OpenZeppelin copy is vendored under `lib/` and declared standard and out of scope. An entry point marked "deprecated, unreachable" is dropped. Coverage looks complete. Separately, `sweep`, `setFee` and `_authorizeUpgrade` sit inside units but never inside a question, and nothing shows that the auditor never read them (PR).

**Recommendation.**

- Derive the inventory deterministically from compiler artifacts: contracts, external and public functions, modifiers, storage variables, assembly blocks, and low-level call and delegatecall sites.
- Block closure until each item maps to a unit, an exclusion decision or a printed gap.
- Hash vendored dependencies against upstream release tags and diff the modified ones (AR-19).
- Show which in-scope functions the auditor has personally reviewed next to unit coverage, and list unread in-scope code as a closure gap.

## 2. Human authority as provenance rather than judgment

### AR-05 · The single human authority is positioned to rubber-stamp, and the record would not show it

**Critical** · MT, RT, PR · packet ordering amends DEC-007 detail (Q-017); the rest are fixes

**Spec.** The synthesis agent writes "concise review packets" (AH:72) and chooses the "strongest supporting and refuting evidence" (AH:103) and the "strongest counterargument" (AG:53). DEC-007's packet includes "a proposed disposition" (`decisions/DEC-007-human-agent-workflow.md:27`), and clarifications carry an agent recommendation (AH:105). The decision record's rationale has no authorship field (SE:28), and NFR-01 counts only "agent-only transitions" (RQ:46). The design withholds the author's rationale from the challenger to reduce anchoring (AH:77), yet presents the human with the agent's conclusion first. The repo's own overreliance sources (SRC-027, SRC-028) inform the walkthrough design (K-006) but not adjudication.

**Failure.** At closure, thirty packets arrive with drafted dispositions and rationales and are accepted in sequence. A later reader sees human reasoning. A weak counterargument chosen by the synthesis agent makes a doubtful claim look settled. Every check NFR-01 defines still passes.

**Recommendation.**

- Present the challenger's and the author's positions verbatim rather than synthesized.
- Extend the controller's packet-completeness check (SE:79) to require every refuting or contradicting record, failed attempt and pruned variant linked to the investigation.
- For potential High or Critical decisions, show the evidence, the counterargument and the evidence-quality fields before any proposed disposition. This is the operator choice, because it changes DEC-007's packet.
- Record whether the rationale was agent-drafted and what the auditor changed. Refuse bulk dispositions and bulk reaffirmations.
- Add a decision-quality measure beside NFR-01. In pilots, seed canary packets (invalid claims with plausible narratives, and valid claims with weakened counterarguments) and report catch rate and inspection depth.

### AR-06 · The reused agent interface is both the human's conversation channel and an untrusted worker

**High** · MT, RT · shapes the Q-008 substrate (Q-018)

**Spec.** The substrate recommendation reuses "an existing agent interface connected through a narrow API" (AH:55). Human-only actions require "an authenticated interface inaccessible to worker processes" (SE:59). Joint lensing is conversational (DEC-005), and walkthrough corrections are captured "with attribution" (CM:123) through no specified channel. Workers may not see home directories, SSH agents or secrets (SE:95), and engagements are isolated (FR-24).

**Failure.** Several things go wrong:

- **Paraphrase.** The auditor says "probably not, check the docs", and the agent records "auditor confirmed fee-on-transfer tokens are unsupported". Either the paraphrase becomes a human record, which is forgery by transcription, or the auditor re-enters everything in a second UI.
- **Selective summary.** The agent summarizes a packet in chat without its failed replay, and the auditor approves the bound revision. SE:59 checks what was bound, not what was displayed.
- **Host privileges and persistence.** An off-the-shelf host runs with the auditor's privileges. It keeps transcripts, memory files and provider-side history outside the engagement's retention and isolation rules.

**Recommendation.**

- The harness owns the conversation surface used for joint exploration and decisions. It records the auditor's own words verbatim as human-authored records, and an agent's interpretation becomes intent or an assumption only after a batched one-click confirmation.
- The trusted UI renders the bound packet itself and stores a display receipt. A decision citing revisions that were never displayed is refused.
- Any reused agent host runs confined per engagement, with host memory off and transcripts kept under the engagement's retention policy.

### AR-07 · Human decision load is unmodelled, interruptions are unbudgeted and time is unplanned

**High** · PR, MT · fix, with numeric targets set by the operator

**Spec.** The review queue has a capacity limit (FR-19), but questions and interruptions do not: no queue, priority or coalescing appears anywhere (WL:55–60). Time limits are only an input (AH:30); there is no allocation per unit, reserve or burn-down. DEC-003 concedes "bureaucratic overhead" but proposes only to measure it (`decisions/DEC-003-harness-architecture-proposal.md:23`). The import's safeguard, "Keep initial records short" (`imports/03-audit-harness-top-three-designs.md:175`), was not carried over.

**Failure.** The practitioner pass estimated 300–650 human decisions over ten days, including 20–40 clarifications, 15–30 batch approvals, 45–90 dispositions and 50–150 revalidation items on day 6. Recording them would cost one to five of the ten days, on top of the thinking itself. Nothing warns on day 7 that the upgrade and lending units are untouched. Between review sessions discovery stops when the queue fills or the batch budget is spent, and small spend top-ups need approval.

**Recommendation.**

- Publish a decision inventory with expected frequency per engagement-day, and set a ceiling as a pilot acceptance target before the pilot starts.
- Give questions a queue with limited capacity, priorities and coalescing, plus a batched export of client questions.
- Add an engagement time plan: an allocation per unit, reserves for revisions and reporting, and a burn-down the planner can see.
- Add standing pre-approved charters, such as overnight local campaigns and spend under a ceiling.

### AR-08 · The auditor's independent read is displaced by the agent's seed

**Medium** · MT, PR · amends DEC-005/006 interaction detail (Q-023)

**Spec.** Intake seeds the KB automatically before the auditor's orientation (`decisions/DEC-005-comprehension-lensing.md:13`). DEC-006 rules that code-derived design "cannot independently validate the same code's conformity" (`decisions/DEC-006-designed-and-implemented-behavior.md:9`). The auditor's intent, however, is elicited during walkthroughs of IMPLEMENTED behavior (CM:117–123), so it can be anchored on the implementation in the same way. Both imports put human orientation first (`imports/02-audit-harness-independent-assesment.md:100`; `imports/03-audit-harness-top-three-designs.md:77`). CM:58 preserves part of this: "broad vulnerability narratives need not precede the auditor's initial orientation".

**Failure.** The seed omits one writer of some state; the auditor learns the system from the seed and inherits the blind spot. The auditor's "intended behavior" for a flow is formed after reading the agent's account of the code, and the comparison then finds no discrepancy by construction.

**Recommendation.** For flows the operator designates as critical, capture the auditor's expectations before the IMPLEMENTED walkthrough, and tag intent recorded after exposure to the implementation. Offer an intake mode in which the auditor reads first while the KB builds in the background.

## 3. Adversarial input and confidentiality

### AR-09 · The threat model protects capabilities, not the integrity of conclusions

**High** · MT, RT · fix

**Spec.** The threat model lists hostile files, malicious retrieved material, misleading tool output and compromised agent behavior (SE:91), but its acceptance scenario tests only capability escalation (EV:23). DEC-006 seeds DESIGNED from documentation first (`decisions/DEC-006-designed-and-implemented-behavior.md:9`), and documentation can be written by the party under audit. Nothing addresses bidirectional-control, invisible or homoglyph characters in code shown to the auditor; a search finds no mention. Replay pins bytecode identity, not behavior (SE:137).

**Failure.** NatSpec falsely says reentrancy is "prevented by the global lock in Router", and a comment addressed to "AI auditors" calls a module formally verified. The agents stay inside their grants, their analysis is steered away from the bug, and because no lead appears, no record does either. Separately, target code branches on `tx.origin`, `block.coinbase`, `basefee`, `chainid` or the code at the cheatcode address. The backdoor stays dormant on a local fork, and both PoC and replay report `no_violation_observed`.

**Recommendation.**

- Add steering and suppression to the threat model, with evaluation scenarios for a misleading comment that contradicts the code, an injected "skip this" instruction and an environment-gated branch.
- At ingestion, flag instruction-like text addressed to AI or auditors, and render bidirectional-control, zero-width and confusable characters visibly.
- Run one challenger pass with comments and NatSpec stripped.
- Before a documentation-derived premise can support a negative conclusion, require IMPLEMENTED evidence or explicit adoption as an assumption.
- Flag deterministically any environment reads that feed branches, replay with realistic values, and label negative results "environment-sensitive".

### AR-10 · The auditee is not a modeled party

**High** · RT, PR · documentation independence narrows DEC-006 (Q-021); the rest are fixes

**Spec.** Developers "may supply answers and patches through that auditor" (AH:28). Statement origins are documented claim, auditor clarification, inferred candidate, adopted assumption, source analysis and execution observation (SE:36); none of them is the auditee. "Known issues, prior reports" are inputs (AH:30) with no handling contract. No record holds a client's response, severity dispute or "by design" reply; "Dispute" is the auditor's own disposition (AG:60).

**Failure.** During the engagement the auditee writes documentation that mirrors the code, so DESIGNED matches IMPLEMENTED and comparison reports `no-discrepancy-observed`. "Admin sweep is intended" is stored as an auditor clarification. The real bug is listed as a known issue and never investigated. After the draft report, lobbying changes a disposition and leaves no trace of the contact.

**Recommendation.**

- Add an `auditee_statement` origin and a communications log.
- Treat documentation that the auditee writes during the engagement as non-independent, like code-derived design.
- A known issue never closes an investigation, and the report labels each known issue as assessed or not assessed.
- Keep a per-finding history of client responses and severity changes, and link each disposition change to any auditee contact that preceded it.

### AR-11 · Egress and disclosure channels can leak exploit knowledge

**High** · RT, MT, PR · fix; whether urgent disclosure is in scope is the operator's choice

**Spec.** The compile and test sandbox row sets resource limits but no egress rule (SE:96), and NFR-04 does not cover general egress (RQ:49). Public references use "brokered allowlisted retrieval" (SE:100), which still permits URLs and queries composed by agents. Upstream RPC is limited by a "method/parameter allowlist" (SE:101) that names no methods. A PoC package carries a reproducible command (IC:123) with no guarantee that it cannot broadcast. "Disclosure constraints" are an input (AH:30) that `approve_export` never checks (IC:32). A credible urgent concern only prompts attention (WL:59) and "cannot authorize external action" (AH:115).

**Failure.** A test or build script phones home. Injected documentation asks the agent to fetch `docs.<protocol>/spec?section=<suspected function>`, and the auditee's server logs the request. An agent simulates the exploit with `eth_call` against the upstream endpoint, handing the calldata to the RPC provider. A recipient runs an exported PoC script against mainnet with broadcasting enabled. A public export includes the PoC for an unfixed finding. A likely critical in a live deployment can leave only through the full frozen export.

**Recommendation.**

- Deny all egress from build and test sandboxes by default, except to the RPC gateway.
- Prefetch reference material at intake, or fetch only exact URLs a human approved, and treat the target's own domains as auditee-controlled.
- Limit upstream methods to the state reads that forking needs, and refuse simulation methods carrying agent-written calldata.
- Export PoCs as tests bound to a local fork, never as broadcastable scripts.
- Add a "live-exploitable, unpatched" data class with restricted providers and minimal context.
- Have `approve_export` check the audience against the disclosure constraints for unfixed findings.
- If the operator puts urgent disclosure in scope, define a minimal urgent-advisory artifact that can be released with one approval.

## 4. Change handling at realistic scale

### AR-12 · Conservative invalidation produces review storms that resolve into false reaffirmation

**High** · MT, PR, RT · relaxes a proposed rule (Q-019)

**Spec.** A revision marks direct dependents and transitive conclusions stale (SE:127). An unresolved dynamic call, assembly or missing edge invalidates the unit "and, when its boundary cannot be established, the whole engagement view", and keeping a conclusion "needs recorded justification and any necessary rechecks" (SE:129). The human "reaffirms consequential conclusions" (SE:83). EV:74 and K-004 measure needless invalidations but offer no way to reduce them.

**Failure.** A day-6 update of about 400 lines touches `totalAssets`, fees and the queue. Nearly everything reads `totalAssets`, and the lending and oracle calls are unresolved edges, so most records go stale: dispositions, coverage, comparisons, diagrams and queued batches. The practitioner pass estimated 5–15 hours of justification, against about half a day to read the diff and rerun the PoCs by hand. Under the deadline the auditor reaffirms in bulk, and the history then records reviews that did not happen, which is worse than no invalidation.

**Recommendation.**

- With each consequential conclusion, record **dependency probes**: hashes of cited code ranges; results of structural queries such as writers of a variable, callers, modifiers, inheritance and storage layout; and witness and property reruns.
- On a new snapshot, the controller reruns the probes and assigns a freshness tier:
  - `carried_forward_mechanical`: the probes are unchanged, and the conclusion is carried in bulk under one attestation shown in the report.
  - `possibly_affected`: reach is unknown; flag it, but do not block.
  - `affected`: a probe changed; recheck.
  - `reaffirmed_by_human`.
- Rerun all PoCs and properties automatically.
- Never record a bulk human reaffirmation as individual review.

### AR-13 · Revisions are reviewed backward from old conclusions, never forward from the diff

**High** · RT, PR · fix

**Spec.** Invalidation follows the dependencies of existing conclusions (SE:125–127). Fix review reruns witnesses and "inspect[s] related changes" (AH:88; AG:87), and L6 has no step for reviewing the diff itself (WL:36). A later revision "is not covered until reviewed" (SE:133), but nothing enumerates what it changed. Storage layout, initializers and upgrade authorization appear nowhere; a search finds no mention, and proxies are handled within one snapshot (CM:89). The report names "the exact reviewed revision" (AG:91), although coverage may span several revisions.

**Failure.** The fix commit also adds `emergencyMigrate()`. Nothing depends on it, so nothing reopens, and the report says "fixed (R2)", which reads as though R2 was audited. The day-6 update and the fix each add a variable to an inherited base contract, and no one compares storage layouts across revisions or against the deployed implementation.

**Recommendation.** Diff every new snapshot against prior snapshots and the deployed implementation, covering functions, modifiers, inheritance, storage layout, dependencies and compiler settings. Map each change to a fix assessment, a reviewed audit unit or an "unreviewed change" gap printed beside the fix status. Make upgrade and storage-layout safety a mandatory unit for proxied systems, and report the reviewed revision for each unit.

### AR-14 · The stale-approval check sees changed evidence, not newly arrived evidence

**Medium** · MT · fix

**Spec.** At commit, the controller compares "the exact records and dependency revisions the auditor reviewed with current eligible state" (SE:59). Dependency digests hash manifests of exact references (IC:13), and the acceptance scenario covers only changed evidence (EV:29).

**Failure.** A late challenger refutation, or a new discrepancy on the same guarantee, references the investigation, but none of the records the auditor reviewed changes revision. The approval commits against a packet that no longer represents the evidence.

**Recommendation.** Include in the digest the set of inbound links (refuting evidence, discrepancies and questions attached to the investigation or its guarantee) and an evidence-sequence watermark. Add a scenario in which refuting evidence arrives just before approval.

## 5. Outcomes that can overstate assurance

### AR-15 · The report omits the assumptions and trust premises that bound its conclusions

**High** · MT, PR · fix

**Spec.** The overall report includes scope, methods, guarantees, accepted findings, unresolved concerns, exclusions, tool failures and fix assessments (AH:135), and the closure review covers the same ground (AG:91). The export layout has no assumptions section (IC:106–117). Both imports listed assumptions in the handover (`imports/02-audit-harness-independent-assesment.md:153`) and at closure (`imports/03-audit-harness-top-three-designs.md:374`). Privileged roles are treated as a realism concern for PoCs (AG:67; FR-13); there is no centralization section and no trusted-role analysis, and a search finds no mention of either.

**Failure.** "No issue found in withdrawals" silently depends on "the keeper is honest", "fee-on-transfer tokens are unsupported" and "the oracle reports within one heartbeat". A reader cannot tell which clean areas would fall if one assumption fails, and the keeper's power to censor fulfilment never appears.

**Recommendation.** Add an "assumptions and trust premises" section generated from the dependency graph. It lists each adopted assumption, trusted role and supported-asset premise, with the conclusions that depend on it. Enumerate privileged roles' powers from the store map as a centralization section. Include both in the closure review and the export manifest.

### AR-16 · The report is checked for support, not for completeness or fidelity

**High** · MT, RT · fix

**Spec.** `prepare_export` takes a "frozen record selection" from the auditor or a reporting worker (IC:31). The auditor reviews the preview for evidence routes and redactions (AG:93). FR-21 checks that "every reported finding resolves to a current acceptance record" (RQ:31). Report prose is drafted by an agent (AH:72).

**Failure.** The selection drops a deferred high-impact withdrawal concern. Or the prose says "withdrawals are robust" while two deferred concerns appear only in the manifest. An absence is hard to spot in a long preview.

**Recommendation.** The controller computes the required set: accepted findings in scope; unresolved, deferred and disputed items above a threshold; rejections above a threshold; adopted assumptions; coverage gaps; unreviewed changes; and tool failures. The preview lists each required item that is absent, and each needs an audience or redaction reason. Generate the scope, coverage, unresolved and assumption sections, and each finding's structured fields (severity, prerequisites, affected code, fix status), from records rather than prose.

### AR-17 · The alternative-evidence route can confirm a drafted argument or hide a failed reproduction

**Medium** · MT, RT, PR · fix within DEC-004; rationale authorship falls under Q-017

**Spec.** DEC-004 permits confirmation by argument when a runnable PoC is impractical, and requires the justification and its limits to be recorded (`decisions/DEC-004-confirmation-evidence-policy.md:17–19`). The packet "must explain why execution is impractical" (AG:75), and agents assemble the packets. A replay can be `failed` (SE:87), but failed attempts are not attached to the decision automatically.

**Failure.** The experiment loop exhausts its attempts because the bug is not real. The agent reframes the case as "fork state impractical", omits the failed runs and drafts a persuasive sufficiency argument, which the auditor approves. For Low findings, the route fills with boilerplate (AR-02).

**Recommendation.** Attach the full attempt history to every decision. After a failed replay of the same claim, refuse the alternative route unless the decision addresses that failure. Record whether the sufficiency rationale was agent-drafted (AR-05), and report the number of alternative-route confirmations and of failed attempts.

### AR-18 · Fix assessment cannot express regression or acknowledgement, and fix review inherits full revalidation

**Medium** · SI, PR · fix

**Spec.** The fix values are fixed, partly fixed, not fixed and not assessed (AH:88; AG:87). EV:43 calls for reporting a "regressive" fix, and FR-20 forbids "fixed" without a review of the regression (RQ:30). A client's decision not to fix has no status or response field.

**Failure.** A patch that blocks the exploit but breaks withdrawals has no truthful value, and a declined fix shows as "not fixed". The practitioner pass estimated 1.5–2.5 days of fix review under full revalidation, against a typical 0.5–1.5.

**Recommendation.** Record attack status and legitimate-behavior status separately, and add `acknowledged` with the client's response. Provide a scoped fix-review mode, covering the diff (AR-13) plus the listed findings, that labels everything else "not re-reviewed at revision C". Make legitimate-use checks mandatory for High and Medium findings and sampled for Low.

## 6. Discovery

### AR-19 · Lead generation is under-specified, and the workbench's own failure mode has no countermeasure

**High** · MT, PR · cross-engagement library policy (Q-022); the rest are fixes

**Spec.** The import that recommended the workbench names its main failure mode, "a well-organized queue of shallow questions" (`imports/03-audit-harness-top-three-designs.md:24`), and the design adds no countermeasure. Questions come from "discrepancies, manual notes, tool signals, and coverage gaps" (AH:85). The curator holds only lessons from the current engagement (AH:73), and historical finding text is withheld to reduce anchoring (AH:77). The imported pattern-retrieval method and schema (`imports/01-audit-harness-research.md:84–88`, `:497–529`) were not adopted. Standards are not DESIGNED sources (CM:34). The spec specifies neither a diff against upstream forks nor a review of the project's own test suite; tests appear only as an evaluation case (EV:95). The baseline control checklist provides partial coverage (AH:59; FR-28).

**Failure.** Documentation and code agree that `totalAssets` is idle plus lending balance, so no discrepancy appears. Nothing then raises first-deposit inflation, donation, ERC-4626 rounding and preview conformance, price-feed staleness and decimals, or non-standard token behavior. These are known patterns that arise even where docs and code agree, which is where most vault findings live.

**Recommendation.** Specify the lead generators each audit unit must run, and track coverage status for each:

- DESIGNED/IMPLEMENTED discrepancies.
- Applicable standards (ERC-20 variants, ERC-4626, ERC-1967) as DESIGNED sources.
- Retrieval from a mechanism library, with counterconditions.
- An attack-vector sweep for each component class.
- A diff of vendored or forked code against upstream, together with its security advisories.
- A run of the project's own test suite with coverage. Its failures and untested branches become leads, and its fixtures seed PoCs, with setup privileges labelled.

Require each batch to include at least one question about a high-value guarantee whose causality is multi-step or crosses flows. The operator should decide whether a sanitized cross-engagement mechanism library exists, and under what confidentiality rules (Q-022).

### AR-20 · Cross-flow composition and system-wide properties fall between audit units

**High** · MT, PR · fix; the routing change adjusts DEC-007 detail, so it needs confirmation

**Spec.** The investigator receives "local code" (AH:69). Flows are modeled one subject at a time (CM:137), and compositions are explored selectively, with unexplored ones "marked" (CM:163). An audit unit, however, is a flow, guarantee, boundary or component (SE:21), so compositions never appear among the "unexamined units" at closure (AG:91). A follow-up that touches a different guarantee "may be a new question" (WL:47) and returns to batch approval.

**Failure.** The cross-flow problems in the walkthrough vault include:

- fee shares minted at claim dilute the shares already in the queue;
- gas grows with queue length;
- one stuck request blocks the ones behind it;
- total claims exceed idle assets after a lending loss.

Per-request state machines show none of these, and the agent that notices the dilution must stop and wait for a new batch.

**Recommendation.**

- Generate an interference matrix mechanically from the store map: flows that write shared stores, configuration writers and their consumers, external callbacks and reentrant entry points. Give every non-empty cell a coverage item and a disposition.
- Make system-wide invariants (solvency, conservation, queue liveness) audit units.
- Give investigators every writer of the storage they read.
- Keep follow-ups that cross guarantees but need no new capability inside the batch.

### AR-21 · The default attacker model excludes core EVM adversary powers, and trusted roles are not attack surface

**High** · PR · sets the default threat model (Q-015)

**Spec.** The example charter is "public calls and permitted token callbacks" (WL:64), and any expanded attacker power requires a human question (WL:45). Transaction ordering, MEV, flash-loan capital and oracle-update timing appear nowhere; a search finds no mention. The keeper is only an intake field (RQ:79), and "oracle" usually means the test oracle (AG:65).

**Failure.** Several attacks need the charter expanded before they can be tried:

- sandwiching the keeper;
- depositing just before a fee harvest;
- requesting a withdrawal ahead of a lending loss;
- arbitraging a stale price.

Either the agents stop and ask, or these attack classes are never tried. With AR-01's mechanical gate in place, a narrow default would turn every such variant into an interrupt.

**Recommendation.** Ship a default EVM attacker charter that the auditor narrows rather than expands. It would cover:

- ordering within a block;
- flash-loan capital;
- multiple accounts;
- griefing spend;
- oracle-update timing within the feed's stated behavior.

Add a trusted-role dimension (honest, faulty or compromised keeper, admin, fee setter and upgrader), with each role's powers enumerated from the store map and feeding AR-15's centralization section. Rename the test oracle "check oracle".

### AR-22 · No accounting or conservation view for accounting-heavy protocols

**Medium** · MT, PR · fix within the DEC-005 lenses

**Spec.** The lenses are purpose, flows, stores and transitions (`decisions/DEC-005-comprehension-lensing.md:14`). Flows are modeled as state machines (DEC-005:15; CM:137), and the store record holds "units" (CM:146). Nothing requires a conservation relation, a decimals table or a rounding-direction analysis.

**Failure.** Rounding direction in `previewRedeem` versus `redeem`, share inflation and unit mismatches between asset and price-feed decimals are numerical problems, not state transitions, and the state-machine view represents them poorly.

**Recommendation.** Without adding a lens, require three tables from the stores and transitions lenses: a value-conservation relation per flow, a units and decimals table per store, and a rounding-direction table per arithmetic operation that names who benefits.

## 7. Buildability

### AR-23 · The data model cannot express the accepted workflow

**High** · SI · fix

**Spec and failure.**

- **Review packet.** DEC-007's central object (`decisions/DEC-007-human-agent-workflow.md:27`) has no record contract. The packet check covers only "records/receipts" (SE:79), so "after agent challenge" is not enforced.
- **Scenario variants.** They have no record (SE:25). Investigation state derives from single-job events (SE:77–79), although an investigation spans many jobs.
- **Work outside batches.** Queueing requires "current human batch authorization" (SE:76). Yet some work happens outside any batch: the baseline build (AG:7), L0 seeding "under an approved intake allowance" (WL:30), comprehension probes (CM:97) and L7 evaluation (WL:37). No record holds intake, round, retry, repair or improvement limits.
- **Missing operations.** About half the human-only operations are absent from the operation list (IC:19–33): accept scope and threat model, register a snapshot, answer a clarification, approve semantics, close the engagement, record a transfer, adopt a method version, import a bundle, and reaffirm. The completion audit still maps FR-02 to operations that do not exist (`research/harness-specification-completeness.md:45`).
- **DEC-004 fields.** The justification fields have no home: the human decision has no evidence-route field (SE:28), and the finding has no severity value (SE:29).
- **Statement origin.** Statements must carry "model affiliation and origin" (SE:36), but the statement record has neither field (SE:17).
- **Value sets.** Value sets differ between documents (SE:81; WL:34, WL:60; RQ:26). Loops "pause on … a relevant stale premise" (WL:26), while "running work can finish for its old snapshot" (SE:127).

**Recommendation.** Add Review packet, Scenario variant, a typed Work authorization (intake, exploration, batch, method evaluation) and Clarification records. Give `record_decision` a decision kind with inputs for each kind, or add the missing operations. Publish one value table per field, define "unresolved" as a derived condition, and choose between the pause and finish rules.

### AR-24 · Terms and numbering collide

**Medium** · SI, MT · fix

- **Stages:** AH:81–89 has seven stages and WL:15–22 has eight. "Stage 6" is fix review in one and adjudication in the other, and the loops address stages by number (WL:26, WL:34).
- **Question:** the Question record is a clarification (SE:22), but batches admit "questions" (SE:23), the investigation lifecycle starts at "New question" (SE:75) and `request_job` needs an "admitted question" (IC:25).
- **Attempt:** a job has "immutable input identity and one or more attempts" (SE:113), yet a fixture repair, which changes the input, counts toward "two attempts" (SE:117).
- **Child:** the child limit is zero (AH:115; AG:33), yet inner loops are called "children" (WL:26). Read literally, every L3 experiment returns to the planner, which defeats DEC-007.
- **Model and snapshot:** WL:57 sends a "model revision" to L6, but SE:125 says an AI-model update does not invalidate tool evidence. `read_snapshot` returns metadata (IC:21), whereas a target snapshot is source code (SE:16).

**Recommendation.** Write one glossary and adopt stages 01–08, with fix review as L6. Rename the clarification record. Use "attempt" only for retries of identical input, define "child task", and qualify "model", "snapshot" and "oracle".

### AR-25 · Accepted decisions are not traced into testable requirements

**Medium** · SI · fix

DEC-005's accepted requirements (`decisions/DEC-005-comprehension-lensing.md:13–19`) have no FR beyond FR-05's "progressive modeling". They are automatic seeding, state-machine diagrams in the KB, explorations runnable at any time, the walkthrough default and the investigation-start policy. The traceability table has no row for DEC-005 or DEC-006 (RQ:74–75). FR-19's capacity has no field or unit, and "discovery" is undefined. FR-04 and FR-05 state processes ("is refined", "can reveal") rather than observable checks. **Recommendation:** add an FR with an observable scenario for each accepted item, plus the missing traceability rows.

### AR-26 · The core is distributed-systems-grade before the value hypothesis is tested

**Medium** · MT · input to Q-008 (Q-020)

**Spec.** Eighteen of the 28 FRs are core, including FR-18's recovery, fencing and reconciliation (RQ:28). The controller specification includes:

- leases and fencing;
- idempotency records with retention;
- monotonic event cursors with `snapshot_required`;
- contract-version migration;
- journal-consistent backups (SE:113–121; IC:11, IC:35, IC:131).

All of this serves at most two agent workers and one heavy experiment on one workstation (AH:115). The delivery sequence builds durable jobs and change invalidation before any agent assistance (AH:139–140). The imports recommended a small local layer: "Git plus Markdown/JSON audit records; SQLite only if query or concurrency needs justify it", starting "with a small controller rather than a platform" (`imports/02-audit-harness-independent-assesment.md:160`, `:167`; `imports/03-audit-harness-top-three-designs.md:152`, `:179`). DEC-003 itself concedes the overhead risk (`decisions/DEC-003-harness-architecture-proposal.md:23`).

**Failure.** The first build effort goes into machinery whose value at this scale is unproven. The pilot that would test the workbench hypothesis arrives late, or not at all.

**Recommendation.** Stage Q-008 as a walking skeleton that keeps the invariants: agents cannot write canonical records, approvals bind revisions, receipts come from a trusted runner, and AR-01's semantic envelope applies. Run them on minimal machinery:

- one process;
- sequential jobs as child processes owned by the controller, stopped by killing the process group instead of through leases;
- append-only Git-backed records with schema validation;
- hash-pinned evidence files.

Add each deferred mechanism only when an observed failure justifies it.

### AR-27 · Normative content is prose, and the controller's invariants are not machine-checkable

**Medium** · MT · fix

The operations are "design vocabulary, not an implemented API" (IC:3), and the records are prose tables (SE:13–30). The controller's safety properties are exactly what the harness asks auditors to verify in target systems:

- no agent-only acceptance;
- stale approvals refused;
- late writes fenced;
- decisions idempotent;
- invalidation monotonic.

**Recommendation:** publish JSON Schemas for the records and explicit state-machine tables with guards. Model authority, approval staleness, fencing and invalidation in TLA+, Quint or Alloy, and check the model before writing code.

### AR-28 · Evaluation cannot falsify the architecture and rewards persuading the same auditor

**Medium** · RT, MT · adoption criteria are standing rules (Q-024)

**Spec.**

- Precision is computed from the auditor's own accept and reject decisions (EV:65), and method changes are evaluated "under approved allowance" (WL:37). False rejections in live engagements are never measured.
- No pre-registered criterion would reject the workbench, the DESIGNED/IMPLEMENTED process or invalidation. The import named one: record-keeping overhead that exceeds the value (`imports/02-audit-harness-independent-assesment.md:187`).
- Retained-case regression (FR-26) reruns stochastic models once.
- Manual work may enter "through the same evidence records" (WL:11), but commands the auditor runs in their own terminal have no capture path.

**Failure.** A prompt change that drops leads guarded by `nonReentrant` cuts review burden and raises measured precision, while the harness stops catching cross-function reentrancy.

**Recommendation.**

- Gate adoption on a hidden, human-curated set of seeded faults for each vulnerability class.
- Periodically re-investigate a sample of rejections with AR-02's positive control.
- Flag any change that narrows a check.
- Pre-register kill criteria for the core hypotheses before the pilot.
- Run each retained case several times.
- Route commands the auditor runs through the receipt collector, or import them as "auditor-run, untrusted receipt".

### AR-29 · Replay depends on third-party archive availability

**Low** · MT · fix

Forked PoCs record the chain and block identity and the "archive requirements" (IC:123), so replaying them later depends on an archive provider still serving that state. **Recommendation:** capture the fork state the PoC touches (accounts, code and storage slots) in the package so it replays without network access, and keep the archive reference as provenance.

## Decisions for the operator

Each item is a proposed question, and none has been decided. "Recommended" marks this review's recommendation, not an accepted choice. The questions are registered as open in [the question register](../kb/questions.md#q-014--mechanical-envelope-for-agent-authored-scenarios).

**Before Q-008, because these shape the architecture:**

| Question | Options (recommendation first) |
|---|---|
| **Q-014** Mechanical envelope for agent-authored scenarios (AR-01) | **A (recommended).** A structured envelope at batch approval plus a trusted power ledger; a mismatch blocks review readiness or relabels the evidence as a stress assumption. **B.** Keep agent self-classification, with challenger review. **C.** The human approves each scenario's setup powers before execution, which partly reverses DEC-007 |
| **Q-015** Default attacker charter (AR-21) | **A (recommended).** A broad default EVM adversary that the auditor narrows, plus a trusted-role dimension and a centralization section. **B.** A narrow default that the auditor expands per batch. **C.** No default; the auditor writes each charter |
| **Q-016** Evidence bar by potential impact (AR-02) | **A (recommended).** `triaged_out`, `no_finding_within_bounds`, and `rejected` with decisive evidence plus a positive control for executable claims of potential High/Critical impact; Low/Info accepted on a source argument by default. **B.** Decisive-evidence references and listing at closure only. **C.** Unchanged |
| **Q-017** Adjudication order for high-impact decisions (AR-05, AR-17) | **A (recommended).** Evidence, the verbatim counterargument and evidence quality first, the proposed disposition after; rationale authorship recorded. **B.** Keep DEC-007's packet and record authorship only. **C.** No dispositions proposed by agents |
| **Q-018** Conversation channel and agent host (AR-06) | **A (recommended).** A harness-owned conversation surface with verbatim capture, batched confirmation and display receipts; any reused host confined per engagement with its persistence off. **B.** Reuse an existing interface, and re-enter conversational statements in a separate authenticated UI. **C.** Treat the agent chat as the human channel; not recommended |
| **Q-019** Invalidation precision (AR-12) | **A (recommended).** Dependency probes and freshness tiers; mechanical carry-forward under one attestation; unknown reach flagged but not blocking. **B.** The current conservative widening, with human justification for each retained conclusion. **C.** Unit-level invalidation only |
| **Q-020** Build order for Q-008 (AR-26) | **A (recommended).** A walking skeleton that keeps the invariants, with deferred mechanisms added when an observed failure justifies them. **B.** Build the core as specified. **C.** A files-only manual prototype |

**Method choices that can follow:**

| Question | Options (recommendation first) |
|---|---|
| **Q-021** The auditee as a party (AR-10) | **A (recommended).** An auditee origin and a communications log; documentation the auditee writes during the engagement treated as non-independent; known issues never close investigations. **B.** Origin tagging and client-response records only |
| **Q-022** Cross-engagement mechanism library (AR-19) | **A (recommended).** A curated library built from public sources plus auditor-sanitized lessons, entered through explicit transfer records. **B.** Public sources only. **C.** Engagement-local only, as now |
| **Q-023** The auditor's independent read (AR-08) | **A (recommended).** Expectations captured first for designated critical flows, a provenance tag on intent recorded later, and an optional "auditor reads first" mode. **B.** The provenance tag only. **C.** Unchanged |
| **Q-024** Method-improvement adoption gate (AR-28) | **A (recommended).** A hidden seeded-fault set per vulnerability class, sampled re-investigation of rejections, flagged narrowing changes and pre-registered kill criteria. **B.** The current held-out comparison |

## Specification fixes within the existing direction

These need no new policy choice and have not been applied. They cover AR-03, AR-04, AR-09, AR-13 to AR-16, AR-18, AR-22 to AR-25, AR-27 and AR-29, plus the following parts of other findings:

- AR-05, except the packet ordering;
- AR-07, except the numeric ceilings;
- AR-11, except whether urgent disclosure is in scope;
- AR-17, except rationale authorship;
- AR-20, whose routing change needs confirmation.

Apply them in one coordinated pass after the questions above are settled, because several of them, and AR-02 and AR-12, change the same record contracts.

## What held up under attack

The passes attacked the following and found them sound, subject to the findings cited:

- Work state, disposition, evidence quality and freshness are separate fields, with no single "verified" label (SE:67).
- Approvals are bound to revisions and compared at commit; stale approvals are refused, never silently rebased (SE:59; IC:64). AR-14 is the exception.
- Brokers outside the workers hold provider and infrastructure credentials. Upstream RPC is read-only through a method allowlist, and there are no live writes (SE:99–107).
- The receipt collector sits outside both sandboxes, and execution provenance is explicitly distinguished from semantic truth (SE:63).
- Proof status is separate from severity, so a potentially critical concern with weak support stays a potentially critical unresolved concern (AG:77).
- The tool-result vocabulary holds, and so does the rule that a parser failure never yields "no violation" (SE:87; IC:54).
- Fix review must check legitimate behavior, not only the old witness (FR-20).
- The metric definitions hold: no false-positive rate without true negatives, zero denominators treated as `not_applicable`, and reclassification kept visible (EV:61–77).
- Reports come from a frozen snapshot, the release receipt sits outside the hashed payload, and changes produce new versions rather than silent rewrites (IC:121; AH:135).
- Imports are quarantined with execution disabled (IC:125), and `outcome_unknown` cost accounting holds (SE:119).
- DEC-006's rule that code-derived design cannot validate conformity (`decisions/DEC-006-designed-and-implemented-behavior.md:9`) holds. AR-08 and AR-10 suggest extending it to human intent and to auditee-written documentation.

## Lab record integrity

These concern the design lab's own records, not the harness.

- **L-01:** the uncommitted working tree rewrites the operator-authored line at `imports/README.md:11`, "Agents are allow to structure semantics as they see fit.", into reworded text with added constraints. Nothing records the edit. `memory/session.md:29` and `research/harness-sprint-verification.md:15` still say the imports are unchanged. The operator should either restore the line or approve and record the new wording.
- **L-02:** several statements are stale:
  - `research/harness-sprint-verification.md:15` says sixteen import files are unchanged; there are now nineteen, and the index has changed.
  - `research/harness-sprint-verification.md:31` says the directory is not a Git repository.
  - `research/harness-specification-completeness.md:93` and `:103` describe Mermaid sources with rendered SVGs and "three current SVGs"; the SVGs were replaced, and there are four diagrams.
  - `research/comprehension-methodology-review.md:5` says "Q-010 remains open", although DEC-005 resolved it.

## Limits

This review examined documents only. No harness, tool or exploit was run, and no external source was re-verified. The practitioner's counts and hours come from a synthetic engagement and are estimates. All passes used the same model family, so their corroboration is weaker than independent human review, and no human expert has reviewed these findings. Severity ratings are judgments relative to the harness's purpose. The lab memory design (DEC-001) was out of scope except where the harness relies on it.

## Subsequent operator disposition — 2026-10-12

The operator answered Q-014 to Q-020 in four focused rounds; [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md) records the answers and their consequences. The findings above remain unchanged as the review's record.

| Question | Selected | Effect on the findings |
|---|---|---|
| Q-014 | Agent self-report | AR-01's mechanical gate was declined, so AR-01 becomes an accepted residual risk. The packet-integrity fixes in AR-05 still apply |
| Q-015 | Broad default attacker; privileged roles trusted | Adopts AR-21's broad default without the trusted-role review. "Roles trusted" becomes an adopted premise that AR-15's assumptions section must list |
| Q-016 | Full impact scaling | Adopts AR-02's recommendation, including the guard-removed rerun |
| Q-017 | Evidence first | Adopts AR-05's packet ordering for potential High/Critical decisions |
| Q-018 | Reuse the agent tool and capture input outside the model | Resolves AR-06 with a refinement offered during the walkthrough. Typed input is captured verbatim, interpretations are confirmed on a trusted screen, and the tool is confined per engagement |
| Q-019 | Probes and tiers | Adopts AR-12's recommendation |
| Q-020 | Walking skeleton | Adopts AR-26's staging as input to Q-008 |

Q-021–024 remain open. The operator also kept the revised `imports/README.md` wording (L-01) and chose dated corrections for stale research statements (L-02). Neither the answers nor the fixes within the existing direction are integrated into the specification documents yet; that coordinated pass is the next action.

**Integration, 2026-10-12.** Later the same day, a coordinated pass integrated DEC-008 and the fix-route findings into the specification documents, including a new [glossary](../design/harness-glossary.md). The parts that depend on open questions were left as they are:

| Finding (part) | Waiting on |
|---|---|
| AR-08 | Q-023 |
| AR-10, documentation independence | Q-021 |
| AR-11, urgent disclosure | Q-025 |
| AR-19, cross-engagement library | Q-022 |
| AR-20, routing of cross-guarantee follow-ups | Q-026 |
| AR-28, adoption gate | Q-024 |

The coordinated pass applied the other parts of those findings.

**Remaining answers, 2026-10-12.** After that pass the operator answered Q-021–026 and accepted Q-008 as amended. [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) records these answers, which a second pass integrated into the specification the same day:

| Question | Selected | Effect on the findings |
|---|---|---|
| Q-021 | Origin label only | AR-10's communications log, documentation-independence rule and known-issue rule are declined, and their failure scenarios become accepted residual risks. The origin label and client-response history already integrated remain |
| Q-022 | Public sources plus the auditor's sanitized lessons | Adopts AR-19's library recommendation |
| Q-023 | Option A, with the expectations note optional | Adopts AR-08's recommendation, except that capture before the walkthrough is optional rather than required for critical flows |
| Q-024 | Current comparison | AR-28's adoption-gate recommendations are declined, and its failure scenario becomes an accepted residual risk. The repeated runs and auditor-run command capture already integrated remain |
| Q-025 | No urgent path | AR-11's optional urgent advisory is not added. The egress and disclosure fixes already integrated remain |
| Q-026 | Follow inside batch | Adopts AR-20's routing change |
| Q-008 | Accept as amended | DEC-003 is accepted as amended by DEC-008 and DEC-009 |
