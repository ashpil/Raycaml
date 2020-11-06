open Yojson.Basic.Util

(** The [object] is a shape that exists
    in the scene and has properties. *)
type t =
    | Sphere of { radius: float; center: Vector.t; material: Material.t }
    | Triangle of { vertices: Vector.t * Vector.t * Vector.t; material: Material.t }

let create_sphere radius center material = Sphere { radius; center; material }

(* TODO: clean this up *)
let from_json json =
  match json |> member "type" |> to_string with 
  | "sphere" -> Sphere {
    radius = json |> member "radius" |> to_float;
    material = json |> member "material" |> Material.from_json;
    center = json |> member "center" |> Vector.from_json;
  }
  | "triangle" -> Triangle {
    vertices = (json |> member "vertex1" |> Vector.from_json, json |> member "vertex2" |> Vector.from_json, json |> member "vertex3" |> Vector.from_json);
    material = json |> member "material" |> Material.from_json;
  }
  | _ -> failwith "unknown object type"

let mat = function 
  | Sphere { material; _ } -> material
  | Triangle { material; _ } -> material

let hit_from_t ray center t material =
    let point = Vector.( + ) (Ray.origin ray) (Vector.( * ) (Ray.dir ray) t) in
    let normal = center |> Vector.( - ) point |> Vector.unit_vector in
    Hit.create t point normal material

let intersect_sphere radius center ray mat =
  let d = Ray.dir ray in
  let p = Vector.( - ) (Ray.origin ray) center in

  let a = Vector.dot_prod d d in
  let b = (Vector.dot_prod p d) *. 2. in
  let c = Vector.dot_prod p p -. (radius *. radius) in

  let dt2 = (b *. b) -. (4. *. a *. c) in

  if dt2 < 0. then 
    None
  else 
    let dt = dt2 *. dt2 in

    let t0 = (-.(b +. dt)) /. (2. *. a) in
    let t1 = (-.(b -. dt)) /. (2. *. a) in
    if Ray.in_bounds t0 ray then Some (hit_from_t ray center t0 mat)
    else if Ray.in_bounds t1 ray then Some (hit_from_t ray center t1 mat)
    else None


let intersect ray = function
  | Sphere { radius; center; material } -> intersect_sphere radius center ray material
  | Triangle { vertices; material; } -> failwith "todo"
