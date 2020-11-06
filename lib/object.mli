(** The object type, represents a shape in a scene. *)
type t

(** [from_json json] is the object built from [json] *)
val from_json :  Yojson.Basic.t -> t

(** [mat object] is the material of [object] *)
val mat : t -> Material.t

val intersect : Ray.t -> t -> Hit.t option

val create_sphere : float -> Vector.t -> Material.t -> t