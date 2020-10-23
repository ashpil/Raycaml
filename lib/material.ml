type t = 
  | Lambertian of Vector.t
  | Metal of Vector.t * float
  | Dielectric of float

type hit_record = {t : float;
                  p : Vector.t;
                  normal : Vector.t; 
                  front_face : bool; 
                  material : t}

let scatter material (ray : Ray.t) hit_record = match material with
  | Lambertian vec ->  failwith "Unimplemented"
  | Metal (vec, flo) -> failwith "Unimplemented"
  | Dielectric refraction -> failwith "Unimplemented"

    

    
    