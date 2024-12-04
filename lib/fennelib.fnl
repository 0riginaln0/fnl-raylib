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


(lume.table.merge fnlib colors)
(lume.table.merge fnlib window)
(lume.table.merge fnlib structs)
(lume.table.merge fnlib cursor)
(lume.table.merge fnlib raudio)
(lume.table.merge fnlib rmodels)
(lume.table.merge fnlib rtext)
(lume.table.merge fnlib rtextures)
(lume.table.merge fnlib rshapes)
(lume.table.merge fnlib drawing)
(lume.table.merge fnlib inputhandling)

fnlib