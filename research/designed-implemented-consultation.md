# DESIGNED vs IMPLEMENTED consultation

Date: **2026-10-01**. Consultation requested by the operator with **Astra Max**. The agent was requested as gpt-6-astra with max reasoning; immutable provider identity was not independently verified. No external research or runtime validation was performed.

## Review finding

FR-04, lensing steps 2–5, the auditor guide and the product proposal already separated intent from code, preserved contradictions and recognized design risks. Missing were mandatory distinct model views, semantic correspondence, repeated comparison, persistent discrepancies and comparison coverage. One shared implementation-shaped explanation could otherwise conceal missing expectations or unexpected functionality.

## Recommendation and rationale

Organize comprehension around DESIGNED and IMPLEMENTED behavior. Independently seed both; compare at purpose, flow, state, store and transition levels, in both directions. Compare meaning rather than diagram shape: several functions or transactions may implement one designed transition. Retain revision-bound correspondence and discrepancy records, source support, uncertainty and next checks. Side-by-side views expose both behavior and comparison gaps. Agreement does not establish security; challenge the designed behavior itself against security objectives and the threat model.

Changes to either model reopen affected comparisons and investigations. Preserve superseded design evidence and the original discrepancies when later clarification changes the baseline. This preserves traceability without treating old documentation as permanently authoritative.

## Clarification and disposition

The agent asked whether missing design should (A) be reconstructed provisionally for auditor review or (B) remain unresolved until design evidence or human clarification supplies it. It recommended A because automated intake can offer concrete alternatives, provided code-derived reconstruction cannot count as independent conformity evidence.

The operator selected A, documentation first, then built substantially through auditor input and further applicable evidence. The agent refined the recommendation to preserve documented claims, auditor clarifications, inferred candidates and adopted audit assumptions distinctly; documentation first is not a universal source ranking. It reported no further consequential questions. The operator approved this direction in [DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md).

## Evaluation proposal

Cases should cover failure-path deviations, unexpected privileged behavior, absent required behavior, equivalent abstractions, shared code/test mistakes, unsafe design conformity, contradictory or outdated documents corrected through auditor input, deeper-lens discoveries and stale comparisons. Measure correct and misleading discrepancy discovery, unresolved comparison gaps, human effort and change handling; avoid a security percentage.
