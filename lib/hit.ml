type t = 
  | No_hit
  | Hit of {t : float;
                  point : Vector.t;
                  normal : Vector.t; 
                  material : Material.t}

let no_hit = No_hit

let create t point normal material = Hit {t; point; normal; material }