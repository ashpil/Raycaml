open Yojson.Basic.Util

type t = 
  | Lambertian of Vector.t
  | Metal of Vector.t * float
  | Dielectric of float

let from_json json =
  match json |> member "type" |> to_string with 
  | "lambertian" -> Lambertian (json |> member "vec" |> Vector.from_json)
  | "metal" -> 
    Metal (json |> member "vec" |> Vector.from_json,
           json |> member "float" |> to_float)
  | "dielectric" -> Dielectric (json |> member "float" |> to_float)
  | _ -> failwith "unknown material type"

type hit_record = {t : float;
                  p : Vector.t;
                  normal : Vector.t; 
                  front_face : bool; 
                  material : t}

let scatter material (ray : Ray.t) hit_record = match material with
  | Lambertian vec ->  failwith "Unimplemented"
  | Metal (vec, flo) -> failwith "Unimplemented"
  | Dielectric refraction -> failwith "Unimplemented"
