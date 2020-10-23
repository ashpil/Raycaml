(* Materials have different properties of how Lambertian they are, how metallic 
they are, and how dielectric they are. *)
type t

(* A hit_record is a collection of data for when a ray hits an object *)
type hit_record

val from_json : Yojson.Basic.t -> t
