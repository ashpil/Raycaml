(** The ray type - has an origin and a direction *)
type t

(** [create origin direction] creates a ray at [origin] with [direction]. *)
val create : Vector.t -> Vector.t -> t

(** [add_start ray start] is [ray] with it's start set to [start]. *)
val add_start : float -> t -> t

(** [evaluate ray magnitude] evaluates a [ray] given a [magnitude] using the 
    function P(t) = A + tb where A is the ray's origin, b is the ray's 
    direction, and t is the magnitude.*)
val evaluate : t -> float -> Vector.t

(** [dir ray] is the direction vector of [ray]. *)
val dir : t -> Vector.t

(** [origin ray] is the origin vector of [ray]*)
val origin : t -> Vector.t

(** [in_bounds f ray] is true if [f] is in bounds of [ray], otherwise it 
    is false *)
val in_bounds : float -> t -> bool