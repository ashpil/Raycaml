open OUnit2
open Raycaml

let origin_test name expect =
  name >:: fun _ ->
    assert_equal expect Vector.origin

let get_test name vec func expect =
  name >:: fun _ ->
    assert_equal expect (func vec)

let sub_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.minus vec1 vec2)

let add_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.add vec1 vec2)

let mult_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.mult vec1 vec2)

let div_const_test name vec c expect =
  name >:: fun _ ->
    assert_equal expect (Vector.div_constant vec c)

let mult_const_test name vec c expect =
  name >:: fun _ ->
    assert_equal expect (Vector.mult_constant vec c)

let dot_prod_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.dot_prod vec1 vec2)

let cross_prod_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.cross_prod vec1 vec2)

let length_test name vec expect =
  name >:: fun _ ->
    assert_equal expect (Vector.length vec)

let unit_vector_test name vec expect =
  name >:: fun _ ->
    assert_equal expect (Vector.unit_vector vec)

(* let rand_unit_vec_test expect =
   name >:: fun _ ->
    assert_equal expect (Vector.random_unit_vector) *)

let vector_o = Vector.create 0. 0. 0.
let vector1 = Vector.create 1. 2. 3. 
let vector2 = Vector.create 1. 3. 2.
let vector3 = Vector.create 0. (-1.) 1.
let vector4 = Vector.create 2. 5. 5. 
let vector5 = Vector.create 1. 6. 6.
let vector6 = Vector.create 0.5 3. 3.
let vector7 = Vector.create 2. 12. 12.
let vector8 = Vector.create (-2.) (-3.) (-1.)
let vector9 = Vector.create (-5.) 1. 1.
let vector10 = Vector.create (1. /. Float.sqrt 14.) (Float.sqrt (2. /. 7.)) 
    (3. /. Float.sqrt 14.)

let vector_tests = 
  [
    origin_test "Ensure origin returns 0. 0. 0. vector" vector_o;
    get_test "Get x component from vector1" vector1 Vector.get_x 1.0;
    get_test "Get y component from vector1" vector1 Vector.get_y 2.0;
    get_test "Get z component from vector1" vector1 Vector.get_z 3.0;
    sub_test "Subtract vector 2 from vector 1" vector1 vector2 vector3; 
    add_test "Add vector 2 to vector 1" vector1 vector2 vector4; 
    mult_test "Multiple vector 1 and vector 2" vector1 vector2 vector5; 
    div_const_test "Divide vector 5 by constant 2" vector5 2. vector6; 
    mult_const_test "Multiply vector 5 by constant 2" vector5 2. vector7; 
    dot_prod_test "Dot product of two positive vectors" vector1 vector2 13.; 
    dot_prod_test "Dot product of vectors with negatives" vector8 vector3 2.; 
    cross_prod_test "Cross product of positive vectors" vector1 vector4 vector9; 
    length_test "Length of vector1" vector1 (Float.sqrt 14.); 
    length_test "Length of vector9" vector9 (Float.sqrt 27.); 
    unit_vector_test "Unit vector of vector1" vector1 vector10;
  ]

let evaluate_test name ray magnitude expect = 
  name >:: fun _ ->
    assert_equal expect (Ray.evaluate ray magnitude)

let dir_test name ray expect = 
  name >:: fun _ ->
    assert_equal expect (Ray.dir ray)

let origin_test name ray expect = 
  name >:: fun _ ->
    assert_equal expect (Ray.origin ray)

let in_bounds_test name d ray expect = 
  name >:: fun _ ->
    assert_equal expect (Ray.in_bounds d ray)

let ray1_origin = Vector.create 0. 0. 0.
let ray1_direction = Vector.create 1. 0. 0.
let ray1 = Ray.create ray1_origin ray1_direction
let evaluated_vector = Vector.add ray1_origin 
    (Vector.mult_constant ray1_direction 2.)

let ray_tests = 
  [
    evaluate_test "evaluate with magnitude 2" ray1 2. evaluated_vector;
    dir_test "direction of ray1" ray1 ray1_direction;
    origin_test "origin of ray1" ray1 ray1_origin;
    in_bounds_test "value in bounds of ray1" 0.5 ray1 true;
    in_bounds_test "value out of bounds of ray1" 500000. ray1 false;
  ]

let vector_eye = Vector.create 1. 0. 0.
let vertical = Vector.create 0. 1. 0.
let camera1 = Camera.create vector_eye vector_o 1. vertical 90.
let dir_vector = Vector.create (-1.) 0. 0.
let ray_o = Ray.create vector_eye dir_vector

let vector_eye2 = Vector.create 1. (-1.) 0.
let vertical2 = Vector.create 0. 1. 0.
let camera2 = Camera.create vector_eye2 vector_o 1. vertical2 90.
let dir_vector2 = Vector.create (-1.) 1. 0.
let ray_o2 = Ray.create vector_eye2 (Vector.unit_vector dir_vector2)

let print_ray ray = 
  "origin vector: " ^ string_of_float (Vector.get_x (Ray.origin ray)) ^ " " ^
  string_of_float (Vector.get_y (Ray.origin ray)) ^ " " ^
  string_of_float (Vector.get_z (Ray.origin ray)) ^ " " ^
  "direction vector: " ^ string_of_float (Vector.get_x (Ray.dir ray)) ^ " " ^
  string_of_float (Vector.get_y (Ray.dir ray)) ^ " " ^
  string_of_float (Vector.get_z (Ray.dir ray))

let generate_test name camera x y expect = 
  name >:: fun _ ->
    assert_equal expect (Camera.generate_ray camera x y) ~printer:(print_ray)

let camera_tests = 
  [
    generate_test "Generate ray for pixel at (0.5, 0.5), eye at (1, 0, 0)" 
      camera1 0.5 0.5 ray_o;
    generate_test "Generate ray for pixel at (0.5, 0.5), eye at (1, -1, 0)" 
      camera2 0.5 0.5 ray_o2;
  ]

let material1 = Material.create vector_o vector_o 0. vector_o vector_o
let vector_1 = Vector.create 2.0 0. 0.
let vector_2 = Vector.create 1.0 0. 0.
let sphere1 = Object.create_sphere 1.0 vector_1 material1 
let ray_hit1 = Ray.create vector_o vector_2

let intersect_test name ray an_object expect = 
  name >:: fun _ ->
    assert_equal expect (Object.intersect ray an_object |> Option.get |> 
                         Hit.distance) ~printer:string_of_float

let intersection_tests =
  [
    intersect_test "ray from origin and sphere of radius 1 @(1, 0 ,0)" ray_hit1 
      sphere1 1.0;
  ]

let suite =
  "test suite for Raycaml"  >::: List.flatten [
    vector_tests;
    camera_tests;
    intersection_tests;
  ]

let _ = run_test_tt_main suite

