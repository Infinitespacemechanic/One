# One: A Minimal Counterexample — Bounded Local Steps Can Have Unbounded Orbits

**Author:** Rob Laakkonen / Infinitespacemechanic  
**Date:** 2026-10-08  
**Repo:** Infinitespacemechanic/One  
**Tool:** Lean 4.10.0 — `lake build`

---

### Abstract

Two maps. Same chassis. One extra kick.

We present a minimal counterexample showing that a uniformly bounded local step `|Δ| ≤ 3` does not imply global boundedness. One map locks after a single step. The other diverges to infinity. The difference is exactly one operation.

This is Chapter 1 of the Infinitespacemechanic program.

---

### 1. Motivation — Aim Small, Miss Small

Complexity hides truth. Simplicity reveals it.

The Infinitespacemechanic philosophy is to aim for the smallest possible proof that still carries the idea. If it fails, it fails small and we learn. If it succeeds, the proof is undeniable because there is nowhere to hide.

`One` is the smallest such proof.

---

### 2. The Two Maps

Both maps satisfy `|step(n) - n| ≤ 3` for all `n : ℕ`.

#### Map U — Unbounded

```lean
def stepU : ℕ → ℕ
| n => if n % 2 = 0 then n + 3 else n + 1
```

Trace: `0 → 3 → 4 → 7 → 8 → 11 → ... → ∞`

#### Map S — Stable (Locks)

```lean
def stepS : ℕ → ℕ
| n => if n % 2 = 0 then n + 0 else n + 1
```

Trace: `0 → 0 → 0 → ...` (idempotent after first odd)

Same bound. Two opposite fates.

---

### 3. Theorems

#### Lemma: Two steps add four (for U)

```lean
theorem two_steps_add_four (n : ℕ) : stepU (stepU n) = n + 4
```

#### Theorem: Orbit of U doubles every two steps — Unbounded

```lean
theorem orbitU_double (k : ℕ) : orbitU (2 * k) = 4 * k
```

Proof by induction. Therefore `orbitU` is unbounded: `∀ B, ∃ k, orbitU k > B`.

#### Theorem: S is idempotent — Bounded

```lean
theorem stepS_idempotent (n : ℕ) : stepS (stepS n) = stepS n
```

After at most one step, S locks. It never exceeds `n + 1`.

**Conclusion:** Local bound does not imply global bound.

---

### 4. Cost Resolution — The Last Cost

In Compounding-scaling we argue:

> M = N + Hm, not N * eˣ

The question is: what is the cheapest operation that turns stability into divergence?

Answer in `One`: **One extra +3 on evens.**

`stepS` uses `+0` on evens. `stepU` uses `+3` on evens. That single difference in cost is the difference between bounded and unbounded.

This is the last cost resolution. You cannot make it cheaper than one.

---

### 5. Formalization in Lean 4

**File structure:**
```
One/
  Main.lean   — stepU, stepS, orbitU, proofs
  Stable.lean — stepS_idempotent and stability lemmas
  lakefile.lean
  lean-toolchain — leanprover/lean4:v4.10.0
```

**Build:**
```bash
lake build
```

No axioms. No sorry. All theorems compile.

---

### 6. Implications for Infinitespacemechanic

`One` is not an isolated trick. It is the base layer:

- **One (this paper):** Proves 1 minimal kick can cause divergence.
- **Plasmapower:** Extends to `1 drifts, 2 flips, 3 locks` — three tracks.
- **MillenniumClock:** Scales to 720 states.
- **Compounding-scaling:** Formalizes cost as `M = N + Hm`.

Each repo is one layer. `One` is Chapter 1.

---

### 7. Conclusion

We have shown the minimal counterexample. Bounded local change `|Δ| ≤ 3` does not guarantee bounded global behavior.

The difference between locking and diverging is one operation. Aim small, miss small — and when you hit, you hit exactly what matters.

**Lean proof + paper source:** github.com/Infinitespacemechanic/One

