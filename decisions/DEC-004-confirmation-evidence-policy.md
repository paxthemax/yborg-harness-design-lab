# DEC-004 Confirmation evidence policy

Status: **accepted for Q-007**. Date: **2026-10-01**. Decision owner: **lab operator**.

## Question

May the auditor confirm a serious issue with a convincing source-based argument when a runnable PoC is impractical, or must every confirmed finding have an executable PoC?

## Options and rationale

Requiring a PoC for every confirmation simplifies artifact checks and encourages reproducibility. It can also leave a valid architectural or environment-dependent defect unresolved when executable reproduction is impractical. Allowing alternative evidence puts responsibility on the human to explain why the argument establishes the claim under the actual prerequisites.

The recommendation was to allow a documented human exception, explicitly label the evidence and its limits, and retain clean replay as the normal route. Model agreement alone is insufficient. This follows the imported distinction between evidence types and impact, extended by the [research sprint](../research/harness-design-sprint.md).

## Accepted choice

The operator selected **“Allow auditor-approved alternative evidence (recommended)”** in response to that focused question on 2026-10-01.

Confirmation may therefore use an explicit human-approved argument when execution is impractical. Record the evidence type, source/model anchors, feasibility of prerequisites, supporting and refuting evidence, why a runnable PoC is impractical, why the alternative is sufficient, and remaining limits. Keep potential impact and human-assigned severity distinct from evidence status. Unsupported concerns remain unresolved rather than becoming confirmed through an exception label alone.

This choice does not waive clean replay for a finding presented as executably reproduced. It does not accept the whole architecture in DEC-003 or confer decision authority on an agent.

**Supersedes:** none. **Affected records:** Q-007, the harness report contract, evidence acceptance and evaluation metrics. **Next action:** encode both evidence routes in any later implementation and show their counts separately during evaluation.
