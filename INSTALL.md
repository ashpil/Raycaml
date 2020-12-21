# Raycaml

## Install

Please install odoc: `opam install odoc`.

The Makefile is pretty self explanatory, too. `make build` to build. `make test`
to test.

`make docs` will produce documentation, which will be in 
`_build/default/_doc/_html/raycaml/index.html`.

Make sure that `opam show bisect` shows version 2.5.0 in order for bisect to 
work properly. 

## Usage

To render a scene, you can choose to create a custom scene by going through a 
walkthrough, or use an existing json file. To create a custom scene, simply do 
`make run`. 


For the second option do `make run scene=[path to scene json]`. For example, to 
render the example scene, do `make run scene=tests/simple_scene.json`. The 
output's name will be the same as the input json's, only a `.ppm`. The initial 
command would produce a `tests/simple_scene.ppm`, which can be opened by default 
on Mac and most Linux systems, but needs to be converted manually to a more
common format on Windows.

You can also optionally specify horizontal pixel width, for example,
`make run scene=tests/simple_scene.json width=1000`.

