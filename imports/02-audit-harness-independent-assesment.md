# Independent assessment: designing an audit process around human judgment

Date: **29 September 2026**. Version: **1.0**.

This is my interpretation of the research in `01_Audit_Harness_Research_KB.md`. The proposals below are design judgments and testable hypotheses. They are not measured outcomes, vendor endorsements, or a claim of unprecedented invention. The concrete designs are in `03_Audit_Harness_Top_Three_Designs.md`.

## 1. My recommendation

**Build a persistent evidence workbench first. Add property engineering and adversarial scenario campaigns as specialized modes.** The important human role is continuous control over the meaning of the audit: what the system promises, what attackers can do, which uncertainty matters next, and what the evidence actually establishes.

I would start with one experienced auditor, one AI assistant capable of tool use, compiler-backed navigation, a local test environment, and durable audit records. I would add additional models, fuzzers, formal tools, and hosted scanners only when they answer a specific unresolved question better than the existing setup.

The proposed advantage is **more well-supported decisions per auditor hour**, alongside deeper coverage of important guarantees. That is a proposition to measure. It would be premature to promise an audit-time reduction or a percentage increase in vulnerability discovery from the public evidence alone.

## 2. What the research changes in my thinking

### The scarce resource is the auditor's capacity to judge

Candidate generation can expand faster than a small team's ability to validate it. Even a reasonably precise system can be expensive when every candidate requires reconstructing context, writing fixtures, and proving that its attacker assumptions are realistic.

I would track a simple time model:

\[
T_{total}=T_{understanding}+T_{specification}+T_{setup}+T_{triage}+T_{validation}+T_{reporting}+T_{fix\ review}.
\]

AI assistance is beneficial only if the resulting combination improves the audit outcome at an acceptable total cost. A reduction in code-reading time can be consumed by noisy triage or generated-test debugging. An increase in total time can still be worthwhile if it uncovers a materially deeper issue; the metric must record that tradeoff rather than hiding it.

For a solo auditor, the operational goal is a small queue of precise questions with enough context to decide the next action. I would initially limit active investigations to three to five, as a tunable workflow choice. This is not a scientific optimum.

### The main failure can occur before vulnerability discovery

Suppose an assistant explains a redemption function as “users can always withdraw their balance.” The developer actually promises withdrawal after a settlement window, and emergency governance can pause it. Every later analysis using the first description is now reasoning about the wrong protocol.

This error can survive multiple agents because they all share the same summary. Independent models can still inherit the same bad premise. The harness therefore needs to separate:

- **Intent:** what documentation or the protocol owner says should happen.
- **Implementation:** what the pinned code actually does.
- **Assumptions:** what must be true outside the local code.
- **Guarantees:** the commitments the auditor is evaluating.
- **Unknowns:** what remains unresolved.

Conflicts among these should remain visible. A polished unified summary should never silently erase disagreement.

### Human involvement should be concentrated at consequential decisions

A workflow with human approval after every file read becomes unusable. A workflow with only a final report approval lets the model make most meaningful choices invisibly.

I would place gates at six decisions:

1. Accept scope, deployment context, and attacker capabilities.
2. Approve or challenge the protocol model and important guarantees.
3. Choose the next bounded investigation or campaign.
4. Approve the semantic validity of a new property or unusual test setup.
5. Accept, reject, dispute, or defer a finding based on evidence.
6. Approve remediation status and the final report's limitations.

Within an approved investigation, compilation, analysis queries, local tests, shrinking, and documentation can run without repeated intervention. Scope expansion, altered assumptions, production-code changes, and external actions require explicit authority. The execution controller should enforce this division.

### Verification is a ladder with different meanings

An AI assertion that a bug is real, a second model's agreement, a failing unit test, a fork reproduction, and a formal proof are different kinds of evidence.

| Evidence | What it can establish | Question still requiring review |
|---|---|---|
| Source-grounded argument | A plausible mechanism in specific code | Is the relevant path reachable under allowed roles and state? |
| Static-analysis result | A structural property within the analysis model | Does that structure cause the claimed impact here? |
| Minimal test | The mechanism occurs in its fixture | Does the fixture faithfully represent the protocol? |
| Stateful counterexample | A sequence breaks an assertion | Is the assertion valid, and are its actions realistic? |
| Fork reproduction | Behavior against a selected deployment snapshot | Does it transfer to intended production configuration and current dependencies? |
| Formal result | A property holds within the stated model and limits | Is the specification complete enough, non-vacuous, and correctly connected to implementation? |
| Remediation regression | A selected witness is blocked after a change | Did the fix preserve behavior and avoid sibling paths? |

