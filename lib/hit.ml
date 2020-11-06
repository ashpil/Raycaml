type t = 
  {t : float;
          point : Vector.t;
          normal : Vector.t; 
          material : Material.t}

let create t point normal material = {t; point; normal; material }

let distance {t; _ } = t  