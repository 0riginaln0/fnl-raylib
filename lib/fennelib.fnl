(local lume (require :lib.lume))

(local fnlib {})

(local colors (require :lib.colors))
(local window (require :lib.window))
(local structs (require :lib.structs))
(local cursor (require :lib.cursor))
(local raudio (require :lib.raudio))
(local rmodels (require :lib.rmodels))
(local rtext (require :lib.rtext))
(local rtextures (require :lib.rtextures))
(local rshapes (require :lib.rshapes))
(local drawing (require :lib.drawing))
(local inputhandling (require :lib.inputhandling))

(fn merge-tables [t1 t2]
  (each [key value (pairs t2)] 
    (tset t1 key value))
  t1)
(merge-tables fnlib colors)
(merge-tables fnlib window)
(merge-tables fnlib structs)
(merge-tables fnlib cursor)
(merge-tables fnlib raudio)
(merge-tables fnlib rmodels)
(merge-tables fnlib rtext)
(merge-tables fnlib rtextures)
(merge-tables fnlib rshapes)
(merge-tables fnlib drawing)
(merge-tables fnlib inputhandling)


; (print "YYYYYYYYYYYYYYYYYYy")
; (each [key value (pairs fnlib)]
;   (print key value))
; (print "YYYYYYYYYYYYYYYYYYy")

fnlib