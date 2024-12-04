; ENUMS BLOCK
;----------------------------------------------------------------------------------
; Enumerators Definition
;----------------------------------------------------------------------------------
; System/Window config flags
; NOTE: Every bit registers one state use it with bit masks
; By default all flags are set to 0
(local enum1 {
 :flag-vsync-hint 64
 :flag-fullscreen-mode 2
 :flag-window-resizable 4
 :flag-window-undecorated 8
 :flag-window-hidden 128
 :flag-window-minimized 512
 :flag-window-maximized 1024
 :flag-window-unfocused 2048
 :flag-window-topmost 4096
 :flag-window-always-run 256
 :flag-window-transparent 16
 :flag-window-highdpi 8192
 :flag-window-mouse-passthrough 16384
 :flag-borderless-windowed-mode 32768
 :flag-msaa-4x-hint 32
 :flag-interlaced-hint 65536
 ; Trace log level
 ; NOTE: Organized by priority level
 :log-all 0
 :log-trace 1
 :log-debug 2
 :log-info 3
 :log-warning 4
 :log-error 5
 :log-fatal 6
 :log-none 7
 ; Keyboard keys US keyboard layout
 ; NOTE: Use GetKeyPressed to allow redefining
 ; required keys for alternative layouts
 :key-null 0
 :key-apostrophe 39
 :key-comma 44
 :key-minus 45
 :key-period 46
 :key-slash 47
 :key-zero 48
 :key-one 49
 :key-two 50
 :key-three 51
 :key-four 52
 :key-five 53
 :key-six 54
 :key-seven 55
 :key-eight 56
 :key-nine 57
 :key-semicolon 59
 :key-equal 61
 :key-a 65
 :key-b 66
 :key-c 67
 :key-d 68
 :key-e 69
 :key-f 70
 :key-g 71
 :key-h 72
 :key-i 73
 :key-j 74
 :key-k 75
 :key-l 76
 :key-m 77
 :key-n 78
 :key-o 79
 :key-p 80
 :key-q 81
 :key-r 82
 :key-s 83
 :key-t 84
 :key-u 85
 :key-v 86
 :key-w 87
 :key-x 88
 :key-y 89
 :key-z 90
 :key-left-bracket 91
 :key-backslash 92
 :key-right-bracket 93
 :key-grave 96
 :key-space 32
 :key-escape 256
 :key-enter 257
 :key-tab 258
 :key-backspace 259
 :key-insert 260
 :key-delete 261
 :key-right 262
 :key-left 263
 :key-down 264
 :key-up 265
 :key-page-up 266
 :key-page-down 267
 :key-home 268
 :key-end 269
 :key-caps-lock 280
 :key-scroll-lock 281
 :key-num-lock 282
 :key-print-screen 283
 :key-pause 284
 :key-f1 290
 :key-f2 291
 :key-f3 292
 :key-f4 293
 :key-f5 294
 :key-f6 295
 :key-f7 296
 :key-f8 297
 :key-f9 298
 :key-f10 299
 :key-f11 300
 :key-f12 301
 :key-left-shift 340
 :key-left-control 341
 :key-left-alt 342
 :key-left-super 343
 :key-right-shift 344
 :key-right-control 345
 :key-right-alt 346
 :key-right-super 347
 :key-kb-menu 348
 :key-kp-0 320
 :key-kp-1 321
 :key-kp-2 322
 :key-kp-3 323
 :key-kp-4 324
 :key-kp-5 325
 :key-kp-6 326
 :key-kp-7 327
 :key-kp-8 328
 :key-kp-9 329
 :key-kp-decimal 330
 :key-kp-divide 331
 :key-kp-multiply 332
 :key-kp-subtract 333
 :key-kp-add 334
 :key-kp-enter 335
 :key-kp-equal 336
 :key-back 4
 :key-menu 5
 :key-volume-up 24
 :key-volume-down 25})

