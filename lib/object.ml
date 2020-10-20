type pos = float * float * float
(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; material: Material.t; position: pos }
    | Box of { width: float; height: float; material: Material.t; position: pos }
    | Cylinder of { radius: float; height: float; material: Material.t; position: pos }

let mat obj =
  obj.material

let pos obj =
  obj.position

