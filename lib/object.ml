open Yojson.Basic.Util

(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; material: Material.t; position: Vector.t }
    | Box of { size: Vector.t; material: Material.t; position: Vector.t }
    | Cylinder of { radius: float; height: float; material: Material.t; position: Vector.t }

let from_json json =
  match json |> member "type" |> to_string with 
  | "sphere" -> Sphere {
    radius = json |> member "radius" |> to_float;
    material = json |> member "material" |> Material.from_json;
    position = json |> member "position" |> Vector.from_json;
  }
  | "box" -> Box {
    size = json |> member "size" |> Vector.from_json;
    material = json |> member "material" |> Material.from_json;
    position = json |> member "position" |> Vector.from_json;
  }
  | "cylinder" -> Cylinder {
    radius = json |> member "radius" |> to_float;
    height = json |> member "height" |> to_float;
    material = json |> member "material" |> Material.from_json;
    position = json |> member "position" |> Vector.from_json;
  }
  | _ -> failwith "unknown object type"

let mat = function 
  | Sphere { material; _ } -> material
  | Box { material; _ } -> material
  | Cylinder { material; _ } -> material

let pos = function
  | Sphere { position; _ } -> position
  | Box { position; _ } -> position
  | Cylinder { position; _ } -> position

