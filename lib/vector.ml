type t = {x : float; y : float; z : float}


let create x y z = {
  x = x;
  y = y; 
  z = z;
} 

let get_x t = t.x

let get_y t = t.y 

let get_z t = t.z 

let ( - ) t1 t2 = {
  x = t1.x -. t2.x;
  y = t1.y -. t2.y;
  z = t1.z -. t2.z;
}

let ( + ) t1 t2 = {
  x = t1.x +. t2.x;
  y = t1.y +. t2.y;
  z = t1.z +. t2.z;
}

let ( * ) t c = {
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

let length t = sqrt(t.x *. t.x +. t.y *. t.y +. t.z *. t.z)

let unit_vector t1 = div_constant t1 (length t1)

let random_unit_vector = 
  let theta = Random.float (2. *. Float.pi) in 
  let pos_or_neg = Random.bool () in 
  let z = if pos_or_neg then Random.float 1. else Random.float (-1.) in 
  {
    x = (Float.sqrt (1. -. z *. z)) *. Float.cos theta;
    y = (Float.sqrt (1. -. z *. z)) *. Float.sin theta;
    z = z;
  }
