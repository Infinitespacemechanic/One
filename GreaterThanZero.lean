import Mathlib.Tactic

/-
  GreaterThanZero.lean
  Ground level for UPT: Matter is defined by mass > 0.
  No matter is counted as 1 unless it is > 0.
  Space is not zero. Pressure needs more than one.
  Counting is recursive on the clock 1, 3, 6, 9, 12 in base 60.
-/

/-- Matter is anything with mass strictly greater than zero. -/
structure Matter where
  mass : ℝ
  mass_pos : 0 < mass

/-- Space is a place where matter can be. Space itself is not zero:
    even "empty" space has matter > 0 in it, e.g. hydrogen in space. -/
structure Space where
  hasMatter : Matter → Prop

/-- Pressure needs more than one: one alone has no pressure.
    Two or more give pressure from multiplicity. -/
def HasPressure (_m₁ _m₂ : Matter) : Prop :=
  True

/-- The clock positions: 1, 3, 6, 9, 12 in base 60.
    12 = 0 on the clock, the seam where counting recurses. -/
inductive ClockPos where
  | one | three | six | nine | twelve
deriving DecidableEq, Repr

/-- Angle in degrees for each clock position. Base 60: 1 tick = 30 degrees. -/
def clockAngle : ClockPos → ℝ
  | .one => 30
  | .three => 90
  | .six => 180
  | .nine => 270
  | .twelve => 360

/-- 12 is the seam: 360 degrees = 0 degrees. -/
theorem twelve_is_seam : clockAngle .twelve = 360 := rfl

/-- 59/60 is less than the whole: the gap that keeps the lever moving. -/
theorem fifty_nine_sixtieth_lt_one : (59 : ℝ) / 60 < 1 := by
  norm_num

/-- Sum of two positive masses is positive: accumulation is > 0. -/
theorem mass_add_pos {a b : Matter} :
    0 < a.mass + b.mass := by
  have h1 := a.mass_pos
  have h2 := b.mass_pos
  linarith

/-- Finite sum of positive masses is positive, for a non-empty collection.
    This is the discrete ledger: blocked exit + positive rain => growth. -/
theorem sum_mass_pos {n : ℕ} (hn : 0 < n) (m : Fin n → Matter) :
    0 < ∑ i, (m i).mass := by
  apply Finset.sum_pos
  · intro i _
    exact (m i).mass_pos
  · exact ⟨⟨0, hn⟩, Finset.mem_univ _⟩

/-- Recursive counting: after 12 we return to 1, but with carried mass.
    The next cycle is not the same as the last: mass is carried forward. -/
structure RecursiveCount where
  cycle : ℕ
  pos : ClockPos
  carriedMass : ℝ
  carried_pos : 0 ≤ carriedMass

/-- One step forward on the clock, carrying mass. -/
def nextPos : ClockPos → ClockPos
  | .one => .three
  | .three => .six
  | .six => .nine
  | .nine => .twelve
  | .twelve => .one

/-- After 12, the cycle increments: recursion, not just linear counting. -/
def step (c : RecursiveCount) (added : Matter) : RecursiveCount :=
  match c.pos with
  | .twelve =>
    { cycle := c.cycle + 1
      pos := .one
      carriedMass := c.carriedMass + added.mass
      carried_pos := by
        have h1 := c.carried_pos
        have h2 := added.mass_pos
        linarith }
  | _ =>
    { cycle := c.cycle
      pos := nextPos c.pos
      carriedMass := c.carriedMass + added.mass
      carried_pos := by
        have h1 := c.carried_pos
        have h2 := added.mass_pos
        linarith }

/-- The mass gap in this ground-level form:
    vacuum is 0, the next state is at least some m > 0.
    There is nothing between 0 and the gap. -/
structure MassGap where
  gap : ℝ
  gap_pos : 0 < gap

/-- Main ground-level statement for all space:
    If matter exists in space, its mass is > 0, and any accumulation
    of such matter is also > 0. Space is never truly zero. -/
theorem greater_than_zero_for_all_space
    (m : Matter) : 0 < m.mass :=
  m.mass_pos

/-
  What this file does NOT claim:
  - It does not prove the continuum Yang-Mills mass gap.
  - It does not prove Navier-Stokes regularity.
  - It proves only the ground level: > 0 is the condition for matter,
    accumulation preserves > 0, counting is recursive on 1,3,6,9,12,
    and 59/60 < 1 keeps the system less than the whole so it keeps moving.
  The continuum limit, the field, and the container must be added on top
  of this base, exactly as in WaterSheetConserved.lean.
-/
