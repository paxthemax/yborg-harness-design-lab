# Source register

Registered: **2026-10-01**. Local inputs remain in `imports/`. Fingerprints identify the bytes inspected for this initial intake; preserve this observation if the file later changes.

## SRC-001 — Audit harness research

- **Path:** [01-audit-harness-research.md](../imports/01-audit-harness-research.md).
- **Source date/version:** 2026-09-29 / 1.0, as declared by the input.
- **Class:** imported research containing DOC, CASE, STUDY, VENDOR, and SYNTHESIS labels.
- **SHA-256:** `b8f6b6b89835fb64d888dac2c7161fe1740ba56a99e5a344b964cbe772a679a7`.
- **Useful locators:** section 1 evidence policy; M01–M08 methodology; S01–S47 evidence cards; section 6 KB schema; section 7 unresolved questions.
- **Limits:** confidence labels belong to the claims specified in the input. The initial intake did not reverify external citations; selected checks from the later sprint are registered below, not a revalidation of all reported results.
- **Intake:** read in full for the [harness sprint](../research/harness-design-sprint.md), with selective design extraction and primary-source checks. [K-002](claims/K-002-evidence-and-memory.md) uses the evidence distinctions. Embedded source IDs use this namespace, e.g. `SRC-001/S24`.

## SRC-002 — Independent assessment

- **Path:** [02-audit-harness-independent-assesment.md](../imports/02-audit-harness-independent-assesment.md).
- **Source date/version:** 2026-09-29 / 1.0, as declared by the input.
- **Class:** SYNTHESIS; the input explicitly labels its proposals design judgments.
- **SHA-256:** `090873e8c4812f839ad577196762e4da1fee130ba4f78f2894cb0e65256c615d`.
- **Useful locators:** section 1 recommendation; section 2 intent/implementation/assumptions/guarantees/unknowns; section 3 claims under challenge; section 7 conditions that change the recommendation.
- **Limits:** proposed workflows, not measured lab outcomes or operator decisions.
- **Intake:** read in full for the harness sprint; recommendation and constraints synthesized in the research and proposed specification. Earlier cards [K-001](claims/K-001-evidence-workbench.md) and [K-002](claims/K-002-evidence-and-memory.md) remain applicable.

## SRC-003 — Top three designs

- **Path:** [03-audit-harness-top-three-designs.md](../imports/03-audit-harness-top-three-designs.md).
- **Source date/version:** 2026-09-29 / 1.0, as declared by the input.
- **Class:** SYNTHESIS; proposed architectures and operating flows.
- **SHA-256:** `926645b82156723ce673eefdb85fe8357e6483abce8db230661c772793920e54`.
- **Useful locators:** section 1 comparison; section 2 human authority; sections 3–5 methods; section 6 closure; section 7 evaluation.
- **Limits:** the input says the designs have not been implemented or benchmarked in that research. Recommendation is not adoption.
- **Intake:** read in full for the harness sprint; all three methods, authority rules, closure and evaluation compared in the new proposal. Earlier [K-001](claims/K-001-evidence-workbench.md) remains an attributed recommendation.

## SRC-004 — PLUR assessment

