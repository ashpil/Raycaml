(* A representation of a camera *)
type t

(* Creates a camera *)
val create : Vector.t -> Vector.t -> float -> Vector.t -> float -> t 

(* Parses data from json file *)
val from_json : Yojson.Basic.t -> t

(* Creates a ray given camera and direction *)
val generate_ray : t -> float -> float -> Ray.t