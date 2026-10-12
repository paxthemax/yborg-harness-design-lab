---
id: K-007
kind: interpretation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-033
    locator: "Comprehension gaps, test-refinement and new-hypothesis return arrows"
  - id: SRC-034
    locator: "Per-contract/finding repeats, PoC repair, fuzzing and improvement loop"
depends_on: [SRC-033, SRC-034]
related_decisions: [DEC-002, DEC-003, DEC-007]
related_questions: [Q-012, Q-013]
stale_if:
  - "The operator changes batch boundaries, human review cadence or loop ownership."
  - "A workflow trial reveals ambiguous loop exits or unwanted approval churn."
---

# A repeated process needs its own authority boundary and exit

The two imported diagrams show materially different repeated activities under similar loop notation: revisit understanding, refine tests, generate a new hypothesis, repeat an investigation and improve future methods. Those repetitions need different permissions and produce different artifacts.

The proposed synthesis is to name each loop and record its entry, owner, repeated work, return point, exit, allowance and output. A scenario variant within an approved question differs from a fixture repair; a new question or changed semantic premise may need human direction. An inner iteration shares its parent's budget. Stopping after a finite allowance establishes a work outcome, not security coverage or a refutation.

[DEC-007](../../decisions/DEC-007-human-agent-workflow.md) separately accepts agent scenario authorship under approved questions/constraints and combined human review after testing and challenge. That operator choice does not accept the entire [eight-loop contract](../../design/harness-workflow-loops.md#loop-register) or the architecture.

**Limits:** this is a workflow-design interpretation, not measured evidence that eight loops are optimal or that either imported system enforces its diagram. Source tool, dataset and effectiveness claims remain unverified.

**Next check:** a future walkthrough should classify in-scope scenario variation, fixture repair, changed attacker powers, a new question and changed source revisions without silently widening a grant or asking for the same approval again.
