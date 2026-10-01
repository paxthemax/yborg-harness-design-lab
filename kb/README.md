# Knowledge base

This is the lab's map of research and design knowledge. Start with the [harness proposal](../design/audit-harness.md), [source register](sources.md), and [question register](questions.md). The [knowledge and memory design](../design/knowledge-and-memory.md) governs this lab's separate memory. Current work is summarized in [the session handover](../memory/session.md).

## Current contents

| Record | What it contributes |
|---|---|
| [SRC-001–005](sources.md) | Three existing reports, the PLUR assessment, and eleven imported diagrams |
| [SRC-006–022](sources.md#sprint-primary-sources) | Seventeen primary-source records covering selected rechecks and new research |
| [K-001](claims/K-001-evidence-workbench.md) | The imported recommendation to begin with an evidence workbench |
| [K-002](claims/K-002-evidence-and-memory.md) | A synthesis about separating evidence and memory authority |
| [K-003](claims/K-003-resumption-and-authority.md) | Recovery does not establish current authority or unique result acceptance |
| [K-004](claims/K-004-refutation-freshness.md) | Negative conclusions need premise and revision boundaries |
| [K-005](claims/K-005-property-adequacy.md) | Property adequacy differs from tool success |
| [DEC-001](../decisions/DEC-001-knowledge-and-memory.md) | Accepted storage, learning, and retrieval choices |
| [DEC-002](../decisions/DEC-002-harness-operating-envelope.md) and [DEC-004](../decisions/DEC-004-confirmation-evidence-policy.md) | Accepted harness envelope and alternative evidence policy |
| [DEC-005](../decisions/DEC-005-comprehension-lensing.md) | Accepted walkthrough default, repeatable state-machine lensing requirements and investigation-start policy; detailed method remains under review |
| [DEC-003](../decisions/DEC-003-harness-architecture-proposal.md) | Proposed architecture, options and rationale |
| [Question register](questions.md) | Accepted choices and proposed architecture review |
| [Harness sprint](../research/harness-design-sprint.md) | Report and diagram extraction, primary research, trade-offs and walkthroughs |
| [Component contracts](../design/harness-interface-contracts.md) and [auditor guide](../design/harness-auditor-guide.md) | Integration boundaries, artifact handoff and the complete human workflow |
| [Specification completion audit](../research/harness-specification-completeness.md) | Coverage of the repository scope, accepted choices, and every functional/non-functional requirement |
| [Comprehension review](../research/comprehension-methodology-review.md) and [lensing method](../design/harness-comprehension-method.md) | Two Astra Max passes on agent knowledge construction and auditor internalization; Q-009–010 resolved |
| [K-006](claims/K-006-comprehension-and-evidence.md) | Model support, human understanding and security adjudication are distinct outcomes |

The three reports were read and all eleven diagrams visually inspected for the harness sprint. Selected external citations were checked; the register identifies exactly which ones and their limits. This is selective extraction, not exhaustive revalidation of every imported assertion. The primary harness architecture remains proposed.

## How to add knowledge

Preserve the original input and register it. Create a card when a claim will help a design decision or prevent repeated research. One card should express one claim; its prose keeps the explanation and limitations. Use stable IDs and descriptive filenames.

Minimum card front matter:

```yaml
id: K-NNN
kind: observation  # observation | interpretation | hypothesis | recommendation
review_status: unreviewed
evidence_class: DOC  # DOC | CASE | STUDY | VENDOR | SYNTHESIS
sources:
  - id: SRC-NNN
    locator: "Exact heading, item ID, URL, or pinned file"
depends_on: []
related_decisions: []
related_questions: []
stale_if: []
```

Then write the claim, supporting evidence, counterevidence or limits, applicability, and next check. `depends_on` contains record IDs; a `sources` locator supplies the precise grounding. Dates and reviewer identity are recorded when known, not guessed. An empty counterevidence list means none has been recorded, not that none exists.

Keep an explicit intake disposition in the source register. A source can be partially extracted indefinitely if the remaining content is irrelevant to the active question; name that scope rather than claiming exhaustive intake.

## How to make a decision

Use [DEC-001](../decisions/DEC-001-knowledge-and-memory.md) as a starter shape: question, context, options, recommendation, consequences, and disposition. Only explicit operator approval changes `proposed` to `accepted`. Record who decided, when, and the actual instruction or answer. Superseding a decision creates a new record and preserves the old rationale.

Every question has an owner, next action, and resolution link. Update the question and decision records together when an answer arrives. A document labeled “recommended” does not resolve the question.

## How to remember and resume

Read the [PLUR store guide](../memory/plur/README.md) before writing memories. Keep reusable working guidance in engrams, events in episodes, and temporary task state in the handover. A memory links to a knowledge card, decision, or explicit instruction; it does not substitute for that record.

When retrieving a disputed or stale claim, bring its limitations and competing evidence into context. Before making a consequential design assertion, read the grounding document and its current disposition. If the PLUR engine is unavailable, read the files directly and use `rg` for locators.

When a source or premise changes, search its ID through the lab, mark dependent cards for review, and examine related decisions and specifications. Keep unresolved trade-offs visible for the operator.

[DEC-006](../decisions/DEC-006-designed-and-implemented-behavior.md) accepts documentation-first DESIGNED behavior developed with auditor input, distinct IMPLEMENTED behavior and comparison during every lens. [The consultation](../research/designed-implemented-consultation.md) retains recommendations, the resolved clarification and rationale.
