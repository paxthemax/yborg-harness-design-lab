---
id: K-005
kind: interpretation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-009
    locator: "Indexed official invariant documentation: handler-based testing and call metrics"
  - id: SRC-011
    locator: "Rule Sanity Checks: Vacuity checks and Trivial invariant checks"
  - id: SRC-012
    locator: "Racing to keep up with Curvance's code changes; debugging"
depends_on: [SRC-009, SRC-011, SRC-012]
related_decisions: [DEC-003, DEC-004]
related_questions: [Q-008]
stale_if:
  - "The selected tool's result semantics or property model changes."
---

# Property adequacy is separate from a successful run

A successful campaign or solver result can be uninformative when relevant actions never occur, preconditions exclude all cases, or the specification is wrong. The inspected sources illustrate different parts of that problem, not a common quantitative failure rate.

The proposed response is a distinct semantic and adequacy review: intended guarantee, independent oracle, reachable states and relevant sensitivity evidence. A generated repair that changes these premises must return for review. Extra review costs should be measured; no fixed mutation score proves security.

**Next check:** use the synthetic all-reverting campaign and oracle-change cases in the proposed pilot. Foundry option names remain subject to version verification because direct source retrieval was unavailable.