- **Path:** [plur-assessment.md](../research/plur-assessment.md).
- **Research date:** 2026-10-01.
- **Upstream:** [plur.ai](https://plur.ai/) and [plur-ai/plur](https://github.com/plur-ai/plur/tree/434ca65e71243a303bee9b0661f5f3bd11558682).
- **Revision inspected:** `434ca65e71243a303bee9b0661f5f3bd11558682`; package manifests identify `0.21.0`.
- **Class:** DOC for inspected mechanics; SYNTHESIS for proposed lab adaptations.
- **Limits:** source inspection only. No runtime installation, npm release verification, host integration, or benchmark replication. Website prose and implementation differ on candidate promotion.
- **Intake:** completed for the named starter-design scope: record formats, draft commitment, store selection, retrieval, history, and integration limits. Wider PLUR feature assessment remains outside this intake.

## Historical filenames in the imports

The reports refer to companion files using their earlier names. Resolve those references through this table without altering the supplied reports:

| Historical name | Current record |
|---|---|
| `01_Audit_Harness_Research_KB.md` | SRC-001 |
| `02_Audit_Harness_Independent_Assessment.md` | SRC-002 |
| `03_Audit_Harness_Top_Three_Designs.md` | SRC-003 |

## SRC-005 — Imported harness diagrams

- **Path:** [Harness diagram manifest](../imports/harnesses/README.md), containing 11 diagrams.
- **Class:** imported visual workflow and architecture references; classifications are interpretations of visible content.
- **Inspection date:** 2026-10-01.
- **Files:** descriptive filenames link from the manifest; renaming preserved all image bytes.
- **Limits:** source URLs, publication dates and independently verified authorship are unavailable. No effectiveness or implementation claims were verified; no architecture was adopted.
- **Intake:** all eleven images visually inspected and extracted in [the sprint comparison](../research/harness-design-sprint.md#diagram-extraction-and-dispositions). The development and auditor loop describes optional human participation, which differs from the lab's standing scope. Other adaptations and version-dependent tool labels are recorded there without altering images or the manifest.

## Sprint primary sources

Accessed **2026-10-01** for this design sprint. Each record covers only the named sections and observation. Living documents were inspected as served, without a pinned source commit or installed binary; no runtime behavior or performance was verified. Recheck and pin them during implementation. The research record separates observations from proposed consequences.

| ID | Primary source and inspected locator | Class and useful observation | Verification limits and disposition |
|---|---|---|---|
| SRC-006 | [sc-auditor README](https://github.com/Archethect/sc-auditor), version label 2.0.0; workflow/configuration, verification and reporting | DOC; staged agent work and optional witness policy | Selected check of SRC-001/S25; documentation only, no enforcement audit |
| SRC-007 | [Hound technical description](https://raw.githubusercontent.com/scabench-org/hound/main/tech.md), sections 1–6 | DOC; agent-built evolving graphs, hypotheses and provenance | Selected check of SRC-001/S24; architectural claims, not tested completeness or performance |
| SRC-008 | [Slither README](https://github.com/crytic/slither), printers and tools | DOC; structural views, entry points, state writers and call graph | Selected check of SRC-001/S07; target compatibility and semantic completeness untested |
| SRC-009 | [Foundry invariant testing](https://getfoundry.sh/forge/invariant-testing?highlight=invariant), handler-based testing and function-call metrics | DOC; useful actions and reverts affect interpretation of successful campaigns | Selected check of SRC-001/S10. Direct fetch failed with unsupported Markdown content type; indexed official full text was readable, with an older crawl. Options need version checks |
| SRC-010 | [Echidna README](https://github.com/crytic/echidna), testing modes, corpus and output | DOC; fuzzing, retained sequences and a separately described symbolic verification mode | Selected check of SRC-001/S11; current documentation should not be generalized to every release or mode |
| SRC-011 | [Certora rule sanity checks](https://docs.certora.com/en/latest/docs/prover/checking/sanity.html), vacuity and trivial invariants | DOC; a successful rule can be vacuous | Selected check of SRC-001/S15; sanity checks cannot establish that a property captures the intended guarantee |
| SRC-012 | [Curvance case report](https://blog.trailofbits.com/2024/04/30/curvance-invariants-unleashed/), 2024-04-30; changing code and debugging | CASE; evolving targets can invalidate properties and corpora | Selected check of SRC-001/S13; supplier engagement report, no independent replication |
| SRC-013 | [LangGraph persistence](https://docs.langchain.com/oss/python/langgraph/persistence) and [interrupts](https://docs.langchain.com/oss/python/langgraph/interrupts), checkpoint/store distinction and side effects before interrupt | DOC; persistence mechanisms have different scopes; resumption may reexecute preceding operations | New substrate research. Durable-execution URL redirected to persistence. No library/version adoption or integration trial |
| SRC-014 | [Temporal Workflows](https://docs.temporal.io/workflows) and [Activity definition](https://docs.temporal.io/activity-definition#idempotency), idempotency and retries | DOC; activity retries can repeat execution after unrecorded completion | New substrate research; no service, SDK or performance evaluation |
| SRC-015 | [SQLite isolation](https://www.sqlite.org/isolation.html), isolation between connections | DOC; serialized writes and ordinary committed-read visibility | New persistence research; does not establish the proposed application schema or recovery implementation |
| SRC-016 | [gVisor security model](https://gvisor.dev/docs/architecture_guide/security/), exposure limits and surrounding policy | DOC; sandboxing needs external resource and network controls | New isolation research; no runtime selected or isolation test performed |
| SRC-017 | [MCP security best practices](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices), local server compromise and token passthrough | DOC; tool-server deployment and credentials have explicit trust boundaries | New integration research; requested older specification URL redirected to 2025-11-25 guidance; not an installed protocol version |
| SRC-018 | [OWASP SCSVS](https://scs.owasp.org/SCSVS/), introduction and related testing/checklist resources | DOC; verification controls connect to testing guidance | Selected check of SRC-001/S05; living/refactoring standard, no compliance or completeness certification inferred |
| SRC-019 | [SPEAR v1](https://arxiv.org/html/2602.04418v1), 2026-02-04; sections 3, 4 and validity limits | STUDY; explicit coordination and bounded generated-artifact recovery | New study. Modest benchmark/failure-injection setting; compilation success is not semantic test validity; no replication |
| SRC-020 | [CyberChainBench v1](https://arxiv.org/html/2606.26216v1), sections 3, 4.3 and limitations | STUDY; historical fork experiments, task-specific grading and reward-design failures | New study. Public-case contamination and largely atomic scope; detection includes label matching; no replication or claim that its taxonomy covers all audit risks |
| SRC-021 | [ReEVMBench v1](https://arxiv.org/html/2603.10795v1), section 8 and evaluation implications | STUDY; task/scaffold differences and incomplete grading matter | Selected check of SRC-001/S40; authors note mostly single trials, routing and false-positive/unknown-finding limits |
| SRC-022 | [OpenZeppelin EVMbench critique](https://www.openzeppelin.com/news/openai-evmbench-audit), 2026-03-02; dataset quality | CASE; disputes some benchmark ground-truth labels | Selected check of SRC-001/S39; subset critique, disputed cases not rerun or checked against subsequent dataset changes |

**Intake disposition for SRC-006–022:** completed for the named documentation and research questions; implementation behavior, procurement, licensing and quantitative performance remain unverified. [Research synthesis](../research/harness-design-sprint.md) identifies the resulting proposals and evidence gaps.

## Comprehension review primary sources

Accessed **2026-10-01** for the [comprehension review](../research/comprehension-methodology-review.md). These studies motivate proposed mechanisms; none evaluates this harness, establishes expert-audit learning gains, or supports ADHD-specific claims. Inspection was selective and no experiment was replicated.

| ID | Primary source and inspected locator | Class and useful observation | Verification limits and disposition |
|---|---|---|---|
| SRC-023 | [Sillito, Murphy and De Volder, Questions Programmers Ask During Software Evolution Tasks](https://www.cs.ubc.ca/~murphy/papers/other/asking-answering-fse06.pdf), FSE 2006; abstract and sections 6–7 | STUDY; linked information needs and difficulty integrating tool answers | Qualitative maintenance studies, short sessions, task/tool dependence; no auditing effectiveness claim |
| SRC-024 | [Karpicke and Blunt, Retrieval Practice Produces More Learning than Elaborative Studying with Concept Mapping](https://learninglab.psych.purdue.edu/downloads/2011/2011_Karpicke_Blunt_Science.pdf), Science 331, 772–775 (2011), DOI 10.1126/science.1199327; experiments 1–2 | STUDY; delayed conceptual benefits of retrieval in the studied learning conditions | Science-text learning, not expert auditing; does not discredit diagrams as navigation aids. Yale mirror failed; author's Purdue copy was inspected |
| SRC-025 | [Chi, de Leeuw, Chiu and LaVancher, Eliciting Self-Explanations Improves Understanding](https://education.asu.edu/sites/g/files/litvpz656/files/lcl/chideleeuwchiulavancher_3.pdf), Cognitive Science 18, 439–477 (1994); abstract and method | STUDY; prompted causal explanation and improved understanding in the study | Small school-age sample and circulatory-system material; expert-audit transfer untested |
| SRC-026 | [Mayer and Chandler, When Learning Is Just a Click Away](https://tecfa.unige.ch/tecfa/teaching/methodo/Mayer_Chandler01.pdf), Journal of Educational Psychology 93, 390–397 (2001), DOI 10.1037/0022-0663.93.2.390; indexed abstract | STUDY; learner-controlled animation segments improved transfer but not retention in two experiments | Abstract-level intake; served PDF yielded no extracted text. No optimal pacing, audit-domain or ADHD claim |
| SRC-027 | [Buçinca, Malaya and Gajos, To Trust or to Think](https://www.eecs.harvard.edu/~kgajos/papers/2021/bucinca21trust.pdf), PACM HCI 5, CSCW1, article 188 (2021); task and discussion | STUDY; lower overreliance with forcing interventions, acceptability costs and no significant overall performance advantage | Nutrition decisions with simulated assistance; does not justify universal forced interaction or personal profiling |
| SRC-028 | [Vasconcelos et al., Explanations Can Reduce Overreliance on AI Systems During Decision-Making](https://arxiv.org/pdf/2212.06823v2), arXiv v2, 2023-01-26 / CSCW 2023; abstract, study summaries and section 10.4 | STUDY; verification costs/benefits influence use of explanations | Controlled low-stakes mazes, crowd workers and ideal explanations; generalization to open-ended expert work remains unknown |

**Intake disposition for SRC-023–028:** completed for the named mechanism review, with SRC-026 limited to its abstract. The [proposed method](../design/harness-comprehension-method.md) contains design inferences rather than accepted policy or measured results.

## Lensing and EVM modeling sources

Accessed **2026-10-01** for the [second comprehension pass](../research/comprehension-methodology-review.md#second-pass-lensing-and-state-machines). These are selected language/EVM semantics checks; representation and exploration contracts remain proposed. The inspected documentation version does not select the compiler or hardfork for an engagement.

| ID | Primary source and inspected locator | Class and useful observation | Verification limits and disposition |
|---|---|---|---|
| SRC-029 | [Solidity 0.8.30 control structures](https://docs.soliditylang.org/en/v0.8.30/control-structures.html), external calls and error handling | DOC; shared transaction, callbacks and handled/propagated failure | Documentation inspection only; target wrappers, guards and reachable paths require their own evidence |
| SRC-030 | [Solidity 0.8.30 introduction](https://docs.soliditylang.org/en/v0.8.30/introduction-to-smart-contracts.html), gas, storage/memory/stack, message calls and delegatecall | DOC; data lifetimes and code/storage context differ | Does not identify any engagement's actual storage, proxy target or fee semantics |
| SRC-031 | [EIP-1153](https://eips.ethereum.org/EIPS/eip-1153), specification | DOC; transient storage lifetime, ownership and revert behavior | Applicability depends on target hardfork/tool support; no tool conformance trial |
| SRC-032 | [EIP-140](https://eips.ethereum.org/EIPS/eip-140), motivation and specification | DOC; execution rollback including logs | Call/transaction outcomes still need target-specific propagation and handling analysis |

**Intake disposition for SRC-029–032:** complete for the named semantics review. No runtime behavior, deployment mapping, formal refinement proof or diagram implementation was verified.
