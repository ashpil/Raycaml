open Yojson.Basic.Util

type t = {x : float; y : float; z : float}

let from_json json = {
  x = json |> member "x" |> to_float;
  y = json |> member "y" |> to_float;
  z = json |> member "z" |> to_float;
}

let create x y z = {
  x = x;
  y = y; 
  z = z;
} 

let origin = {
  x = 0.;
  y = 0.;
  z = 0.;
}

let get_x t = t.x

let get_y t = t.y 

let get_z t = t.z 

let minus t1 t2 = {
  x = t1.x -. t2.x;
  y = t1.y -. t2.y;
  z = t1.z -. t2.z;
}

let add t1 t2 = {
  x = t1.x +. t2.x;
  y = t1.y +. t2.y;
  z = t1.z +. t2.z;
}

let mult_constant t c = {
  x = t.x *. c;
  y = t.y *. c;
  z = t.z *. c;
}

let mult t1 t2 = {
  x = t1.x *. t2.x;
  y = t1.y *. t2.y;
  z = t1.z *. t2.z;
}

let div_constant t c = {
  x = t.x /. c;
  y = t.y /. c;
  z = t.z /. c;
}

let dot_prod t1 t2 = (t1.x *. t2.x) +. (t1.y *. t2.y) +. (t1.z *. t2.z)

let cross_prod t1 t2 = {
  x = (t1.y *. t2.z) -. (t1.z *. t2.y);
  y = (t1.z *. t2.x) -. (t1.x *. t2.z);
  z = (t1.x *. t2.y) -. (t1.y *. t2.x);
}

let length t = Float.sqrt(t.x *. t.x +. t.y *. t.y +. t.z *. t.z)

let unit_vector t1 = div_constant t1 (length t1)

let det v1 v2 v3 = 
  let a = get_x v1 in
  let b = get_x v2 in
  let c = get_x v3 in
  let d = get_y v1 in
  let e = get_y v2 in
  let f = get_y v3 in
  let g = get_z v1 in
  let h = get_z v2 in
  let j = get_z v3 in

  let aej = a *. e *. j in  
  let afh = a *. f *. h in  
  let bdj = b *. d *. j in  
  let bfg = b *. f *.g in  
  let cdh = c *. d *. h in  
  let ceg = c *.e *. g in  

  aej -. afh -. bdj +. bfg +. cdh -. ceg

let string_of_vector v = 
  let x = v |> get_x |> string_of_float in
  let y = v |> get_y |> string_of_float in
  let z = v |> get_z |> string_of_float in
  "[ " ^ x ^ " " ^ y ^ " " ^ z ^ " ]"
