(local rl (require :lib.raylib))

; Vector2 and Vector3 have the following metamethods defined:
;  :__eq (fn [vec1 vec2] (= (rl.Vector2Equals vec1 vec2) 1))
;  :__tostring (fn [vec] (.. "[x: " vec.x "\ty:" vec.y "]"))
;  :__add (fn [vec1 vec2] (rl.Vector2Add vec1 vec2))
;  :__sub (fn [vec1 vec2] (rl.Vector2Subtract vec1 vec2))
;  :__mul (fn [vec1 vec2] (rl.Vector2Multiply vec1 vec2))
;  :__div (fn [vec1 vec2] (rl.Vector2Divide vec1 vec2))
;  :__unm (fn [vec] (rl.Vector2Negate vec))

(local a (rl.Vector2 5 6))
(local b (rl.Vector2 5 4))
(print "a:" a)
(print "a.x =" a.x "a.y =" a.y)
(print "b:" b)
(print "-b =" (- b))
(print "a + b" (+ a b))
(print "a - b" (- a b))
(print "a * b" (* a b))
(print "a / b" (/ a b))
(print "a = b" (= a b))

(print "a + 3" (rl.vector2-add-value a 3))
(print "b - 5" (rl.vector2-subtract-value b 5))
(print "a . b" (rl.vector2-dot-product a b))

; And more more functions on vector2 and vector3. But not on vector4...
; idk why raymath.h does not provide vector4 math functions, but that's what it is
; Maybe nobody needs math on vector4 :)