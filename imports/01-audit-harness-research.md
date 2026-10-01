# Human-led smart contract audit harnesses: research knowledge base

Research date: **29 September 2026**. Version: **1.0**. Audience: one experienced auditor or a team of two to four. Primary technical scope: **Solidity/EVM**; the process concepts transfer more broadly, but tool compatibility does not.

Companion reports: `02_Audit_Harness_Independent_Assessment.md` explains my conclusions; `03_Audit_Harness_Top_Three_Designs.md` specifies the proposed designs.

## 1. Scope, definitions, and evidence policy

An **audit harness** here means the working environment that connects code understanding, security hypotheses, analysis tools, experiments, human decisions, evidence, and reporting. It includes orchestration and persistent audit state. A **test harness** is the narrower executable fixture used to drive contracts and check properties. A scanner, prompt collection, fuzzing framework, and audit management platform each supply part of the larger harness.

This is desk research of primary documentation, public repositories, research papers, and practitioner case studies. No products were installed or benchmarked, no vendors were interviewed, and no private engagement data was available. Repository documentation establishes a claimed interface or workflow; it does not establish implementation correctness or detection effectiveness. Availability, prices, licenses, model versions, and hosted data policies require checking again when selecting an actual deployment.

The research deliberately includes autonomous products as **bounded components and comparators**, not as the recommended operating model. A human-led process must let the auditor change the threat model, reject the generated specification, choose experiments, inspect evidence, and control final findings.

Evidence labels used below:

| Label | Meaning | Appropriate use |
|---|---|---|
| DOC | Official documentation or inspectable repository | Establish documented mechanics; independently test before relying on them |
| CASE | Practitioner describes its own engagement | Evidence that a practice has been used; outcomes are self-reported |
| STUDY | Research paper or experimental evaluation | Interpret within its dataset, controls, versions, and grading method |
| VENDOR | Product description or supplier comparison | Establish positioning and claimed features; not independent validation |
| SYNTHESIS | My inference across evidence | A design judgment to test, not an observed industry result |

**Confidence refers to the stated claim, not to a product's overall security quality.** “High” can mean high confidence that documentation describes a feature, while confidence in its effectiveness remains unknown.

All external sources below were accessed on the research date. Source IDs are stable within this report. Direct source links are included so the KB remains usable outside this conversation. Publication dates are supplied where visible; living documentation is marked accordingly. Summaries are selective, not source reproductions.

### The supplied example

The screenshot, headed “The human in the loop” and labeled “yBORG / BLOCK 8,” shows AI preprocessing and explanation, human questions and focus selection, AI exploration, human filtering, AI verification, and human evidence review/reporting. This is a useful interaction pattern. It does not specify persistent state, execution controls, coverage accounting, test validity, or remediation verification. I use it as an illustrative sequence, without attributing an implemented product or measured performance to it.

## 2. Landscape: what actually exists

| Layer | Representative primary sources | Human's essential contribution | Small-team implication |
|---|---|---|---|
| Manual understanding and threat modeling | Dedaub, Hacken, Tincho demonstration, OpenZeppelin [S01–S04] | Determine intended behavior and trust boundaries | Still the foundation; tools cannot choose the business contract on behalf of the client |
| Control and weakness checklists | OWASP, Cyfrin [S05, S31] | Decide applicability and inspect evidence | Useful baseline and omission control, insufficient as the discovery engine |
| Structural code intelligence | Slither, Slither-MCP, Aderyn, Wake [S07–S09, S18] | Resolve dynamic behavior and validate interpretation | Prefer compiler-derived references over model-invented call graphs |
| Stateful testing | Foundry, Echidna, Medusa, ItyFuzz [S10–S12, S19] | Define meaningful properties, reachable states, and attacker actions | Executable evidence, with substantial harness engineering cost |
| Symbolic and formal methods | Halmos, Certora, Gambit [S14–S16] | Choose correct specifications and modeling assumptions | Apply selectively to high-value properties; validate the specification itself |
| Agent workflow packages | Trail of Bits skills, sc-auditor [S20–S21, S25] | Invoke suitable workflows and enforce checkpoints | Low-cost starting material; prompt compliance is not a hard permission boundary |
| Persistent reasoning workspaces | Hound [S24] | Correct the evolving model and adjudicate hypotheses | Useful architecture precedent; model-built graphs require evidence tagging |
| Commercial AI analysis | AuditAgent, Sherlock AI, Wake Arena, Octane, Olympix [S26–S30, S44–S46] | Triage results and verify impact | Treat as candidate sources; evaluate incremental value and reviewer burden |
| Coordinated review and reporting | Sherlock Audit Engine, Cantina [S30, S32] | Judge duplicates, severity, and unresolved issues | Borrow the adjudication model without reproducing a large marketplace |
| Research hybrids | GPTScan, PropertyGPT, Knowdit [S34–S36] | Check semantic applicability and external oracles | Strong ideas for tool-grounded AI; published scores are dataset-specific |
| Evaluation infrastructure | EVMbench, SCONE-bench, ReEVMBench [S38–S42] | Curate ground truth and judge practical validity | Reuse reproducibility mechanics; do not adopt benchmark scores as audit assurance |
| Continuous review | Lido pilot, differential-review workflows, Octane [S20, S28, S44] | Reassess changes and affected assumptions | Retained audit artifacts can make subsequent reviews more useful |

This taxonomy is a synthesis. It describes overlapping capabilities rather than mutually exclusive product categories. The absence of a tool from the table is not a finding that it is ineffective.

