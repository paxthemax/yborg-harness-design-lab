# DEC-005 Comprehension interaction and lensing requirements

Status: **accepted requirements and Q-009–010 choices; detailed methodology under review**. Date: **2026-10-01**. Decision owner: **lab operator**.

## Context and choice

The first Astra Max review proposed a connected walkthrough with optional checkpoints, prediction-first dialogue, or briefing-first presentation. The operator selected **“1A”**, accepting the connected walkthrough with optional checkpoints. This supports short, flowing explanations while leaving active reconstruction optional and source inspection available.

The operator then supplied a more concrete goal: identify flows as state machines and put flow diagrams into the knowledge base through a repeatable **lensing** process.

## Accepted requirements

- Intake automatically seeds the engagement knowledge base and prepares exploration in one or more rounds.
- Human and agent explore the system's high-level purpose, map flows, map stores (where data lives), then explore transitions at progressively finer resolution down to the lowest relevant level.
- Flows are modeled as state machines and represented by diagrams in the knowledge base.
- Explorations are repeatable activities the auditor can undertake with the agent; their conclusions update the knowledge base.
- Explorations can be run at any time, rather than only during intake.
- The default interaction is a connected walkthrough with optional checkpoints.
- Investigation may begin after broad system orientation and review of the relevant flow; other flows, gaps and deeper exploration remain visible and can be explored alongside investigation.

These are requirements supplied by the operator, not an acceptance of every mechanism proposed in the first or second review. The second pass must distinguish provisional automated seed from reviewed conclusions and preserve source/revision links and existing human authority.

## Open design scope

The exact state abstractions, refinement and composition contracts, exploration execution/checkpoint protocol, and diagram lifecycle are proposed in the [comprehension method](../design/harness-comprehension-method.md). The operator requested another Astra Max pass and updated conclusions/questions before concluding this design work.

After the second-pass report, the operator answered **“A”** to Q-010, selecting investigation after broad orientation and review of the relevant flow. The alternative was to review all critical flows first; the selected policy enables earlier focused work while retaining visible gaps and continuing exploration. This does not authorize a batch or waive the relevant semantic/evidence checks. Existing evidence policy and approved-batch authority remain applicable; DEC-003 architecture acceptance is separate.

**Supersedes:** none. **Affected records:** Q-009–010; comprehension methodology; auditor comprehension workflow. **Next action:** accepted requirements and start policy are integrated into the product and auditor guide; review detailed mechanisms separately without inferring broader architecture acceptance.
