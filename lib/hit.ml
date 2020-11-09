type t = {
  t : float;
  point : Vector.t;
  normal : Vector.t; 
  direction: Vector.t;
  material : Material.t
}

let create t point normal direction material = {t; point; normal; direction; material }

let distance {t; _ } = t  

let dir {direction; _ } = direction

