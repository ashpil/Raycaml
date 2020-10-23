type t = {origin : Vector.t; direction : Vector.t}

let create origin direction = {origin; direction}

let evaluate ray magnitude = Vector.(ray.origin + ray.direction * magnitude)