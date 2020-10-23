open OUnit2
open Raycaml

let simple = Yojson.Basic.from_file "simple_scene.json" |> Scene.from_json

let pos_test name scene i expect =
  name >:: fun _ ->
    assert_equal expect (List.nth (Scene.objects scene) i |> Object.pos)

let scene_tests =
  [
    pos_test "ensures position of first object is (1., 1., 1.) in simple scene"
      simple 0 (Vector.create 0. 0. 0.)
  ]

let suite =
  "test suite for Raycaml"  >::: List.flatten [
    scene_tests;
  ]

let _ = run_test_tt_main suite