let () = print_endline "Hello, World!"


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

open Printf

let file = "example.ppm" (* file name *)
let width = "300"
let height = "200" 
let max_color = "255" 
let header = "P3" 

let () =
  let oc = open_out file in    (* create or truncate file, return channel *)
  fprintf oc "%s\n" header; (* write header of file *)  
  fprintf oc "%s " width; (* write horizontal dimension of image *)  
  fprintf oc "%s\n" height; (* write vertical dimension of image *)  
  fprintf oc "%s\n" max_color; 

  for _ = 0 to (int_of_string width) do (* write each row *)
    for _ = 0 to (int_of_string height) do (* write each pixel in a row *)
      fprintf oc "%s " "19"; (* red *)
      fprintf oc "%s " "132"; (* green *)
      fprintf oc "%s     " "255"; (* blue *)
    done 
  done;


  close_out oc; (* flush and close the channel *)
