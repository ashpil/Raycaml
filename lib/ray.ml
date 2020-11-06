type t = { origin : Vector.t;
        direction : Vector.t;
        start : float;
        finish : float option }

let create origin direction = {origin; direction; start = 0.; finish = None}

let evaluate ray magnitude = Vector.(ray.origin + ray.direction * magnitude)

let dir ray = ray.direction

let origin ray = ray.origin

let in_bounds d = function
  | {start; finish = Some(f); _ } -> f >= d && d >= start
  | {start; _ } -> d >= start