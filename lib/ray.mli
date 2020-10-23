(* A ray has an origin and a direction *)
type t = {origin : Vector.t; direction : Vector.t}

(** Create a ray at [origin] with [direction] *)
val create : Vector.t -> Vector.t -> t

(* Evaluate a [ray] given a [magnitude] using the function P(t) = A + tb where 
A is the ray's origin, b is the ray's direction, and t is the magnitude.*)
val evaluate : t -> float -> Vector.t