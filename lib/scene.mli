(** The scene type, represents a scene of objects to be rendered from a
    vantage point *)
type t

(** [from_json j] is the representation of a scene built from json file [j] *)
val from_json : Yojson.Basic.t -> t

(** [create objects bg_color] is a scene with [objects] and background color [bg_color] *)
val create : Object.t list -> Vector.t -> t

(** [bg_color scene] is the scene's bg_color [scene] *)
val bg_color : t -> Vector.t

(** [objects scene] is a list of objects in [scene] *)
val objects : t -> Object.t list

(** [intersect ray scene] intersects the ray with all objects in the scene, and returns
 * the hit with smallest t value *)
val intersect : Ray.t -> t -> Hit.t option

