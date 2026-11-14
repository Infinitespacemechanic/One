import Mathlib

/-- stepU: even +3, odd +1 -/
def stepU (n : Int) : Int :=
  if n % 2 = 0 then n + 3 else n + 1

/-- stepU_inv: even -1, odd -3 -/
def stepU_inv (m : Int) : Int :=
  if m % 2 = 0 then m - 1 else m - 3

theorem stepU_inv_stepU (n : Int) : stepU_inv (stepU n) = n := by
  unfold stepU stepU_inv
  split_ifs with h1 h2 h2 <;> omega

theorem stepU_stepU_inv (m : Int) : stepU (stepU_inv m) = m := by
  unfold stepU stepU_inv
  split_ifs with h1 h2 h2 <;> omega

theorem stepU_two_step (n : Int) : stepU (stepU n) = n + 4 := by
  unfold stepU
  split_ifs with h1 h2 h2 <;> omega

theorem unique_predecessor (m : Int) : ∃! n, stepU n = m := by
  refine ⟨stepU_inv m, ?_, ?_⟩
  · exact stepU_stepU_inv m
  · intro n h
    rw [← h]
    exact (stepU_inv_stepU n).symm

/-- F1, no ^ with Complex exponent. Use exp(log x). -/
noncomputable def F1 (x : ℝ) (t : ℝ) : ℂ :=
  let xc : ℂ := (x : ℂ)
  let exponent : ℂ := (1 / 2 : ℂ) + Complex.I * (t : ℂ)
  Complex.exp (exponent * Complex.log xc) / ((1 / 2 : ℂ) + Complex.I * (t : ℂ))

/-- Pair = F1 + F1, two fibers linked -/
noncomputable def FP (x : ℝ) (t : ℝ) : ℂ :=
  F1 x t + F1 x t

/-- t from fretboard: 1 Hz base, 2π per fret -/
noncomputable def t_of (n : Int) (k : Int) : ℝ :=
  2 * Real.pi * (((n - 1) * 24 + k + 1 : Int) : ℝ)