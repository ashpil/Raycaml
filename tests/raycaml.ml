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
    assert_equal expect (Vector.(-) vec1 vec2)

let add_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.(+) vec1 vec2)

let mult_test name vec1 vec2 expect =
  name >:: fun _ ->
    assert_equal expect (Vector.mult vec1 vec2)

let div_const_test name vec c expect =
  name >:: fun _ ->
    assert_equal expect (Vector.div_constant vec c)

let mult_const_test name vec c expect =
  name >:: fun _ ->
    assert_equal expect (Vector.( * ) vec c)

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

let suite =
  "test suite for Raycaml"  >::: List.flatten [
    vector_tests;
  ]

let _ = run_test_tt_main suite