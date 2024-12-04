# Raylib 5.5 bindings for the Fennel programming language (and consequently for Lua) for the sake of interest.

API coverage is 99% (or maybe even 100%)

Includes:
- Built-in [Raylib dynamic libraries](https://github.com/raysan5/raylib/releases/tag/5.5) for Windows and Linux (x64).
- [Lume](https://github.com/rxi/lume) library
- A couple of [examples](https://github.com/0riginaln0/fnl-raylib/tree/main/examples)
- Makefile for both Windows and Linux

# Requirements

The only thing you need to have installed is Luajit and (optionally) Fennel. The main bindings file which you want to import is `raylib.fnl` or its compiled version `raylib.lua`.

- Luajit installation is very easy. Just follow the [instructions](https://luajit.org/install.html) 
- Likewise with the [Fennel](https://fennel-lang.org/setup) (I install it via the [script fennel-1.5.1 version](https://fennel-lang.org/downloads/fennel-1.5.1))
<details>
<summary>fennel.bat script to run Fennel on Windows</summary>

```
@echo off
luajit C:\Games\Fennel\fennel1.5.1 %*
```
</details>


# How to start using it

Just `git clone` this repo, `cd fnl-raylib` and then

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
