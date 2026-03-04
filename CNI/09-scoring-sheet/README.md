# 09 — CNI Weighted Scoring Sheet

This section gives you a ready scoring model to compare CNI candidates consistently.

## Files

- `cni-scoring-sheet-template.md` — editable Markdown worksheet
- `cni-scoring-sheet-template.csv` — spreadsheet-ready CSV template
- `../10-sample-decision/sample-cni-scoring-filled.md` — filled example worksheet
- `../10-sample-decision/sample-cni-scoring-filled.csv` — filled example CSV

## Scoring model

1. Define criteria and weights (sum = 100).
2. Score each CNI from 1 to 5 for each criterion.
3. Compute weighted score per criterion.
4. Sum all weighted scores to get final ranking.

Formula:

$$\text{Weighted Score} = \left(\frac{\text{Raw Score}}{5}\right) \times \text{Weight}$$

$$\text{Total} = \sum \text{Weighted Score}$$

## Suggested criteria

- Security policy depth
- Performance/latency
- Observability
- Operational simplicity
- Cloud/platform fit
- Portability
- Cost impact

## Practical guidance

- Use evidence from benchmark templates, not opinion only.
- Keep scoring notes for auditability.
- Re-score after pilot/proof-of-concept results.
