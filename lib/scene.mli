(** The scene type, represents a scene of objects to be rendered from a
    vantage point *)
type t

(** [from_json j] is the representation of a scene built from json file [j] *)
val from_json : Yojson.Basic.t -> t

(** [objects scene] is a list of objects in [scene] *)
val objects : t -> Object.t list

(** [camera scene] is the camera in [scene] *)
val camera : t -> Camera.t
