type pos = float * float * float
(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; material: Material.t; position: pos }
    | Box of { width: float; height: float; material: Material.t; position: pos }
    | Cylinder of { radius: float; height: float; material: Material.t; position: pos }

let mat = function 
  | Sphere { material } -> material
  | Box { material } -> material
  | Cylinder { material } -> material

let pos = function
  | Sphere { position } -> position
  | Box { position } -> position
  | Cylinder { position } -> position

