---
id: K-002
kind: interpretation
review_status: unreviewed
evidence_class: SYNTHESIS
sources:
  - id: SRC-001
    locator: "Section 1: Evidence policy; section 6: Reusable internal KB schema"
  - id: SRC-002
    locator: "Section 2: The main failure can occur before vulnerability discovery"
  - id: SRC-004
    locator: "Implementation details: approval, feedback, and backup"
depends_on: [SRC-001, SRC-002, SRC-004]
related_decisions: [DEC-001]
related_questions: [Q-002]
stale_if:
  - "PLUR changes its draft injection or commitment behavior."
  - "The operator changes the selected learning or decision-authority workflow."
---

# Memory relevance does not establish design authority

The lab should preserve source evidence, interpretation, and operator decisions as distinct records, while using PLUR to recall reusable guidance linked to those records.

The imported research distinguishes facts, interpretations, hypotheses, experiments, and decisions. The assessment warns that a mistaken shared summary can propagate through several agents. PLUR's usage and activation fields help choose context; they do not establish the truth of a claim or the operator's acceptance of an architecture.

The working adaptation is a document-backed memory layer with automatic learning and periodic correction, as selected in DEC-001. An unreviewed memory can guide work while its associated recommendation remains a proposal. Draft commitment is available for incomplete grounding or disputed guidance. This is synthesis for the design lab, rather than a measured finding about this lab or a universal claim about every PLUR deployment.

**Trade-off:** extra links and review cost effort. A small corpus and selective extraction should keep that cost reviewable; a pilot should measure whether the records reduce repeated research and correction.

**Next check:** inspect the selected integration's actual automatic-learning behavior against the resolved [Q-002 policy](../questions.md#q-002--review-and-promotion).
