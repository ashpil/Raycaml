(** The light type *)
type t

(** [create_point intensity position] creates a point light at [position] with 
    [intensity] *)
val create_point : Vector.t -> Vector.t -> t

(** [create_ambient intensity] creates an ambient light with [intensity] *)
val create_ambient : Vector.t -> t

(** [from_json j] is the light represented by the json data [json] *)
val from_json : Yojson.Basic.t -> t

(** [illuminate hit scene light] is the color gotten from hitting the hit's 
    point in [scene] while from [light] *)
val illuminate : Hit.t -> Scene.t -> t -> Vector.t

(** [intensity light] is the intensity vector of [light]*)
val intensity : t -> Vector.t 

(** [position light] is the position of [light]. If [light] has no position,
    it returns None. Otherwise, it returns Some [position] *)
val position : t -> Vector.t option