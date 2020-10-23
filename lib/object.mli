type t

val from_json :  Yojson.Basic.t -> t
val pos : t -> Vector.t
val mat : t -> Material.t

