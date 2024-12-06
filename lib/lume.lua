local lume = {_version = "2.3.0"}
local pairs, ipairs = pairs, ipairs
local type, assert, unpack = type, assert, (unpack or table.unpack)
local tostring, tonumber = tostring, tonumber
local math_floor = math.floor
local math_ceil = math.ceil
local math_atan2 = (math.atan2 or math.atan)
local math_sqrt = math.sqrt
local math_abs = math.abs
local function noop()
end
local function identity(x)
  return x
end
local function patternescape(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
end
local function absindex(len, i)
  return (((i < 0) and (len + i + 1)) or i)
end
local function iscallable(x)
  if (type(x) == "function") then
    return true
  else
  end
  local mt = getmetatable(x)
  return (mt and (mt.__call ~= nil))
end
local function getiter(x)
  if lume.isarray(x) then
    return ipairs
  elseif (type(x) == "table") then
    return pairs
  else
  end
  return error("expected table", 3)
end
local function iteratee(x)
  if (x == nil) then
    return identity
  else
  end
  if iscallable(x) then
    return x
  else
  end
  if (type(x) == "table") then
    local ___antifnl_rtn_1___
    local function _5_(z)
      for k, v in pairs(x) do
        if (z[k] ~= v) then
          return false
        else
        end
      end
      return true
    end
    ___antifnl_rtn_1___ = _5_
    return ___antifnl_rtn_1___
  else
  end
  local function _8_(z)
    return z[x]
  end
  return _8_
end
lume.clamp = function(x, min, max)
  return (((x < min) and min) or (((x > max) and max) or x))
end
lume.round = function(x, increment)
  if increment then
    local ___antifnl_rtn_1___ = (lume.round((x / increment)) * increment)
    return ___antifnl_rtn_1___
  else
  end
  return (((x >= 0) and math_floor((x + 0.5))) or math_ceil((x - 0.5)))
end
lume.sign = function(x)
  return (((x < 0) and ( - 1)) or 1)
end
lume.lerp = function(a, b, amount)
  return (a + ((b - a) * lume.clamp(amount, 0, 1)))
end
lume.smooth = function(a, b, amount)
  local t = lume.clamp(amount, 0, 1)
  local m = (t * t * (3 - (2 * t)))
  return (a + ((b - a) * m))
end
lume.pingpong = function(x)
  return (1 - math_abs((1 - (x % 2))))
end
lume.distance = function(x1, y1, x2, y2, squared)
  local dx = (x1 - x2)
  local dy = (y1 - y2)
  local s = ((dx * dx) + (dy * dy))
  return ((squared and s) or math_sqrt(s))
end
lume.angle = function(x1, y1, x2, y2)
  return math_atan2((y2 - y1), (x2 - x1))
end
lume.vector = function(angle, magnitude)
  return (math.cos(angle) * magnitude), (math.sin(angle) * magnitude)
end
lume.random = function(a, b)
  if not a then
    a, b = 0, 1
  else
  end
  if not b then
    b = 0
  else
  end
  return (a + (math.random() * (b - a)))
end
lume.randomchoice = function(t)
  return t[math.random(#t)]
end
lume.weightedchoice = function(t)
  local sum = 0
  for _, v in pairs(t) do
    assert((v >= 0), "weight value less than zero")
    sum = (sum + v)
  end
  assert((sum ~= 0), "all weights are zero")
  local rnd = lume.random(sum)
  for k, v in pairs(t) do
    if (rnd < v) then
      return k
    else
    end
    rnd = (rnd - v)
  end
  return nil
end
lume.isarray = function(x)
  return ((type(x) == "table") and (x[1] ~= nil))
end
lume.push = function(t, ...)
  local n = select("#", ...)
  for i = 1, n do
    t[(#t + 1)] = select(i, ...)
  end
  return ...
end
lume.remove = function(t, x)
  local iter = getiter(t)
  for i, v in iter(t) do
    if (v == x) then
      if lume.isarray(t) then
        table.remove(t, i)
        break
      else
        t[i] = nil
        break
      end
    else
    end
  end
  return x
end
lume.clear = function(t)
  local iter = getiter(t)
  for k in iter(t) do
    t[k] = nil
  end
  return t
end
lume.extend = function(t, ...)
  for i = 1, select("#", ...) do
    local x = select(i, ...)
    if x then
      for k, v in pairs(x) do
        t[k] = v
      end
    else
    end
  end
  return t
end
lume.shuffle = function(t)
  local rtn = {}
  for i = 1, #t do
    local r = math.random(i)
    if (r ~= i) then
      rtn[i] = rtn[r]
    else
    end
    rtn[r] = t[i]
  end
  return rtn
end
lume.sort = function(t, comp)
  local rtn = lume.clone(t)
  if comp then
    if (type(comp) == "string") then
      local function _17_(a, b)
        return (a[comp] < b[comp])
      end
      table.sort(rtn, _17_)
    else
      table.sort(rtn, comp)
    end
  else
    table.sort(rtn)
  end
  return rtn
end
lume.array = function(...)
  local t = {}
  for x in ... do
    t[(#t + 1)] = x
  end
  return t
end
lume.each = function(t, ___fn___, ...)
  local iter = getiter(t)
  if (type(___fn___) == "string") then
    for _, v in iter(t) do
      v[___fn___](v, ...)
    end
  else
    for _, v in iter(t) do
      ___fn___(v, ...)
    end
  end
  return t
end
lume.map = function(t, ___fn___)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  local rtn = {}
  for k, v in iter(t) do
    rtn[k] = ___fn___(v)
  end
  return rtn
end
lume.all = function(t, ___fn___)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  for _, v in iter(t) do
    if not ___fn___(v) then
      return false
    else
    end
  end
  return true
end
lume.any = function(t, ___fn___)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  for _, v in iter(t) do
    if ___fn___(v) then
      return true
    else
    end
  end
  return false
end
lume.reduce = function(t, ___fn___, first)
  local started = (first ~= nil)
  local acc = first
  local iter = getiter(t)
  for _, v in iter(t) do
    if started then
      acc = ___fn___(acc, v)
    else
      acc = v
      started = true
    end
  end
  assert(started, "reduce of an empty table with no first value")
  return acc
end
lume.unique = function(t)
  local rtn = {}
  for k in pairs(lume.invert(t)) do
    rtn[(#rtn + 1)] = k
  end
  return rtn
end
lume.filter = function(t, ___fn___, retainkeys)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  local rtn = {}
  if retainkeys then
    for k, v in iter(t) do
      if ___fn___(v) then
        rtn[k] = v
      else
      end
    end
  else
    for _, v in iter(t) do
      if ___fn___(v) then
        rtn[(#rtn + 1)] = v
      else
      end
    end
  end
  return rtn
end
lume.reject = function(t, ___fn___, retainkeys)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  local rtn = {}
  if retainkeys then
    for k, v in iter(t) do
      if not ___fn___(v) then
        rtn[k] = v
      else
      end
    end
  else
    for _, v in iter(t) do
      if not ___fn___(v) then
        rtn[(#rtn + 1)] = v
      else
      end
    end
  end
  return rtn
end
lume.merge = function(...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    local iter = getiter(t)
    for k, v in iter(t) do
      rtn[k] = v
    end
  end
  return rtn
end
lume.concat = function(...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    if (t ~= nil) then
      local iter = getiter(t)
      for _, v in iter(t) do
        rtn[(#rtn + 1)] = v
      end
    else
    end
  end
  return rtn
end
lume.find = function(t, value)
  local iter = getiter(t)
  for k, v in iter(t) do
    if (v == value) then
      return k
    else
    end
  end
  return nil
end
lume.match = function(t, ___fn___)
  ___fn___ = iteratee(___fn___)
  local iter = getiter(t)
  for k, v in iter(t) do
    if ___fn___(v) then
      return v, k
    else
    end
  end
  return nil
end
lume.count = function(t, ___fn___)
  local count = 0
  local iter = getiter(t)
  if ___fn___ then
    ___fn___ = iteratee(___fn___)
    for _, v in iter(t) do
      if ___fn___(v) then
        count = (count + 1)
      else
      end
    end
  else
    if lume.isarray(t) then
      local ___antifnl_rtn_1___ = #t
      return ___antifnl_rtn_1___
    else
    end
    for _ in iter(t) do
      count = (count + 1)
    end
  end
  return count
end
lume.slice = function(t, i, j)
  i = ((i and absindex(#t, i)) or 1)
  j = ((j and absindex(#t, j)) or #t)
  local rtn = {}
  for x = (((i < 1) and 1) or i), (((j > #t) and #t) or j) do
    rtn[(#rtn + 1)] = t[x]
  end
  return rtn
end
lume.first = function(t, n)
  if not n then
    local ___antifnl_rtn_1___ = t[1]
    return ___antifnl_rtn_1___
  else
  end
  return lume.slice(t, 1, n)
end
lume.last = function(t, n)
  if not n then
    local ___antifnl_rtn_1___ = t[#t]
    return ___antifnl_rtn_1___
  else
  end
  return lume.slice(t, ( - n), ( - 1))
end
lume.invert = function(t)
  local rtn = {}
  for k, v in pairs(t) do
    rtn[v] = k
  end
  return rtn
end
lume.pick = function(t, ...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local k = select(i, ...)
    rtn[k] = t[k]
  end
  return rtn
end
lume.keys = function(t)
  local rtn = {}
  local iter = getiter(t)
  for k in iter(t) do
    rtn[(#rtn + 1)] = k
  end
  return rtn
end
lume.clone = function(t)
  local rtn = {}
  for k, v in pairs(t) do
    rtn[k] = v
  end
  return rtn
end
lume.fn = function(___fn___, ...)
  assert(iscallable(___fn___), "expected a function as the first argument")
  local args = {...}
  local function _38_(...)
    local a = lume.concat(args, {...})
    return ___fn___(unpack(a))
  end
  return _38_
end
lume.once = function(___fn___, ...)
  local f = lume.fn(___fn___, ...)
  local done = false
  local function _39_(...)
    if done then
      return 
    else
    end
    done = true
    return f(...)
  end
  return _39_
end
local memoize_fnkey = {}
local memoize_nil = {}
lume.memoize = function(___fn___)
  local cache = {}
  local function _41_(...)
    local c = cache
    for i = 1, select("#", ...) do
      local a = (select(i, ...) or memoize_nil)
      c[a] = (c[a] or {})
      c = c[a]
    end
    c[memoize_fnkey] = (c[memoize_fnkey] or {___fn___(...)})
    return unpack(c[memoize_fnkey])
  end
  return _41_
end
lume.combine = function(...)
  local n = select("#", ...)
  if (n == 0) then
    return noop
  else
  end
  if (n == 1) then
    local ___fn___ = select(1, ...)
    if not ___fn___ then
      return noop
    else
    end
    assert(iscallable(___fn___), "expected a function or nil")
    return ___fn___
  else
  end
  local funcs = {}
  for i = 1, n do
    local ___fn___ = select(i, ...)
    if (___fn___ ~= nil) then
      assert(iscallable(___fn___), "expected a function or nil")
      funcs[(#funcs + 1)] = ___fn___
    else
    end
  end
  local function _46_(...)
    for _, f in ipairs(funcs) do
      f(...)
    end
    return nil
  end
  return _46_
end
lume.call = function(___fn___, ...)
  if ___fn___ then
    return ___fn___(...)
  else
    return nil
  end
end
lume.time = function(___fn___, ...)
  local start = os.clock()
  local rtn = {___fn___(...)}
  return (os.clock() - start), unpack(rtn)
end
local lambda_cache = {}
lume.lambda = function(str)
  if not lambda_cache[str] then
    local args, body = str:match("^([%w,_ ]-)%->(.-)$")
    assert((args and body), "bad string lambda")
    local s = ("return function(" .. args .. ")\nreturn " .. body .. "\nend")
    lambda_cache[str] = lume.dostring(s)
  else
  end
  return lambda_cache[str]
end
local serialize = nil
local serialize_map
local function _49_(v)
  if (v ~= v) then
    return "0/0"
  elseif (v == (1 / 0)) then
    return "1/0"
  elseif (v == (( - 1) / 0)) then
    return "-1/0"
  else
  end
  return tostring(v)
end
local function _51_(v)
  return string.format("%q", v)
end
local function _52_(t, stk)
  stk = (stk or {})
  if stk[t] then
    error("circular reference")
  else
  end
  local rtn = {}
  stk[t] = true
  for k, v in pairs(t) do
    rtn[(#rtn + 1)] = ("[" .. serialize(k, stk) .. "]=" .. serialize(v, stk))
  end
  stk[t] = nil
  return ("{" .. table.concat(rtn, ",") .. "}")
end
serialize_map = {boolean = tostring, ["nil"] = tostring, number = _49_, string = _51_, table = _52_}
local function _54_(_, k)
  return error(("unsupported serialize type: " .. k))
end
setmetatable(serialize_map, {__index = _54_})
local function _55_(x, stk)
  return serialize_map[type(x)](x, stk)
end
serialize = _55_
lume.serialize = function(x)
  return serialize(x)
end
lume.deserialize = function(str)
  return lume.dostring(("return " .. str))
end
lume.split = function(str, sep)
  if not sep then
    return lume.array(str:gmatch("([%S]+)"))
  else
    assert((sep ~= ""), "empty separator")
    local psep = patternescape(sep)
    return lume.array((str .. sep):gmatch(("(.-)(" .. psep .. ")")))
  end
end
lume.trim = function(str, chars)
  if not chars then
    local ___antifnl_rtn_1___ = str:match("^[%s]*(.-)[%s]*$")
    return ___antifnl_rtn_1___
  else
  end
  chars = patternescape(chars)
  return str:match(("^[" .. chars .. "]*(.-)[" .. chars .. "]*$"))
end
lume.wordwrap = function(str, limit)
  limit = (limit or 72)
  local check = nil
  if (type(limit) == "number") then
    local function _58_(s)
      return (#s >= limit)
    end
    check = _58_
  else
    check = limit
  end
  local rtn = {}
  local line = ""
  for word, spaces in str:gmatch("(%S+)(%s*)") do
    local s = (line .. word)
    if check(s) then
      table.insert(rtn, (line .. "\n"))
      line = word
    else
      line = s
    end
    for c in spaces:gmatch(".") do
      if (c == "\n") then
        table.insert(rtn, (line .. "\n"))
        line = ""
      else
        line = (line .. c)
      end
    end
  end
  table.insert(rtn, line)
  return table.concat(rtn)
end
lume.format = function(str, vars)
  if not vars then
    return str
  else
  end
  local function f(x)
    return tostring(((vars[x] or vars[tonumber(x)]) or ("{" .. x .. "}")))
  end
  return str:gsub("{(.-)}", f)
end
lume.trace = function(...)
  local info = debug.getinfo(2, "Sl")
  local t = {(info.short_src .. ":" .. info.currentline .. ":")}
  for i = 1, select("#", ...) do
    local x = select(i, ...)
    if (type(x) == "number") then
      x = string.format("%g", lume.round(x, 0.01))
    else
    end
    t[(#t + 1)] = tostring(x)
  end
  return print(table.concat(t, " "))
end
lume.dostring = function(str)
  return assert((loadstring or load)(str))()
end
lume.uuid = function()
  local function ___fn___(x)
    local r = (math.random(16) - 1)
    r = (((x == "x") and (r + 1)) or ((r % 4) + 9))
    return ("0123456789abcdef"):sub(r, r)
  end
  return ("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", ___fn___)
end
lume.hotswap = function(modname)
  local oldglobal = lume.clone(_G)
  local updated = {}
  local function update(old, new)
    if updated[old] then
      return 
    else
    end
    updated[old] = true
    local oldmt, newmt = getmetatable(old), getmetatable(new)
    if (oldmt and newmt) then
      update(oldmt, newmt)
    else
    end
    for k, v in pairs(new) do
      if (type(v) == "table") then
        update(old[k], v)
      else
        old[k] = v
      end
    end
    return nil
  end
  local err = nil
  local function onerror(e)
    for k in pairs(_G) do
      _G[k] = oldglobal[k]
    end
    err = lume.trim(e)
    return nil
  end
  local ok, oldmod = pcall(require, modname)
  oldmod = ((ok and oldmod) or nil)
  local function _67_()
    package.loaded[modname] = nil
    local newmod = require(modname)
    if (type(oldmod) == "table") then
      update(oldmod, newmod)
    else
    end
    for k, v in pairs(oldglobal) do
      if ((v ~= _G[k]) and (type(v) == "table")) then
        update(v, _G[k])
        _G[k] = v
      else
      end
    end
    return nil
  end
  xpcall(_67_, onerror)
  package.loaded[modname] = oldmod
  if err then
    return nil, err
  else
  end
  return oldmod
end
local function ripairs_iter(t, i)
  i = (i - 1)
  local v = t[i]
  if (v ~= nil) then
    return i, v
  else
    return nil
  end
end
lume.ripairs = function(t)
  return ripairs_iter, t, (#t + 1)
end
lume.color = function(str, mul)
  mul = (mul or 1)
  local r, g, b, a = nil
  r, g, b = str:match("#(%x%x)(%x%x)(%x%x)")
  if r then
    r = (tonumber(r, 16) / 255)
    g = (tonumber(g, 16) / 255)
    b = (tonumber(b, 16) / 255)
    a = 1
  elseif str:match("rgba?%s*%([%d%s%.,]+%)") then
    local f = str:gmatch("[%d.]+")
    r = ((f() or 0) / 255)
    g = ((f() or 0) / 255)
    b = ((f() or 0) / 255)
    a = (f() or 1)
  else
    error(("bad color string '%s'"):format(str))
  end
  return (r * mul), (g * mul), (b * mul), (a * mul)
end
local chain_mt = {}
local function _73_(___fn___)
  local function _74_(self, ...)
    self._value = ___fn___(self._value, ...)
    return self
  end
  return _74_
end
chain_mt.__index = lume.map(lume.filter(lume, iscallable, true), _73_)
chain_mt.__index.result = function(x)
  return x._value
end
lume.chain = function(value)
  return setmetatable({_value = value}, chain_mt)
end
local function _75_(_, ...)
  return lume.chain(...)
end
setmetatable(lume, {__call = _75_})
return lume
