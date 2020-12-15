open Yojson.Basic.Util

(* A light can optionally have a position. If it does not have one, it is simply an ambient light
 * and shades all surfaces equally. If it does have a position, the shading depends on the light's
 * distance and access to the surface *)
type t = { intensity : Vector.t; position: Vector.t option }

let from_json json = {
  intensity = json |> member "intensity" |> Vector.from_json;
  position = json |> member "position" |> 
    to_option (fun x -> Vector.from_json x);
}

let create_point intensity position = { intensity; position = Some position }

let create_ambient intensity = {intensity; position = None}

let illuminate hit scene { intensity; position; } =
  match position with
  | Some position ->
    let light_ray = Vector.minus position (Hit.point hit) in
    let v = Vector.mult_constant (Vector.unit_vector (Hit.dir hit)) ~-.1. in
    let l = Vector.unit_vector light_ray in
    let h = Vector.unit_vector (Vector.add v l) in
    let angle = Vector.dot_prod (Hit.norm hit) h in
    Material.specular (Vector.dot_prod (Hit.norm hit) h) (Hit.mat hit)
  | None -> Vector.create 0. 0. 0.

