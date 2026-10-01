# Harness sprint delivery verification

Date: **2026-10-01**. This record concerns document, data and diagram consistency. It is separate from the future runtime scenarios in the [evaluation plan](../design/harness-evaluation.md).

## Inspection scope

Read all three imported reports and visually inspected all eleven imported diagrams. The [research record](harness-design-sprint.md) maps each input to retained mechanisms, corrections and proposed adaptations. Seventeen primary-source records distinguish selective checks of imported citations from new research; not every inherited citation was reverified.

The deliverable includes the product proposal, state/execution specification, component/artifact contracts, auditor guide, functional and non-functional requirements, evaluation plan, three diagrams with editable Mermaid sources, research rationale, decision dispositions, knowledge cards and session memory. The [full specification audit](harness-specification-completeness.md) maps all repository requirements and every FR/NFR. No harness implementation, PLUR integration, target exploit execution, or product benchmark was performed.

## Checks and corrections

| Check | Result |
|---|---|
| Original input preservation | All 16 files under `imports/`, including the three reports, eleven images and two indexes, match the initial SHA-256 fingerprints |
| PLUR engrams | All 13 records match the previously inspected upstream `engram.schema.json`, revision `434ca65e71243a303bee9b0661f5f3bd11558682` |
| YAML and knowledge metadata | Current engrams, episodes, config and five card front matters parse; scope, privacy, grounding paths and unreviewed approval fields inspected |
| Decision authority | Q-004–006 map to DEC-002; Q-007 maps to DEC-004; DEC-003 and Q-008 remain proposed |
| Local navigation | All 294 local links and heading anchors resolve; final pass repeated after continuity updates |
| Full requirement mapping and examples | All 28 FRs and 13 NFRs occur exactly once in the completion matrix; the synthetic JSON request parses; new document code fences balance |
| Diagrams | All three Mermaid diagrams rendered and visually inspected; native SVG text and whitespace corrected after an initial preview omitted labels; final trust-boundary and sequence-label revisions rechecked |
| Independent review | Initial sprint reviews and the final full-spec review returned `done`; the last reviewer independently checked actual content against all repository scope items, 28 FRs, 13 NFRs and Q-004–007 with no actionable omissions or contradictions |
| Main-thread review | Clarified that the trusted tool broker/receipt collector is outside untrusted workers; added explicit baseline-control tracking and preserved the distinction between execution provenance and semantic validity |

Temporary inspection scripts, package caches and image previews live outside the repository. YAML/schema validation used mise-managed uv with temporary packages. Mermaid rendering used the existing mise-managed installation. SVG exports use native text labels and `xml:space="preserve"` for portable spacing; the latter is applied after rendering. No new tool was added to `mise.toml`.

The final integrity inspection ran successfully with `mise exec uv -- uv run --offline --cache-dir /tmp/harness-sprint-uv-cache --no-project --with pyyaml --with jsonschema python /tmp/harness-verify.py`. The temporary inspector's coverage was read before relying on its result. A separate document inspection compared all FR/NFR IDs and parsed the synthetic JSON request. Current SVGs were converted with `rsvg-convert` and visually inspected. These are document checks, not a harness test suite; temporary inspection files are not part of the product.

## Verification limits

The working directory is not an initialized Git repository, so inspection compared file fingerprints against a captured initial inventory instead of a Git diff. Original imports and unrelated configuration remain unchanged; all changed and new files belong to the sprint deliverable and its continuity records. No claims here establish runtime permission enforcement, job recovery, sandbox security, auditor productivity or vulnerability recall.

Direct retrieval of Foundry's invariant page failed; the source register marks its indexed official text and version-check limitation. One newly surveyed publisher page could not be retrieved and was excluded from design support. No external source's reported performance was reproduced.

## Memory review

DEC-001 still governs this lab's isolated PLUR-format store, automatic learning and keyword retrieval. Its earlier “lab first” instruction was a scope sequence, not a prohibition on the now-requested separate harness design. Existing instruction memories remain intact. New operator decisions are grounded in DEC-002/004; three new research lessons are active but unreviewed synthesis. They do not establish architectural acceptance. PLUR's engine remains unconnected; all retrieval and updates were file-based.

The full-spec pass reviewed the thirteen standing memories against the current decisions and found no correction needed. Its contract details elaborate the existing resumption, authority and evidence lessons. Completion events were appended to the episode history without manufacturing a new operator acceptance or changing memory activation policy.
