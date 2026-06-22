# Word-list history

A version-by-version record of Claude Code's embedded UI vocabulary, extracted
with [`snapshot.sh`](./snapshot.sh). Raw per-version files live under
[`versions/`](./versions/). This file summarizes what changed between them.

The goal: when a future Claude Code release adds, removes, or renames a spinner
verb (or a startup tip), the diff shows up here.

## Counts per version

| Version  | Spinner (present) | Completion (past) | Tips |
|----------|:-----------------:|:-----------------:|:----:|
| 2.1.185  | 187               | 8                 | 64   |
| 2.1.183  | 187               | 8                 | 64   |
| 2.1.181  | 187               | 8                 | 64   |

Tips count is the reconstructed `tips.txt` — one complete sentence per tip
(ASCII + UTF-16, fragments joined); see [TIPS.md](./TIPS.md) for the grouped,
annotated reference.

## Changes

### 2.1.181 → 2.1.183 → 2.1.185
**No changes.** All three releases ship byte-for-byte identical spinner,
completion, and tip lists (verified by `md5`). These are consecutive patch
releases, so the UI vocabulary was untouched. This establishes the baseline; the
archive starts earning its keep the first time a release actually moves a word.

<!--
When adding a new version:
  1. Upgrade Claude Code, then run `./snapshot.sh`
  2. Diff against the previous version, e.g.:
       diff versions/2.1.185/spinner.txt versions/<new>/spinner.txt
  3. Add a row to the table and a "### <old> → <new>" entry describing the diff
  4. Commit the new versions/<new>/ folder together with this file
-->
