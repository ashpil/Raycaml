type pos = float * float * float

(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; material: Material.t; position: pos }
    | Box of { width: float; height: float; material: Material.t; position: pos }
    | Cylinder of { radius: float; height: float; material: Material.t; position: pos }

let mat = function 
  | Sphere { material; _ } -> material
  | Box { material; _ } -> material
  | Cylinder { material; _ } -> material

let pos = function
  | Sphere { position; _ } -> position
  | Box { position; _ } -> position
  | Cylinder { position; _ } -> position

