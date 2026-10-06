# One

> Two maps. Same chassis. One extra kick.

**A minimal counterexample in Lean 4: a bounded local step can have an unbounded orbit.**

### Maps

- `stepU` (Main.lean): even +3, odd +1 → two steps = +4 → `0 → 3 → 4 → 7 → 8 → 11 → ... → ∞`
- `stepS` (Stable.lean): even +0, odd +1 → idempotent after one tick

Both satisfy |Δ| ≤ 3 locally. Globally, one diverges.

### Theorems

- `two_steps_add_four`: even n → stepU(stepU n) = n+4
- `orbitU_double`: orbitU(2k) = 4k → unbounded
- `stepS_idempotent`: stepS ∘ stepS = stepS

### Build

```bash
lake update
lake build
lake exe one
```
Requires leanprover/lean4:v4.10.0

### License
MIT
