-- Stable.lean
-- Pair-rest version: sits after one tick

def stepS (n : Nat) : Nat :=
  if n % 2 == 0 then n else n + 1

theorem stepS_even (n : Nat) (h : n % 2 = 0) : stepS n = n := by
  simp [stepS, h]

theorem stepS_odd (n : Nat) (h : n % 2 = 1) : stepS n = n + 1 := by
  simp [stepS, h]

theorem stepS_idempotent (n : Nat) : stepS (stepS n) = stepS n := by
  by_cases h : n % 2 = 0
  · simp [stepS, h]
    have h1 : (n % 2 = 0) := h
    simp [stepS, h1]
  · have h1 : n % 2 = 1 := by omega
    have h2 : (n + 1) % 2 = 0 := by omega
    simp [stepS, h, h1, h2]
