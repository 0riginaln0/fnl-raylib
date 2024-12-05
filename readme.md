# Raylib 5.5 bindings for the Fennel programming language (and consequently for Lua) for the sake of interest.

WIP

Includes:
- Built-in [Raylib dynamic libraries](https://github.com/raysan5/raylib/releases/tag/5.5) for Windows and Linux (x64).
- [Lume](https://github.com/rxi/lume) library
- A couple of [examples](https://github.com/0riginaln0/fnl-raylib/tree/main/examples)
- Makefile for both Windows and Linux

# Example

Bindings use kebab-case naming

```clojure
(local rl (require :lib.raylib))
(local lume (require :lib.lume))

(print "epic")
(-> 4.5
    (lume.round)
    (print))

(rl.init-window 640 640 "Fennel & Raylib")
(rl.set-target-fps 60)
(local background (rl.Color 161 212 242 250))

(while (not (rl.window-should-close))
  (rl.begin-drawing)
  (rl.clear-background background)
  (rl.end-drawing))

(rl.close-window)
(print "That's all")
```

# Requirements

You need to have Luajit and Fennel installed. The main bindings file which you want to import is `raylib.fnl`.

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
