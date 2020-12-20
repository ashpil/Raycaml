open Yojson.Basic.Util

type t = {
  objects: Object.t list;
  bg_color: Vector.t
}

let from_json json = {
  objects =
    json
    |> member "objects"
    |> to_list
    |> List.map Object.from_json;
  bg_color =
    json
    |> member "bg_color"
    |> Vector.from_json 
}

let create objects bg_color =
  { objects; bg_color }

let objects { objects; _ } =
  objects

let bg_color { bg_color; _ } =
  bg_color

let cmp_hit h1 h2 =
  Stdlib.compare (Hit.distance h2) (Hit.distance h1)

let get_greater_hit h1 h2 =
  match Option.compare cmp_hit h1 h2 with 
  | 1 -> h1
  | _ -> h2

let intersect ray { objects; _ } = 
  objects
  |> List.map (Object.intersect ray)
  |> List.fold_left get_greater_hit None

let intersect_bool ray { objects; _ } =
  List.exists (fun x -> Option.is_some (Object.intersect ray x)) objects
