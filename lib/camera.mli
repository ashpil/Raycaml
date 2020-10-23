(* A representation of a camera with an origin, lower_left vector, 
vertical vector, horizontal vector, u vector, v vector, w vector, 
and lens_radius *)
type t

val from_json : Yojson.Basic.t -> t
