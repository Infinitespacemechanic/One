# One

> Two maps. Same chassis. One extra kick.

**A minimal counterexample in Lean 4: a bounded local step can have an unbounded orbit.**

### Maps

- `stepU` (`Main.lean`): even +3, odd +1 → two steps = +4 → `0 → 3 → 4 → 7 → 8 → 11 → ... → ∞`
- `stepS` (`Stable.lean`): even +0, odd +1 → idempotent after one tick

Both satisfy |Δ| ≤ 3 locally. Globally, one diverges.

### Theorems

- `two_steps_add_four`: even n → stepU(stepU n) = n+4
- `orbitU_double`: orbitU(2k) = 4k → unbounded
- `stepS_idempotent`: stepS ∘ stepS = stepS

### GeometricPathway

[`GeometricPathway.lean`](GeometricPathway.lean) is a separate Lean 4 development that encodes a discrete angle-counting model using natural numbers. It defines a 60-degree slice and a scaled value of 1.0472 (stored as 10472), then proves arithmetic identities for:

- Six slices forming 360 degrees, and twelve slices forming 720 degrees.
- Scaling the twelve-slice relationship by any natural number.
- The 1, 3, 6, 9, 12 count sequence in both degrees and scaled units.
- The identity that the pair `6k - 1` and `6k + 1` sums to `12k` for `k ≥ 1`.

These are formalized arithmetic relationships; the file does not prove that the model describes physical matter, establish primality of numbers of the form `6k ± 1`, or prove the Riemann Hypothesis. The development uses Lean's core `omega` tactic and does not import Mathlib.

To check the file with the repository's pinned Lean toolchain:

```bash
lake env lean GeometricPathway.lean
```

### Build

```bash
lake update
lake build
lake exe one
```
Requires leanprover/lean4:v4.10.0

### Images

Project images are stored in `assets/images/`.

### License
MIT
