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

(** getting custom scene from JSON file *)
let () = print_string "Please input the name of your JSON file: " 
let () = print_newline ()
let input = read_line ()  (* can get from tests/simple_scene.json *)
let input_json = Yojson.Basic.from_file input
let camera = input_json |> member "camera" |> Camera.from_json
let light = input_json |> member "light" |> Light.from_json
let scene = input_json |> Scene.from_json
let bg_color = Scene.bg_color scene
let file = (input |> String.split_on_char '.' |> List.hd) ^ ".ppm"

let width = 300
let height = 200

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

