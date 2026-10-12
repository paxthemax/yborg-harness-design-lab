# DEC-010 Linked variants into unreviewed flows

Status: **accepted for Q-027**. Date: **2026-10-12**. Decision owner: **lab operator**.

## Context

The fresh-context consistency review of the [DEC-009](DEC-009-architecture-acceptance-and-remaining-dispositions.md) integration found that two accepted rules meet without saying which one wins:

- [DEC-005](DEC-005-comprehension-lensing.md) (Q-010) starts investigations only after broad orientation and a recorded review of the relevant flow.
- DEC-009 (Q-026) lets a linked variant follow an effect into a different guarantee inside the current batch, without a new approval.

The question, registered as Q-027, is what happens when such an effect leads into a flow that has no `record_flow_review` decision. During the integration pass the specification provisionally followed option A, the recommendation. The operator asked for a recap in the walkthrough format, with a one-sentence summary, a plain explanation and an example, and then decided.

## Accepted answer

| Question | Operator's answer | What it establishes | Versus recommendation |
|---|---|---|---|
| Q-027 Linked variants into unreviewed flows | **“Proceed, flagged”** (option B) | A linked variant may follow an effect into a flow that has no `record_flow_review` decision. Its other limits are unchanged: it needs no new capability, permission, budget, attacker power or scope, and changes no guarantee's or check oracle's meaning. The review packet flags each linked claim whose flow is unreviewed, so the auditor sees that the evidence concerns a flow they have not reviewed. A linked variant never marks a flow reviewed | Differs: option A was recommended |

The option label is quoted without its suffix.

## Consequences and boundaries

- **DEC-005's gate is narrowed.** The flow-review gate still governs batch authorization, and `authorize_work` still refuses a batch whose relevant flow has no `record_flow_review` decision (FR-32). It no longer applies to linked variants.
- **The trade-off accepted.** Effects that cross into unreviewed flows surface sooner, at the cost that the auditor may judge evidence about a flow they have not yet reviewed. The flag makes this visible, and the auditor can still review the flow before deciding a flagged claim.
- **The provisional option A text is replaced** wherever the integration pass wrote it.

**Supersedes:** none. **Amends:** DEC-005's flow-review gate, which no longer applies to linked variants; DEC-009's linked-variant rule, which gains the flag. **Affected records:** Q-027, DEC-005, DEC-009, FR-32, the glossary, the state and component contracts, the product proposal, the auditor guide, the loop register, the completion audit, the handover and lab memory. **Acceptance evidence:** the operator's selection on 2026-10-12, quoted above. **Next action:** none beyond integration, which follows the same day as part of the authorized DEC-009 pass.
