type t = 
  {origin : Vector.t;
  lower_left : Vector.t;
  vertical: Vector.t;
  horizontal : Vector.t;
  u : Vector.t;
  v : Vector.t;
  w : Vector.t;
  lens_radius : float}

(* Not actuall useful at the moment, just dummy function so can test scenes *)
let from_json json = 
  let v = Vector.origin in
  { origin = v; lower_left = v; vertical = v; horizontal = v; u = v; v = v; w = v; lens_radius = 0. }
