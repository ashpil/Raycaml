(* Materials have different properties of how Lambertian they are, how metallic 
they are, and how dielectric they are. *)
type t

val from_json : Yojson.Basic.t -> t

val create_dielectric : float -> t