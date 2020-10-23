open Yojson.Basic.Util

type t = { objects: Object.t list; camera: Camera.t }

let from_json json = {
  objects = json |> member "objects" |> to_list |> List.map Object.from_json;
  camera = json |> member "camera" |> Camera.from_json;
}
  
let objects scene = scene.objects

let camera scene = scene.camera
