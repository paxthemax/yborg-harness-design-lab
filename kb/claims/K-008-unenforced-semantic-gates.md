---
id: K-008
kind: interpretation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-001
    locator: "S25 Use: enforce evidence rules in state transitions, not only prompts"
  - id: SRC-003
    locator: "Section 2: the controller should enforce these limits even if the model requests otherwise"
depends_on: [SRC-001, SRC-003]
related_decisions: [DEC-003, DEC-004, DEC-007, DEC-008]
related_questions: [Q-008, Q-014, Q-016, Q-017, Q-019]
stale_if:
  - "The operator accepts a design in which these gates are enforced mechanically."
  - "A trial shows that agents classify their own semantic changes reliably enough for the evidence policy."
---

# A gate is unenforced when the constrained agent detects its own crossing

The proposed harness mechanically enforces capabilities, revisions and receipts. Its semantic gates are stated as policy, however: syntactic versus consequential fixture change, setup versus attacker power, impractical versus failed reproduction, refuted versus exhausted, complete versus selective packet or report. Each is detected by the agent the gate constrains, or by a single auditor reading an agent-composed packet. Such a gate holds only while the agent is both correct and candid.

The [adversarial design review](../../research/adversarial-design-review.md) found this pattern in AR-01, AR-02, AR-04, AR-05, AR-16 and AR-17, and several reviewer passes reached each of these independently. In every case the controller already holds data that can partly mechanize the gate:

- runner traces and fixture syntax, as a power ledger;
- oracle-unit hashes;
- compiler-derived inventories;
- record link sets, which can check omission as well as support;
- snapshot diffs.

**Limits:** mechanization sees only what traces and syntax expose. A deployed mock or a chosen fork state can still grant power without appearing in either, so human review remains necessary. The claim is that review should start from a mechanical difference, not from an agent's self-report. This is a design interpretation from a document review, not a measured failure rate, and all reviewer passes shared one model family.

**Operator disposition:** for scenario and fixture changes under DEC-007, the operator chose agent self-report over a mechanical check (Q-014, [DEC-008](../../decisions/DEC-008-adversarial-review-dispositions.md)), accepting this residual risk. The same decision adopted mechanical support for several other gates: the guard-removed rerun for rejections (Q-016), evidence-first packets (Q-017), out-of-model input capture (Q-018) and dependency probes (Q-019). This card describes that accepted risk; it is not a pending proposal to reverse Q-014.

**Next check:** in a walkthrough or pilot, seed a fixture repair that adds a prank of a privileged role and changes an assertion. Record whether the challenger or the auditor surfaces the change. That rate measures the accepted residual risk.
