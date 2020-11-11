open Yojson.Basic.Util

type t = {
  diffuse : Vector.t;
  spec_co : Vector.t;
  spec_exp : float;
  mirror : Vector.t;
  ambient : Vector.t;
}

let create diffuse spec_co spec_exp mirror ambient = 
  {diffuse; spec_co; spec_exp; mirror; ambient;}

let from_json json = {
  diffuse = json |> member "diffuse" |> Vector.from_json;
  spec_co =  json |> member "spec_co" |> Vector.from_json;
  spec_exp =  json |> member "spec_exp" |> to_float;
  mirror = json |> member "mirror" |> Vector.from_json;
  ambient = json |> member "ambient" |> Vector.from_json;
}

let specular angle {diffuse; spec_co; spec_exp; _ } =
  Vector.add diffuse (Vector.mult_constant spec_co (angle ** spec_exp))

