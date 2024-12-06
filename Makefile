ifeq ($(OS),Windows_NT)
	fennel-files = $(shell dir /S /B *.fnl)

	run-command = fennel .\main.fnl

	clean-command = @for /f "delims=" %%f in ('dir /S /B *.lua ^| findstr /V /I "\\lib\\"') do del "%%f"

	copy-to-release = xcopy main main.luac lib release /E /I /Y
else
	fennel-files := $(shell find . -name '*.fnl')

	run-command = fennel ./main.fnl

	clean-command = find . -name '*.lua' ! -path '*/lib/*' -exec rm {} +

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

	gcc -o main main.c -lluajit-5.1

	$(copy-to-release)