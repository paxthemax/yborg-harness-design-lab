# DEC-006 DESIGNED and IMPLEMENTED behavior

Status: **accepted process direction**. Date: **2026-10-01**. Decision owner: **lab operator**.

## Decision and rationale

Comprehension maintains two separately inspectable behavioral models: **DESIGNED** and **IMPLEMENTED**. Intake and repeated lensing compare purpose, flows, states, stores, transitions, permissions, accounting and outcomes. Discrepancies are a foundation for bug hunting; agreement also leaves design weaknesses open to investigation.

DESIGNED starts with documentation and develops substantially through auditor input and further applicable evidence throughout the audit. Candidate reconstructions are permitted, attributed and provisional pending review. Documentation first is a starting sequence, not an unconditional source ranking. Code-derived design cannot independently validate the same code's conformity.

The operator requested an Astra Max consultation, selected option A with “taking in docs first” and substantial auditor input and applicable evidence, then explicitly answered “Approved” to the revised process. The consultation found no further consequential questions. [The retained consultation](../research/designed-implemented-consultation.md) preserves alternatives and rationale.

## Accepted process

- Seed and maintain separate source-linked, revision-bound DESIGNED and IMPLEMENTED views.
- Compare both at each lens, tracing design obligations toward implementation and implemented paths toward design explanations.
- Map semantic correspondence, allowing one-to-many states, stores and transitions; different abstractions alone are not discrepancies.
- Preserve comparison coverage, discrepancies, conditions, evidence, uncertainty and next checks as durable records.
- Distinguish missing design evidence, unexamined implementation and examined comparisons with no observed discrepancy.
- Investigate implementation deviations and design weaknesses through the existing human-approved batch workflow.
- Revisit affected comparisons after either model changes, preserving historical evidence and rationale.

## Boundaries and consequences

The auditor owns consequential semantics and finding acceptance. Clarification cannot overwrite observed implementation or retrospectively establish original developer intent. Discrepancies are investigation inputs, not automatically confirmed bugs. The accepted broad-orientation-plus-relevant-flow start policy remains; full-system comparison is not a prerequisite to focused investigation.

This adds modeling and review work; evaluation must measure useful discovery, misleading discrepancies, unresolved gaps and human effort. Detailed schemas and presentation below implement this direction as proposed contracts. No database, engine, implementation or overall architecture is accepted; DEC-003/Q-008 remain proposed.
