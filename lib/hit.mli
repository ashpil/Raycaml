(** The hit type *)
type t

(** [create t point normal direction material] is a hit of distance [t] along 
    the ray, at [point], with a [normal], [direction] of the hitting ray, and 
    a [material] at the location of the hit. *)
val create : float -> Vector.t -> Vector.t -> Vector.t -> Material.t -> t

(** [distance hit] is the distance along the ray this hit was *)
val distance : t -> float

(** [dir hit] is the direction that the ray that created this hit was coming 
    from *)
val dir : t -> Vector.t

(** [point hit] is the point on the object that the ray hit *)
val point : t -> Vector.t

(** [mat hit] is the material on the object that the ray hit *)
val mat : t -> Material.t

(** [norm hit] is the normal of the hit *)
val norm : t -> Vector.t

