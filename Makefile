ifeq ($(OS),Windows_NT)
	fennel-files = $(shell dir /S /B *.fnl)

	run-command = fennel .\main.fnl

	clean-command = @for /f "delims=" %%f in ('dir /S /B *.lua ^| findstr /V /I "\\lib\\"') do del "%%f"
else
	fennel-files := $(shell find . -name '*.fnl')

	run-command = fennel ./main.fnl

	clean-command = find . -name '*.lua' ! -path '*/lib/*' -exec rm {} +
endif

run:
	$(run-command)

build: $(fennel-files:.fnl=.lua)
%.lua: %.fnl
	fennel --compile $< > $@

clean:
	$(clean-command)

