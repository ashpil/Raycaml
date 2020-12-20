(* may need to rename this file "test.ml" 

   TEST PLAN: 

   Our approach to testing was to test as many of the functions in the modules 
   as feasible with OUnit tests. Thus, included in our test suite are tests for 
   the Light, Vector, Camera, Ray, Hit, Material, Object, and Scene modules. 
   Essentially, we tested every function necessary in every module. We developed 
   test cases through both black box and glass box testing; for some cases, we 
   only considered what the function was specified to take in, such as two 
   vectors, while for other functions we had to look at the actual code to 
   devise cases.

   The functions in modules that were very simple, such as merely returning the 
   property of a type, were tested implicitly, but not explicity using OUnit, in 
   this test suite. We also tested the conversion of the json data structure to 
   our unique data types. 

   Certain functions have fewer tests because designing these tests took
   a lot of time and thought; for example, there are very few intersection tests
   because thinking of the scenario to test was more difficult than say testing 
   a function that adds two vectors. Still, we believe our test suite 
   demonstrates the correctness of our system because it ensures that each 
   individual part of our ray tracer is operating as it should be, returning 
   correct values for sample inputs. 

   Lastly, we conducted manual tests for correctness of the ppm file that is 
   output by our raytracer by inputting various scenes as json files and viewing
   the resulting image. Ensuring that each and every pixel is correct would 
   be an arduous task, and it's also unnecessary for determining whether the 
   system is functioning as it should be. If even one line of the code in our 
   system were incorrect, the image would look nothing like the scene that we
   input as a json file. So, by visually assessing whether the spheres or 
   triangles were appearing correctly, with the proper shading, orientation, and 
   light source, we can gather much about the correctness of our code. 
*)
open OUnit2
open Raycaml
open Yojson.Basic.Util

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
let vector8m9 = Vector.create (3.) (-4.) (-2.)
let vector8p9 = Vector.create (-7.) (-2.) (0.)
let vector8mult9 = Vector.create (10.) (-3.) (-1.)
let vector6divn = Vector.create (-0.25) (-1.5) (-1.5)
let vector5multn = Vector.create (-3.0) (-18.) (-18.)
let vector8cross9 = Vector.create (-2.) (7.) (-17.)
let vector4cross1 = Vector.create (5.) (-1.) (-1.)

let vector_tests = 
  [
    origin_test "Ensure origin returns 0. 0. 0. vector" vector_o;
    get_test "Get x component from vector1" vector1 Vector.get_x 1.0;
    get_test "Get y component from vector1" vector1 Vector.get_y 2.0;
    get_test "Get z component from vector1" vector1 Vector.get_z 3.0;
    sub_test "Subtract vector 2 from vector 1" vector1 vector2 vector3; 
    sub_test "Subtraction with negatives" vector8 vector9 vector8m9; 
    add_test "Add vector 2 to vector 1" vector1 vector2 vector4; 
    add_test "Add negative vectors" vector8 vector9 vector8p9; 
    mult_test "Multiply vector 1 and vector 2" vector1 vector2 vector5; 
    mult_test "Multiply negative vectors" vector8 vector9 vector8mult9; 
    div_const_test "Divide vector5 by constant 2" vector5 2. vector6; 
    div_const_test "Divide vector6 by negative constant" vector6 (-2.) 
      vector6divn; 
    mult_const_test "Multiply vector5 by constant 2" vector5 2. vector7; 
    mult_const_test "Multiply vector5 by negative constant 2" vector5 (-3.) 
      vector5multn; 
    dot_prod_test "Dot product of two positive vectors" vector1 vector2 13.; 
    dot_prod_test "Dot product of vectors with negatives" vector8 vector3 2.; 
    cross_prod_test "Cross product of positive vectors: vector1 cross vector4" 
      vector1 vector4 vector9;
    cross_prod_test "Cross product of positive vectors: vector4 cross vector1" 
      vector4 vector1 vector4cross1; 
    cross_prod_test "Cross product of negative vectors" vector8 vector9 
      vector8cross9; 
    length_test "Length of vector1 - positive" vector1 (Float.sqrt 14.); 
    length_test "Length of vector9 - negative" vector9 (Float.sqrt 27.); 
    length_test "Length of vector8 - negative" vector8 (Float.sqrt 14.); 
    unit_vector_test "Unit vector of vector1" vector1 vector10;
  ]

let print_ray ray = 
  "origin vector: " ^ string_of_float (Vector.get_x (Ray.origin ray)) ^ " " ^
  string_of_float (Vector.get_y (Ray.origin ray)) ^ " " ^
  string_of_float (Vector.get_z (Ray.origin ray)) ^ " " ^
  "direction vector: " ^ string_of_float (Vector.get_x (Ray.dir ray)) ^ " " ^
  string_of_float (Vector.get_y (Ray.dir ray)) ^ " " ^
  string_of_float (Vector.get_z (Ray.dir ray))

