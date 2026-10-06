-- ThreeMachine.lean
-- Common chassis: parity check
def parity (n : Nat) : Nat := n % 2

def BoundedStep (f : Nat -> Nat) : Prop :=
  ∀ n, (f n : Int) - (n : Int) ≤ 3
