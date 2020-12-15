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
open Printf

(** getting custom scene from JSON file *)

let () =
  (* Ask for json file, if didn't get one, print message and exit *)
  let input_json =
    try Yojson.Basic.from_file (Sys.argv.(1))
    with _ -> print_endline "please pass a json file with a valid scene. ex: `raycaml scene.json`"; exit 1
  in
  let camera = input_json |> member "camera" |> Camera.from_json in
  let light = input_json |> member "light" |> Light.from_json in
  let scene = input_json |> Scene.from_json in
  let bg_color = Scene.bg_color scene in
  let file = (Sys.argv.(1) |> String.split_on_char '.' |> List.hd) ^ ".ppm" in

  (* If a commandline argument integer was passed after the scene, use it as the width.
   * Otherwise, default is 320 *)
  let width =
    try int_of_string Sys.argv.(2)
    with _ -> 320
  in
  let height = int_of_float ((float_of_int width) /. (Camera.get_aspect camera)) in

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