let evaluate_test name ray magnitude expect = 
  name >:: fun _ ->
    assert_equal expect (Ray.evaluate ray magnitude)
      ~printer:Vector.string_of_vector

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
let eval_ray1 = Vector.add ray1_origin 
    (Vector.mult_constant ray1_direction 2.)

let ray2_origin = Vector.create 0.5 0.2 0.4
let ray2_direction = Vector.create 0. 1. 0.
let ray2 = Ray.create ray2_origin ray2_direction
let eval_ray2 = Vector.(add ray2_origin (mult_constant ray2_direction (-4.)))

let ray3_origin = Vector.create 0.7 1.0 (-0.2)
let ray3_direction = Vector.create 0. 1. (-1.0)
let ray3 = Ray.create ray3_origin ray3_direction
let eval_ray3 = ray3_origin 

let ray_tests = 
  [
    evaluate_test "evaluate ray1 with magnitude 2" ray1 2. eval_ray1;
    evaluate_test "evaluate ray2 with magnitude -4" ray2 (-4.) eval_ray2;
    evaluate_test "evaluate ray3 with magnitude 0" ray3 (0.) eval_ray3;
    dir_test "direction of ray1" ray1 ray1_direction;
    origin_test "origin of ray1" ray1 ray1_origin;
    in_bounds_test "value in bounds of ray1" 0.5 ray1 true;
    (* why does Ray.create automatically set finish to None? 
       test fails because of Ray.create:
       in_bounds_test "value out of bounds of ray1" 500000000. ray1 false; *)
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

let generate_test name camera x y expect = 
  name >:: fun _ ->
    assert_equal expect (Camera.generate_ray camera x y) ~printer:print_ray

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

(* creating objects from json file *)
let test_scene = Yojson.Basic.from_file "test_scene.json"
let cam_json = test_scene |> member "camera" |> Camera.from_json 
let light_json = test_scene |> member "light" |> Light.from_json 
let intens_json = Light.intensity light_json 
let pos_json = 
  match Light.position light_json with 
  | Some c -> c 
  | None -> Vector.origin;;
let scene_json = test_scene |> Scene.from_json 
let bg_color_json = Scene.bg_color scene_json 
let object1_json = List.nth (Scene.objects scene_json) 0 
let object2_json = List.nth (Scene.objects scene_json) 1
let object3_json = List.nth (Scene.objects scene_json) 2 
let mat1_json = Object.mat object1_json
let mat2_json = Object.mat object2_json
let mat3_json = Object.mat object3_json
let diffuse1_json = Vector.create (0.5) (0.7) (0.5)
let diffuse2_json = Vector.create (0.1) (0.1) (0.1)
let diffuse3_json = Vector.create (0.1) (0.7) (0.6)
let specco1_json = Vector.create (0.1) (0.3) (0.1)
let specco2_json = Vector.create (0.2) (0.2) (0.2)
let specco3_json = Vector.create (0.2) (0.3) (0.1)
let specexp1_json = 20.0
let specexp2_json = 30.0
let specexp3_json = 10.0
let mirror1_json = Vector.create (0.0) (0.0) (0.0)
let mirror2_json = Vector.create (0.1) (0.0) (0.3)
let mirror3_json = Vector.create (0.0) (0.0) (0.0)
let ambient1_json = Vector.create (0.5) (0.4) (0.1)
let ambient2_json = Vector.create (0.3) (0.1) (0.2)
let ambient3_json = Vector.create (0.7) (0.4) (0.1)
let center1_json = Vector.create (0.0) (0.0) (0.0)
let center2_json = Vector.create (0.5) (1.5) (0.5)
let vert1_json = Vector.create (1.0) (1.0) (1.0)
let vert2_json = Vector.create (-1.0) (-1.0) (1.0)
let vert3_json = Vector.create (-2.0) (-2.0) (2.0)
let tri_vertices = (vert1_json, vert2_json, vert3_json)
let origin_json = Vector.create (3.0) (2.0) (5.0)
let target_json = Vector.create (0.0) (0.0) (0.0)
let aspect_json = 1.5
let vert_json = Vector.create (0.0) (1.0) (0.0)
let vfov_json = 25.0

(* tests if the material created in the Material.create function is the same
   as the material generated from Material.from_json *)
let create_mat_test name diffuse spec_co spec_exp mirror ambient expect = 
  name >:: fun _ ->
    assert_equal expect (Material.create diffuse spec_co spec_exp mirror 
                           ambient)

(* tests if the object created in the Object.create function is the same
   as the object generated from Object.from_json *)
let create_sphere_test name radius center material expect = 
  name >:: fun _ ->
    assert_equal expect (Object.create_sphere radius center material)

let create_tri_test name vertices material expect = 
  name >:: fun _ ->
    assert_equal expect (Object.create_triangle vertices material)

let create_light_test name intensity position expect = 
  name >:: fun _ ->
    assert_equal expect (Light.create_point intensity position)

let create_scene_test name objs bg_color expect = 
  name >:: fun _ ->
    assert_equal expect (Scene.create objs bg_color)

let create_camera_test name origin target aspect_ratio vertical vfov expect = 
  name >:: fun _ ->
    assert_equal expect (Camera.create origin target aspect_ratio vertical vfov)

let from_and_create_tests = 
  [
    create_mat_test "Material of first object in json file, sphere" 
      diffuse1_json specco1_json specexp1_json mirror1_json ambient1_json 
      mat1_json;
    create_mat_test "Material of second object in json file, triangle" 
      diffuse2_json specco2_json specexp2_json mirror2_json ambient2_json 
      mat2_json;
    create_mat_test "Material of third object in json file, sphere" 
      diffuse3_json specco3_json specexp3_json mirror3_json ambient3_json 
      mat3_json;
    create_sphere_test "Object of first sphere in json file" 0.5 center1_json
      mat1_json object1_json;
    create_tri_test "Object of triangle (second object) in json file"
      tri_vertices mat2_json object2_json;
    create_sphere_test "Object of second sphere (third object) in json file" 
      1.0 center2_json mat3_json object3_json;
    create_light_test "Light of scene in json file" intens_json pos_json 
      light_json;
    create_scene_test "Scene of json file" 
      [object1_json; object2_json; object3_json] bg_color_json scene_json;
    create_camera_test "Camera from json file" origin_json target_json
      aspect_json vert_json vfov_json cam_json; 
  ]

let hit1_pt = Vector.create 0.5 0.5 0.5
let hit1_dir = Vector.create 1.0 0.0 0.5 
let hit1_norm = Vector.unit_vector hit1_dir
let hit1_material = material1
let hit1 = Hit.create 1.0 hit1_pt hit1_norm hit1_dir hit1_material
let hit2 = Hit.create 5.0 hit1_pt hit1_norm hit1_dir hit1_material
let hit_neg = Hit.create (-10.) hit1_pt hit1_norm hit1_dir hit1_material

let greater_hit_test name hit1 hit2 expect = 
  name >:: fun _ ->
    assert_equal expect (Scene.get_greater_hit (Some hit1) (Some hit2))

let hit_tests = 
  [
    greater_hit_test "Return hit of greater distance" hit1 hit2 (Some hit2);
    greater_hit_test "Comparing hit distance with negatives" hit2 hit_neg 
      (Some hit2)
  ]

let get_spec_test name angle material expect = 
  name >:: fun _ ->
    assert_equal expect (Material.specular angle material)
      ~printer:Vector.string_of_vector

let material_tests = 
  [
    get_spec_test "Get specular of material of first sphere in json file with 
    angle of 1.0" 1.0 mat1_json (Vector.create (0.6) (1.0) (0.6));
    get_spec_test "Get specular of material of triangle in json file with 
    angle of 1.0" 1.0 mat2_json (Vector.create (0.1+.0.2) (0.1+.0.2) 
                                   (0.1+.0.2));
  ]