## 3. Methodologies and their actual tradeoffs

### M01 — Understand, then challenge

First reconstruct legitimate operations, assets, roles, and assumptions. Then deliberately attempt to violate the guarantees. Dedaub describes this separation explicitly; the Tincho demonstration makes context acquisition and review tracking concrete [S01, S03].

**Design implication:** keep the protocol model separately editable from the vulnerability queue. Label developer intent, observed code behavior, and unverified interpretation differently. A persuasive summary can otherwise become an invisible premise shared by every subsequent check.

### M02 — Independent review followed by reconciliation

Multiple human reviewers remain part of established offerings [S01, S04]; the reviewed service descriptions do not establish that their initial passes are blinded. Nethermind's 2025 case study describes manual review before revealing AI results [S26].

**Design implication:** a solo auditor can delay AI hypotheses until after recording an initial threat model. This reduces one source of anchoring; it does not create a genuinely independent second human review. A second model with the same context is also not independent evidence.

### M03 — Property-driven audit

Translate expected behavior into explicit properties, construct meaningful action sequences, and search for counterexamples. Curvance is an unusually concrete account of the engineering and client collaboration involved [S13].

**Design implication:** distinguish the person specifying what should hold from the machinery checking it. The harness must also test whether its assertions can fail. A million successful executions of irrelevant states provide little useful assurance.

### M04 — Tool-grounded AI analysis

Use deterministic program analysis to resolve structure and constrain candidate claims. Slither-MCP and GPTScan illustrate complementary implementations [S08, S34].

**Design implication:** attach source locations, analysis versions, and uncertainty to generated explanations. Static facts and inferred protocol semantics need different provenance. Dynamic dispatch, proxy upgrades, assembly, callbacks, and external state can make a static view incomplete.

### M05 — Hypothesis, challenge, experiment, adjudication

Maintain a persistent queue of security hypotheses; look for both supporting and refuting evidence; test before promotion to a finding. Hound and sc-auditor provide accessible precedents [S24–S25].

**Design implication:** lifecycle states should include blocked, disputed, rejected, and deferred. “No PoC yet” is not synonymous with invalid. Likewise, a passing PoC does not establish a realistic attacker model automatically.

### M06 — Historical-pattern retrieval

Retrieve similar vulnerabilities, relevant standards, and prior properties through resources such as Solodit, Cyfrin's checklist, or a curated internal corpus [S31, S33, S35].

**Design implication:** retrieve by economic mechanism and preconditions, then test whether those preconditions exist locally. Preserve invalidated analogies. Blindly importing a reported severity or copying a vulnerability description creates benchmark contamination and false positives.

### M07 — Adversarial scenario review

Review complete value flows and combinations of dependencies rather than treating files as independent units. Dedaub's integration focus and the Lido pilot's economic clusters are practical precedents [S01, S28].

**Design implication:** build campaigns around guarantees such as redeemability, backing, or single settlement. Explicitly vary time, ordering, roles, liquidity, and dependency behavior. State which variations are in the threat model.

### M08 — Differential and continuing assurance

Compare an audited baseline with changes, and re-evaluate affected assumptions, integrations, properties, and previous fixes. Differential review skills and continuous-analysis products support parts of this [S20, S44].

**Design implication:** preserving links from claims to code is valuable only if changed code invalidates those links. Unchanged files can become security-relevant through modified callers or changed external configuration.

## 4. Atomic evidence cards and source register

### S01 — Dedaub: two-phase reasoning and paired challenge

