(local lume {:_version :2.3.0})
(local (pairs ipairs) (values pairs ipairs))
(local (type assert unpack) (values type assert (or unpack table.unpack)))
(local (tostring tonumber) (values tostring tonumber))
(local math-floor math.floor)
(local math-ceil math.ceil)
(local math-atan2 (or math.atan2 math.atan))
(local math-sqrt math.sqrt)
(local math-abs math.abs)
(fn noop [])
(fn identity [x] x)
(fn patternescape [str] (str:gsub "[%(%)%.%%%+%-%*%?%[%]%^%$]" "%%%1"))
(fn absindex [len i]
  (or (and (< i 0) (+ len i 1)) i))
(fn iscallable [x]
  (when (= (type x) :function) (lua "return true"))
  (local mt (getmetatable x))
  (and mt (not= mt.__call nil)))
(fn getiter [x]
  (if (lume.isarray x) (lua "return ipairs")
      (= (type x) :table) (lua "return pairs"))
  (error "expected table" 3))
(fn iteratee [x]
  (when (= x nil) (lua "return identity"))
  (when (iscallable x) (lua "return x"))
  (when (= (type x) :table)
    (let [___antifnl_rtn_1___ (fn [z]
                                (each [k v (pairs x)]
                                  (when (not= (. z k) v) (lua "return false")))
                                true)]
      (lua "return ___antifnl_rtn_1___")))
  (fn [z] (. z x)))
(fn lume.clamp [x min max]
  (or (and (< x min) min) (or (and (> x max) max) x)))
(fn lume.round [x increment]
  (when increment
    (let [___antifnl_rtn_1___ (* (lume.round (/ x increment)) increment)]
      (lua "return ___antifnl_rtn_1___")))
  (or (and (>= x 0) (math-floor (+ x 0.5))) (math-ceil (- x 0.5))))
(fn lume.sign [x]
  (or (and (< x 0) (- 1)) 1))
(fn lume.lerp [a b amount]
  (+ a (* (- b a) (lume.clamp amount 0 1))))
(fn lume.smooth [a b amount]
  (let [t (lume.clamp amount 0 1)
        m (* t t (- 3 (* 2 t)))]
    (+ a (* (- b a) m))))
(fn lume.pingpong [x]
  (- 1 (math-abs (- 1 (% x 2)))))
(fn lume.distance [x1 y1 x2 y2 squared]
  (let [dx (- x1 x2)
        dy (- y1 y2)
        s (+ (* dx dx) (* dy dy))]
    (or (and squared s) (math-sqrt s))))
(fn lume.angle [x1 y1 x2 y2] (math-atan2 (- y2 y1) (- x2 x1)))
(fn lume.vector [angle magnitude]
  (values (* (math.cos angle) magnitude) (* (math.sin angle) magnitude)))
(fn lume.random [a b]
  (when (not a) (set-forcibly! (a b) (values 0 1)))
  (when (not b) (set-forcibly! b 0))
  (+ a (* (math.random) (- b a))))
(fn lume.randomchoice [t]
  (. t (math.random (length t))))
(fn lume.weightedchoice [t]
  (var sum 0)
  (each [_ v (pairs t)] (assert (>= v 0) "weight value less than zero")
    (set sum (+ sum v)))
  (assert (not= sum 0) "all weights are zero")
  (var rnd (lume.random sum))
  (each [k v (pairs t)] (when (< rnd v) (lua "return k")) (set rnd (- rnd v))))
(fn lume.isarray [x]
  (and (= (type x) :table) (not= (. x 1) nil)))
(fn lume.push [t ...]
  (let [n (select "#" ...)]
    (for [i 1 n]
      (tset t (+ (length t) 1) (select i ...)))
    ...))
(fn lume.remove [t x]
  (let [iter (getiter t)]
    (each [i v (iter t)]
      (when (= v x)
        (if (lume.isarray t) (do
                               (table.remove t i)
                               (lua :break))
            (do
              (tset t i nil) (lua :break)))))
    x))
(fn lume.clear [t]
  (let [iter (getiter t)]
    (each [k (iter t)] (tset t k nil))
    t))
(fn lume.extend [t ...]
  (for [i 1 (select "#" ...)]
    (local x (select i ...))
    (when x
      (each [k v (pairs x)] (tset t k v))))
  t)
(fn lume.shuffle [t]
  (let [rtn {}]
    (for [i 1 (length t)]
      (local r (math.random i))
      (when (not= r i) (tset rtn i (. rtn r)))
      (tset rtn r (. t i)))
    rtn))
