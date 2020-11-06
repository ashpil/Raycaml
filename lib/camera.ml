type t = 
  {origin : Vector.t;
   target: Vector.t;
   aspect_ratio : float; (* ratio of width to height *)
   vertical: Vector.t;
   v_f_of_v : float} (* v_f_of_v = vertical field of view*)

(* Not actuall useful at the moment, just dummy function so we can test scenes *)
let from_json json = 
  let v = Vector.origin in
  { origin = v; target = v; aspect_ratio = 0.0; vertical = v; v_f_of_v = 0.0}

let generate_ray camera x y = 
  let w = Vector.unit_vector (Vector.(-) camera.origin camera.target) in
  let u = Vector.unit_vector (Vector.(cross_prod) camera.vertical w) in
  let v = Vector.unit_vector (Vector.(cross_prod) w u) in
  let d = camera.v_f_of_v in 
  let x_comp = Vector.length (Vector.( * ) u x) in 
  let y_comp = Vector.length (Vector.( * ) v y) in 
  let z_comp =  Vector.length (Vector.( * ) w (-.d)) in
  let direction = Vector.create x_comp y_comp z_comp in
  Ray.create camera.origin direction 