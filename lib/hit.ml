type t = {
  t : float;
  point : Vector.t;
  normal : Vector.t; 
  direction: Vector.t;
  material : Material.t
}

let create t point normal direction material = {t; point; normal; direction; material }

let distance { t; _ } = t  

let dir { direction; _ } = direction

let point { point; _ } = point

let mat { material; _ } = material

let norm { normal; _ } = normal

