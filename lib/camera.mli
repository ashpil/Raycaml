(** A representation of a camera *)
type t

(** [create origin target aspect_ratio vertical vfov] creates a camera with 
    those properties *)
val create : Vector.t -> Vector.t -> float -> Vector.t -> float -> t 

(** [get_aspect camera] is the aspect ratio of [camera] *)
val get_aspect : t -> float

(** [from_json json] is the camera represented by [json] *)
val from_json : Yojson.Basic.t -> t

(** [generate ray x y] is the ray emitted from the camera at location [x], [y] 
*)
val generate_ray : t -> float -> float -> Ray.t

