#include <stdio.h>
#ifdef __linux__
#include <luajit-2.1/luajit.h>
#include <luajit-2.1/lua.h>
#include <luajit-2.1/lualib.h>
#include <luajit-2.1/lauxlib.h>
#elif _WIN32
#include <luajit.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#else
#endif

int main(int argc, char **argv)
{
    printf("C app starts\n");
    lua_State *L = luaL_newstate(); // Create a new Lua state
    luaL_openlibs(L);               // Load standard libraries

    // Load your compiled Lua bytecode
    if (luaL_loadfile(L, "main.luac") || lua_pcall(L, 0, 0, 0))
    {
        fprintf(stderr, "Error: %s\n", lua_tostring(L, -1));
        lua_pop(L, 1); // Remove error message from stack
    }

    lua_close(L); // Close the Lua state
    printf("C app ends\n");
    return 0;
}
