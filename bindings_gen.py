from caseconverter import kebabcase
# pip install case-converter


bindings = open("genraylib.fnl", "w")
bindings.write(
    r"""
; My Raylib bindings for Fennel and so for Lua
; Generated for further manual deconstruction.

(print "RAYLIB FFI INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
"""
)

export_names = ["{: safe-mode\n"]


def add_export_name(newname):
    global export_names
    export_names.append(f" : {newname}\n")


state = "comment"
comments: list[str] = []
cffistruct: list[str] = ['(ffi.cdef "\n']
constructs: list[str] = []
enums: list[str] = []
functions: list[str] = []


def create_construct(name: str, arguments: list[str]) -> str:
    add_export_name(name)
    constr = ""
    constr += f"(fn {name} ["
    args = ""
    for i, arg in enumerate(arguments):
        if i == len(arguments) - 1:
            args += kebabcase(arg)
        else:
            args += kebabcase(arg) + " "
    constr += f"{args}] (ffi.new :{name} [{args}]))\n"
    return constr


def create_enum(name, value):
    name = kebabcase(name)
    add_export_name(name)
    enum = ""
    enum += f"(local {name} {value})\n"
    return enum


def create_fn(name: str, arguments, doc: str) -> str:
    fn_name = kebabcase(name)
    add_export_name(fn_name)
    fn = ""
    fn += f"(fn {fn_name} ["
    args = ""
    for i, arg in enumerate(arguments):
        if i == len(arguments) - 1:
            args += kebabcase(arg)
        else:
            args += kebabcase(arg) + " "
    if name.startswith("*"):
        name = name.removeprefix("*")
    if name.startswith("*"):
        name = name.removeprefix("*")
    fn += f'{args}]\n\t"{doc.strip()}"\n\t(rl.{name} {args}))\n\n'
    return fn


def get_args_names(args: str) -> list[str]:
    # print("1: ", args)
    args_names = []
    if args == "void":
        return args_names
    arg = args.split(",")
    cur_arg, *rest = arg
    while cur_arg != "":
        # print("1/5:", cur_arg)
        new_arg_name = kebabcase(cur_arg.split(" ")[-1])
        if new_arg_name == "length":
            new_arg_name = "llength"
        args_names.append(new_arg_name)
        args = ", ".join(rest)
        arg = args.split(",")
        cur_arg, *rest = arg
    # print("2: ", args_names)
    return args_names


struct_field_indent = ""

