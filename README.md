# Audit Harness Design Lab

This repository specifies an AI-agent harness for auditing smart contract systems. One human auditor directs several classes of agents and owns consequential decisions. The lab preserves research, design proposals, and decision rationale; it contains no harness implementation.

The result of this design is the specification for building this framework, including:

- Framework product definition
- Functional and non-functional requirements
- Component architecture
- Interaction flows

## Harness proposal

Start with the [human led EVM audit harness proposal](design/audit-harness.md). It recommends a persistent evidence workbench with bounded investigations, property campaigns, scenario analysis, explicit human decisions, and reproducible evidence.

- [State, execution, isolation and memory contracts](design/harness-state-and-execution.md)
- [Component interfaces, adapters and portable packages](design/harness-interface-contracts.md)
- [Auditor workflow and review guide](design/harness-auditor-guide.md)
- [Functional and non-functional requirements](design/harness-requirements.md)
- [Evaluation and improvement plan](design/harness-evaluation.md)
- [Extended research and diagram comparison](research/harness-design-sprint.md)
- [Accepted operating choices](decisions/DEC-002-harness-operating-envelope.md) and [evidence policy](decisions/DEC-004-confirmation-evidence-policy.md)
- [Proposed architecture and alternatives](decisions/DEC-003-harness-architecture-proposal.md)
- [Delivery verification and limits](research/harness-sprint-verification.md)
- [Full specification completion audit](research/harness-specification-completeness.md)

The operator selected Solidity/EVM first, small approved batches, a local workspace with approved cloud AI, and justified alternative evidence when a runnable PoC is impractical. The complete architecture remains a proposal for review.

## Knowledge and memory

The lab's [knowledge base](kb/README.md) preserves source-backed claims and unresolved questions. The [knowledge and memory design](design/knowledge-and-memory.md) uses PLUR for reusable guidance and session history alongside research and decision records.

- [PLUR research and implementation limits](research/plur-assessment.md)
- [Accepted memory policies and trade-offs](decisions/DEC-001-knowledge-and-memory.md)
- [Operator questions and answers](kb/questions.md)
- [Current session handover](memory/session.md)
- [PLUR-format starter store](memory/plur/README.md)

The design covers this lab first: repository-local isolated memory, automatic learning with periodic review, and keyword retrieval initially. PLUR installation and agent-host integration are separate work.

## Development scope
In scope:

- Harness (software substrate) design
- Shared memory and/or knowledge base design for said harness
- Research of system under audit -- knowledge intake and systematization
- Guided clarification aimed at human auditor
- Audit process the harness uses (stages and flows)
- Agent role classification
- Human in the loop interaction touchpoints
- Audit outcomes (confirmation reports and PoCs)
- Quality and recursive improvement measurement

Out of scope:

- Model training and training preparation
- Full automation of the audit process
