# DEC-001 — Knowledge and memory for the design lab

Status: **accepted for Q-001–003**. Date: **2026-10-01**. Decision owner: **lab operator**.

## Question and fixed inputs

How should this lab preserve researched knowledge and design rationale while giving agents useful memory between sessions?

Fixed by the operator: use PLUR as substrate and guide; cover the design lab first. Fixed by repository instructions: deliver specifications and their research/decision records, keep consequential design choices with the human, and stay within the stated harness scope. The operator also requested mise for internal package management.

Those inputs are accepted instructions. The operator subsequently resolved Q-001–003 as recorded below. Detailed procedures remain revisable; installation and host integration are separate work.

## Options and initial recommendations

| Choice | Options | Recommendation | Cost or limitation |
|---|---|---|---|
| Store placement, Q-001 | Dedicated repo-local store; separate local store; shared personal store | `memory/plur/`, explicit path, no additional mounts | Changes may include runtime counters; ordinary repository sharing needs review |
| Review, Q-002 | Review new standing guidance; permit automatic learning with later review | Grounded drafts and explicit promotion | Requires a small review queue and an approval route |
| Retrieval, Q-003 | Keyword first; hybrid retrieval from the start | Keyword first for the small seed corpus | Semantic matches may be missed; comparison is pending |
| Knowledge records | Source-backed cards and decision documents; memories carrying all context | Documents with selectively grounded engrams | Requires link maintenance; keeps longer rationale inspectable |

## Accepted choices

1. Keep the dedicated store at `memory/plur/` in this repository, isolated from other projects, with no automatic sharing.
2. Allow automatic learning and periodically review or correct memories. Memories may guide work before review; activation does not make a consequential design choice accepted.
3. Start with keyword retrieval. Add embeddings if retrieval needs improve.

The [knowledge and memory specification](../design/knowledge-and-memory.md) and file-based workflow reflect those choices. Automatic learning enables agents to record reusable lessons without individual approval; design recommendations retain attribution and their unresolved disposition. The existing harness recommendation remains unaccepted.

The memory config and records express the selected policy. PLUR installation and host integration have not been performed.

## Alternatives considered

A single personal PLUR store is convenient across tools, but mixes lab work with personal context unless its mounts and read behavior are deliberately constrained. A separate local lab store offers isolation and less repository churn, but its backup and shared access must be managed separately.

Storing all research as engrams simplifies one search surface, but turns long evidence and evolving debate into compact assertions. Keeping only documents makes provenance straightforward, but provides less support for recurring corrections and task-specific recall. The proposed combination uses the two formats for their respective purposes.

The initial recommendation used explicit drafts to provide review before injection. The operator chose automatic learning with later review instead, prioritizing less review friction. That choice accepts earlier exposure to inaccurate memories; source links, attribution, periodic correction, and human authority over design decisions address that trade-off. Draft commitment remains available for incomplete or disputed records requiring quarantine.

## Disposition

- **Q-001 accepted:** `memory/plur/` in this repository, isolated from other projects, with no automatic sharing.
- **Q-002 accepted:** automatic learning with periodic review or correction.
- **Q-003 accepted:** keyword search first; add embeddings if retrieval needs improve.
- **Decided by / on:** lab operator, 2026-10-01, for all three questions.
- **Acceptance evidence:** the operator selected the repository-local isolated store, “Allow automatic learning and review or correct it periodically,” and keyword search first in the decision questionnaire.
- **Supersedes:** none.
- **Affected records:** `design/knowledge-and-memory.md`, `kb/`, `memory/plur/`, session workflow guidance in `AGENTS.md`.

Revisit these choices when retrieval, maintenance cost, or memory quality provides evidence for a change. Record a superseding disposition before changing an accepted policy.
