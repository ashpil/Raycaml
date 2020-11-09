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

open Raycaml

let file = "example.ppm" (* file name *)
let width = 300
let height = 200
let zero = Vector.create 0. 0. 0.
let unit_forward = Vector.create 1. 0. 0.
let three_forward = Vector.create 3. 0. 0.
let unit_up = Vector.create 0. 1. 0.
let unit_all = Vector.create 1. 1. 1.
let half = Vector.create 0.5 0.5 0.5
let mat = Material.create half half 5. half half
let bg_color = Vector.create 0.10 0.45 0.79
let camera = Camera.create zero unit_forward (3./.2.) unit_up 90.
let sphere = Object.create_sphere 1. three_forward mat
let scene = Scene.create [sphere] bg_color
let light = Light.create_point unit_all unit_all

let () =
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
        output_char oc (char_of_int (int_of_float ((Vector.get_x color) *. 255.))); 
        output_char oc (char_of_int (int_of_float ((Vector.get_y color) *. 255.))); 
        output_char oc (char_of_int (int_of_float ((Vector.get_z color) *. 255.))); 
      | None -> 
        output_char oc (char_of_int (int_of_float ((Vector.get_x bg_color) *. 255.))); 
        output_char oc (char_of_int (int_of_float ((Vector.get_y bg_color) *. 255.))); 
        output_char oc (char_of_int (int_of_float ((Vector.get_z bg_color) *. 255.))); 
    done 
  done;


  output_char oc '\n';
  close_out oc; (* flush and close the channel *)

