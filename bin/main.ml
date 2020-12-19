(** 
   how to write PPM file:
   - create an output file stream (ex output.ppm)
   - writing to a file in OCaml: open file to obtain an out_channel 
     -- write stuff to the channel 
     -- when done, close the channel (should flush out_channel)
     -- functions: open_out, open_out_bin, flush, close_out, close_out_nerr
     -- standard out_channels: stdout, stderr
   - need to write a header:
     P3 
     width height 
     maximum size of colors (255)
   - for loop 
     -- outer loop = row 
     -- inner loop = each pixel in that row (columns)
   - three values for red green and blue, %256 to be within 255 bounds
*)
open Yojson.Basic.Util
open Raycaml

(**  #require "yojson";;
     let myvar = Yojson.Basic.from_string "\"object\"";;
     Yojson.Basic.to_file "exfile.json" myvar;;

*)


let create_ppm camera light scene bg_color file width height = 
  let oc = open_out file in    (* create or truncate file, return channel *)
  Printf.fprintf oc "P6\n%d %d\n255\n" width height; 
  for i = 0 to pred height do (* write each row *)
    for j = 0 to pred width do (* write each pixel in a row *)
      let v = ((float_of_int i) +. 0.5) /. (float_of_int height) in
      let u = ((float_of_int j) +. 0.5) /. (float_of_int width) in
      let ray = Camera.generate_ray camera u v in
      match Scene.intersect ray scene with
      | Some(hit) ->
        let color = Light.illuminate hit scene light in
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_x color) *. 255.))); 
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_y color) *. 255.))); 
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_z color) *. 255.))); 
      | None -> 
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_x bg_color) *. 255.))); 
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_y bg_color) *. 255.))); 
        output_char oc (char_of_int (int_of_float 
                                       ((Vector.get_z bg_color) *. 255.))); 
    done 
  done;

  output_char oc '\n';
  close_out oc; (* flush and close the channel *)

  print_endline "  Congratulations! Your completed raytraced scene, output as a 
  ppm file, should be located in whatever directory you're currently in. 
  Thank you for using our Raytracer! We hope you had fun."; 


type material = Material.t

type custom_in = {
  objects_in : Object.t list;
  camera_in : Camera.t; 
  bg_color_in : Vector.t;
  light_in : Light.t; 
}

type command = 
  | Continue
  | Quit

exception Empty
exception Malformed

let rec select_words lst = 
  match lst with 
  | [] -> raise Empty 
  | h :: t -> begin 
      if h = "" then select_words t 
      else if h = "quit" then Quit
      else Continue
    end 

let parse str =
  str |> String.split_on_char ' '|> select_words 

let vector_of_string vec = 
  let fstcomma = String.index vec ',' in 
  let x = String.sub vec 1 (fstcomma - 1) in 
  let sndcomma = String.index_from vec (fstcomma + 1) ',' in 
  let y = String.sub vec (fstcomma + 1) (sndcomma - fstcomma - 1) in 
  let closep = String.index_from vec (sndcomma + 1) ')' in 
  let z = String.sub vec (sndcomma + 1) (closep - sndcomma - 1) in
  Vector.create (float_of_string x) (float_of_string y) (float_of_string z)

