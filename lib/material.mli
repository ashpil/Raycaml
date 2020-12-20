(** Materials have different properties that define how light produces color *)
type t

(** [from_json j] is the representation of a material built from json object 
    [j] *)
val from_json : Yojson.Basic.t -> t

(** [create diffuse spec_co spec_exp mirror ambient] is an object with those 
    properties *)
val create : Vector.t -> Vector.t -> float -> Vector.t -> Vector.t -> t

(** [specular angle mat] is the specular shading at [angle] for [mat] *)
val specular : float -> t -> Vector.t

(** [ambient intensity mat] is the ambient shading with [intensity] for [mat] *)
val ambient : Vector.t -> t -> Vector.t
