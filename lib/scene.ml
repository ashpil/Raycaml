open Yojson.Basic.Util

type t = { objects: Object.t list; bg_color: Vector.t }

let from_json json = {
  objects = json |>  member "objects" |> to_list |> List.map Object.from_json;
  bg_color = json |> member "bg_color" |> Vector.from_json 
}

let create objects bg_color = { objects; bg_color }

let objects scene = scene.objects

let bg_color scene = scene.bg_color

let cmp_hit h1 h2 = Stdlib.compare (Hit.distance h1) (Hit.distance h2)

let get_greater_hit h1 h2 =
  match Option.compare cmp_hit h1 h2 with 
  | 1 -> h1
  | _ -> h2

let intersect ray scene = 
  scene.objects
  |> List.map (fun obj -> Object.intersect ray obj)
  |> List.fold_left (get_greater_hit) None