let get_material ui =
  if ui = "custom" then
    print_endline "  Next, we would like to know the material properties of your 
  object. We will start with diffusion. Light is said to be diffused when it 
  hits an object and scatters in a seemingly random way. Our diffuse property 
  has three components: x, which determines the amount of red light scattered;
  y, the amount of green light scattered; and z, the amount of blue light. So, 
  the larger the x value, the more red the object will appear, and so on. 
  Please input the diffusion as a vector (x,y,z), where all values are between 
  0 and 0.7";
  let diffuse = vector_of_string (read_line()) in 
  print_endline "  Next, please input the specular color as a vector (x,y,z)
  with values between 0 and 0.5. A specular highlight is a mirror reflection of 
  a light source. This color value will determine the hue of the light that is 
  reflected, with x corresponding to red, y with green, and z with blue.";
  let spec_co = vector_of_string (read_line()) in 
  print_endline "  Input the specular exponent as a float. This controls what
  can be thought of as the 'shininess' of the object. The larger the number 
  e.g. 100.0, the more focused the reflection on the object will appear, and 
  thus it will seem shinier. The smaller the number, e.g. 1.0, the more spread 
  out the reflection will be, causing it to appear more dull.";
  let spec_exp = float_of_string (read_line()) in 
  print_endline "  Please input the reflective property of your object as a 
  vector (x,y,z). Surfaces can be highly reflective, which causes many shadow 
  rays to bounce off of them, or lowly reflective. This is broken into red,
  green, and blue components corresponding to x, y, and z respectively.";
  let mirror = vector_of_string (read_line()) in 
  print_endline "  Please input the ambient as a vector (x,y,z). Ambient light 
  is the result of interactions between light sources and the objects in the 
  scene. It appears to be uniform all over. It is also separated into red, 
  green, and blue components.";
  let ambient = vector_of_string (read_line()) in
  Material.create diffuse spec_co spec_exp mirror ambient

let get_sphere ui = 
  if ui = "custom" then 
    print_endline "  Please enter the radius of the sphere as a float."; 
  let radius = float_of_string (read_line()) in 
  print_endline "  Please enter the center of the sphere as a vector in the form 
  (x,y,z) including the parentheses and with no spaces.";
  let center = vector_of_string (read_line()) in 
  let material = get_material ui in 
  Object.create_sphere radius center material 

let get_triangle ui = 
  if ui = "custom" then 
    print_endline "  Please enter the first vertex of the triangle as a vector 
    (x,y,z)."; 
  let vert1 = vector_of_string (read_line()) in 
  print_endline "  Please enter the second vertex of the triangle as a vector 
    (x,y,z)."; 
  let vert2 = vector_of_string (read_line()) in 
  print_endline "  Please enter the third vertex of the triangle as a vector 
    (x,y,z)."; 
  let vert3 = vector_of_string (read_line()) in 
  let material = get_material ui in 
  Object.create_triangle (vert1, vert2, vert3) material 

let get_camera ui = 
  if ui = "custom" then 
    print_endline "  Next, we would like to know the physical properties of your 
  camera. To begin with, please enter the origin of the camera as a position
  vector (x,y,z)"; 
  let origin = vector_of_string (read_line()) in 
  print_endline 
    "  Next, the target of the camera will be the position that the camera will
  be directly looking at. Please enter the target of the camera as a position 
  vector (x,y,z).";
  let target = vector_of_string (read_line()) in 
  print_endline "  Next, we want to know the aspect ratio for the camera. The
  aspect ratio is ratio of the width to the height for the dimensions of the 
  image. Please enter the aspect ratio of the camera as a float.";
  let aspect_ratio = float_of_string (read_line()) in 
  print_endline 
    "  Next, we would like the vertical vector of the camera. This 
  vertical vector is orthogonal to the camera's origin and points upwards in the
  plane of the camera. Please enter the vertical vector of the camera as a 
  vector (x,y,z).";
  let vertical = vector_of_string (read_line()) in 
  print_endline 
    "  Lastly, for the camera, we would like the vertical field of view of the 
  camera. The vertical field of view is the angle range in radians of what the 
  camera is capable of seeing. Please enter the vertical field of view of the 
  camera as a float.";
  let vfov = float_of_string (read_line()) in 
  Camera.create origin target aspect_ratio vertical vfov 

