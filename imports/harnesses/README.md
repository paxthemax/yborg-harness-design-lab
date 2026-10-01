# Harness diagrams

| Diagram | What it represents |
|---|---|
| [Protocol comprehension](protocol-comprehension-and-specialist-hunt.webp) | Specs and code feed a protocol map, intent invariants, a diff and threat model; specialist agents produce PoCs and a review list. |
| [Human–agent audit workflow](0xflint-human-agent-audit-adaptation.png) | Titled adaptation of 0xFlint’s method: code model, human comprehension check, critical paths, intent comparison, hypotheses, tests and evidence validation. |
| [Auditor-led audit workflow](protocol-audit-flow-walk-and-agent-hunt.png) | Understand the protocol, build a threat model, walk each flow, dispatch agents, triage, prove and report; includes feedback loops. |
| [Agent orchestration and triage](specialist-agent-hunt-and-human-triage.png) | Scope and context feed bug-class subagents, followed by duplicate/bug-chain checks, eligibility and reachability verification, and human disposition. |
| [Human–AI collaboration](ivanfitro-human-ai-audit-workflow.png) | Parallel human and AI lanes connect manual review, orchestrated agents, triage, deep dives and validation to confirmed findings. |
| [Comprehension and evidence workflow](0xflint-comprehension-hunt-and-evidence-loop.png) | Intent and implementation models become a system model and threat diff; hunting, human prioritization, a consensus runner, tests and validation feed back into the model. |
| [Harness architecture](review-harness-independent-methods-architecture.png) | Frozen preparation feeds four independent review methods and bounded child reviews; shared critique, evidence checks and human judgment lead to reports with provenance. Includes planned extensions. |
| [Invariant-driven audit workflow](ad3sh-invariant-driven-smart-contract-audit-workflow.jpg) | Eight stages cover intake, system modeling, security properties, path analysis, attack generation, proof, human review and findings, with a knowledge base and feedback loop. |
| [Development and audit integration](development-code-review-and-auditor-loop.png) | Mandatory code review plus an additive Solidity audit workflow with PR-delta, Core and Thorough modes, shared threads and PoCs. Human check-in is optional. |
| [Question-driven harness workflow](human-ai-question-driven-audit-workflow.png) | Progressive comprehension builds a shared system model; deviations become precise questions for partner or pipeline mode, independent verification, human judgment, reporting and learning. Distinguishes first-version work from later extensions. |
| [Evidence investigation loop](hypothesis-trace-probe-and-evidence-triage.png) | Docs, threat model and other signals identify weakness areas; hypothesis, trace and probe lead to triage, validation, ruled-out leads or open questions, an audit log, deduplication and a final report. |