(fn lume.sort [t comp]
  (let [rtn (lume.clone t)]
    (if comp (if (= (type comp) :string)
                 (table.sort rtn (fn [a b] (< (. a comp) (. b comp))))
                 (table.sort rtn comp)) (table.sort rtn))
    rtn))
(fn lume.array [...]
  (let [t {}]
    (each [x ...]
      (tset t (+ (length t) 1) x))
    t))
(fn lume.each [t ___fn___ ...]
  (let [iter (getiter t)]
    (if (= (type ___fn___) :string)
        (each [_ v (iter t)] ((. v ___fn___) v ...))
        (each [_ v (iter t)] (___fn___ v ...)))
    t))
(fn lume.map [t ___fn___]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (local rtn {})
  (each [k v (iter t)] (tset rtn k (___fn___ v)))
  rtn)
(fn lume.all [t ___fn___]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (each [_ v (iter t)]
    (when (not (___fn___ v)) (lua "return false")))
  true)
(fn lume.any [t ___fn___]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (each [_ v (iter t)] (when (___fn___ v) (lua "return true")))
  false)
(fn lume.reduce [t ___fn___ first]
  (var started (not= first nil))
  (var acc first)
  (local iter (getiter t))
  (each [_ v (iter t)]
    (if started (set acc (___fn___ acc v))
        (do
          (set acc v) (set started true))))
  (assert started "reduce of an empty table with no first value")
  acc)
(fn lume.unique [t]
  (let [rtn {}]
    (each [k (pairs (lume.invert t))]
      (tset rtn (+ (length rtn) 1) k))
    rtn))
(fn lume.filter [t ___fn___ retainkeys]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (local rtn {})
  (if retainkeys (each [k v (iter t)] (when (___fn___ v) (tset rtn k v)))
      (each [_ v (iter t)]
        (when (___fn___ v)
          (tset rtn (+ (length rtn) 1) v))))
  rtn)
(fn lume.reject [t ___fn___ retainkeys]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (local rtn {})
  (if retainkeys (each [k v (iter t)]
                   (when (not (___fn___ v)) (tset rtn k v)))
      (each [_ v (iter t)]
        (when (not (___fn___ v))
          (tset rtn (+ (length rtn) 1) v))))
  rtn)
(fn lume.merge [...]
  (let [rtn {}]
    (for [i 1 (select "#" ...)]
      (local t (select i ...))
      (local iter (getiter t))
      (each [k v (iter t)] (tset rtn k v)))
    rtn))
(fn lume.concat [...]
  (let [rtn {}]
    (for [i 1 (select "#" ...)]
      (local t (select i ...))
      (when (not= t nil)
        (local iter (getiter t))
        (each [_ v (iter t)]
          (tset rtn (+ (length rtn) 1) v))))
    rtn))
(fn lume.find [t value]
  (let [iter (getiter t)]
    (each [k v (iter t)] (when (= v value) (lua "return k")))
    nil))
(fn lume.match [t ___fn___]
  (set-forcibly! ___fn___ (iteratee ___fn___))
  (local iter (getiter t))
  (each [k v (iter t)] (when (___fn___ v) (lua "return v, k")))
  nil)
(fn lume.count [t ___fn___]
  (var count 0)
  (local iter (getiter t))
  (if ___fn___ (do
                 (set-forcibly! ___fn___ (iteratee ___fn___))
                 (each [_ v (iter t)]
                   (when (___fn___ v) (set count (+ count 1)))))
      (do
        (when (lume.isarray t)
          (let [___antifnl_rtn_1___ (length t)]
            (lua "return ___antifnl_rtn_1___")))
        (each [_ (iter t)] (set count (+ count 1)))))
  count)
(fn lume.slice [t i j]
  (set-forcibly! i (or (and i (absindex (length t) i)) 1))
  (set-forcibly! j (or (and j (absindex (length t) j)) (length t)))
  (local rtn {})
  (for [x (or (and (< i 1) 1) i) (or (and (> j (length t)) (length t)) j)]
    (tset rtn (+ (length rtn) 1) (. t x)))
  rtn)
(fn lume.first [t n]
  (when (not n)
    (let [___antifnl_rtn_1___ (. t 1)] (lua "return ___antifnl_rtn_1___")))
  (lume.slice t 1 n))
(fn lume.last [t n]
  (when (not n)
    (let [___antifnl_rtn_1___ (. t (length t))]
      (lua "return ___antifnl_rtn_1___")))
  (lume.slice t (- n) (- 1)))