These are not a universal linear ranking. For some authorization defects, a short code argument is stronger than a heavily mocked exploit. For an economic claim, a toy test is weaker than an accurately modeled multi-party scenario. Evidence type and applicability should be explicit.

## 3. My proposed organizing idea: an audit as a set of claims under challenge

The central record should be a **claim with assumptions and evidence**, rather than a scanner alert or a chat session.

Consider: “A non-privileged participant cannot increase their redeemable claim at another participant's expense through a deposit/withdrawal cycle, except for the explicitly specified fees and rounding.” This statement is still incomplete: it needs exact asset behavior, pricing semantics, time assumptions, and an error bound. But that incompleteness is useful because it exposes the questions the audit must answer.

Each important claim would link to:

- Relevant functions, state, configurations, and external dependencies.
- Its human-approved interpretation and unresolved assumptions.
- Candidate counterexamples and reasons some were rejected.
- Experiments, successful or unsuccessful, and their limits.
- Any resulting finding, remediation, and retest.

The useful graph is therefore modest: claims, code, assumptions, experiments, and decisions. A JSON/Markdown representation can implement it before a graph database or complex visual interface is justified.

### The fresh contribution I would test

The individual techniques have clear precedents in the KB. My contribution is the combination of the following operating choices:

1. **Preserve disproofs as valuable work.** If a suspected attack fails because a specific guard holds, keep that fact with its scope and revision. This prevents repeated rediscovery and identifies what must be retested if the guard changes.
2. **Ask for the cheapest decisive next experiment.** The next step should distinguish competing explanations, not generate another broad report. It might be one trace, one developer question, or a short symbolic test.
3. **Invalidate evidence when its premises change.** A code change, deployment change, or revised assumption marks dependent conclusions stale. It should not merely trigger a new scanner pass.
4. **Challenge test adequacy.** Before trusting a property, demonstrate relevant reachability and deliberately test whether a plausible fault would be detected.
5. **Delay cross-contamination selectively.** Give the human an initial independent understanding pass; keep adversarial roles' first judgments separate until reconciliation.
6. **Report unresolved exposure explicitly.** An important question blocked by missing oracle semantics must survive into the report rather than disappearing because no exploit was built.

I would call these design decisions original synthesis, not evidence that no existing team implements them. Their value needs a pilot.

## 4. The audit process I would actually run

### Phase A — Establish the audit contract

Pin source revision, compiler/settings, dependencies, deployment or fork state, configuration, upgrade paths, scope boundaries, and excluded systems. Obtain the client's intended behaviors, allowed assets, trust assumptions, and meaningful loss scenarios. Record missing information with an owner.

Create a build baseline. Document test failures and analyzer incompatibilities instead of spending unlimited time repairing the target. Local execution should be isolated; repository scripts and instructions are untrusted inputs.

**Exit:** a reproducible environment and a human-approved scope/assumption record, or an explicit list of limitations preventing one.

### Phase B — Understand the system without committing to a verdict

The human reviews documentation and core value flows first. AI can prepare structural inventory and explain selected code with source references. Reconcile the two views. Organize work around economic or authorization boundaries, not only directory structure.

Record a compact list of high-value guarantees and failure outcomes. Review entry points, shared state, trust transitions, privileged operations, and integrations. Identify which guarantees lack a clear source of enforcement.

**Exit:** a corrected system model, risk map, and unanswered questions. Completion means enough understanding to investigate—not a comprehensive generated encyclopedia.

### Phase C — Run bounded investigations

Use three kinds of work item, matching the designs in Report 03:

- **Hypothesis:** a specific mechanism may violate a guarantee.
- **Property:** a precise guarantee deserves systematic checking.
- **Scenario:** interacting participants or dependencies may break a system-level promise.

Select by potential impact, uncertainty, reachability, and expected investigation effort. These are judgment inputs, not calibrated probabilities. Allocate some time to low-signal areas to avoid only following the easiest leads.

