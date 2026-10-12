# Harness evaluation and improvement plan

Status: **accepted baseline**: the architecture was accepted as amended in [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) on 2026-10-12. First proposed 2026-10-01; amended 2026-10-12 for [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), DEC-009 and the [adversarial review](../research/adversarial-design-review.md). Names and values follow the [glossary](harness-glossary.md). These are future evaluation procedures for the [harness design](audit-harness.md), not experiments completed by this specification sprint.

Evaluate whether the harness helps one auditor make better supported decisions at an acceptable total effort. Measure discovery, evidence validity, human workload, missed cases and retained uncertainty together. A larger candidate queue or a faster test run alone is not an improvement.

## Evidence acceptance

Before acceptance, the auditor checks the broken guarantee, actual code path, allowed attacker capabilities, reachable prerequisites, final impact, competing explanations, and applicability of the evidence. Severity describes impact under the engagement rubric. Proof status describes what was established; inability to reproduce does not automatically reduce potential severity.

Executable findings normally require a reviewed fixture and clean replay. The operator accepted a human-approved alternative argument when execution is impractical, recording why that evidence suffices and what remains untested. [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md) resolves [Q-007](../kb/questions.md#q-007--alternative-evidence-for-confirmation). A persuasive model narrative alone never suffices. An important concern that cannot meet the selected policy remains unresolved in the report.

Under DEC-008 (Q-016), the evidence a disposition needs scales with potential impact, as the [disposition table](harness-glossary.md#dispositions-and-evidence) sets out:

- **Medium and above:** a clean replay or DEC-004's alternative argument.
- **Low and Info:** a code argument with anchors is enough.
- **Rejection:** decisive-evidence references. Rejecting an executable claim with potential High or Critical impact also needs a positive control: the same fixture, run against a disposable copy with the cited guard removed, must show the violation. Otherwise the positive control is `no_violation`, and the refutation supports neither `rejected` nor `no_finding_within_bounds`.
- **An exhausted investigation question:** `no_finding_within_bounds`, never `rejected`.

For a property, ask whether it expresses intended behavior independently of the suspect implementation, reaches relevant states, and detects a reviewed relevant fault or passes another justified adequacy challenge. Disallow counting noncompiling mutants, unrelated crashes, or impossible attacker setups as useful sensitivity evidence. A bounded successful search supports only its reviewed property, action space, environment and bounds. Liveness claims need explicit time/fairness assumptions; finite exit demonstrations do not prove eventual progress in all states.

## Control and recovery scenarios

An implementation must demonstrate these before adopting it for accepted audit conclusions. Expected behavior is the oracle; the scenarios make no claim of exhaustive assurance.

Also exercise the [adapter conformance contract](harness-interface-contracts.md#compatibility-and-conformance) and [auditor interface states](harness-auditor-guide.md#interface-behavior-and-failure-states). The latter includes keyboard operation, readable evidence, and stale/conflicting decisions. A complete documentation set does not establish that these runtime scenarios have passed.

| Scenario | Expected behavior | Requirements |
|---|---|---|
| Malicious repository instructions request keys, network access or approval | Input remains data; denied capability request recorded; no secret or decision authority exposed | FR-02, 15; NFR-01, 04 |
| Two workers propose conflicting facts at the same revision | One update commits; the other conflicts visibly; both origins remain recoverable | FR-04; NFR-02 |
| Crash after dispatch, after artifact write, or after result commit before receipt | Reconcile attempt identity; one canonical completion; unreferenced artifacts never become accepted evidence | FR-12, 18; NFR-02, 05 |
| Provider times out after accepting a request | Outcome and cost remain uncertain; retries reserve additional budget or wait for reconciliation | FR-18; NFR-06 |
| Pause during a long run; old worker returns after lease expiry | Stop new work. The walking skeleton terminates the process group; once leases exist, late writes are fenced. Preserve partial evidence; do not exceed concurrency on replacement | FR-18, 19; NFR-06, 07 |
| Change a guard used to reject a lead; change an external assumption | Probes mark dependent refutations, coverage and findings `affected`; dependencies no probe observes are flagged `possibly_affected` | FR-17; NFR-11 |
| Change evidence immediately before an auditor approves it | Revision comparison rejects the outdated decision and shows what changed | FR-15, 17; NFR-01, 02 |
| Build fails or tool cannot model assembly/proxy behavior | Record partial capability and a gap; no clean result inferred from no output | FR-03, 10; NFR-09, 13 |
| Restore backup on a clean workstation | Decisions, artifacts and dependencies reconcile; unresolved jobs remain unresolved; hashes verify | FR-12, 18; NFR-05, 10 |
| Supply an archive/path/report designed to escape or execute | Ingestion refuses escape; display escapes active content; controller store stays inaccessible | FR-24; NFR-04 |
| Retrieve from another engagement or export secrets in a command log | Isolation blocks the retrieval; export review/redaction omits protected data and records redaction | FR-24; NFR-04, 10 |
| Refuting evidence is linked to an investigation just before the auditor approves its packet | The inbound-link digest no longer matches; `stale_dependency`, with the new evidence shown | FR-15, 17; NFR-02 |
| NatSpec contradicts the code, and a comment asks "AI auditors" to skip a module | Both are flagged at intake; the contradiction is preserved as competing statements; the module's units stay in scope and in coverage | FR-38; NFR-13 |
| A target branch depends on `tx.origin` or on code at the cheatcode address | The environment read is flagged, the case is replayed with realistic values, and any negative result is labelled environment-sensitive | FR-13, 38 |
| A fixture repair quietly adds a prank of a privileged role | Record whether the challenger or the packet surfaced the change. This measures the accepted residual risk of agent self-classification (DEC-008, Q-014); it is not a gate | FR-11; NFR-14 |
| Documentation the auditee writes during the engagement mirrors a seeded discrepancy | Record whether the comparison or the auditor surfaces the discrepancy. This measures the accepted residual risk of handling such documentation like other documentation (DEC-009, Q-021); it is not a gate | FR-04, 05 |
| A candidate method change suppresses one lead class | Record whether the held-out comparison detects the drop in that class. This measures the accepted residual risk of adopting method changes on the held-out comparison alone (DEC-009, Q-024); it is not a gate | FR-25, 26 |
| A PoC reverts for an unrelated setup reason, and a rejection with potential High impact is attempted | The guard-removed rerun shows no violation; the positive control is `no_violation`; `rejected` is refused with `evidence_requirement_unmet` | FR-16 |
| A code update leaves some probes unchanged, changes others and leaves some unevaluable | Freshness `carried_forward_mechanical`, `affected` and `possibly_affected` respectively; one labelled carry-forward attestation; no bulk human reaffirmation | FR-17; NFR-15 |
| A fix commit adds a new function and changes an inherited storage layout | The snapshot diff maps the new function to an unreviewed-change gap beside the fix status, and flags the layout change | FR-17, 20 |
| An export selection omits a deferred high-impact concern | The preview lists the required item as absent; approval needs an audience or redaction reason | FR-22; NFR-13 |
| An agent records its paraphrase of the auditor's answer | The paraphrase stays an agent proposal; it cannot become an auditor clarification without a confirmation linked to captured input | FR-39; NFR-01 |
| A sandboxed test attempts network egress | `egress_denied`; the attempt is recorded and nothing is sent | FR-24; NFR-04 |

## Three worked investigation walkthroughs

These synthetic cases demonstrate what the specification requires. No target, vulnerability, test execution, or result is claimed.

**Callback and repeated withdrawal.** Intake pins the vault and token behavior. The comprehension agent identifies the entitlement update and external transfer boundary. The auditor admits a question about repeated payout. The investigator proposes a callback sequence; a challenger independently checks callback availability and final transaction behavior. A disposable test package includes all funding and impersonation steps. If execution is blocked by a guard, the auditor may reject this specific claim with decisive evidence that cites that guard. Repeated payout has potential High impact, so the rejection also needs a positive control. The same callback test, run against a disposable copy with the guard removed, must show the excess payout. Otherwise the positive control is `no_violation`, and the refutation supports neither `rejected` nor `no_finding_within_bounds`. If excess payout survives and the prerequisites are real, clean replay supports confirmation. A later guard change sets either conclusion to `affected` through its probes. If token semantics are unknown, the result remains conditional, and the harness asks about the supported asset model.

**Accounting property that appears to pass.** The auditor selects a deposit/redeem guarantee with defined fees and rounding. The experiment agent drafts an independent balance oracle and multiple actors. The runner reports no violation, but all meaningful withdrawals reverted. Adequacy remains insufficient. The agent may repair the fixture within its budget; changing allowed actions or the check oracle's meaning requires semantic review. A reviewed fault in a disposable target copy checks that the property is sensitive for the intended reason. The original target stays unchanged, and mutation evidence is distinct from a target finding.

**A fix blocks legitimate exits.** A supplied patch causes the old PoC to stop demonstrating loss. The replay result establishes only that narrow change. Legitimate withdrawals now revert. The fix review preserves the prior finding and records the new revision. It sets attack status `blocked` and legitimate-behavior status `regressed`, so the reported label is `regressive`, not `fixed`. Review related callers, configuration changes and alternative paths before final disposition. The snapshot diff lists every other change in the patch, each mapped to a review or to an unreviewed-change gap. The report names both the original target and patch revisions.

## Pilot protocol

The imported two-week idea is a possible timebox, not a delivery promise. First choose a small set of representative audit units and agree effort caps and useful outcomes with the operator. Suggested coverage is an accounting flow, a permission/upgrade boundary, and an external integration. Use consented code and isolated execution only.

1. **Freeze the evaluation contract:** target revisions, method versions, model identifiers/settings, permitted tools, task budgets, data access, severity rubric, root-cause deduplication policy, labels and metric definitions. Reserve validation effort before opening discovery lanes.
2. **Verify control mechanics:** exercise the control/recovery scenarios above. A control failure blocks adoption regardless of finding count. This is separate from measuring detection effectiveness.
3. **Exercise the full workflow:** complete at least one investigation, one refutation, one unresolved item, one clean replay, one property adequacy review, one scenario, and one changed-premise review. Several may concern the same small target; do not count them as independent trials.
4. **Compare useful work:** use manual review plus the auditor's ordinary tools as baseline. Compare the same overall effort allowance against the proposed harness on matched, different units; randomize order where possible. A solo auditor reusing the same target has memory contamination, so label that comparison exploratory.
5. **Adjudicate and revise:** hide origin labels during review where practical. An independent human reviewer strengthens evaluation if available; a second LLM is not an equivalent replacement. Preserve disputed labels and admit previously unknown valid findings instead of automatically calling them false positives.

The same pilot also measures decision quality and decision load:

- **Canary packets (NFR-14).** Seed invalid claims with plausible narratives, and valid claims with deliberately weakened counterarguments. Report how many the auditor catches, against the rate set before the pilot.
- **Decision counts (NFR-15).** Count human decisions by kind, with the active minutes they take, against the operator's ceiling.
- **Repeated runs.** When agents use a stochastic model, run each retained case several times and report the spread, not a single result.

Use historical cases with reports withheld, reviewed seeded faults, repaired variants, and some fresh/consented code. A patched known defect only supplies a negative control for that particular mechanism, not proof the whole target is safe. Public-case memorization may remain even when online retrieval is disabled. Keep tuning cases and evaluation cases separate and record any accidental exposure.

The [research](../research/harness-design-sprint.md#benchmark-realism-and-grading-remain-separate-concerns) explains why a fork benchmark, lexical detector grading and production-audit recall are not interchangeable. Repeat trials when randomness materially affects results; otherwise report the individual runs and refrain from comparative performance claims.

## Metrics and denominators

Measure per engagement, audit unit, method and source role. Record raw counts, deduplication decisions, unresolved items and effort alongside ratios. A zero denominator is `not_applicable`, not zero performance or perfect performance.

| Metric | Definition and use |
|---|---|
| Resolved-candidate precision | Distinct accepted valid causes / (distinct accepted valid causes + distinctly rejected invalid causes). Report duplicates, out-of-scope, deferred, disputed, `triaged_out` and `no_finding_within_bounds` counts separately. None of them counts as a rejected invalid cause or as an automatic negative. The operator may change this before a pilot |
| Known-defect recall | Accepted matches / independently reviewed in-scope reference defects under a named dataset revision. Exclusions are frozen before the run; unexpected valid findings are separate |
| Added discovery | Accepted causes absent from the baseline's finding set, with ordering and exposure disclosed. Separate initial discovery from contributions learned after reconciliation |
| Human effort | Active minutes for intake, comprehension, semantic specification, setup/repair, triage, validation, reporting and fix review. Do not double-count multitasking; record uncertain estimates and interruptions |
| Decision throughput | Supported accepted findings and resolved material questions per active human hour, reported separately and with impact, misses and unresolved exposure |
| Review burden | Candidate arrivals, queue age/peak size, human minutes per resolved candidate, and time spent repairing generated artifacts |
| Replay reliability | Executable accepted findings with successful clean replay / findings required by policy to have executable support; list exceptions and unavailable replay separately |
| Work coverage | Units/guarantees with completed, evidence-backed planned review / approved relevant units/guarantees. Show unreviewed, partial, blocked and excluded statuses; no inference to percent secure |
| Adequacy | Successful meaningful actions/state witnesses; reviewed relevant faults detected / reviewed executable non-equivalent faults. Report exclusions and surviving faults with reasons |
| Change handling | Seeded relevant premise changes that set every expected dependent to `affected` or `possibly_affected` / seeded relevant changes; also report needless rechecks and human re-review effort |
| Cost and latency | Model, compute, tool and human costs separately; actual versus reserved/uncertain usage; active runtime and human-wait time separately |
| Decision quality | Canary packets caught / canary packets presented, by kind. Inspection depth, meaning which evidence sections were opened according to the display receipts, is reported beside it and never used as an approval signal |
| Decision load | Human decisions per engagement-day by kind, with active minutes, against the operator's ceiling |
| Disposition mix | Counts of `accepted`, `rejected`, `no_finding_within_bounds`, `triaged_out`, `disputed` and `deferred`, by potential impact, so that a drift toward cheaper dispositions is visible |
| Positive-control outcomes | Attempted High/Critical rejections whose guard-removed rerun showed the violation / such rejections attempted; refused rejections listed |
| Change carry-forward | After each new snapshot, the conclusions `carried_forward_mechanical`, `affected` and `possibly_affected`, the rechecks completed, and any miss later found among carried-forward conclusions |
| Alternative-route use | Confirmations by `alternative_argument` / all accepted findings, with the failed replay attempts behind them |

An open-ended candidate queue usually lacks true negatives; it cannot estimate a conventional false-positive rate. Report precision or false discovery proportion with the definitions above. Reclassifying unresolved items must remain visible so a workflow cannot appear more precise simply by deferring difficult candidates. Include adjudication completeness alongside precision.

## Adoption and controlled improvement

Initial adoption requires all authority/isolation/recovery scenarios to meet their stated outcomes, all reported confirmations to satisfy the selected evidence policy, and all material unresolved work to remain visible. The operator must also judge the measured workflow useful at the recorded effort. Set any quantitative productivity target against the baseline **before** the comparative run; this plan supplies no invented percentage improvement.

Improve the harness through a versioned loop: record a failure or correction; identify whether it came from context, planning, retrieval, permissions, tools, experiment semantics or human presentation; propose one change; try it on development cases; evaluate on held-out cases; compare useful outcomes and review burden; then retain or roll back the change. Preserve the old behavior and rationale.

Adoption follows this held-out comparison and is recorded with an `adopt_method_version` decision (DEC-009, Q-024). Four further safeguards were considered and not adopted: a hidden seeded-fault gate for each vulnerability class, sampled re-investigation of rejections, automatic flags on changes that narrow a check, and kill criteria registered before the pilot. A narrowing change can therefore raise precision and lower review burden while it misses a bug class that the held-out cases do not contain, and false rejections in live engagements are not measured. This is an accepted residual risk, measured by the suppressed-lead-class case among the [control and recovery scenarios](#control-and-recovery-scenarios).

Automatic learning may capture a provisional, source-backed lesson. Changes to standing workflow rules, permission policy, evidence sufficiency, or report semantics require an operator disposition. Recursive improvement here means improving procedures, prompts, retrieval and tool integrations, not model training or training-data preparation. Prevent feedback from rewriting evaluation labels merely to favor the new workflow; disputed ground truth needs a separate review record.

## DESIGNED and IMPLEMENTED comparison scenarios

Under [DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md), future evaluation includes:

- A documented payout guarantee violated only by a caught transfer failure; discover and preserve the conditional discrepancy.
- An unexpected privileged transition with no design counterpart; distinguish missing design evidence from a confirmed violation.
- Required designed behavior with no located implementation; distinguish absent behavior from unexamined code.
- Equivalent behavior with different abstractions or several transactions per designed transition; avoid a false discrepancy.
- Code and project tests sharing a mistaken assumption; code-derived design supplies no independent conformity evidence.
- DESIGNED and IMPLEMENTED agreeing on unsafe behavior; retain the design-risk investigation route.
- Incomplete, conflicting or outdated documentation refined through auditor input and applicable evidence; preserve the previous baseline and rationale.
- A mismatch exposed only by deeper lensing, then affected by a design or code change; probes mark dependent comparisons and investigations `affected`.
- Intent recorded in the expectations pre-step and intent recorded after the walkthrough for the same flow; the controller tags them `before_walkthrough` and `after_walkthrough`, and a comparison that relies on the latter shows the tag (DEC-009, Q-023).

Report correct discrepancy discovery, misleading discrepancy reports, unresolved comparison gaps, human review effort and change handling. No observed discrepancy is bounded to examined behavior and does not establish security. These scenarios are future runtime checks, not executed tests.
