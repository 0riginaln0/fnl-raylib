(local rl (require :lib.raylib))

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