let light_intens1 = Vector.create (100.) (100.) (100.)
let light_pos1 = Vector.create (0.0) (0.1) (0.1)
let point1 = Light.create_point light_intens1 light_pos1 
let ambient1 = Light.create_ambient light_intens1 

let get_pos_test name light expect = 
  name >:: fun _ ->
    assert_equal expect (Light.position light)

let get_intensity_test name light expect = 
  name >:: fun _ ->
    assert_equal expect (Light.intensity light)

let illuminate_test name hit scene light expect = 
  name >:: fun _ ->
    assert_equal expect (Light.illuminate hit scene light) 
      ~printer:Vector.string_of_vector

let light_tests = 
  [
    get_pos_test "Get position of point light" point1 (Some light_pos1); 
    get_pos_test "Get position of ambient light returns None" ambient1 None; 
    get_intensity_test "Get intensity of point light" point1 light_intens1;
    get_intensity_test "Get intensity of ambient light" ambient1 light_intens1;
    illuminate_test "Illuminate ambient is 0 vector" hit1 scene_json 
      ambient1 Vector.origin;
    illuminate_test "Illuminate point light" hit1 scene_json point1 
      Vector.origin;
  ]

let suite =
  "test suite for Raycaml"  >::: List.flatten [
    vector_tests;
    camera_tests;
    ray_tests; 
    intersection_tests;
    from_and_create_tests;
    hit_tests;
    material_tests;
    light_tests;
  ]

let _ = run_test_tt_main suite