---
id: K-003
kind: interpretation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-013
    locator: "Persistence; Interrupts: Side effects called before interrupt must be idempotent"
  - id: SRC-014
    locator: "Activity Definition: Idempotency and Activity retry policy"
depends_on: [SRC-013, SRC-014]
related_decisions: [DEC-003]
related_questions: [Q-008]
stale_if:
  - "A selected runner's retry or checkpoint contract changes."
---

# Resumption needs separate permission and result checks

Checkpoint restoration can repeat operations or leave an attempt's outcome uncertain. LangGraph and Temporal document different forms of this issue. Neither checkpoint presence nor a recovered conversation establishes a current human decision.

The proposed harness therefore uses revision-bound approvals, attempt identities, reconciled receipts and explicit uncertainty. This is an application design inference, not a claim that either framework cannot implement those rules. The extra controller logic creates maintenance work that the recovery pilot must assess.

**Next check:** compare candidate runners using the crash and stale-approval scenarios in the harness evaluation plan.
