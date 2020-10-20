type t = {origin : Vector.t; direction : Vector.t}

val create : Vector.t -> Vector.t -> t

val evaluate : t -> float -> Vector.t