(fn lume.invert [t]
  (let [rtn {}]
    (each [k v (pairs t)] (tset rtn v k))
    rtn))
(fn lume.pick [t ...]
  (let [rtn {}]
    (for [i 1 (select "#" ...)] (local k (select i ...)) (tset rtn k (. t k)))
    rtn))
(fn lume.keys [t]
  (let [rtn {}
        iter (getiter t)]
    (each [k (iter t)]
      (tset rtn (+ (length rtn) 1) k))
    rtn))
(fn lume.clone [t]
  (let [rtn {}]
    (each [k v (pairs t)] (tset rtn k v))
    rtn))
(fn lume.fn [___fn___ ...]
  (assert (iscallable ___fn___) "expected a function as the first argument")
  (local args [...])
  (fn [...]
    (let [a (lume.concat args [...])]
      (___fn___ (unpack a)))))
(fn lume.once [___fn___ ...]
  (let [f (lume.fn ___fn___ ...)]
    (var done false)
    (fn [...] (when done (lua "return ")) (set done true) (f ...))))
(local memoize-fnkey {})
(local memoize-nil {})
(fn lume.memoize [___fn___]
  (let [cache {}]
    (fn [...]
      (var c cache)
      (for [i 1 (select "#" ...)]
        (local a (or (select i ...) memoize-nil))
        (tset c a (or (. c a) {}))
        (set c (. c a)))
      (tset c memoize-fnkey (or (. c memoize-fnkey) [(___fn___ ...)]))
      (unpack (. c memoize-fnkey)))))
(fn lume.combine [...]
  (let [n (select "#" ...)]
    (when (= n 0) (lua "return noop"))
    (when (= n 1) (local ___fn___ (select 1 ...))
      (when (not ___fn___) (lua "return noop"))
      (assert (iscallable ___fn___) "expected a function or nil")
      (lua "return ___fn___"))
    (local funcs {})
    (for [i 1 n]
      (local ___fn___ (select i ...))
      (when (not= ___fn___ nil)
        (assert (iscallable ___fn___) "expected a function or nil")
        (tset funcs (+ (length funcs) 1) ___fn___)))
    (fn [...]
      (each [_ f (ipairs funcs)] (f ...)))))
(fn lume.call [___fn___ ...] (when ___fn___ (___fn___ ...)))
(fn lume.time [___fn___ ...]
  (let [start (os.clock)
        rtn [(___fn___ ...)]]
    (values (- (os.clock) start) (unpack rtn))))
(local lambda-cache {})
(fn lume.lambda [str]
  (when (not (. lambda-cache str))
    (local (args body) (str:match "^([%w,_ ]-)%->(.-)$"))
    (assert (and args body) "bad string lambda")
    (local s (.. "return function(" args ")\nreturn " body "\nend"))
    (tset lambda-cache str (lume.dostring s)))
  (. lambda-cache str))
(var serialize nil)
(local serialize-map
       {:boolean tostring
        :nil tostring
        :number (fn [v]
                  (if (not= v v) (lua "return \"0/0\"")
                      (= v (/ 1 0)) (lua "return \"1/0\"")
                      (= v (/ (- 1) 0)) (lua "return \"-1/0\""))
                  (tostring v))
        :string (fn [v] (string.format "%q" v))
        :table (fn [t stk]
                 (set-forcibly! stk (or stk {}))
                 (when (. stk t) (error "circular reference"))
                 (local rtn {})
                 (tset stk t true)
                 (each [k v (pairs t)]
                   (tset rtn (+ (length rtn) 1)
                         (.. "[" (serialize k stk) "]=" (serialize v stk))))
                 (tset stk t nil)
                 (.. "{" (table.concat rtn ",") "}"))})
(setmetatable serialize-map
              {:__index (fn [_ k] (error (.. "unsupported serialize type: " k)))})
(set serialize (fn [x stk]
                 ((. serialize-map (type x)) x stk)))
(fn lume.serialize [x] (serialize x))
(fn lume.deserialize [str] (lume.dostring (.. "return " str)))
(fn lume.split [str sep]
  (if (not sep) (lume.array (str:gmatch "([%S]+)"))
      (do
        (assert (not= sep "") "empty separator")
        (local psep (patternescape sep))
        (lume.array (: (.. str sep) :gmatch (.. "(.-)(" psep ")"))))))
(fn lume.trim [str chars]
  (when (not chars)
    (let [___antifnl_rtn_1___ (str:match "^[%s]*(.-)[%s]*$")]
      (lua "return ___antifnl_rtn_1___")))
  (set-forcibly! chars (patternescape chars))
  (str:match (.. "^[" chars "]*(.-)[" chars "]*$")))