- **Source:** [How Smart Contracts Are Audited: The Methodology](https://dedaub.com/blog/how-are-smart-contracts-audited/), 14 July 2026.
- **Type / confidence:** CASE; high for described practice, unmeasured comparative effectiveness.
- **Observation:** Describes two senior auditors challenging each other's understanding, first modeling legitimate use and then subverting assumptions. External integrations and combinations of components are explicitly in scope alongside automated analysis.
- **Limitation:** Supplier account, without controlled solo-versus-pair or AI productivity measurements.
- **Use:** Source for M01, M02, M07. Do not infer that replacing one senior reviewer with an LLM preserves the assurance level.

### S02 — Hacken: explicit quality control and remediation workflow

- **Source:** [Smart Contract Code Review and Security Analysis Methodology](https://docs.hacken.io/methodologies/smart-contracts/), v3.0, 16 June 2026.
- **Type / confidence:** DOC; high for documented process.
- **Observation:** Separates preparation, review, finding validation, quality checks, remediation, and final verification. Quality review checks reproducibility, classification, recommendations, consistency, and omissions.
- **Limitation:** A documented process does not establish execution quality on every engagement.
- **Use:** Make human gates observable artifacts with an owner and recorded decision. Preserve fix review as a distinct activity.

### S03 — Tincho's practical manual-review demonstration

- **Source:** [Cyfrin: Introduction to Manual Review](https://updraft.cyfrin.io/courses/advanced-foundry/security/smart-contract-manual-review), living course, featuring Tincho's demonstration.
- **Type / confidence:** Practitioner teaching / DOC; high for the demonstrated method.
- **Observation:** Establish context through documentation, prepare the local code and tools, and understand the protocol before evaluating suspicious behavior.
- **Limitation:** A teaching example, not a comparative study or universal prescription.
- **Use:** The human should be able to explain core value flows without depending entirely on generated summaries.

### S04 — OpenZeppelin: multiple-human review coverage

- **Source:** [Security Audits](https://www.openzeppelin.com/security-audits), living service description.
- **Type / confidence:** VENDOR; high for stated offering.
- **Observation:** States that at least two security researchers inspect each line and collaborate with the client on design and business logic; testing techniques are used where needed.
- **Limitation:** Line inspection is a process claim, not a probability of detecting all vulnerabilities.
- **Use:** Benchmark small-team operating practices against explicit second-review coverage. A solo workflow should disclose its human-review limitation.

### S05 — OWASP: requirements, weaknesses, and testing procedures

- **Sources:** [SCSTG](https://scs.owasp.org/SCSTG/) and [SCSVS](https://scs.owasp.org/SCSVS/), living documentation.
- **Type / confidence:** DOC; high.
- **Observation:** SCSTG supplies testing guidance for controls represented in SCSVS, with weakness enumeration supporting the mapping.
- **Limitation:** A broad baseline cannot fully express project-specific economic guarantees or prove their implementation.
- **Use:** Track each relevant control as applicable, examined, evidenced, or excluded with reason. Avoid an undifferentiated “checklist complete” signal.

### S06 — Historical audit evidence on tooling limits

- **Source:** [Trail of Bits: 246 Findings From Our Smart Contract Audits](https://blog.trailofbits.com/2019/08/08/246-findings-from-our-smart-contract-audits-an-executive-summary/), 8 August 2019.
- **Type / confidence:** CASE / empirical retrospective; high for the historical dataset, limited temporal transfer.
- **Observation:** Categorizes findings from real assessments and considers what static or dynamic tools could detect. It challenges treating an extensive ordinary unit-test suite as a substitute for expert security review.
- **Limitation:** Pre-modern LLM evidence; not a measurement of 2026 AI capability.
- **Use:** Historical support for heterogeneous review methods, not for a claim that present tools can never detect business logic flaws.

### S07 — Slither: analysis framework as infrastructure

- **Source:** [crytic/slither](https://github.com/crytic/slither), living repository.
- **Type / confidence:** DOC; high for documented capability.
- **Observation:** A Solidity/Vyper static-analysis framework with detectors and program information useful to custom analyses and review tooling.
- **Limitation:** Detector output needs contextual triage; build compatibility and incomplete representations matter.
- **Use:** Structural backbone, detector adapter, and custom query substrate. Store tool configuration and errors alongside results; an analysis failure must not appear as a clean scan.

### S08 — Slither-MCP: structured code access for models

- **Source:** [Level up your Solidity LLM tooling with Slither-MCP](https://blog.trailofbits.com/2025/11/15/level-up-your-solidity-llm-tooling-with-slither-mcp/), 15 November 2025.
- **Type / confidence:** DOC / VENDOR; high for published interface, unmeasured universal gains.
- **Observation:** Exposes function source, callers/callees, inheritance, possible implementations, and filtered detector results. The announcement identifies AGPLv3 licensing and a commercial licensing option.
- **Limitation:** Better structural navigation does not make all inferred semantic facts true. This report does not determine legal obligations for a particular integration.
- **Use:** Prefer an analyzer query to a guessed implementation; investigate deployment rights before productizing.

### S09 — Aderyn: complementary static analysis

- **Source:** [Cyfrin/aderyn](https://github.com/Cyfrin/aderyn), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Rust-based Solidity analyzer with Foundry/Hardhat support and Markdown, JSON, and SARIF output; repository identifies GPL-3.0 licensing.
- **Limitation:** Complementary tool output is not automatically independent evidence of a bug. Shared rule ancestry can produce overlapping findings.
- **Use:** Normalize findings into one queue, deduplicate by root cause, and measure unique confirmed contribution before making every analyzer mandatory.

### S10 — Foundry: stateful invariants and harness observability

- **Source:** [Invariant Testing](https://getfoundry.sh/forge/invariant-testing?highlight=invariant), official documentation indexed by search; direct retrieval returned an unsupported Markdown content type.
- **Type / confidence:** DOC; high for the retrieved documented behavior; pin the installed version.
- **Observation:** Handler contracts can establish useful preconditions and track ghost state. Call/revert/discard metrics help reveal campaigns that pass because meaningful operations never execute.
- **Limitation:** The reviewed page documents defaults that can change. Handler restrictions can accidentally remove attacks.
- **Use:** Audit successful action distribution and reachable states, not just run counts or a green invariant result.

### S11 — Echidna: property-based state exploration

- **Source:** [crytic/echidna](https://github.com/crytic/echidna), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Property-oriented smart contract fuzzing with configurable campaigns, coverage information, and reusable corpus artifacts.
- **Limitation:** A bounded search without a counterexample does not prove a property. Setup, action selection, and the property determine the question actually tested.
- **Use:** A persistent experiment engine; retain corpus, seed/configuration, minimized failures, and exact code revision.

### S12 — Medusa: alternative execution and fuzzing machinery

- **Source:** [crytic/medusa](https://github.com/crytic/medusa), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Parallel, coverage-guided, mutational Solidity fuzzing based on go-ethereum.
- **Limitation:** Different backends, configurations, and random exploration can change results; more tools also increase integration cost.
- **Use:** Escalation option when another engine's exploration stalls. Decide using newly reached states or confirmed findings rather than tool count.

### S13 — Curvance: the cost and value of specifying behavior

- **Source:** [Trail of Bits: Curvance—Invariants Unleashed](https://blog.trailofbits.com/2024/04/30/curvance-invariants-unleashed/), 30 April 2024.
- **Type / confidence:** CASE; high for reported engagement details, no independent replication here.
- **Observation:** Reports nine weeks, 216 invariants, and 13 critical findings. The team describes sustained developer discussions, English property formulation, executable translation, extensive fuzzing, and tool/debugging work.
- **Limitation:** A specialist engagement with client and tooling-team support; unsuitable as a productivity promise for a solo auditor.
- **Use:** Budget property design and harness diagnosis as substantive audit work. The useful deliverable includes a maintained executable property suite.

### S14 — Halmos: bounded symbolic testing

- **Sources:** [a16z/halmos](https://github.com/a16z/halmos) and [symbolic test guide](https://github.com/a16z/halmos/blob/main/docs/getting-started.md), living documentation.
- **Type / confidence:** DOC; high.
- **Observation:** Uses symbolic inputs with familiar Solidity test structures. The guide distinguishes assertion violations from other reverting behavior and explains important differences from fuzz testing.
- **Limitation:** Bounds, unsupported operations, environment modeling, and skipped paths constrain conclusions.
- **Use:** Target arithmetic and local authorization properties. Record the exact property and analysis limits; never collapse timeout, unsupported, and verified into one status.

### S15 — Certora: vacuity is a first-class problem

- **Source:** [Rule Sanity Checks](https://docs.certora.com/en/latest/docs/prover/checking/sanity.html), living documentation.
- **Type / confidence:** DOC; high.
- **Observation:** Sanity checks examine vacuity and trivial invariants, including whether the end of a rule is reachable when user assertions are ignored.
- **Limitation:** Non-vacuity does not establish that the specification captures the intended guarantee or models dependencies correctly.
- **Use:** Require a property-validity review in addition to a solver result. An AI-generated assumption can make a desired proof true by excluding the dangerous case.

### S16 — Gambit: challenge the test or specification

- **Source:** [Certora/gambit](https://github.com/Certora/gambit), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Generates Solidity mutations to evaluate tests and specifications.
- **Limitation:** Some mutants are equivalent or outside the intended property. Mutation score is not vulnerability recall.
- **Use:** Introduce targeted, relevant faults and check that the intended property rejects them. Investigate survivors; do not treat every survivor as a contract vulnerability.

### S17 — Scribble: explicit specifications made executable

- **Sources:** [Introducing Scribble](https://consensys.io/blog/introducing-scribble-by-consensys-diligence) and [strategies for annotations](https://diligence.consensys.io/blog/2021/02/4-effective-strategies-to-come-up-with-scribble-annotations/), 2020–2021 documentation/articles.
- **Type / confidence:** DOC; high for the specification pattern.
- **Observation:** A property language and instrumentation approach that makes behavioral expectations available to automated checking, including fuzzing.
- **Limitation:** Historical product pages are not evidence of current hosted-service availability. Instrumentation and semantic compatibility need checking.
- **Use:** Valuable methodological precedent: durable specifications can feed several tools, while their semantic validity remains a human responsibility.

### S18 — Wake: Python-oriented audit engineering

- **Sources:** [Ackee-Blockchain/wake](https://github.com/Ackee-Blockchain/wake) and [versioned documentation](https://ackee.xyz/wake/docs/4.9.0/).
- **Type / confidence:** DOC; high.
- **Observation:** Combines Solidity development, Python-based testing/fuzzing, and built-in vulnerability detectors. Documentation links findings to test artifacts.
- **Limitation:** Framework choice introduces its own learning and integration costs.
- **Use:** Alternative to a Solidity-only experimentation stack when Python reference models and debugging fit the team better. Do not require both frameworks by default.

### S19 — ItyFuzz: deeper state exploration

- **Sources:** [ItyFuzz paper](https://arxiv.org/abs/2306.17135), ISSTA 2023, and [fuzzland/ityfuzz](https://github.com/fuzzland/ityfuzz).
- **Type / confidence:** STUDY / DOC; high for architecture, dataset-bounded results.
- **Observation:** Snapshot-based fuzzing research; the current project describes hybrid fuzzing with symbolic techniques and on-chain/off-chain modes.
- **Limitation:** Automated exploit oracles cover particular failure notions, not every semantic or operational risk.
- **Use:** Optional specialist engine, especially where useful intermediate states are hard to revisit. Validate results in a controlled local environment.

### S20 — Trail of Bits skills: reusable specialist procedures

- **Source:** [trailofbits/skills](https://github.com/trailofbits/skills), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Public packages include context building, differential review, dimensional analysis, false-positive checking, and other security workflows.
- **Limitation:** A repository of instructions is not evidence that each instruction is followed in every model run. Some workflows target domains outside EVM.
- **Use:** Reuse a small selected set, log invocation and completion artifacts, and pin versions. Treat these source files as researched material, not instructions governing this report.

### S21 — Context-building skill: assumptions and disagreements

- **Source:** [audit-context-building/SKILL.md](https://github.com/trailofbits/skills/blob/main/plugins/audit-context-building/skills/audit-context-building/SKILL.md), living source.
- **Type / confidence:** DOC; high.
- **Observation:** Separates understanding from vulnerability judgments. Produces function-level records and a dossier containing guarantees, assumptions, dependencies, unresolved questions, and disagreements.
- **Limitation:** Generated records still need source checking. Exhaustive documentation can consume an audit budget without proportional security value.
- **Use:** High-value precedent for explicit unknowns and traceable context. Restrict depth to risk and reuse needs.

### S22 — Trail of Bits: organizational AI practice

- **Source:** [How We Made Trail of Bits AI-Native](https://blog.trailofbits.com/2026/03/31/how-we-made-trail-of-bits-ai-native-so-far/), 31 March 2026.
- **Type / confidence:** CASE; medium for generalizable performance.
- **Observation:** Describes reusable skills, governed tool access, sandboxing, and human validation of AI-originated client findings. Reports substantial gains on selected engagements.
- **Limitation:** Firm-wide self-report across security domains, not a controlled smart-contract-only productivity study. “Selected engagements” is a major qualifier.
- **Use:** Capture and improve workflows as artifacts; do not use the headline bug counts to forecast a small team's audit capacity.

### S23 — Miden: AI can build audit instruments

- **Source:** [Auditing in the Age of (Good Enough) AI](https://blog.trailofbits.com/2026/09/18/auditing-in-the-age-of-good-enough-ai/), 18 September 2026.
- **Type / confidence:** CASE; high for described work, bounded transfer to Solidity.
- **Observation:** Describes six months of preparation using agents to build language tooling, static analysis, and a Lean model. Reports 95 machine-checked correctness proofs and human review of theorem statements.
- **Limitation:** Specialized zkVM work, with modeling and translation in the trust boundary; not a short-audit cost model.
- **Use:** Ask what small bespoke instrument would answer a difficult question reliably. Generated proof text needs a checker; checked proofs still need correct statements and models.

### S24 — Hound: persistent graph and hypothesis architecture

- **Sources:** [scabench-org/hound](https://github.com/scabench-org/hound) and [technical description](https://github.com/scabench-org/hound/blob/main/tech.md), living repository.
- **Type / confidence:** DOC; high for documented design, effectiveness unverified here.
- **Observation:** Describes evolving code/semantic graphs, evidence-linked observations, hypothesis states, different model roles, and resumable analysis. Coverage includes visited graph nodes and analyzed code cards.
- **Limitation:** Agent-generated graph completeness and model confidence are not security guarantees. Visitation measures activity, not semantic coverage.
- **Use:** Close architectural precedent for a persistent audit workspace; human authority must be added or verified explicitly.

### S25 — sc-auditor: closest public interactive orchestration example

- **Source:** [Archethect/sc-auditor](https://github.com/Archethect/sc-auditor), living repository.
- **Type / confidence:** DOC; high for advertised workflow, runtime behavior untested.
- **Observation:** Describes Map–Hunt–Attack–Verify–Report, review gates, specialist lanes, static analysis, Solodit retrieval, and optional proof tools. Its configuration documents `autonomous=false`, but `require_witness_for_high=false` by default.
- **Limitation:** Optional tools and permissive settings mean the words “verify” and “proof” do not guarantee executable evidence for every finding. No independent effectiveness evaluation was established here.
- **Use:** Strong prototype reference. Enforce evidence rules in state transitions, not only prompts, and retain plausible unproven concerns without silently downgrading their impact.

### S26 — AuditAgent after manual review: 29 audits

- **Source:** [How Nethermind Security Uses AuditAgent Alongside Manual Audits](https://www.nethermind.io/blog/how-nethermind-security-uses-auditagent-alongside-manual-audits), 1 October 2025.
- **Type / confidence:** CASE; medium for performance generalization.
- **Observation:** Manual review preceded AI analysis. Across 29 audits, the article reports AI matching 30% of human findings, with mean project size 725 lines and 11.6 contracts.
- **Limitation:** Overlap with human findings is not 30% additional discovery. No complete precision or human-time denominator is supplied. Post-incident detection anecdotes are retrospective.
- **Use:** Evidence for a second-pass operating pattern and for separating overlap from incremental contribution.

### S27 — AuditAgent on EVMbench

- **Source:** [AuditAgent on EVMBench: What the Data Shows](https://www.nethermind.io/blog/auditagent-on-evmbench-what-the-data-shows), 29 April 2026.
- **Type / confidence:** VENDOR / evaluation; medium, version-specific.
- **Observation:** Reports 67% post-validation recall across 40 repositories, down from 74% before validation. Explicitly discusses the absence of a complete negative set for false-positive measurement.
- **Limitation:** A vendor-run benchmark; its “120 vulnerabilities” denominator differs from the current introduction page's 117. Do not compare directly with the earlier 29-audit case study.
- **Use:** Useful evidence of the recall/triage tradeoff. A filter should expose discarded candidates and reasons for human sampling.

### S28 — Lido Evergreen pilot: context shaped around economic flows

- **Source:** [Piloting Continuous AI-Augmented Security on Lido Core](https://www.nethermind.io/blog/piloting-continuous-ai-augmented-security-on-lido-core), article dated 20 August 2026; some site listings show later dates.
- **Type / confidence:** CASE; medium for generalization.
- **Observation:** Four-week pilot with two AI engineers and two security researchers, roughly 19,000 lines, and two economic-invariant clusters. Runs compared original and structured documentation; researchers triaged and adjusted between rounds.
- **Limitation:** The article explicitly defines coverage against the issue set surfaced by the pilot, not all actual defects. Iterative feedback prevents treating gains as a clean prospective benchmark.
- **Use:** Strong practical support for curated protocol context and flow-based ownership. Not a solo-auditor effort estimate.

### S29 — AuditAgent product interface

- **Source:** [AuditAgent documentation](https://docs.auditagent.nethermind.io/), living documentation.
- **Type / confidence:** DOC / VENDOR; high for described interface.
- **Observation:** Documents repository/commit selection, findings, architecture diagrams, generated invariants, and API/CI integration, with Solidity, Cairo, and Solana Rust positioning.
- **Limitation:** Feature presence and a security score do not establish a calibrated assurance level. Hosted processing and model data handling need procurement review.
- **Use:** A purchasable candidate-generation adapter; retain the auditor's own evidence and decision records outside a vendor score.

### S30 — Sherlock: benchmark and coordinated engine

- **Sources:** [controlled benchmark](https://sherlock.xyz/post/controlled-benchmark-chatgpt-and-claude-vs-sherlock-ai), 5 May 2026, run 7 February; [Why We Built Audit Engine](https://sherlock.xyz/post/why-we-built-sherlock-audit-engine), 19 August 2026.
- **Type / confidence:** VENDOR; medium.
- **Observation:** The benchmark reports 21 valid and 17 invalid findings from Sherlock AI v2.2 on one public scope. It compares a full system with single-shot general-model outputs. Audit Engine describes consolidated adjudication and measurement of unique contribution, overlap, and noise across participants.
- **Limitation:** Independent triage is not an independent experimental design. The benchmark has public-data contamination and configuration confounds; the engine is an engagement offering, not demonstrated self-hostable software.
- **Use:** Adopt the attribution and deduplication concepts. Do not transplant the large-review model into a solo workflow unchanged.

### S31 — Cyfrin audit checklist

- **Source:** [Cyfrin/audit-checklist](https://github.com/Cyfrin/audit-checklist), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Aggregates smart-contract audit checks and references to concrete prior issues.
- **Limitation:** Relevance depends on protocol design, supported assets, chain semantics, and compiler/library versions.
- **Use:** A searchable omission check and source of candidate properties. Record why a check applies and what evidence resolved it.

### S32 — Cantina: finding quality and review coordination

- **Sources:** [Cantina documentation](https://docs.cantina.xyz/) and [finding submission examples](https://docs.cantina.security/researchers/participation/examples), living documentation.
- **Type / confidence:** DOC; high.
- **Observation:** Describes review coordination and provides examples of stronger and weaker finding submissions, including proof-of-concept material.
- **Limitation:** Submission quality and platform workflow are distinct from completeness of vulnerability discovery.
- **Use:** Report schema should force the mechanism, conditions, impact, and reproducible support to be explicit before client delivery.

### S33 — Solodit: historical findings as a corpus

- **Sources:** [Solodit documentation](https://docs.solodit.cyfrin.io/) and [Cyfrin 2025 wrap-up](https://www.cyfrin.io/blog/cyfrin-2025-wrap-up-advancing-web3-security-audits-and-blockchain-education).
- **Type / confidence:** DOC / VENDOR; high for corpus/API announcement.
- **Observation:** Provides discovery of historical security findings; the wrap-up documents a November 2025 API announcement for researcher/agent workflows.
- **Limitation:** Access conditions and corpus counts are time-sensitive. Public findings can contain disputes, duplicates, and assumptions that do not transfer.
- **Use:** Store original provenance, adjudication status, prerequisites, and a local applicability argument. Do not ingest raw reports as unquestioned truth.

### S34 — GPTScan: model interpretation plus static confirmation

- **Source:** [GPTScan paper](https://arxiv.org/abs/2308.03314), ICSE 2024; revised 6 May 2024.
- **Type / confidence:** STUDY; high for reported architecture, dataset-bounded performance.
- **Observation:** Decomposes supported logic bug types into scenarios and properties; uses model-assisted matching and program analysis to confirm relevant variables/statements. Reports reduced false positives from static confirmation.
- **Limitation:** Supported classes and evaluation corpora constrain transfer to unrestricted protocol auditing.
- **Use:** The LLM should propose semantic candidates; a different mechanism should check facts supporting the claim.

### S35 — PropertyGPT: retrieval-assisted property generation

- **Source:** [PropertyGPT paper](https://arxiv.org/abs/2405.02580), NDSS 2025, arXiv revision December 2024.
- **Type / confidence:** STUDY; high for reported method.
- **Observation:** Retrieves human-written properties, generates candidate specifications, repairs them using compilation/static feedback, ranks them, and checks them with a prover.
- **Limitation:** Compilable, plausible, and verified properties can still omit the important guarantee. The paper's property recall is not whole-audit vulnerability recall.
- **Use:** AI-assisted specification drafting is credible; semantic acceptance remains a separate human gate.

### S36 — Knowdit: economic semantics, knowledge graph, fuzzing loop

- **Source:** [Knowdit paper](https://arxiv.org/html/2603.26270v1), 27 March 2026 preprint.
- **Type / confidence:** STUDY; medium, no replication in this research.
- **Observation:** Connects historical findings to DeFi semantics, then iterates specification generation, harness synthesis, fuzzing, and reflection. Evaluates 12 contest projects with 75 known vulnerabilities; includes graph ablations.
- **Limitation:** Small, selected evaluation; research setup and retrieval leakage need examination before extrapolating. Human-led productivity was not established.
- **Use:** Retrieve by economic mechanism and persist experimental feedback, rather than simply adding more vulnerability descriptions to prompts.

### S37 — Agent skills study: availability is not invocation

- **Source:** [Demystifying Agent Skills for Smart Contract Auditing](https://arxiv.org/html/2609.29454v1), submitted 24 September 2026.
- **Type / confidence:** STUDY; provisional, very recent preprint.
- **Observation:** Studies 83 skills across seven agent/model configurations. Reports substantial variation in whether skills activate, including configurations that never use them.
- **Limitation:** Model/configuration-specific findings on EVMbench; benchmark ground truth and contamination caveats carry through. Novelty of the preprint leaves little replication history.
- **Use:** Verify that required workflows actually ran and produced artifacts. Installing skills is not a coverage measure.

### S38 — EVMbench: separate discovery, patching, and exploitation

- **Sources:** [OpenAI introduction](https://openai.com/index/introducing-evmbench/), 18 February 2026, and [paper](https://cdn.openai.com/evmbench/evmbench.pdf).
- **Type / confidence:** STUDY / DOC; high for task structure, bounded inference.
- **Observation:** Separates detect, patch, and exploit modes. Uses isolated chain execution and transaction replay for exploit evaluation; detect grading matches known findings. The current introduction says 117 vulnerabilities, while the paper says 120, both across 40 audits.
- **Limitation:** Additional findings are not reliably classified in detect mode. Simplified single-chain environments and mocks omit timing and deployment complexities.
- **Use:** Reuse the separation of claims, patches, and executable witnesses. Always name the dataset revision and denominator when reporting scores.

### S39 — OpenZeppelin's EVMbench critique

- **Source:** [We Audited OpenAI's EVMBench](https://www.openzeppelin.com/news/openai-evmbench-audit), 2 March 2026.
- **Type / confidence:** Independent technical critique by an interested industry participant; high that objections were documented.
- **Observation:** Challenges at least four high-severity labels in a reviewed subset and identifies possible training-data contamination. Examples concern checked arithmetic, signature domain separation, and guards defeating the asserted exploit.
- **Limitation:** A historical critique of a subset, not a complete re-audit of today's benchmark. This research did not execute the disputed cases or confirm their current disposition.
- **Use:** Ground-truth curation itself requires adversarial review. Never teach an internal KB that benchmark labels are infallible.

### S40 — ReEVMBench: environmental realism changes results

- **Sources:** [Re-evaluation paper](https://arxiv.org/html/2603.10795v1), March 2026, and [artifacts](https://github.com/blocksecteam/ReEVMBench).
- **Type / confidence:** STUDY; medium, bounded and largely single-trial.
- **Observation:** Reports zero completed profitable exploits across 110 agent/incident attempts on 22 harder real-world cases, while detection remained possible. Finds scaffold-dependent variation.
- **Limitation:** Authors acknowledge no false-positive penalty, limited sample size, single trials, and third-party model routing. Different task conditions prevent interpreting this as a direct disproof of every other exploit benchmark.
- **Use:** Measure practical execution separately from recognizing a bug. Preserve environment preparation and budget as explanatory variables.

### S41 — SCONE-bench: forked execution and economic witnesses

- **Source:** [Anthropic: AI Agents Find Smart Contract Exploits](https://www.anthropic.com/research/smart-contracts), 2025, with December edits.
- **Type / confidence:** STUDY; high for described setup, bounded results.
- **Observation:** Uses 405 historically exploited contracts and local blockchain forks at specified blocks. Measures executable outcomes and simulated extracted value; reports multi-attempt evaluations and discusses contamination and concentration of returns.
- **Limitation:** Selecting known-vulnerable targets differs from auditing unknown repositories. Simulated value is not realized attack profit or expected audit loss prevention.
- **Use:** Fork snapshots and replayable transactions are useful evidence infrastructure. Do not make immediate attacker profit the only supported impact type.

### S42 — Paradigm EVMbench harness: tool security boundary

- **Sources:** [paradigmxyz/evmbench](https://github.com/paradigmxyz/evmbench) and [security model](https://github.com/paradigmxyz/evmbench/security), living repository.
- **Type / confidence:** DOC; high.
- **Observation:** Treats uploaded code and the agent worker as untrusted. Documents scoped worker access and an optional credential proxy that keeps raw provider keys outside the worker.
- **Limitation:** Architecture documentation is not a penetration test or proof of isolation.
- **Use:** The audit harness itself has a threat model: untrusted repositories, scripts, dependencies, tool outputs, and generated reports.

### S43 — Certora AI Composer: verification inside generation

- **Source:** [Certora AI Composer announcement](https://www.certora.com/blog/certora-ai-composer-first-safe-ai-coding-platform), 21 November 2025.
- **Type / confidence:** VENDOR / DOC; high for announced alpha design.
- **Observation:** Introduces an open-source alpha connecting AI code generation with Certora Prover checks.
- **Limitation:** Primarily a development workflow; the title's safety framing should not be interpreted as proof of all relevant contract behavior. Current deployment readiness was not tested.
- **Use:** Precedent for external checking in an iterative generation loop. In an audit, protect original code and treat remediation as a separate branch.

### S44 — Octane: continuous analysis and suggested fixes

- **Sources:** [Octane](https://www.octane.security/) and [Code Fix Engine documentation](https://docs.octane.security/essentials/code-fix), living pages.
- **Type / confidence:** VENDOR / DOC; high for positioning, effectiveness unverified here.
- **Observation:** Positions analysis across code changes as complementary to point-in-time audits; documents an assisted remediation feature.
- **Limitation:** Public positioning does not establish false-positive burden on a particular protocol, transparent internals, or that a proposed patch preserves intended behavior.
- **Use:** Candidate source for continuing review. Keep proposed fixes, verification, and merge authority distinct.

### S45 — Olympix: mutation and executable findings

- **Source:** [Olympix product description](https://blue.olympix.ai/), living page.
- **Type / confidence:** VENDOR; medium for effectiveness, high for stated offering.
- **Observation:** Markets static analysis, mutation testing, and a BugPOCer combining program analysis and AI to produce executable proofs of concept.
- **Limitation:** Claims such as low noise or deterministic impact require testing; an executable witness still depends on the correctness of its fixture and attacker assumptions.
- **Use:** Commercial comparator for an evidence-producing workflow, particularly test-suite improvement.

### S46 — Wake Arena: useful transparency, imperfect comparability

- **Source:** [Wake Arena benchmark repository](https://github.com/Ackee-Blockchain/wake-arena-benchmarks), living dataset with updates through April 2026.
- **Type / confidence:** VENDOR / CASE; medium.
- **Observation:** Describes graph-based AI analysis and reports contest and production results. The table separates versions and links findings; production rows distinguish AI findings from total findings.
- **Limitation:** A blanket November 2025 testing date coexists with columns added in 2026. Aggregate “true/false positive rate” terminology needs denominator clarification. Supplier-run comparisons are not interchangeable with EVMbench results.
- **Use:** Ask vendors for exact run manifests, raw candidates, reviewer decisions, and unique contributions rather than relying on the headline table.

### S47 — SmartAuditFlow: adaptive planning

- **Source:** [Adaptive Plan-Execute Framework for Smart Contract Security Auditing](https://arxiv.org/abs/2505.15242), 21 May 2025.
- **Type / confidence:** STUDY; medium for operational transfer.
- **Observation:** Proposes adjusting audit plans based on intermediate analysis, with external knowledge and iterative execution.
- **Limitation:** The reported success on selected benchmarks does not establish that unrestricted autonomous planning meets a professional audit scope.
- **Use:** Let experiments change the next question, while the human retains scope and stopping authority. A rigid one-pass checklist can miss newly exposed interactions.

## 5. Evidence conflicts and claims not to carry forward unqualified

| Issue | What the evidence supports | What it does not support |
|---|---|---|
| EVMbench has 117 or 120 vulnerabilities | Different reviewed artifacts state different counts [S38] | A stable denominator for every published score |
| AI matches 30% of human findings | Overlap in one historical production dataset [S26] | 30% additional discovery or a 30% labor saving |
| Sherlock reports 55.3% precision | 21/38 valid on one scope with independent triage [S30] | A universal production precision rate or a controlled comparison of equally equipped systems |
| AI “verified” a finding | A system applied its own validation procedure | Independent exploitability confirmation without inspecting that procedure |
| Formal proof passes | The checked statement holds within the verifier's model and applicable limits | Complete specification, accurate deployment assumptions, or absence of all defects |
| Fuzzing passes | No violation was observed under the actual campaign | Exhaustive reachability, non-vacuity, or security of untested behaviors |
| Context customization improves coverage | A pilot reported improvement against discovered issues [S28] | Discovery of all bugs, or a guaranteed transferable percentage gain |
| An autonomous system can exploit contracts | Demonstrated in selected controlled environments [S38, S41] | Readiness to replace a human-led unknown-code audit |
| More models produce more findings | May increase candidate breadth | Proportional independent evidence or improved auditor throughput |
| A property-generation paper reports high recall | Its own property/finding metric under its experiment [S35–S36] | Comparable percentages across different denominators and tasks |

No reviewed source establishes a universal winning model, harness, or productivity multiplier for a single auditor. Public evidence for **human time saved per accepted new finding** is particularly weak. These are gaps in the reviewed evidence, not claims that no private evidence exists.

## 6. Reusable internal KB schema

The source cards above describe research. A team's operational vulnerability KB should use a different, mechanism-focused schema:

```yaml
id: PATTERN-0042
title: Share-price manipulation through external balance changes
status: curated  # candidate | curated | disputed | withdrawn
mechanism: "Describe the accounting mismatch, not just the bug name"
protocol_families: [vault, lending]
required_preconditions:
  - "Exact local conditions needed for the mechanism"
attacker_capabilities:
  - "Actions and capital the attacker can legitimately obtain"
counterconditions:
  - "Controls or semantics that make this analogy inapplicable"
property_templates:
  - "A protocol-specific property to consider, requiring human approval"
evidence:
  original_report_url: null
  source_commit: null
  final_adjudication: null
  reproducible_artifact: null
  compiler_and_chain: null
negative_examples: []
retrieval_tags: [accounting, donation, rounding]
review:
  curator: null
  reviewed_at: null
  known_limitations: []
```

Keep separate records for **facts**, **interpretations**, **hypotheses**, **experiments**, and **decisions**. Preserve rejected analogies with their decisive counterconditions. A model should retrieve a possible mechanism and its limitations together.

## 7. Outstanding research and procurement questions

1. Can the selected tool export every candidate, including rejected ones, with raw evidence and run configuration?
2. Does it run against a frozen commit and preserve tool/model versions, test fixtures, and complete error logs?
3. Can a human amend assumptions without regenerating and silently overwriting the entire audit state?
4. Are tool execution and state transitions enforced outside the model, or merely requested in instructions?
5. What source code leaves the workstation, under what retention and training terms, and through which subprocessors?
6. Which language/compiler/chain features are unsupported, and how are unsupported analyses surfaced?
7. What rights apply to each tool, bundled dataset, hosted integration, and redistributed output?
8. On a private, representative scope, how many unique accepted findings arise per human review hour, and what is missed?

These questions are intentionally unresolved. Answering them requires hands-on trials, relevant contractual terms, or vendor disclosure beyond the public evidence reviewed here.