; Add backwards compatibility support for deprecated names
; Mouse buttons
(local enum2 {:mouse-button-left 0
 :mouse-button-right 1
 :mouse-button-middle 2
 :mouse-button-side 3
 :mouse-button-extra 4
 :mouse-button-forward 5
 :mouse-button-back 6
 ; Mouse cursor
 :mouse-cursor-default 0
 :mouse-cursor-arrow 1
 :mouse-cursor-ibeam 2
 :mouse-cursor-crosshair 3
 :mouse-cursor-pointing-hand 4
 :mouse-cursor-resize-ew 5
 :mouse-cursor-resize-ns 6
 :mouse-cursor-resize-nwse 7
 :mouse-cursor-resize-nesw 8
 :mouse-cursor-resize-all 9
 :mouse-cursor-not-allowed 10
 ; Gamepad buttons
 :gamepad-button-unknown 0
 :gamepad-button-left-face-up 1
 :gamepad-button-left-face-right 2
 :gamepad-button-left-face-down 3
 :gamepad-button-left-face-left 4
 :gamepad-button-right-face-up 5
 :gamepad-button-right-face-right 6
 :gamepad-button-right-face-down 7
 :gamepad-button-right-face-left 8
 :gamepad-button-left-trigger-1 9
 :gamepad-button-left-trigger-2 10
 :gamepad-button-right-trigger-1 11
 :gamepad-button-right-trigger-2 12
 :gamepad-button-middle-left 13
 :gamepad-button-middle 14
 :gamepad-button-middle-right 15
 :gamepad-button-left-thumb 16
 :gamepad-button-right-thumb 17
 ; Gamepad axis
 :gamepad-axis-left-x 0
 :gamepad-axis-left-y 1
 :gamepad-axis-right-x 2
 :gamepad-axis-right-y 3
 :gamepad-axis-left-trigger 4
 :gamepad-axis-right-trigger 5})


; Material map index

