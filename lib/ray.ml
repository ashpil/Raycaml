type t = {
  origin : Vector.t;
  direction : Vector.t;
  start : float;
  finish : float option
}

let create origin direction =
  {origin; direction; start = 0.; finish = None}

let add_start start ray =
  { ray with start }

let evaluate { origin; direction; _ } magnitude =
  Vector.add origin (Vector.mult_constant direction magnitude)

let dir { direction; _ } =
  direction

let origin { origin; _ } =
  origin

let in_bounds d = function
  | {start; finish = Some(f); _ } ->
    f >= d && d >= start
  | {start; _ } ->
    d >= start
