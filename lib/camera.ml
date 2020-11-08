type t = 
  {origin : Vector.t;
   target: Vector.t;
   aspect_ratio : float; (* ratio of width to height (w/h)*)
   vertical: Vector.t;
   vfov : float} (* vfov = vertical field of view*)

let create origin target aspect_ratio vertical vfov =
  { origin; target; aspect_ratio; vertical; vfov; }

(* Not actually useful at the moment, just dummy function so we can test scenes *)
let from_json json = 
  let v = Vector.origin in
  { origin = v; target = v; aspect_ratio = 0.0; vertical = v; vfov = 0.0}

let generate_ray camera x y = 
  let w = Vector.unit_vector (Vector.(-) camera.origin camera.target) in
  let u = Vector.unit_vector (Vector.cross_prod camera.vertical w) in
  let v = Vector.unit_vector (Vector.cross_prod w u) in
  let height = 2. *. Float.tan(camera.vfov *. Float.pi /. 360.) in 
  let width = camera.aspect_ratio *. height in  
(*  let d = Vector.length camera.origin in
  let x_comp = Vector.length (Vector.( * ) u (width *. x)) in 
  let y_comp = Vector.length (Vector.( * ) v (height *.y)) in 
  let z_comp =  Vector.length (Vector.( * ) w (-.d)) in
  let direction = Vector.create x_comp y_comp z_comp in *)
  let x = width *. (x -. 0.5) in
  let y = height *. (y -. 0.5) in
  let direction = Vector.( - ) (Vector.( + ) (Vector.( * ) u x) (Vector.( * ) v y)) w in
  Ray.create camera.origin direction 