(local enum3 {:material-map-albedo 0
 :material-map-metalness 1
 :material-map-normal 2
 :material-map-roughness 3
 :material-map-occlusion 4
 :material-map-emission 5
 :material-map-height 6
 :material-map-cubemap 7
 :material-map-irradiance 8
 :material-map-prefilter 9
 :material-map-brdf 10
 ; Shader location index
 :shader-loc-vertex-position 0
 :shader-loc-vertex-texcoord01 1
 :shader-loc-vertex-texcoord02 2
 :shader-loc-vertex-normal 3
 :shader-loc-vertex-tangent 4
 :shader-loc-vertex-color 5
 :shader-loc-matrix-mvp 6
 :shader-loc-matrix-view 7
 :shader-loc-matrix-projection 8
 :shader-loc-matrix-model 9
 :shader-loc-matrix-normal 10
 :shader-loc-vector-view 11
 :shader-loc-color-diffuse 12
 :shader-loc-color-specular 13
 :shader-loc-color-ambient 14
 :shader-loc-map-albedo 15
 :shader-loc-map-metalness 16
 :shader-loc-map-normal 17
 :shader-loc-map-roughness 18
 :shader-loc-map-occlusion 19
 :shader-loc-map-emission 20
 :shader-loc-map-height 21
 :shader-loc-map-cubemap 22
 :shader-loc-map-irradiance 23
 :shader-loc-map-prefilter 24
 :shader-loc-map-brdf 25
 :shader-loc-vertex-boneids 26
 :shader-loc-vertex-boneweights 27
 :shader-loc-bone-matrices 28
 ; Shader uniform data type
 :shader-uniform-float 0
 :shader-uniform-vec2 1
 :shader-uniform-vec3 2
 :shader-uniform-vec4 3
 :shader-uniform-int 4
 :shader-uniform-ivec2 5
 :shader-uniform-ivec3 6
 :shader-uniform-ivec4 7
 :shader-uniform-sampler2d 8
 ; Shader attribute data types
 :shader-attrib-float 0
 :shader-attrib-vec2 1
 :shader-attrib-vec3 2
 :shader-attrib-vec4 3
 ; Pixel formats
 ; NOTE: Support depends on OpenGL version and platform
 :pixelformat-uncompressed-grayscale 1
 :pixelformat-uncompressed-gray-alpha 2
 :pixelformat-uncompressed-r5g6b5 3
 :pixelformat-uncompressed-r8g8b8 4
 :pixelformat-uncompressed-r5g5b5a1 5
 :pixelformat-uncompressed-r4g4b4a4 6
 :pixelformat-uncompressed-r8g8b8a8 7
 :pixelformat-uncompressed-r32 8
 :pixelformat-uncompressed-r32g32b32 9
 :pixelformat-uncompressed-r32g32b32a32 10
 :pixelformat-uncompressed-r16 11
 :pixelformat-uncompressed-r16g16b16 12
 :pixelformat-uncompressed-r16g16b16a16 13
 :pixelformat-compressed-dxt1-rgb 14
 :pixelformat-compressed-dxt1-rgba 15
 :pixelformat-compressed-dxt3-rgba 16
 :pixelformat-compressed-dxt5-rgba 17
 :pixelformat-compressed-etc1-rgb 18
 :pixelformat-compressed-etc2-rgb 19
 :pixelformat-compressed-etc2-eac-rgba 20
 :pixelformat-compressed-pvrt-rgb 21
 :pixelformat-compressed-pvrt-rgba 22
 :pixelformat-compressed-astc-4x4-rgba 23
 :pixelformat-compressed-astc-8x8-rgba 24
 ; Texture parameters: filter mode
 ; NOTE 1: Filtering considers mipmaps if available in the texture
 ; NOTE 2: Filter is accordingly set for minification and magnification
 :texture-filter-point 0
 :texture-filter-bilinear 1
 :texture-filter-trilinear 2
 :texture-filter-anisotropic-4x 3
 :texture-filter-anisotropic-8x 4
 :texture-filter-anisotropic-16x 5
 ; Texture parameters: wrap mode
 :texture-wrap-repeat 0
 :texture-wrap-clamp 1
 :texture-wrap-mirror-repeat 2
 :texture-wrap-mirror-clamp 3
 ; Cubemap layouts
 :cubemap-layout-auto-detect 0
 :cubemap-layout-line-vertical 1
 :cubemap-layout-line-horizontal 2
 :cubemap-layout-cross-three-by-four 3
 :cubemap-layout-cross-four-by-three 4
 ; Font type, defines generation method
 :font-default 0
 :font-bitmap 1
 :font-sdf 2
 ; Color blending modes pre-defined
 :blend-alpha 0
 :blend-additive 1
 :blend-multiplied 2
 :blend-add-colors 3
 :blend-subtract-colors 4
 :blend-alpha-premultiply 5
 :blend-custom 6
 :blend-custom-separate 7
 ; Gesture
 ; NOTE: Provided as bit-wise flags to enable only desired gestures
 :gesture-none 0
 :gesture-tap 1
 :gesture-doubletap 2
 :gesture-hold 4
 :gesture-drag 8
 :gesture-swipe-right 16
 :gesture-swipe-left 32
 :gesture-swipe-up 64
 :gesture-swipe-down 128
 :gesture-pinch-in 256
 :gesture-pinch-out 512
 ; Camera system modes
 :camera-custom 0
 :camera-free 1
 :camera-orbital 2
 :camera-first-person 3
 :camera-third-person 4
 ; Camera projection
 :camera-perspective 0
 :camera-orthographic 1
 ; N-patch layout
 :npatch-nine-patch 0
 :npatch-three-patch-vertical 1
 :npatch-three-patch-horizontal 2})

(local enums {})

(local utils (require :lib.utils))

(utils.merge-tables enums enum1)
(utils.merge-tables enums enum2)
(utils.merge-tables enums enum3)

enums
