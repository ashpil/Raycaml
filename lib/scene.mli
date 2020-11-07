(** The scene type, represents a scene of objects to be rendered from a
    vantage point *)
type t

(** [from_json j] is the representation of a scene built from json file [j] *)
val from_json : Yojson.Basic.t -> t

val create : Object.t list -> Vector.t -> t

(** [objects scene] is a list of objects in [scene] *)
val objects : t -> Object.t list

val intersect : Ray.t -> t -> Hit.t option