ifeq ($(OS),Windows_NT)
	fennel-files = $(shell dir /S /B *.fnl)

	run-command = fennel .\main.fnl

	clean-command = @for /f "delims=" %%f in ('dir /S /B *.lua ^| findstr /V /I "\\lib\\"') do del "%%f"

	compile-release-binary = gcc -o main main.c -I"C:\LuaJIT\src" -L"C:\LuaJIT\src" -l"luajit-5.1"
	copy-to-release = copy main.exe release\ & copy main.luac release\ & xcopy lib release\lib /E /I

else
	fennel-files := $(shell find . -name '*.fnl')

	run-command = fennel ./main.fnl

	clean-command = find . -name '*.lua' ! -path '*/lib/*' -exec rm {} +

	compile-release-binary = gcc -o main main.c -lluajit-5.1
	copy-to-release = cp main main.luac release/; cp -r lib release/
endif

run:
	$(run-command)

build: $(fennel-files:.fnl=.lua)
%.lua: %.fnl
	fennel --compile $< > $@

clean:
	$(clean-command)

release: build
	luajit -b main.lua main.luac

	$(compile-release-binary)

	$(copy-to-release)