with open("lib/raylib-5.5_linux_amd64/include/raylib.h", "r") as rl_header:
    while True:
        line = rl_header.readline()
        if not line:  # Check for EOF
            break
        # elif line.strip() in ignorelist:
        #     continue
        elif line.startswith("//"):
            # Комментарий верхнего уровня. Записываем в память.
            comment = line.replace("//", ";")
            comments.append(comment)
        elif line.startswith("typedef struct"):
            struct_field_indent = "    "
            fn_comment = "".join(comments)
            constructs.append(fn_comment)
            comments.clear()
            # Записать определение структуры в cffistruct
            cffistruct.append(line)
            # Записать функцию-конструктор для струкруты в construct
            fn_name = line.split(" ")[2].strip()
            # print("Start:", struct_name)
            args_names = []

            parsing_enum = True
            while parsing_enum:
                nline = rl_header.readline().strip()
                cffistruct.append(struct_field_indent + nline + "\n")
                if nline == "":
                    continue
                if nline.startswith("//"):
                    continue

                # print("line:", nline)
                # int params[4];                  // Event parameters (if required)
                if nline in [
                    "typedef struct rAudioBuffer rAudioBuffer;",
                    "typedef struct rAudioProcessor rAudioProcessor;",
                ]:
                    parsing_enum = False
                    struct_field_indent = ""
                    cffistruct.append("\n")
                    continue
                if nline.split(" ")[1].strip() == f"{fn_name};":
                    parsing_enum = False
                    struct_field_indent = ""
                    cffistruct.append("\n")
                    constructs.append(create_construct(fn_name, args_names))
                # поля могут быть следующих типов:
                # - в ряд
                # float m0, m4, m8, m12;  // Matrix first row (4 components)
                elif len(nline.split(",")) > 1:
                    nline = nline.split(";")[0]
                    ftype = nline.split(" ")[0]
                    fnames = nline.removeprefix(ftype).split(",")
                    for name in fnames:
                        name = name.strip()
                        args_names.append(name)
                # - одиночный массив
                # float params[4];
                elif len(nline.split("];")) > 1:
                    nline = nline.split(";")[0]
                    fname = nline.split(" ")[1]
                    fname = fname.split("[")[0]
                    args_names.append(fname)
                # - одиночный (тип имя)
                # unsigned char r;        // Color red value
                # float w;                // Vector w component
                else:
                    fname = nline.split(";")[0]
                    fname = fname.split(" ").pop()
                    # print("someone here?", fname)
                    args_names.append(fname)
        elif line.startswith("typedef enum"):
            fn_comment = "".join(comments)
            enums.append(fn_comment)
            comments.clear()

            # Enum может быть типа:
            # Автоинкремент
            # typedef enum {
            #   NPATCH_NINE_PATCH = 0,          // Npatch layout: 3x3 tiles
            #   NPATCH_THREE_PATCH_VERTICAL,    // Npatch layout: 1x3 tiles
            #   NPATCH_THREE_PATCH_HORIZONTAL   // Npatch layout: 3x1 tiles
            # } NPatchLayout;

            # Автоинкремент с единицы
            # typedef enum {
            #   PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
            #   PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA,
            # Заданные с возможными комментами между
            # typedef enum {
            #     KEY_NULL            = 0,        // Key: NULL, used for no key pressed
            #     // Alphanumeric keys
            #     KEY_APOSTROPHE      = 39,       // Key: '
            #     KEY_COMMA           = 44,       // Key

            # Заданные в BASE16
            # typedef enum {
            #     FLAG_VSYNC_HINT         = 0x00000040,   // Set to try enabling V-Sync on GPU
            #     FLAG_FULLSCREEN_MODE    = 0x00000002,   // Set to run program in fullscreen
            #     FLAG_WINDOW_RESIZABLE   = 0x00000004,   // Set to allow resizable window
            #     FLAG_WINDOW_UNDECORATED = 0x00000008,   // Set to disable window decoration (frame and buttons)
            #     FLAG_WINDOW_HIDDEN      = 0x00000080,
            parsing_enum = True
            cur_val = 0
            while parsing_enum:
                nline = rl_header.readline().strip()
                if nline == "":
                    continue
                elif nline.startswith("//"):
                    continue
                elif nline.startswith("}"):
                    parsing_enum = False
                    cur_val = 0
                elif "=" in nline:
                    nline = nline.split(",")[0].strip()
                    name, value = nline.split("=")
                    value = value.split("//")[0].strip()
                    name = kebabcase(name.strip())
                    if "x" in value:
                        value = int(value, 16)
                    else:
                        value = int(value)
                    enums.append(create_enum(name, value))
                    cur_val = value
                else:
                    nline = nline.split(",")[0].strip()
                    if "//" in nline:
                        nline = nline.split("//")[0].strip()
                    cur_val += 1
                    enums.append(create_enum(nline, cur_val))
        elif line.startswith("typedef"):
            fn_comment = "".join(comments)
            constructs.append(fn_comment)
            comments.clear()
            # Записать определение структуры в cffistruct
            cffistruct.append(line)
            line = line.strip()
            # print("", line.strip())

            if line == "typedef Vector4 Quaternion;":
                constructs.append(
                    "(fn Quaternion [x y z w] (ffi.new :Quaternion [x y z w]))"
                )
                add_export_name("Quaternion")
            elif line == "typedef Texture Texture2D;":
                constructs.append(
                    "(fn Texture2D [id width height mipmaps format] (ffi.new :Texture2D [id width height mipmaps format]))"
                )
                add_export_name("Texture2D")
            elif line == "typedef Texture TextureCubemap;":
                constructs.append(
                    "(fn TextureCubemap [id width height mipmaps format] (ffi.new :TextureCubemap [id width height mipmaps format]))"
                )
                add_export_name("TextureCubemap")
            elif line == "typedef RenderTexture RenderTexture2D;":
                constructs.append(
                    "(fn RenderTexture2D [id texture depth] (ffi.new :RenderTexture2D [id texture depth]))"
                )
                add_export_name("RenderTexture2D")
            elif (
                line
                == "typedef Camera3D Camera;    // Camera type fallback, defaults to Camera3D"
            ):
                constructs.append(
                    "(fn Camera [position target up fovy projection] (ffi.new :Camera [position target up fovy projection]))"
                )
                add_export_name("Camera")
        elif line.startswith("RLAPI"):
            fn_comment = "".join(comments)
            functions.append(fn_comment)
            comments.clear()
            # Записать определение функции в cffistruct
            line = line.removeprefix("RLAPI ")
            cffistruct.append(line + "\n")
            # Записать функцию-обёртку
            docstring = line.split("//")[1]
            fn_name = line.split("(")[0].split(" ")[-1]

            line = line.split("(")[1]
            args = line.split(")")[0]
            args_names = get_args_names(args)
            functions.append(create_fn(fn_name, args_names, docstring))


