open Yojson.Basic.Util

type t = 
  {origin : Vector.t;
   target: Vector.t;
   aspect_ratio : float; (* ratio of width to height (w/h)*)
   vertical: Vector.t;
   vfov : float} (* vfov = vertical field of view*)

let create origin target aspect_ratio vertical vfov =
  { origin; target; aspect_ratio; vertical; vfov; }

let from_json json = {
  origin = json |> member "origin" |> Vector.from_json;
  target =  json |> member "target" |> Vector.from_json;
  aspect_ratio =  json |> member "aspect_ratio" |> to_float;
  vertical = json |> member "vertical" |> Vector.from_json;
  vfov = json |> member "vfov" |> to_float;
}

let get_aspect {aspect_ratio; _} = aspect_ratio

let generate_ray camera x y = 
  let w = Vector.unit_vector (Vector.minus camera.origin camera.target) in
  let u = Vector.unit_vector (Vector.cross_prod camera.vertical w) in
  let v = Vector.unit_vector (Vector.cross_prod u w) in
  let height = 2. *. Float.tan(camera.vfov *. Float.pi /. 360.) in 
  let width = camera.aspect_ratio *. height in  
  let x = width *. (x -. 0.5) in
  let y = height *. (y -. 0.5) in
  let direction = Vector.minus (Vector.add (Vector.mult_constant u x) 
                                  (Vector.mult_constant v y)) w in
  Ray.create camera.origin direction 

