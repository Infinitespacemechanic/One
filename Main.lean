-- Main.lean
-- Bounded local step can have an unbounded orbit
-- Two maps. Same chassis. One extra kick.

def stepU (n : Nat) : Nat :=
  if n % 2 == 0 then n + 3 else n + 1

def orbitU : Nat -> Nat
  | 0 => 0
  | k+1 => stepU (orbitU k)

theorem stepU_even (n : Nat) (h : n % 2 = 0) : stepU n = n + 3 := by
  simp [stepU, h]

theorem stepU_odd (n : Nat) (h : n % 2 = 1) : stepU n = n + 1 := by
  simp [stepU, h]

theorem two_steps_add_four (n : Nat) (h : n % 2 = 0) : stepU (stepU n) = n + 4 := by
  have h1 : stepU n = n + 3 := stepU_even n h
  have h2 : (n + 3) % 2 = 1 := by omega
  calc stepU (stepU n) = stepU (n + 3) := by rw [h1]
    _ = n + 4 := by simp [stepU, h2]

theorem orbitU_double (k : Nat) : orbitU (2*k) = 4*k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    have h_eq : 2*(k+1) = (2*k+1)+1 := by omega
    calc orbitU (2*(k+1))
        = orbitU ((2*k+1)+1) := by rw [h_eq]
      _ = stepU (orbitU (2*k+1)) := rfl
      _ = stepU (stepU (orbitU (2*k))) := rfl
      _ = stepU (stepU (4*k)) := by rw [ih]
      _ = 4*k + 4 := two_steps_add_four (4*k) (by omega)
      _ = 4*(k+1) := by omega

def main : IO Unit := do
  let vals := List.range 10 |>.map orbitU
  IO.println s!"One: orbitU from 0 = {vals}  -- +4 per 2 steps, unbounded"
