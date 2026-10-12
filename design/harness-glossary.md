# Harness glossary and value tables

Status: **vocabulary of the accepted baseline**, 2026-10-12. It integrates [DEC-008](../decisions/DEC-008-adversarial-review-dispositions.md), [DEC-009](../decisions/DEC-009-architecture-acceptance-and-remaining-dispositions.md) and the [adversarial review](../research/adversarial-design-review.md)'s fixes within the existing direction. The page fixes names and allowed values so the specification documents agree. The [state contract](harness-state-and-execution.md#record-contracts) remains authoritative for each record's content, and the [component contracts](harness-interface-contracts.md#human-decision-kinds) for decision kinds.

## Terms

| Term | Meaning | Not to be confused with |
|---|---|---|
| Stage 01–08 | The workflow stages: 01 Scope and limits; 02 Seed knowledge; 03 Joint lensing; 04 Authorize work; 05 Investigate, with steps 05a draft and trace, 05b probe, and 05c challenge and refine; 06 Review and decide; 07 Report and close; 08 Learn and improve | Loops L0–L7. Fix review is loop L6, not a stage |
| Loop L0–L7 | A repeated process defined in the [loop register](harness-workflow-loops.md#loop-register) | EVM state-machine transitions, job states |
| Clarification | A question to the auditor about intent, an assumption, scope or a missing fact. The `Clarification` record was previously named "Question" | An investigation question; the lab's own Q-NNN register |
| Investigation | Admitted security work on one investigation question, using the hypothesis, property or scenario method | A clarification |
| Investigation question | The falsifiable claim or security question that an investigation addresses | — |
| Scenario variant | One causal sequence tried inside a scenario investigation, recorded with its own outcome | A new investigation |
| Linked variant | A scenario variant that follows an effect on a different guarantee inside the current batch. It needs no new capability, permission, budget, attacker power or scope, and changes no guarantee's or check oracle's meaning. It uses the parent investigation's allowance and names the guarantee it touches. The agent classifies the follow-up and the challenger reviews it, as for other scenario changes (Q-014). A claim it supports is recorded as a linked claim. It may enter a flow without a `record_flow_review` decision (DEC-009, Q-026; DEC-010, Q-027) | A new investigation question, which returns to `authorize_work` |
| Linked claim | A claim about a linked guarantee that linked variants support. It is recorded on the parent investigation with its own potential impact, disposition and proof status, decided in the same review. Its own potential impact sets its evidence requirement and presentation order. The packet flags a linked claim whose flow has no `record_flow_review` decision | The parent investigation question's claim |
| Job | A logical unit of execution with immutable inputs | — |
| Attempt | One execution of a job. Retries of identical input are attempts of the same job | A fixture repair or changed input, which creates a new job linked by lineage |
| Child task | An additional task, such as a parallel sub-investigation, that a worker requests inside the parent's approved investigation question. It counts against the child-task limit. A follow-up into a different guarantee that needs nothing new and changes no meaning is a [linked variant](#terms). Other work outside the investigation question is a new investigation question and returns to `authorize_work` | L2 and L3 iterations inside the same investigation, including linked variants, which share the parent's allowance and are not child tasks |
| Work authorization | A human authorization of one kind: `intake`, `exploration`, `batch`, `revalidation` (the standing allowance for automatic probe, PoC and property reruns after a change) or `method_evaluation` | — |
| Standing charter | A batch authorization with a validity window, for recurring local work under explicit ceilings such as overnight campaigns | Open-ended permission |
| Behavioral model | DESIGNED or IMPLEMENTED behavior. A "model revision" in L6 means a behavioral-model revision | AI model |
| AI model | The provider model an agent uses. Changing it makes agent-derived interpretations due for review but does not invalidate tool evidence | Behavioral model |
| Target snapshot | Pinned source, dependencies, effective settings and deployment identity | The record view returned by `read_records` |
| Check oracle | The independent computation a test or property uses to decide whether a violation occurred | A price oracle, which is an external data feed |
| Potential impact | The impact if a claim holds. It scales evidence requirements | Severity, which is assigned to an accepted finding under the engagement rubric; proof status |
| Default attacker charter | The broad permissionless EVM adversary that the auditor narrows per engagement: multiple accounts and attacker contracts, flash-loan capital within real liquidity, transaction ordering within a block, timing around oracle updates within the feed's rules, griefing spend, and any callback the protocol permits (DEC-008, Q-015) | Privileged roles, which are trusted unless the auditor raises them; that trust is an adopted premise |
| Dependency probe | A check that can be re-run, recorded with a conclusion: a hash of cited code, a structural query result, a storage layout, a configuration value, or a witness or property rerun (DEC-008, Q-019) | A one-off dependency reference |
| Positive control | A rerun of a refuting experiment against a disposable copy of the target with the cited guard removed. To reject an executable claim with potential High or Critical impact, the rerun must show the violation (DEC-008, Q-016) | Mutation adequacy for properties, a related idea |
| Captured input | The auditor's typed input, recorded verbatim by a capture hook or wrapper that the model cannot alter (DEC-008, Q-018) | An agent's paraphrase |
| Trusted decision screen | The authenticated, human-only interface that renders bound records, records display receipts and accepts decisions | The agent tool's chat |
| Display receipt | The record of which record revisions the trusted decision screen rendered, in what order and when | — |
| Unresolved | Derived, not stored. Applies to an item with no current disposition, a `disputed` or `deferred` disposition, or freshness `affected` or `possibly_affected` | The comparison result `undetermined` |
| Accepted residual risk | A known weakness the operator chose to accept. It is stated in limits and evaluated, but not silently fixed | An open defect |
| Accepted baseline | The specification accepted with the architecture in DEC-009 as the starting point for the implementer package. A consequential change to a mechanism still needs an operator decision. Numeric limits and the choice of store, runner, model provider, sandbox and agent host remain proposals | An operator decision on each mechanism |
| Mechanism library | The curated cross-engagement library of vulnerability mechanisms, each with its counterconditions and applicability. It holds public entries and lessons the auditor transferred from engagements. It has its own library scope for records and decisions. Engagements read admitted entries, and only `record_transfer` decisions write it. No entry names its source engagement (DEC-009, Q-022) | Engagement-local lessons; the lab's own PLUR memory |
| Library transfer | The record of one admission to the mechanism library: a public reference, or a lesson from an engagement with its sanitized text and the auditor's confirmations that client details are removed and the client agreement allows reuse. A lesson's transfer record stays in its source engagement, and the entry carries only an opaque reference to it | An export, which releases a frozen report |
| Expectations pre-step | An optional step before the walkthrough of a flow's implemented behavior, in which the auditor records what should happen and what must never happen. It is never required; when it is skipped, the auditor reviews what the agents found (DEC-009, Q-023) | `record_flow_review`, which records a completed review |
| Read-first mode | An optional intake mode in which the auditor reads the documentation and code first while the knowledge base builds in the background. The controller records when it starts and ends, and withholds recorded presentations of implemented behavior until it ends (DEC-009, Q-023) | — |
| Intent timing | For intent the auditor records: `before_walkthrough` if it was captured before the first recorded presentation of its audit unit's implemented behavior, as in the expectations pre-step or read-first mode, and otherwise `after_walkthrough`. A presentation is recorded when the trusted screen or the auditor interface renders the unit's IMPLEMENTED records or a KB diagram of them, including the seed's preliminary diagrams, or when an exploration round on the unit starts. The controller derives the value; it is never self-reported. It cannot see what an agent says in conversation, so `before_walkthrough` means before any recorded presentation. A comparison that relies on `after_walkthrough` intent shows the tag (DEC-009, Q-023) | Statement origin |

## Value tables

Values are written as code in all documents. A dash means the field does not apply.

| Field | Allowed values |
|---|---|
| Investigation work state | `proposed`, `queued`, `running`, `blocked`, `ready_for_review`, `closed` |
| Job and attempt execution status | `queued`, `running`, `completed`, `failed`, `cancelled`, `outcome_unknown` |
| Disposition | `accepted`, `rejected`, `no_finding_within_bounds`, `triaged_out`, `disputed`, `deferred` (see [dispositions](#dispositions-and-evidence)) |
| Freshness, relative to the active snapshot | `current`, `carried_forward_mechanical`, `possibly_affected`, `affected`, `reaffirmed_by_human`. A historical record stays valid for its own snapshot |
| Scenario variant outcome | `supports`, `refuted`, `inconclusive`, `blocked`, `stress_assumption`, `abandoned` |
| Potential impact | `critical`, `high`, `medium`, `low`, `info`, `unknown` |
| Evidence route, for an accepted finding | `executable_replay`, `alternative_argument`, `code_argument` |
| Positive control | `not_required`, `pending`, `shows_violation`, `no_violation`, `unavailable` |
| Replay | `not_required`, `pending`, `succeeded`, `failed`, `unavailable` |
| Provenance | `complete`, `incomplete` |
| Prerequisite review | `pending`, `accepted`, `disputed` |
| Adequacy | `pending`, `sufficient`, `insufficient`, `not_applicable` (with a reason) |
| Tool result type | `counterexample`, `no_violation_observed`, `proved_in_model`, `inconclusive`, `unsupported`, `error` |
| Comparison coverage | `missing_design`, `unexamined_implementation`, `partial`, `examined` |
| Comparison result | `undetermined`, `discrepancy`, `no_discrepancy_observed` |
| Fix attack status | `blocked`, `partly_blocked`, `not_blocked`, `not_assessed` |
| Fix legitimate-behavior status | `preserved`, `regressed`, `not_assessed` |
| Reported fix label, derived | `fixed`, `attack_blocked_only`, `partly_fixed`, `regressive`, `not_fixed`, `acknowledged`, `not_assessed` |
| Client response | `fixed`, `partially_fixed`, `acknowledged`, `disputed`, `no_response` |
| Rationale authorship | `human_written`, `agent_drafted_edited`, `agent_drafted_unedited` |
| Statement origin | `documented_claim`, `auditor_clarification`, `auditee_statement`, `inferred_candidate`, `adopted_assumption`, `source_analysis`, `execution_observation` |
| Model affiliation | `designed`, `implemented`, `shared` |
| Work authorization kind | `intake`, `exploration`, `batch`, `revalidation`, `method_evaluation` |
| Audit unit kind | `flow`, `guarantee`, `boundary`, `component`, `composition`, `system_invariant`, `upgrade_and_storage_layout` |
| Audit unit review status | `not_started`, `partial`, `reviewed` (for a flow, set by a `record_flow_review` decision), `excluded` (by a scope decision) |
| Dependency probe kind | `code_hash`, `structural_query`, `storage_layout`, `config_value`, `witness_rerun`, `property_rerun` |
| Intent timing, for intent the auditor records | `before_walkthrough`, `after_walkthrough` |
| Library entry source | `public_reference`, `transfer` |

The reported fix label is derived from the other fix fields:

| Label | When it applies |
|---|---|
| `fixed` | Attack `blocked` and legitimate behavior `preserved` |
| `attack_blocked_only` | Attack `blocked` and legitimate behavior `not_assessed` |
| `regressive` | Attack `blocked` or `partly_blocked`, and legitimate behavior `regressed` |
| `partly_fixed` | Attack `partly_blocked` and legitimate behavior `preserved` or `not_assessed` |
| `not_fixed` | Attack `not_blocked` |
| `acknowledged` | The client response is `acknowledged` and no fix was supplied |
| `not_assessed` | No fix assessment has been made |

## Dispositions and evidence

Adopted in DEC-008 (Q-016). The controller enforces each requirement when the decision is committed.

| Disposition | Use it when | Requires |
|---|---|---|
| `accepted` | The claim is established | A severity under the engagement rubric, plus the evidence route that the potential impact requires. **Medium and above:** `executable_replay` with a clean replay receipt; or `alternative_argument` under DEC-004, which needs a reason why a runnable PoC is impractical, a justification, stated limits and the full attempt history, and must address any failed replay of the same claim. **Low and Info:** `code_argument` with source anchors, or a stronger route |
| `rejected` | The specific claim is refuted | Decisive-evidence references stating the countercondition and its scope. For an executable claim with potential High or Critical impact, a positive control that `shows_violation`. Otherwise the positive control is `no_violation` and `rejected` is refused. A refutation without a violating positive control cannot support `no_finding_within_bounds` either; the claim stays unresolved until an adequate check exists, or the auditor disputes or defers it |
| `no_finding_within_bounds` | The investigation question was examined and no supported claim emerged | The bounds: methods, variants tried, budget, attacker charter and assumptions. It is never presented as a refutation |
| `triaged_out` | A lead's potential impact is low | A one-line reason and an auditor-confirmed potential impact of `low` or `info`. The lead is listed in an appendix and supports no assurance claim |
| `disputed` | Competing interpretations remain | The interpretations, and what would distinguish them |
| `deferred` | Work stops while the concern stands | The residual concern and a revisit condition |

**Setting potential impact.** Agents propose a value. By default the effective value is the higher of the agent's estimate and the auditor's, and `unknown` counts as `high`. The auditor may set it below the agent's estimate only by recording a reason. This keeps the evidence bar from being lowered by an optimistic estimate.