let get_light ui = 
  if ui = "custom" then 
    print_endline 
      "  We will now create the lighting. To describe the lighting, we must describe
  the intensity of the lighting as a vector where the magnitude of the intensity
  is measured in the x, y, and z direction. Please enter the intensity of 
  the light as a vector (x,y,z)."; 
  let intensity = vector_of_string (read_line()) in
  print_endline "  If you would like a specific position of the light source, 
  please enter it as a position vector (x,y,z). Otherwise, enter 'None'. 
  Entering none will create 'ambient lighting'. "; 
  let position = read_line() in 
  if position = "None" then Light.create_ambient intensity 
  else Light.create_point intensity (vector_of_string position)

let get_scene objlist ui = 
  if ui = "custom" then 
    print_endline 
      "  We will now create the scene. Please enter the background color
   as a vector (x,y,z)."; 
  let bg_color = vector_of_string (read_line()) in 
  Scene.create objlist bg_color 

let get_file_name ui = 
  if ui = "custom" then 
    print_endline "  Now, you get to name your ppm file. What would you like 
    your finished product to be called?"; 
  read_line() ^ ".ppm"

let get_width ui = 
  if ui = "custom" then 
    print_endline 
    "  How wide should your image be in pixels? (enter an integer)";
  int_of_string (read_line())

let get_height ui = 
  if ui = "custom" then 
    print_endline 
    "  What should the height of your image be in pixels? (enter an integer)"; 
  int_of_string (read_line())

let rec get_objects objlist ui = 
  if ui = "custom" then
    print_endline "  Please enter a valid type of the object you would like to 
    add to the scene (Sphere or Triangle - case sensitive). Or, if you have 
    already entered all of the objects you want, then type 'quit'"; 
  let next_command = read_line() in 
  match (parse next_command) with 
  | Continue -> begin 
      let object_type = next_command in 
      if object_type = "Sphere" then 
        get_objects ((get_sphere ui) :: objlist) ui 
      else if object_type = "Triangle" then 
        get_objects ((get_triangle ui) :: objlist) ui
      else get_objects objlist ui
    end 
  | Quit -> begin 
      let camera = get_camera ui in 
      let light = get_light ui in 
      let scene = get_scene objlist ui in 
      let file_name = get_file_name ui in 
      let width = get_width ui in 
      let height = get_height ui in 
      create_ppm camera light scene 
      (Scene.bg_color scene) file_name width height
    end 
  | exception Empty -> failwith "unimplemented"


let build_own_json ui = 
  if ui = "custom" then get_objects [] ui else failwith "impossible"

let plain_json ui = 
  (* Ask for json file, if didn't get one, print message and exit *)
  if ui = "filename" then
    let input_json =
      try Yojson.Basic.from_file (Sys.argv.(1))
      with _ -> print_endline "Please pass a json file with a valid scene. ex: 
    `raycaml scene.json`"; exit 1
    in
    let camera = input_json |> member "camera" |> Camera.from_json in
    let light = input_json |> member "light" |> Light.from_json in
    let scene = input_json |> Scene.from_json in
    let bg_color = Scene.bg_color scene in
    let file = (Sys.argv.(1) |> String.split_on_char '.' |> List.hd) ^ ".ppm" in
    (* If a commandline argument integer was passed after the scene, use it 
       as the width.
     * Otherwise, default is 320 *)
    let width =
      try int_of_string Sys.argv.(2)
      with _ -> 320
    in
    let height = int_of_float ((float_of_int width) /. 
                               (Camera.get_aspect camera)) in 
    create_ppm camera light scene bg_color file width height 
  else failwith "this shouldn't be possible"


let () = 
  print_endline 
    "  Welcome to RayCaml, our OCaml raytracer. First, select whether 
  you would like to have a guided tour of the system, by building your very own 
  json file from scratch, or if you'd rather simply input the name of a json 
  file. Please enter either `custom` for the first option or `filename` for the 
  latter to proceed.";
  let user_choice = read_line() in 
  try 
    if user_choice = "custom" then build_own_json user_choice
    else if user_choice = "filename" then plain_json user_choice
    else raise (Failure "That is not a valid option.")
  with Failure s -> print_endline s;() 
