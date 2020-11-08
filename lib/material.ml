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

let from_json json = failwith "fix me pls"

