fennel-files = $(shell dir /S /B *.fnl)

#fennel .\main.fnl
#luajit .\main.lua
run:
	fennel .\main.fnl
	
# fennel --compile .\main.fnl > main.lua
build: $(fennel-files:.fnl=.lua)
%.lua: %.fnl
	fennel --compile $< > $@

#del /S *.lua
clean:
	@for /f "delims=" %%f in ('dir /S /B *.lua ^| findstr /V /I "\\lib\\"') do del "%%f"

#.PHONY: build clean