(fn lume.wordwrap [str limit]
  (set-forcibly! limit (or limit 72))
  (var check nil)
  (if (= (type limit) :number) (set check (fn [s] (>= (length s) limit)))
      (set check limit))
  (local rtn {})
  (var line "")
  (each [word spaces (str:gmatch "(%S+)(%s*)")]
    (local s (.. line word))
    (if (check s) (do
                    (table.insert rtn (.. line "\n"))
                    (set line word)) (set line s))
    (each [c (spaces:gmatch ".")]
      (if (= c "\n") (do
                       (table.insert rtn (.. line "\n"))
                       (set line ""))
          (set line (.. line c)))))
  (table.insert rtn line)
  (table.concat rtn))
(fn lume.format [str vars]
  (when (not vars) (lua "return str"))

  (fn f [x]
    (tostring (or (or (. vars x) (. vars (tonumber x))) (.. "{" x "}"))))

  (str:gsub "{(.-)}" f))
(fn lume.trace [...]
  (let [info (debug.getinfo 2 :Sl)
        t [(.. info.short_src ":" info.currentline ":")]]
    (for [i 1 (select "#" ...)]
      (var x (select i ...))
      (when (= (type x) :number)
        (set x (string.format "%g" (lume.round x 0.01))))
      (tset t (+ (length t) 1) (tostring x)))
    (print (table.concat t " "))))
(fn lume.dostring [str]
  ((assert ((or loadstring load) str))))
(fn lume.uuid []
  (fn ___fn___ [x]
    (var r (- (math.random 16) 1))
    (set r (or (and (= x :x) (+ r 1)) (+ (% r 4) 9)))
    (: :0123456789abcdef :sub r r))

  (: :xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx :gsub "[xy]" ___fn___))
(fn lume.hotswap [modname]
  (let [oldglobal (lume.clone _G)
        updated {}]
    (fn update [old new]
      (when (. updated old) (lua "return "))
      (tset updated old true)
      (local (oldmt newmt) (values (getmetatable old) (getmetatable new)))
      (when (and oldmt newmt) (update oldmt newmt))
      (each [k v (pairs new)]
        (if (= (type v) :table) (update (. old k) v) (tset old k v))))

    (var err nil)

    (fn onerror [e]
      (each [k (pairs _G)] (tset _G k (. oldglobal k)))
      (set err (lume.trim e)))

    (var (ok oldmod) (pcall require modname))
    (set oldmod (or (and ok oldmod) nil))
    (xpcall (fn []
              (tset package.loaded modname nil)
              (local newmod (require modname))
              (when (= (type oldmod) :table) (update oldmod newmod))
              (each [k v (pairs oldglobal)]
                (when (and (not= v (. _G k)) (= (type v) :table))
                  (update v (. _G k))
                  (tset _G k v)))) onerror)
    (tset package.loaded modname oldmod)
    (when err (lua "return nil, err"))
    oldmod))
(fn ripairs-iter [t i] (set-forcibly! i (- i 1)) (local v (. t i))
  (when (not= v nil) (values i v)))
(fn lume.ripairs [t]
  (values ripairs-iter t (+ (length t) 1)))
(fn lume.color [str mul]
  (set-forcibly! mul (or mul 1))
  (var (r g b a) nil)
  (set (r g b) (str:match "#(%x%x)(%x%x)(%x%x)"))
  (if r (do
          (set r (/ (tonumber r 16) 255))
          (set g (/ (tonumber g 16) 255))
          (set b (/ (tonumber b 16) 255))
          (set a 1)) (str:match "rgba?%s*%([%d%s%.,]+%)")
      (let [f (str:gmatch "[%d.]+")]
        (set r (/ (or (f) 0) 255))
        (set g (/ (or (f) 0) 255))
        (set b (/ (or (f) 0) 255))
        (set a (or (f) 1)))
      (error (: "bad color string '%s'" :format str)))
  (values (* r mul) (* g mul) (* b mul) (* a mul)))
(local chain-mt {})
(set chain-mt.__index (lume.map (lume.filter lume iscallable true)
                                (fn [___fn___]
                                  (fn [self ...]
                                    (set self._value (___fn___ self._value ...))
                                    self))))
(fn chain-mt.__index.result [x] x._value)
(fn lume.chain [value] (setmetatable {:_value value} chain-mt))
(setmetatable lume {:__call (fn [_ ...] (lume.chain ...))})
lume	