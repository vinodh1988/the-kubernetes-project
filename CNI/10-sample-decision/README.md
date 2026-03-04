# 10 — Sample Filled Decision (Cilium vs Calico vs AWS VPC CNI)

This section provides a pre-filled scoring example using realistic placeholder assumptions for a mid-to-large EKS platform team.

## Assumptions

- Primary platform: EKS
- Need strong policy depth and observability
- Moderate preference for portability (future multi-cloud possibility)
- Team can operate medium complexity tooling

## Candidate labels used

- Candidate A: Cilium
- Candidate B: Calico
- Candidate C: AWS VPC CNI

## Scoring model

Weighted score per criterion:

- `Weighted = (Raw / 5) * Weight`

Total score:

- `Total = sum(all weighted scores)`

## Files

- `sample-cni-scoring-filled.md` — completed worksheet with rationale
- `sample-cni-scoring-filled.csv` — spreadsheet-ready filled sample

## Summary result (example)

- Cilium: 83
- Calico: 81
- AWS VPC CNI: 75

Interpretation:

- Cilium and Calico are both strong choices for policy-first platforms.
- AWS VPC CNI remains compelling where native AWS integration simplicity is prioritized over portability/policy depth.

> Replace values with your benchmark outcomes before production decisions.
