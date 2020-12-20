open Yojson.Basic.Util

(**A light can optionally have a position. If it does not have one, it is 
   simply an ambient light and shades all surfaces equally. If it does have a 
   position, the shading depends on the light's distance and access to the 
   surface *)
type t = { intensity : Vector.t; position: Vector.t option }

let from_json json = {
  intensity = json |> member "intensity" |> Vector.from_json;
  position = json |> member "position" |> 
             to_option (fun x -> Vector.from_json x);
}

let create_point intensity position = { intensity; position = Some position }

let create_ambient intensity = {intensity; position = None}

let intensity light = light.intensity 

let position light = light.position 

let illuminate hit scene { intensity; position; } =
  match position with
  | Some position ->
    let hit_point = Hit.point hit in
    let light_ray = Vector.minus position hit_point in

    let shadow_ray = Ray.create hit_point light_ray |> Ray.add_start 0.00001 in

    if Scene.intersect_bool shadow_ray scene then
      Vector.create 0. 0. 0.
    else 
      let hit_norm = Hit.norm hit in
      let v = Vector.mult_constant (Vector.unit_vector (Hit.dir hit)) ~-.1. in
      let l = Vector.unit_vector light_ray in
      let h = Vector.unit_vector (Vector.add v l) in
      let angle = Vector.dot_prod hit_norm h in
      let numer = max 0.0 (Vector.dot_prod hit_norm l) in
      let denom = Vector.length light_ray ** 2.0 in
      let irradiance = Vector.mult_constant intensity (numer /. denom) in
      let specular = Material.specular angle (Hit.mat hit) in
      Vector.mult irradiance specular
  | None -> Material.ambient intensity (Hit.mat hit)

