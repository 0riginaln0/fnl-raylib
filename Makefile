ifeq ($(OS),Windows_NT)
	fennel-files = $(shell dir /S /B *.fnl)

	run-command = fennel .\main.fnl

	compile-release-binary = gcc -o main main.c -I"C:\LuaJIT\src" -L"C:\LuaJIT\src" -l"luajit-5.1"
	copy-to-release = copy main.exe release\ & copy main.luac release\ & xcopy lib release\lib /E /I
else
	fennel-files := $(shell find . -name '*.fnl')

	run-command = fennel ./main.fnl

	compile-release-binary = gcc -o main main.c -lluajit-5.1
	copy-to-release = cp main main.luac release/; cp -r lib release/
endif

run:
	$(run-command)

# Compiles all .fnl files to .lua files
build: $(fennel-files:.fnl=.lua)
%.lua: %.fnl
	fennel --compile $< > $@

release: build
	luajit -b main.lua main.luac

	$(compile-release-binary)

	$(copy-to-release)

# Deletes every *.lua file in project skipping the `lib` and `release` folders 
clean:
	python cleanup_luafiles.py

# Deletes every *.lua file in project skipping the `release` folder
clean-all:
	python cleanup_luafiles.py --all