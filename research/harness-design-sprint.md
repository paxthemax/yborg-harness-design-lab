# Audit harness research and design sprint

Date: **2026-10-01**. Author: **Codex**. Status: **research and proposed synthesis**. The [operator decisions](../decisions/DEC-002-harness-operating-envelope.md) establish the first ecosystem, interaction model, and deployment envelope. They do not approve the whole [harness proposal](../design/audit-harness.md).

The proposed harness extends the imported evidence workbench with explicit contracts for authority, shared state, experiment validity, recovery, and change review. The research supports borrowing individual mechanisms from existing systems; it does not establish a winning framework or a productivity gain for this operator.

## Research method and limits

Read all three supplied reports and visually inspected all eleven supplied diagrams. Used keyword retrieval and the PLUR-format files directly; no PLUR engine is connected. Opened primary documentation and papers to check selected inherited claims and investigate gaps. [SRC-006–022](../kb/sources.md#sprint-primary-sources) records exactly which sources and sections were inspected, including access limits.

The new research concentrates on five questions: how to recover interrupted work; where to enforce permissions; how to keep agents from corrupting shared conclusions; how to assess generated experiments; and how to measure value without rewarding noise. This is desk research and a specification walkthrough, not execution of the proposed harness. Source documentation establishes described behavior. Studies and case reports retain their own sampling and measurement limits.

Original imports remain unchanged. Their source IDs are namespaced, such as `SRC-001/S25`. This sprint does not reverify all 47 citations, procure products, choose a model, or execute contract exploits. Paper publication dates and document versions are recorded only where available. Living documentation must be pinned again at implementation time.

## What the reports contribute

| Import | Retained contribution | Extension in this sprint |
|---|---|---|
| [Research report](../imports/01-audit-harness-research.md), M01–M08 and evidence conflicts | Intent and implementation differ; tools answer bounded questions; benchmark scores have different denominators | Typed system records; explicit tool result vocabulary; evaluation accounting |
| [Independent assessment](../imports/02-audit-harness-independent-assesment.md), sections 2–4 | Auditor attention is scarce; preserve disproofs; choose a decisive experiment | Small batch authorization, review capacity limit, question routing and prerequisite dependencies |
| [Three designs](../imports/03-audit-harness-top-three-designs.md), sections 2–7 | Evidence workbench, property work, and scenarios share authority and evidence needs | One investigation contract with three methods, separate execution and adjudication states, immutable evidence and revision-specific decisions |

The reports are related synthesis, not three independent confirmations. The initial preference for an evidence workbench remains a design recommendation. Property engineering may deserve more of an engagement's budget for accounting-heavy protocols; integration scenarios may dominate another engagement.

## Diagram extraction and dispositions

These are observations of visible content and proposed adaptations. Attribution printed inside an image is not independently verified authorship. The [original manifest](../imports/harnesses/README.md) remains a simple image index.

| Diagram | Useful mechanism | Proposed adaptation or correction |
|---|---|---|
| [Protocol comprehension](../imports/harnesses/protocol-comprehension-and-specialist-hunt.webp) | Separate spec and code inputs; compare invariants with a protocol map | Keep disagreements as records, then map them to bounded investigations |
| [Human–agent adaptation](../imports/harnesses/0xflint-human-agent-audit-adaptation.png) | Human comprehension check and human validation after tests | Bind both decisions to specific model and evidence revisions |
| [Auditor-led flow walk](../imports/harnesses/protocol-audit-flow-walk-and-agent-hunt.png) | Walk complete flows before specialist hunting; feed false positives back into context | Preserve the original lead and the scope of its refutation; avoid a global “safe pattern” exclusion |
| [Specialist hunt and triage](../imports/harnesses/specialist-agent-hunt-and-human-triage.png) | Duplicate and bug-chain review before human disposition | Cluster root causes without deleting origins; examine chains as new claims |
| [Human and AI lanes](../imports/harnesses/ivanfitro-human-ai-audit-workflow.png) | Manual notes survive into validation; interactive deep dives | Keep an auditor notebook and optional initial blind pass; AI validation is a recommendation |
| [Comprehension and evidence loop](../imports/harnesses/0xflint-comprehension-hunt-and-evidence-loop.png) | Intent model, implementation model, and disputed questions | Use disagreement to select experiments. Model agreement supplies no proof or extra discovery credit |
| [Independent review architecture](../imports/harnesses/review-harness-independent-methods-architecture.png) | Frozen packets, separate first passes, bounded children, completion barrier | Borrow snapshot isolation and explicit failure accounting; avoid mandatory four-lane fan-out for every question |
| [Invariant-driven workflow](../imports/harnesses/ad3sh-invariant-driven-smart-contract-audit-workflow.jpg) | Property construction, reachability checks, human semantic review | “All reachable paths” becomes a bounded coverage objective. Failed reproduction may mean blocked or unknown. Tool classification must name mode/version |
| [Development and auditor loop](../imports/harnesses/development-code-review-and-auditor-loop.png) | Frozen deltas and retained threads across a fix | Optional human control conflicts with this repository. Automatic patching and PR delivery are outside this harness's initial authority |
| [Question-driven workflow](../imports/harnesses/human-ai-question-driven-audit-workflow.png) | Progressive comprehension; precise question; fresh challenge; human disposition | Include dependency assumptions and basic deduplication in v1. They cannot be deferred when they affect validity. Fork execution can be conditional on an investigation |
| [Hypothesis, trace, probe](../imports/harnesses/hypothesis-trace-probe-and-evidence-triage.png) | Retain credible, ruled-out, and unresolved outcomes | Closure exports unresolved exposure as well as confirmed findings; absence of a finding does not erase the investigation |

One live-source correction matters: the invariant diagram puts Echidna under symbolic execution. A blanket correction to “Echidna only fuzzes” would also be wrong: its current README describes both fuzzing and a separate single-transaction verification mode. The proposed adapter advertises exact supported modes and records the selected mode. No compatibility was exercised. [Echidna testing modes](https://github.com/crytic/echidna#testing-modes).

## Primary research findings

### Existing audit agents supply patterns to inspect

**Observation:** sc-auditor documents staged mapping, hunting, attack construction, and skeptical verification. Its settings leave executable witnesses optional and its benchmark mode can demote unproven findings. Hound describes evolving agent-built graphs and evidence-linked hypotheses. [sc-auditor](https://github.com/Archethect/sc-auditor), [Hound technical description](https://raw.githubusercontent.com/scabench-org/hound/main/tech.md).

**Interpretation:** adopt their useful decomposition as design precedent, not their claims of effectiveness. Keep potential impact separate from proof status, and keep a model-created graph distinguishable from compiler-derived structure. Neither inspected document establishes the enforcement and human decision contract required here.

### Checkpointing does not settle application authority

**Observation:** LangGraph separates thread checkpoints from cross-thread stores, and warns that code preceding an interrupt can run again on resumption. Temporal documents retryable Activities and the need for idempotency when execution completes without a recorded response. [LangGraph persistence](https://docs.langchain.com/oss/python/langgraph/persistence), [interrupt behavior](https://docs.langchain.com/oss/python/langgraph/interrupts#side-effects-called-before-interrupt-must-be-idempotent), [Temporal Activities](https://docs.temporal.io/activity-definition#idempotency).

**Recommendation:** durable jobs need unique attempts, reconciled receipts, and bounded retries. Human decisions need separate authenticated records tied to the reviewed revision. A resumed agent conversation cannot itself restore permission. Framework selection should follow a recovery trial against this contract.

### Small local state still needs transactional writes

**Observation:** SQLite serializes writes and hides uncommitted changes from ordinary separate connections. [SQLite isolation](https://www.sqlite.org/isolation.html).

**Recommendation:** use one controller as the only writer to engagement metadata, with immutable evidence files and portable exports. A transactional store is a reasonable first implementation candidate because several agents can finish together. This is an extension beyond the import's file-first prototype, not a change to the lab's accepted PLUR/YAML workflow. A database is proposed for the future harness only.

### Execution isolation and tool protocols solve different problems

**Observation:** gVisor's security model explicitly leaves network policy and resource limits to surrounding mechanisms. MCP security guidance describes local server compromise and warns about credential passthrough. [gVisor security model](https://gvisor.dev/docs/architecture_guide/security/), [MCP security practices](https://modelcontextprotocol.io/docs/2025-11-25/tutorials/security/security_best_practices).

**Recommendation:** isolate repository builds and generated tests, route approved model requests through a separate credential broker, and enforce a read-only upstream RPC policy independently of the local fork. Selecting MCP does not select a sandbox. An allowed provider domain also does not authorize sending arbitrary engagement files.

### A working test can ask the wrong question

**Observation:** Foundry's indexed official invariant documentation explains handler and action metrics, including campaigns in which useful actions revert. Certora documents checks for vacuous rules and trivial invariants. Curvance's case report describes maintenance and debugging difficulties as target changes invalidate properties and corpora. [Foundry invariants](https://getfoundry.sh/forge/invariant-testing?highlight=invariant), [Certora sanity checks](https://docs.certora.com/en/latest/docs/prover/checking/sanity.html), [Curvance case report](https://blog.trailofbits.com/2024/04/30/curvance-invariants-unleashed/).

**Recommendation:** review semantic intent, reachable actions, and oracle independence separately from the tool result. Preserve generated-test revisions; a repair that removes an assertion or adds assumptions must reopen semantic review. Foundry was read through its indexed official text after direct retrieval failed, so specific options need version checks before use.

### Coordination studies do not justify an agent fleet

**Observation:** SPEAR compares coordination and recovery mechanisms under injected failures. Its stated limitations include modest samples and a repair metric that measures compilation/execution rather than semantic correctness. Human interaction is future work in the paper. [SPEAR v1, sections 3–4.6](https://arxiv.org/html/2602.04418v1).

**Interpretation:** bounded artifact repair and fault isolation are useful ideas. Its results do not establish that auctions, distributed planning, or autonomous adjudication are necessary for one auditor. The proposed controller uses a simple queue; complexity must earn its place through the pilot.

### Benchmark realism and grading remain separate concerns

**Observation:** CyberChainBench evaluates historical fork tasks and discusses failures of its original reward design. Its detection score matches type/function labels, while exploit and patch tasks use execution; the paper's broad execution-only framing should not be transferred to every task. Its limitations include public-case contamination and largely atomic attacks. [CyberChainBench v1, sections 3, 4.3 and limitations](https://arxiv.org/html/2606.26216v1).

**Recommendation:** separate detection, reproduction, impact, and fix preservation. Require successful legitimate behavior during fix review. Include lockup and multi-transaction cases in a future pilot, and do not equate a profit oracle with all security impact.

**Observation:** ReEVMBench notes single-trial evaluations and detection grading that cannot credit unknown findings or penalize false positives. OpenZeppelin disputes labels in a subset of EVMbench. [ReEVMBench v1, section 8](https://arxiv.org/html/2603.10795v1), [OpenZeppelin critique](https://www.openzeppelin.com/news/openai-evmbench-audit).

**Recommendation:** curate evaluation labels, preserve disputes, count human adjudication time, and avoid a universal model ranking. These publications are evidence of evaluation limitations; their disputed cases were not rerun here.

## Design alternatives and rationale

| Choice | Proposed direction | Alternative and reason to revisit |
|---|---|---|
| Main product | Persistent evidence workbench with hypothesis, property, and scenario methods | Property-first when specification reuse dominates; scenario-first when integration risk dominates |
| Work allocation | One controller, small authorized batches, role-specific contexts | Broad parallel campaigns if review capacity and independent contribution justify them |
| State | Transactional metadata, immutable evidence, linked semantic records | Files alone for a demonstrably single-writer prototype; distributed storage for a future shared service |
| Workflow engine | Define the job contract first; compare a small local runner with LangGraph | Temporal if long-running remote jobs and recovery operations justify a service |
| Knowledge representation | Typed records and links, keyword retrieval initially | Graph database or embeddings after measured query or retrieval limitations |
| Initial tools | Compiler-backed inventory, Slither, Foundry/Anvil | Specialist fuzzers, symbolic/formal tools, or hosted scanners per unresolved question |
| Verification | Fresh prerequisite challenge, checked artifacts, clean replay, human disposition | Repeated model voting adds little unless it exposes a distinct, testable premise |

These recommendations are scoped to one auditor and the accepted operating envelope. No framework, vendor, database, or sandbox implementation is installed or adopted by this sprint.

## Specification walkthrough

These are thought experiments against the draft requirements, not runtime results. Their detailed expected behavior appears in [the state specification](../design/harness-state-and-execution.md) and [evaluation scenarios](../design/harness-evaluation.md).

| Case | Design issue exposed | Resulting rule |
|---|---|---|
| Two workers edit the same assumption | Last-write-wins can erase a contradiction | Submit proposals against expected revisions; retain conflicting proposals |
| Worker finishes, controller crashes before acknowledging | Retry can create duplicate runs or charges | Reconcile run receipts; accept a result once; classify uncertain remote calls explicitly |
| Auditor approves evidence while an upstream premise changes | A valid click can approve obsolete evidence | Compare reviewed dependency revisions in the commit transaction |
| A test passes because every withdrawal reverts | Green result can hide untested behavior | Record successful action/state witnesses and adequacy status |
| A reentrancy lead is rejected, then its guard changes | Negative evidence can suppress a newly real issue | Invalidate rejected conclusions as well as findings |
| A generated repair changes the expected withdrawal amount | Test repair can redefine correctness | Version the oracle and require semantic review for changed meaning |
| A malicious README requests a private key or a new tool | Source content can be mistaken for authority | Separate data from policy; worker cannot obtain credentials or install tool servers |
| One callback is blocked in a patch but all exits now revert | Old exploit failing can masquerade as a complete fix | Replay the exploit and relevant legitimate paths; inspect related changes |

## Remaining evidence gaps

The proposal still needs trials of runtime recovery, analyzer compatibility, replay portability, reviewer workload, and deployment isolation. Numeric concurrency and queue settings are starting hypotheses. Hosted-provider terms, engagement retention policy, and actual model/tool versions belong to implementation or engagement intake. Product licensing and redistribution were not assessed.

SEMA and other papers appeared in the survey; SEMA's full publisher page could not be retrieved and was excluded from design support. Abstract-only discovery was not treated as verification. Benchmark percentages, vendor speedups, and unverified claims of complete coverage were deliberately not used as product acceptance targets.

The [verification record](harness-sprint-verification.md) records the delivered documents' inspection separately from these future runtime checks.

## Full specification handoff

The completion pass made two implicit parts of the first proposal explicit: component request/error contracts and the auditor's operating workflow. The [interface specification](../design/harness-interface-contracts.md) covers capability registration, revision checks, idempotency, uncertain execution and portable report/PoC handoff. The [auditor guide](../design/harness-auditor-guide.md) covers each human action from intake to export, including blocked, stale and incomplete states.

These are proposed design elaborations of the recorded authority, recovery and evidence requirements, not newly observed behavior of a framework. In particular, an idempotent response acknowledges a historical commit rather than renewing its authority, and a report release receipt refers to a frozen payload rather than being included in its own hash. The additions resolve routine specification ambiguities without accepting the architecture or selecting a runtime. [The completion audit](harness-specification-completeness.md) checks them against the full repository scope.
