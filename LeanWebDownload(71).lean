-- Main.lean
-- A bounded local step can have an unbounded orbit.

def stepU (n : Nat) : Nat :=
  if n % 2 == 0 then n + 3 else n + 1

def orbitU : Nat → Nat
  | 0 => 0
  | k + 1 => stepU (orbitU k)

theorem stepU_even (n : Nat) (h : n % 2 = 0) :
    stepU n = n + 3 := by
  simp [stepU, h]

theorem stepU_odd (n : Nat) (h : n % 2 = 1) :
    stepU n = n + 1 := by
  simp [stepU, h]

/--
Every local step increases the value by at least 1
and by at most 3.
-/
theorem stepU_bounds (n : Nat) :
    n + 1 ≤ stepU n ∧ stepU n ≤ n + 3 := by
  by_cases h : n % 2 = 0
  · rw [stepU_even n h]
    omega
  · have hodd : n % 2 = 1 := by
      omega
    rw [stepU_odd n hodd]
    omega

/--
Starting from an even number, two steps add exactly 4.
-/
theorem two_steps_add_four (n : Nat) (h : n % 2 = 0) :
    stepU (stepU n) = n + 4 := by
  have h1 : stepU n = n + 3 := stepU_even n h
  have h2 : (n + 3) % 2 = 1 := by
    omega
  calc
    stepU (stepU n) = stepU (n + 3) := by
      rw [h1]
    _ = n + 4 := by
      rw [stepU_odd (n + 3) h2]

/--
Every pair of steps in the orbit increases the value by 4.
-/
theorem orbitU_double (k : Nat) :
    orbitU (2 * k) = 4 * k := by
  induction k with
  | zero =>
      rfl
  | succ k ih =>
      have hindex : 2 * (k + 1) = (2 * k) + 2 := by
        omega
      rw [hindex]
      simp only [orbitU]
      have hvalue : orbitU (2 * k) = 4 * k := ih
      rw [hvalue]
      have heven : (4 * k) % 2 = 0 := by
        omega
      rw [two_steps_add_four (4 * k) heven]
      omega

/--
The orbit is unbounded.
-/
theorem orbitU_unbounded :
    ∀ bound : Nat, ∃ k : Nat, bound < orbitU (2 * k) := by
  intro bound
  refine ⟨bound + 1, ?_⟩
  rw [orbitU_double]
  omega

def main : IO Unit := do
  let vals := List.range 10 |>.map orbitU
  IO.println s!"One: orbitU from 0 = {vals}"

