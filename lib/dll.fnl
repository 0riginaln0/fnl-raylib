(print "INIT: DLL")

(local ffi (require :ffi))

(local os ffi.os)
; (print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_msvc16\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))

{: ffi
 : rl}