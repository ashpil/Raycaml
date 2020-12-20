(** The object type, represents a shape in a scene. *)
type t

(** [from_json json] is the object built from [json] *)
val from_json :  Yojson.Basic.t -> t

(** [mat object] is the material of [object] *)
val mat : t -> Material.t

(** [intersect ray object] is Some hit if [ray] intersects [object], creating
a hit, otherwise, None *)
val intersect : Ray.t -> t -> Hit.t option

(** [create_sphere r c mat] is the object of type Sphere with radius [r], 
    center [c], and material [mat]. *)
val create_sphere : float -> Vector.t -> Material.t -> t

(** [create_triangle verts mat] is the object of type Triangle with vertices 
    [verts] and material [mat]. *)
val create_triangle : Vector.t * Vector.t * Vector.t -> Material.t -> t
