# Raylib 5.5 bindings for the Fennel programming language (and consequently for Lua) for the sake of interest.

API coverage is 99% (or maybe even 100%)

Includes:
- Built-in Raylib dynamic libraries for x64 Windows and Linux.
- Makefile for Windows and Linux
- Lume library
- A couple of examples

# Requirements

The only thing you need to have installed is Luajit and (optionally) Fennel. The main bindings file is `raylib.fnl` or its compiled version `raylib.lua`.

# How to start using int

Just git clone this repo, and then 

`make run` 

or 

`fennel examples/core/core-input-keys.fnl`

or

`luajit main.lua`

or

`luajit examples/core/core-input-mouse.lua`

you got it.

https://fennel-lang.org/see


https://github.com/raysan5/raylib/tree/master/examples


https://github.com/raysan5/raylib/blob/1f0325b52c87af4820b31957d8e40d7bc1f112bb/src/raylib.h#L183