Each work item requests one outcome: evidence supporting the claim, evidence refuting it, or a precise account of what remains blocked. It must not manufacture a minimum number of findings.

### Phase D — Reproduce and adjudicate

Replay important witnesses in a clean environment. Inspect fixture changes, role impersonation, balance provisioning, time changes, and mocks. Confirm that setup conveniences were not used to grant capabilities the attacker lacks.

The human then determines validity, impact, severity under the engagement's rules, and whether multiple candidates share one cause. Keep proof status separate from severity. A plausible catastrophic issue may remain an unresolved high-impact concern while evidence is incomplete.

**Exit:** accepted findings with sufficient support; rejected hypotheses with reasons; explicit unresolved items and coverage gaps.

### Phase E — Review fixes as new security changes

Run old witnesses against the patch. Review adjacent operations, alternative callers, arithmetic boundaries, new trust assumptions, and changes to availability. Repeat relevant properties and scenario campaigns.

The development team owns the intended fix; the auditor assesses it. A model may propose alternatives, but an automatically generated patch must not overwrite the original audit target or silently define what the protocol is supposed to do.

**Exit:** fix status tied to a commit, regression evidence, and any residual limitations.

### Phase F — Produce a reusable handover

Deliver findings, scope, assumptions, exclusions, tested guarantees, outstanding concerns, and fix status. Retain executable tests, experiment manifests, rejected hypotheses, and the evidence dependency map for future review. Share only the portions agreed with the client; internal scratch reasoning need not become a client deliverable.

## 5. Build, reuse, and buy

| Component | My initial choice | Reason |
|---|---|---|
| Agent interface | Existing supported coding assistant | Avoid spending the pilot building chat infrastructure |
| Audit state and approval rules | Build a small local layer | This is where human control, provenance, and stale-evidence handling must be explicit |
| Code intelligence | Reuse Slither; evaluate Slither-MCP | Program structure is expensive to reconstruct unreliably |
| Experiments | Foundry first; add one specialist engine as needed | Common EVM workflow and small operational footprint |
| Properties | Human-curated set with AI drafting | Specification quality is central to the audit |
| Knowledge retrieval | Small curated mechanism corpus; optionally Solodit | Local relevance and counterconditions matter more than corpus size |
| Candidate generation | Existing models; trial a hosted audit tool on an approved scope | Evaluate what it adds after human review cost |
| Reporting | Generate from accepted structured records | Keeps report claims aligned with reviewed evidence |
| Rich UI, graph database, orchestration fleet | Defer | Useful only after the workflow earns its complexity |

For accessible precedents, inspect **sc-auditor** for interactive stage control, **Hound** for persistent hypotheses, and **Trail of Bits skills** for specialist procedures. These are architectural references, not installations I have validated. A commercial scanner can be plugged into the same queue without granting it authority to decide the report. See KB S20–S25 and S29–S30 for sources and limitations.

If Moonstruck turns this into an internal capability, I would initially keep its scope to EVM audits with an experienced security lead. General software engineering strength helps build the machinery, but it does not replace protocol-specific audit judgment. A service offering should be scoped to the demonstrated capabilities of the people and process.

## 6. What I would decline to optimize first

- A maximum number of agents or vulnerability ideas.
- A single numerical “security score.”
- A dashboard claiming percentage of the protocol proven safe.
- Automatic severity copied from historical findings.
- Automatic patch-and-merge as part of the auditor's normal loop.
- A large prompt library without evidence that its workflows ran correctly.
- Fine-tuning before measuring shortcomings in context, tools, and human review.

These may be useful in narrower contexts, but none addresses the first small-team bottleneck as directly as precise questions, dependable experiments, and preserved decisions.

## 7. What would change my recommendation

The evidence-workbench recommendation would weaken if a trial shows its record-keeping overhead exceeds the value of reduced repetition and better validation. The property lab becomes the first choice when the contract is mathematically dense, the team has specification expertise, and the property suite will be reused. The scenario method becomes the first choice when the dominant risks arise between contracts, chains, external services, or governance states.

The next decision should come from a measured pilot on representative code: compare accepted unique findings, important known misses, human hours, reproducibility, and unresolved assumptions. Select the workflow that supports better audit judgment under the team's actual constraints.