cffistruct.append(f'")')
bindings.write("\n\n; CFFI BLOCK\n")
bindings.writelines(cffistruct)


bindings.write("\n\n; CONSTRUCTS BLOCK\n")
bindings.writelines(constructs)

bindings.write("\n\n; ENUMS BLOCK\n")
bindings.writelines(enums)

bindings.write("\n\n; FUNCTIONS BLOCK\n")
bindings.writelines(functions)

basic_colors = r"""(local raywhite (Color 245 245 245 255))
(local lightgray (Color 200 200 200 255))
(local maroon (Color 190 33 55 255))
(local darkblue (Color 0 82 172 255))
(local darkgray (Color 80 80 80 255))
(local yellow (Color 253 249 0 255))
(local gray (Color 130 130 130 255))
(local gold (Color 255 203 0 255))
(local orange (Color 255 161 0 255))
(local pink (Color 255 109 194 255))
(local red (Color 230 41 55 255))
(local green (Color 0 228 48 255))
(local lime (Color 0 158 47 255))
(local darkgreen (Color 0 117 44 255))
(local skyblue (Color 102 191 255 255))
(local blue (Color 0 121 241 255))
(local purple (Color 200 122 255 255))
(local violet (Color 135 60 190 255))
(local darkpurple (Color 112 31 126 255))
(local beige (Color 211 176 131 255))
(local brown (Color 127 106 79 255))
(local darkbrown (Color 76 63 47 255))
(local white (Color 255 255 255 255))
(local black (Color 0 0 0 255))
(local blank (Color 0 0 0 0))
(local magenta (Color 255 0 255 255))
"""
bindings.write("\n\n; COLORS BLOCK\n")
bindings.write(basic_colors)

color_names = [
    "raywhite",
    "lightgray",
    "maroon",
    "darkblue",
    "darkgray",
    "yellow",
    "gray",
    "gold",
    "orange",
    "pink",
    "red",
    "green",
    "lime",
    "darkgreen",
    "skyblue",
    "blue",
    "purple",
    "violet",
    "darkpurple",
    "beige",
    "brown",
    "darkbrown",
    "white",
    "black",
    "blank",
    "magenta",
]
for col in color_names:
    add_export_name(col)

export_names.append(" : rl}")

bindings.write("\n\n; EXPORT BLOCK\n")
bindings.writelines(export_names)


rl_header.close()
