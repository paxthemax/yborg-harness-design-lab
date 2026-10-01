---
id: K-004
kind: recommendation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-002
    locator: "Section 3: Preserve disproofs; invalidate evidence when premises change"
  - id: SRC-003
    locator: "Design 1 candidate state machine: rejected conclusions return to retest"
  - id: SRC-005
    locator: "0xflint-comprehension-hunt-and-evidence-loop.png: killed leads update the model"
depends_on: [SRC-002, SRC-003, SRC-005]
related_decisions: [DEC-003]
related_questions: [Q-008]
stale_if:
  - "The operator changes the harness evidence lifecycle or change-review scope."
---

# Refutations need revision and premise boundaries

A rejected lead is useful only with its decisive countercondition and scope. A changed guard, actor capability or external assumption can make that rejection inapplicable. Preserve the old record and reopen the current conclusion rather than deleting either.

This recommendation extends the imports into a dependency contract for the harness. Dependency extraction may be incomplete, so unknown reach requires conservative review of a wider unit. That can increase unnecessary review; measure both missed invalidations and review burden.

**Next check:** change a guard supporting a refutation and inspect whether the proposed implementation reopens the lead and related coverage.
