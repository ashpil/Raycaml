(* A representation of a camera *)
type t

val from_json : Yojson.Basic.t -> t
