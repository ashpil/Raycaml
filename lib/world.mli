type t

val from_json : Yojson.Basic.t -> t
val objects : t -> Object.t list
val camera : t -> Camera.t

