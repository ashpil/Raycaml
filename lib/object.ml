open Yojson.Basic.Util

(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; material: Material.t; center: Vector.t }
    | Triangle of { vertices: Vector.t * Vector.t * Vector.t; material: Material.t }

(* TODO: clean this up *)
let from_json json =
  match json |> member "type" |> to_string with 
  | "sphere" -> Sphere {
    radius = json |> member "radius" |> to_float;
    material = json |> member "material" |> Material.from_json;
    center = json |> member "center" |> Vector.from_json;
  }
  | "triangle" -> Triangle {
    vertices = (json |> member "vertex1" |> Vector.from_json, json |> member "vertex2" |> Vector.from_json, json |> member "vertex3" |> Vector.from_json);
    material = json |> member "material" |> Material.from_json;
  }
  | _ -> failwith "unknown object type"

let mat = function 
  | Sphere { material; _ } -> material
  | Triangle { material; _ } -> material

let intersect obj hit = failwith "unimplemented"
