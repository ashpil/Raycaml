# Raycaml

## Install

Right now, you pretty much already have all the modules you might need from
the basic 3110 switch. So, `yojson`, `ounit`.

The Makefile is pretty self explanatory, too. `make build` to build. `make test` to test.

## Usage

To render a scene, do `make run scene=[path to scene json]`. For example, to render the example
scene, do `make run scene=tests/simple_scene.json`. The output's name will be the same as the input
json's, only a `.ppm`. The initial command would produce a `tests/simple_scene.ppm`, which can be 
opened by default on Mac and most Linux systems, but needs to be converted manually to a more
common format on Windows.

You can also optionally specify horizontal pixel width, for example,
`make run scene=tests/simple_scene.json width=1000`.

