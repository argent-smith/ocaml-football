The Football Exercise
=====================

The example shows naive (if-then-else) algorythm along with more
idiomatic and modularized version.

Installation
------------

Prerequisites: opam should be installed. Also, utop, merlin and Emacs
(or other Merlin-compatible editor) are very useful.

1. Clone the repo and cd to the top directory
2. `opam pin add football . -n`
3. `opam install football -t --deps-only`

Operation
---------

1. To play with utop: `jbuilder utop src/lib`
2. To test: `jbuilder runtest`

Feel free to play.

License
-------

MIT (see the file)
