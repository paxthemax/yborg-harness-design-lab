# DEC-002 Harness operating envelope

Status: **accepted for Q-004–006 only**. Date: **2026-10-01**. Decision owner: **lab operator**.

## Question and context

Which ecosystem, auditor interaction model, and deployment envelope should constrain the first harness proposal? The operator requested an extended research and design sprint, authorized resolution of trivial internal issues, and requested focused questions for consequential choices.

The [sprint research](../research/harness-design-sprint.md) and original reports support a human-led workflow but cannot select the operator's priorities. DEC-001 continues to govern the design lab's memory; this decision concerns the future audit harness.

## Options and accepted choices

| Question | Options considered | Operator selection and consequence |
|---|---|---|
| Q-004 Ecosystem | EVM first; multiple ecosystems initially; another first ecosystem | **Solidity/EVM first; leave room for later adapters.** The initial analysis and execution contract targets EVM semantics |
| Q-005 Work selection | Small batches; every question interactively; broad campaigns with milestone reviews | **Approve small batches of investigations.** Each batch has explicit questions and a budget; routine steps inside it do not need repeated permission |
| Q-006 Deployment | Local workspace with approved cloud AI; entirely local inference; centrally hosted workspace | **Local workspace with approved cloud AI providers.** The design may route necessary code/context to approved providers while keeping engagement state local |

Small batches trade some scheduling autonomy for manageable review and steering. A local workspace reduces initial service operations; allowing cloud inference makes external data handling an explicit engagement policy. Neither choice selects a provider or approves disclosure of any particular client's material.

## Acceptance evidence and boundaries

The operator answered three focused questions in this session with the selections above, on 2026-10-01. The scope question explained that it determines code-analysis, testing, and reproduction adapters. The batch question described auditor-approved questions/budget followed by returned evidence and blockers. The deployment question explicitly asked whether approved cloud providers may receive needed audit code/context.

**Not decided here:** primary architecture, state-store technology, workflow engine, model/provider, exact numeric budgets, evidence sufficiency exceptions, or a runtime implementation. Those remain proposed or engagement-specific. The specification is a proposal within this accepted envelope.

**Supersedes:** none. **Affected records:** Q-004–006, the harness design documents, session handover, and grounded lab memories. No change to DEC-001's isolated repository-local PLUR store or sharing policy.
