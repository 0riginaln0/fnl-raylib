from caseconverter import kebabcase


bindings = open("gen-raylib.fnl", "w")
bindings.write(
    r"""
; My Raylib bindings for Fennel and so for Lua

(print "RAYLIB FFI INIT: STARTED")
(local safe-mode true)

(local ffi (require :ffi))

(local os ffi.os)
(print os)

(local rl 
  (case os 
    :Windows (ffi.load :lib\raylib-5.5_win64_mingw-w64\lib\raylib.dll) 
    :Linux   (ffi.load :lib/raylib-5.5_linux_amd64/lib/libraylib.so)))
(assert (= rl nil) "Unknown OS. Sorry")
"""
)

export_names = ["{: safe-mode\n"]


def add_export_name(newname):
    global export_names
    export_names.append(f" : {newname}\n")


ignorelist = [
    "// Callbacks to hook some internal functions",
    "// WARNING: These callbacks are intended for advanced users",
    "typedef void (*TraceLogCallback)(int logLevel, const char *text, va_list args);  // Logging: Redirect trace log messages",
    "typedef unsigned char *(*LoadFileDataCallback)(const char *fileName, int *dataSize);    // FileIO: Load binary data",
    "typedef bool (*SaveFileDataCallback)(const char *fileName, void *data, int dataSize);   // FileIO: Save binary data",
    "typedef char *(*LoadFileTextCallback)(const char *fileName);            // FileIO: Load text data",
    "typedef bool (*SaveFileTextCallback)(const char *fileName, char *text); // FileIO: Save text data",
    "typedef void (*AudioCallback)(void *bufferData, unsigned int frames);",
]

# # Писать определения структур в ffi_cdef
# # Писать функции-конструкторы для структур
# if line.startswith("typedef"):

#     pass
# if line == "// Enumerators Definition":
#     # Писать локальные переменные
#     # Енамы могут быть как полностью определённые, так и только для первого элемен
#     pass
# if line == "// Global Variables Definition":
#     # Начало
#     pass
# if line == "// Window and Graphics Device Functions (Module: core)":
#     # Писать определения функций в ffi_cdef
#     # Писать обёртки фнльные

#     # Отделять блоки функций комментариями // Window-related functions
#     # Комментарии перед блоками функций могут быть многострочными
#     pass


state = "comment"
# "comment" - запоминать комментарии (верхнего уровня). Записать при переходе в другой стейт
# "typedef struct" - записать определение структуры в cffistruct
#                    записать функцию-конструктор для струкруты в construct
# "typedef enum"
# "typedef alias"
# "func"

comments: list[str] = []
cffistruct: list[str] = ['(ffi.cdef "\n']
constructs: list[str] = []
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


def create_fn(name, arguments) -> str:
    add_export_name(name)
    fn = ""
    fn += f"(fn {name} ["
    args = ""
    for i, arg in enumerate(arguments):
        if i == len(arguments) - 1:
            args += kebabcase(arg)
        else:
            args += kebabcase(arg) + " "
    fn += f"{args}] (rl.{name} {args}))\n"
    return fn


struct_field_indent = ""

with open("lib/raylib-5.5_linux_amd64/include/raylib.h", "r") as rl_header:
    while True:
        line = rl_header.readline()
        if not line:  # Check for EOF
            break
        if line in ignorelist:
            continue
        if line.startswith("//"):
            # Комментарий верхнего уровня. Записываем в память.
            comment = line.replace("//", ";")
            comments.append(comment)
        if line.startswith("typedef struct"):
            struct_field_indent = "    "
            struct_comment = "".join(comments)
            constructs.append(struct_comment)
            comments.clear()
            # Записать определение структуры в cffistruct
            cffistruct.append(line)
            # Записать функцию-конструктор для струкруты в construct
            struct_name = line.split(" ")[2].strip()
            # print("Start:", struct_name)
            field_names = []

            parsing_struct = True
            while parsing_struct:
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
                    parsing_struct = False
                    struct_field_indent = ""
                    cffistruct.append("\n")
                    continue
                if nline.split(" ")[1].strip() == f"{struct_name};":
                    parsing_struct = False
                    struct_field_indent = ""
                    cffistruct.append("\n")
                    constructs.append(create_construct(struct_name, field_names))
                # поля могут быть следующих типов:
                # - в ряд
                # float m0, m4, m8, m12;  // Matrix first row (4 components)
                elif len(nline.split(",")) > 1:
                    nline = nline.split(";")[0]
                    ftype = nline.split(" ")[0]
                    fnames = nline.removeprefix(ftype).split(",")
                    for name in fnames:
                        name = name.strip()
                        field_names.append(name)
                # - одиночный массив
                # float params[4];
                elif len(nline.split("];")) > 1:
                    nline = nline.split(";")[0]
                    fname = nline.split(" ")[1]
                    fname = fname.split("[")[0]
                    field_names.append(fname)
                # - одиночный (тип имя)
                # unsigned char r;        // Color red value
                # float w;                // Vector w component
                else:
                    fname = nline.split(";")[0]
                    fname = fname.split(" ").pop()
                    # print("someone here?", fname)
                    field_names.append(fname)

cffistruct.append(f'")')
bindings.write("\n\n; CFFI BLOCK\n")
bindings.writelines(cffistruct)


bindings.write("\n\n; CONSTRUCTS BLOCK\n")
bindings.writelines(constructs)

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
