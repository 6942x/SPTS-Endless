if getgenv().cLTR_State then
    local a = getgenv().cLTR_State
    for _, b in pairs(a.cn) do pcall(function() b:Disconnect() end) end
    for _, b in pairs(a.tw) do pcall(function() b:Cancel() end) end
    for _, b in pairs(a.th) do
        if typeof(b) == "thread" and coroutine.status(b) ~= "dead" then pcall(task.cancel, b) end
    end
    if a.gui then pcall(function() a.gui:Destroy() end) end
end

getgenv().cLTR_State = {cn = {}, tw = {}, th = {}, gui = nil}
local w = getgenv().cLTR_State

local w1 = game:GetService("Players")
local w2 = game:GetService("UserInputService")
local w3 = game:GetService("TweenService")
local w4 = game:GetService("HttpService")

local w5 = w1.LocalPlayer
if not w5 then return end
local w6 = w5:WaitForChild("PlayerGui")

local w7 = UDim2.new
local w8 = Color3.fromRGB
local w9 = Instance.new
local w10 = Enum.Font.SourceSansBold

local w11 = {
    bg = w8(45, 45, 45),
    btn = w8(60, 60, 60),
    item = w8(70, 70, 70),
    hov = w8(80, 80, 80),
    prs = w8(90, 90, 90),
    inp = w8(110, 110, 110),
    drop = w8(50, 50, 50),
    dim = w8(150, 150, 150),
    sbr = w8(190, 190, 190),
    red = w8(180, 0, 0),
    redH = w8(220, 30, 30),
    cy = w8(0, 168, 255),
    cyH = w8(64, 196, 255),
    pu = w8(168, 85, 247),
    grn = w8(0, 200, 150),
    vio = w8(124, 77, 255),
    org = w8(245, 158, 11),
    orgH = w8(251, 191, 36),
    puH = w8(187, 134, 252),
    wht = w8(255, 255, 255)
}

local function w12(a, b)
    local c = a:Connect(b)
    w.cn[#w.cn + 1] = c
    return c
end

local function w13(a, b, c)
    if w.tw[a] then w.tw[a]:Cancel() end
    local d = w3:Create(a, b, c)
    w.tw[a] = d
    d:Play()
    return d
end

local w14 = {
    {"k", 1e3}, {"M", 1e6}, {"B", 1e9}, {"T", 1e12},
    {"Qa", 1e15}, {"Qi", 1e18}, {"Sx", 1e21}, {"Sp", 1e24},
    {"Oc", 1e27}, {"No", 1e30}, {"Dc", 1e33}, {"Ud", 1e36},
    {"Dd", 1e39}, {"Td", 1e42}
}
w14.m = {million = 1e6, billion = 1e9, trillion = 1e12}
for _, a in ipairs(w14) do
    w14.m[a[1]] = a[2]
    w14.m[string.lower(a[1])] = a[2]
end

local function w15(a)
    a = tonumber(a)
    if not a then return "0" end
    local b = math.abs(a)
    for c = #w14, 1, -1 do
        local d = w14[c]
        if b >= d[2] then
            return (string.format("%.2f", a / d[2]):gsub("%.?0+$", "")) .. d[1]
        end
    end
    return tostring(a)
end

local function w16(a)
    a = tostring(a):gsub("[,%s]", "")
    a = a:gsub("^[xX]", "")
    local b = tonumber(a)
    if b then return b end
    local c, d = string.match(a, "([%d%.]+)%s*(%a+)")
    if c then return tonumber(c) * (w14.m[string.lower(d)] or 1) end
    return nil
end

local function w17(a)
    a = tonumber(a)
    if not a or a ~= a then return "0d 0h 0m" end
    if a == math.huge or a <= -1e18 then return "Never" end
    if a < 0 then a = 0 end
    local b = math.floor(a / 8.64e4)
    if b >= 1e6 then return w15(b) .. " days" end
    local c = math.floor((a % 8.64e4) / 3600)
    local d = math.floor((a % 3600) / 60)
    return string.format("%.0fd %.0fh %.0fm", b, c, d)
end

local function w18(a, b)
    return a .. " -- " .. w15(w16(b) or 0)
end

local w19 = {
    FS = {
        {name = "TrainingArea_2", req = "0e0", multi = "x1e1"},
        {name = "TrainingArea_3", req = "1e6", multi = "x1e2"},
        {name = "StarFSTraining1", req = "1e9", multi = "x2e3"},
        {name = "StarFSTraining2", req = "1e11", multi = "x4e4"},
        {name = "StarFSTraining3", req = "1e13", multi = "x8e5"},
        {name = "AFK_FS_1", req = "1e15", multi = "x6e6"},
        {name = "AFK_FS_2", req = "1e17", multi = "x3e8"},
        {name = "AFK_FS_3", req = "1.5e19", multi = "x2.1e10"},
        {name = "AFK_FS_4", req = "2.5e21", multi = "x2.308e12"},
        {name = "AFK_FS_5", req = "1e24", multi = "x3.475e14"},
        {name = "AFK_FS_6", req = "5e26", multi = "x5.2e16"},
        {name = "AFK_FS_7", req = "2.5e29", multi = "x7.8e18"},
        {name = "AFK_FS_8", req = "1.5e32", multi = "?"},
        {name = "AFK_FS_9", req = "5.5e34", multi = "?"},
        {name = "AFK_FS_10", req = "3e37", multi = "?"},
        {name = "AFK_FS_11", req = "1.1e40", multi = "?"}
    },
    BT = {
        {name = "Water", req = "5e0", min = "5e0", multi = "x5e0"},
        {name = "FireBathTouchPart", req = "5e2", min = "5e2", multi = "x1e1"},
        {name = "IcePart", req = "5e3", min = "5e3", multi = "x2e1"},
        {name = "TornadoTouchPart", req = "5e4", min = "5e4", multi = "x5e1"},
        {name = "LavaPart", req = "5e5", min = "5e5", multi = "x1e2"},
        {name = "GreenFirePart", req = "5e7", min = "5e7", multi = "x2e3"},
        {name = "AcidPart", req = "5e9", min = "5e9", multi = "x4e4"},
        {name = "LavaPart2", req = "5e11", min = "5e11", multi = "x8e5"},
        {name = "AFK_BT_1", req = "7.383e12", min = "7.383e12", multi = "x6e6"},
        {name = "AFK_BT_2", req = "6.55e14", min = "6.55e14", multi = "x1.8e8"},
        {name = "AFK_BT_3", req = "6.66e16", min = "6.66e16", multi = "x5.5e9"},
        {name = "AFK_BT_4", req = "5.1e18", min = "5.1e18", multi = "x1.625e11"},
        {name = "AFK_BT_5", req = "4.6e20", min = "4.6e20", multi = "x5e12"},
        {name = "AFK_BT_6", req = "4.005e22", min = "4.005e22", multi = "x1.5e14"},
        {name = "AFK_BT_7", req = "3.55e24", min = "3.55e24", multi = "x4.5e15"},
        {name = "AFK_BT_8", req = "3.14e26", min = "3.14e26", multi = "x1.312e17"},
        {name = "AFK_BT_9", req = "2.778e28", min = "2.778e28", multi = "x3.925e18"},
        {name = "AFK_BT_10", req = "2.473e30", min = "2.473e30", multi = "x1.18e20"},
        {name = "AFK_BT_11", req = "2.175e32", min = "2.175e32", multi = "x3.55e21"},
        {name = "AFK_BT_12", req = "1.95e34", min = "1.95e34", multi = "x1.062e23"},
        {name = "AFK_BT_13", req = "1.7e36", min = "1.7e36", multi = "x3.2e24"},
        {name = "AFK_BT_14", req = "1.55e38", min = "1.55e38", multi = "x9.574e25"},
        {name = "AFK_BT_15", req = "1.356e40", min = "1.356e40", multi = "x2.5e27"}
    },
    MS = {
        {name = "AFK_MS_1", req = "1e14", multi = "x1.3e6"},
        {name = "AFK_MS_2", req = "2.22e15", multi = "x1.69e7"},
        {name = "AFK_MS_3", req = "6e16", multi = "x2.197e8"},
        {name = "AFK_MS_4", req = "1.5e18", multi = "x2.85e9"},
        {name = "AFK_MS_5", req = "4e19", multi = "x3.72e10"},
        {name = "AFK_MS_6", req = "1e21", multi = "x4.824e11"},
        {name = "AFK_MS_7", req = "2.5e22", multi = "x6.274e12"},
        {name = "AFK_MS_8", req = "7.5e23", multi = "x8.15e13"},
        {name = "AFK_MS_9", req = "1.55e25", multi = "x2.12e15"},
        {name = "AFK_MS_10", req = "4e26", multi = "x1.377e16"},
        {name = "AFK_MS_11", req = "1e28", multi = "x1.792e17"}
    },
    JF = {
        {name = "AFK_JF_1", req = "1e14", multi = "x1.7e6"},
        {name = "AFK_JF_2", req = "5e15", multi = "x3.05e7"},
        {name = "AFK_JF_3", req = "1.5e17", multi = "x5.5e8"},
        {name = "AFK_JF_4", req = "5e18", multi = "x9.92e9"},
        {name = "AFK_JF_5", req = "2e20", multi = "?"},
        {name = "AFK_JF_6", req = "1e22", multi = "?"},
        {name = "AFK_JF_7", req = "3e23", multi = "?"},
        {name = "AFK_JF_8", req = "1.5e25", multi = "?"},
        {name = "AFK_JF_9", req = "4e26", multi = "?"}
    },
    PP = {
        {name = "PPTrainingPart1", req = "1e6", multi = "x1e2"},
        {name = "PPTrainingPart2", req = "1e9", multi = "x1e4"},
        {name = "PPTrainingPart3", req = "1e12", multi = "x1e6"},
        {name = "PPTrainingPart4", req = "1e15", multi = "x1e8"},
        {name = "AFK_PP_1", req = "3.33e17", multi = "x2.5e9"},
        {name = "AFK_PP_2", req = "1.11e20", multi = "x2.5e11"},
        {name = "AFK_PP_3", req = "3.33e22", multi = "x2.5e13"},
        {name = "AFK_PP_4", req = "1.11e25", multi = "x2.5e15"},
        {name = "AFK_PP_5", req = "3.36e27", multi = "x2.5e17"},
        {name = "AFK_PP_6", req = "1.11e30", multi = "x2.5e19"},
        {name = "AFK_PP_7", req = "4.44e32", multi = "x2.5e21"},
        {name = "AFK_PP_8", req = "1.11e35", multi = "?"},
        {name = "AFK_PP_9", req = "5.55e37", multi = "?"},
        {name = "AFK_PP_10", req = "2.22e40", multi = "?"}
    }
}

local w20 = {"FS", "BT", "MS", "JF", "PP"}

local w21 = {FS = "1e15", BT = "7.383e12", PP = "3.33e17"}
local w22 = {}
for a, b in pairs(w21) do
    for c, d in ipairs(w19[a]) do
        if d.req == b then
            w22[a] = c
            break
        end
    end
end

local function w91(a, b)
    local c = 1
    for d, e in ipairs(w19[a]) do
        local f = w16(e.req)
        if f and f <= b then c = d else break end
    end
    return c
end

local wW = {
    {name = "1e2 LB", ms = "1e2", jf = "5e3", mm = "x2", jm = "x2"},
    {name = "1e0 TON", ms = "5e3", jf = "2e5", mm = "x5", jm = "x5"},
    {name = "1e1 TON", ms = "5e5", jf = "2e6", mm = "x10", jm = "x10"},
    {name = "1e2 TON", ms = "1e7", jf = "1e7", mm = "x20", jm = "x20"},
    {name = "1e3 TON", ms = "1e8", jf = "2e8", mm = "x150", jm = "x150"},
    {name = "1e4 TON", ms = "1e9", jf = "1e9", mm = "x750", jm = "x750"},
    {name = "1e5 TON", ms = "1e10", jf = "1e10", mm = "x3.5K", jm = "x3.5K"},
    {name = "1e6 TON", ms = "1e11", jf = "1e11", mm = "x18K", jm = "x18K"},
    {name = "1e7 TON", ms = "1e12", jf = "1e12", mm = "x90K", jm = "x90K"},
    {name = "1e9 TON", ms = "1e13", jf = "1e13", mm = "x400K", jm = "x400K"},
    {name = "1e11 TON", ms = "2.56e28", jf = "1.54e28", mm = "x9.32 Qi", jm = "x1.35 Qi"},
    {name = "1e13 TON", ms = "0e0", jf = "6e26", jm = "x21.9 Qi"},
    {name = "1e15 TON", ms = "1.68e32", jf = "2.221e31", mm = "x1.569 Sx", jm = "x436.9 Qi"},
    {name = "1e17 TON", ms = "4.288e33", jf = "8.48e31", mm = "x20.38 Sx", jm = "x7.869 Sx"},
    {name = "1e19 TON", ms = "1.082e34", jf = "3.226e33", mm = "x264.7 Sx", jm = "x141.9 Sx"},
    {name = "1e21 TON", ms = "2.823e36", jf = "1.229e36", mm = "x3.437 Sp", jm = "x2.552 Sp"},
    {name = "1e23 TON", ms = "7.02e37", jf = "4.683e37", mm = "x44.63 Sp", jm = "x45.89 Sp"},
    {name = "1e25 TON", ms = "1.852e39", jf = "1.785e39", mm = "x579.6 Sp", jm = "x825.3 Sp"},
    {name = "1e28 TON", ms = "4.744e39", jf = "6.8e39", mm = "x7.527 Oc", jm = "x14.84 Oc"}
}
local wWst = {MS = true, JF = true}

local function wWn(a)
    local b = string.match(a, "^(%S+)")
    local c = b and w16(b)
    if c then
        return a .. " - " .. w15(c) .. string.sub(a, #b + 1)
    end
    return a
end

local function wW91(a, b)
    local c = nil
    for d, e in ipairs(wW) do
        local f = w16(e.ms)
        local g = w16(e.jf)
        local h = f == 0 or (a ~= nil and f ~= nil and f <= a)
        local i = g == 0 or (b ~= nil and g ~= nil and g <= b)
        if h and i then
            c = d
        end
    end
    return c
end

local wSm = {}

local function wSmg(a)
    if wSm[a] then
        return wSm[a]
    end
    local b = {}
    if wWst[a] then
        local c = w16(a == "MS" and wW[1].ms or wW[1].jf)
        if c and c > 0 then
            b[#b + 1] = {nm = "No Weight", mu = "x1", bo = false, th = 0}
        end
        for d, e in ipairs(wW) do
            local f = w16(a == "MS" and e.ms or e.jf)
            if f and f > 0 then
                local g = a == "MS" and e.mm or e.jm
                b[#b + 1] = {nm = e.name, dn = wWn(e.name), mu = g or "?", bo = false, th = f}
            end
        end
    end
    for d, e in ipairs(w19[a]) do
        b[#b + 1] = {nm = e.name, mu = e.multi, bo = not w22[a] or d >= w22[a], th = w16(a == "BT" and e.min or e.req)}
    end
    table.sort(b, function(c, d) return (c.th or 0) < (d.th or 0) end)
    wSm[a] = b
    return b
end

local function wSm91(a, b)
    local c = wSmg(a)
    local d = nil
    for e = 1, #c do
        local f = c[e].th
        if f and f <= b then
            d = e
        end
    end
    return d
end

local w23 = "TrainingCalc/" .. w5.Name .. ".json"
local w24 = {
    key = "G", pos = nil, icon = nil, pw = "", cat = nil, view = "Home",
    md = {}, sp = {}, gn = {}, st = {}, mem = {},
    tok = {cur = {}, oth = {}},
    ml = {cur = {}, oth = {}, ov = {}, tg = nil, tm = nil},
    msg = {FS = "", BT = "", MS = "", JF = "", PP = "", Tokens = "", ML = ""}
}
for _, a in ipairs(w20) do
    w24.md[a] = false
    w24.sp[a] = false
    w24.gn[a] = false
    w24.st[a] = false
    w24.mem[a] = {cur = {}, oth = {}}
end
w24.md.TK = false
w24.md.ML = false

local function wA(a)
    local b = w24.mem[a]
    if not b then
        b = {cur = {}, oth = {}}
        w24.mem[a] = b
    end
    return b[w24.md[a] and "cur" or "oth"]
end

local w26, w29, w34, w109
local w84, w85 = false, false
local w110 = {}
local w27 = os.clock()

local function w25()
    if not readfile then return end
    local a, b = pcall(function()
        if isfile and not isfile(w23) then return end
        return readfile(w23)
    end)
    if not a or not b then return end
    local c, d = pcall(function() return w4:JSONDecode(b) end)
    if not c or type(d) ~= "table" then return end

    local function e(f, g, h)
        local i = type(g) == "table" and g or {}
        local j = type(h) == "table" and h or {}
        local k = i[f]
        if k == nil then k = j[f] end
        return k
    end

    local function f(g, h)
        local i = w24.mem[g]
        local j = type(h.cur) == "table" and h.cur or nil
        local k = type(h.oth) == "table" and h.oth or nil
        i.cur.pw = tostring(e("pw", j, h) or e("power", j, h) or "")
        i.oth.pw = tostring(e("pw", k, h) or e("power", k, h) or "")
        i.cur.ob = tostring(e("ob", j, h) or e("pobj", j, h) or "")
        i.oth.ob = tostring(e("ob", k, h) or e("pobj", k, h) or "")
        local l = tonumber(e("ar", j, h) or e("area", j, h))
        local m = tonumber(e("ar", k, h) or e("area", k, h))
        i.cur.ar = l and math.floor(l) or nil
        i.oth.ar = m and math.floor(m) or nil
        local n = e("mu", j, h) or e("mult", j, h)
        local o = e("mu", k, h) or e("mult", k, h)
        i.cur.mu = n ~= nil and tostring(n) or nil
        i.oth.mu = o ~= nil and tostring(o) or nil
        i.cur.mv = tonumber(e("mv", j, h) or e("val", j, h))
        i.oth.mv = tonumber(e("mv", k, h) or e("val", k, h))
        local p = tonumber(e("wt", j, h))
        local q = tonumber(e("wt", k, h))
        i.cur.wt = p and math.floor(p) or nil
        i.oth.wt = q and math.floor(q) or nil
    end

    local function g(h)
        local i = type(h.cur) == "table" and h.cur or nil
        local j = type(h.oth) == "table" and h.oth or nil
        if not i and not j then
            local k = {tokens = h.tokens, tpm = h.tpm}
            if h.mode == "cur" then i = k else j = k end
        end
        local l = {cur = i, oth = j}
        for m, n in pairs(l) do
            local o = w24.tok[m]
            o.tk = tostring(e("tk", n, h) or e("tokens", n, h) or "")
            o.tp = tostring(e("tp", n, h) or e("tpm", n, h) or "")
            o.ob = tostring(e("ob", n, h) or e("obj", n, h) or "")
            o.to = tostring(e("to", n, h) or e("tpo", n, h) or "")
            o.sp = tostring(e("sp", n, h) or e("spent", n, h) or "")
        end
    end

    w24.key = tostring(d.key or "G")
    if type(d.pos) == "table" and type(d.pos.X) == "number" and type(d.pos.Y) == "number" then
        w24.pos = {X = d.pos.X, Y = d.pos.Y}
    end
    if type(d.icon) == "table" and type(d.icon.X) == "number" and type(d.icon.Y) == "number" then
        w24.icon = {X = d.icon.X, Y = d.icon.Y}
    end
    w24.pw = tostring(d.pw or d.power or "")
    if d.view == "Farming" or d.view == "Tokens" or d.view == "Multipliers" then
        w24.view = d.view
    end
    if w19[d.cat] then
        w24.cat = d.cat
    end
    local h = d.fmode == "cur"
    local i = d.speed == true
    local j = d.train == true
    local l = d.stay == true
    for _, k in ipairs(w20) do
        if type(d.md) == "table" then
            w24.md[k] = d.md[k] == true or (d.md[k] == nil and h)
        else
            w24.md[k] = h
        end
        if type(d.sp) == "table" then
            w24.sp[k] = d.sp[k] == true or (d.sp[k] == nil and i)
        else
            w24.sp[k] = i
        end
        if type(d.gn) == "table" then
            w24.gn[k] = d.gn[k] == true or (d.gn[k] == nil and j)
        else
            w24.gn[k] = j
        end
        if type(d.st) == "table" then
            w24.st[k] = d.st[k] == true or (d.st[k] == nil and l)
        else
            w24.st[k] = l
        end
        if type(d.mem) == "table" and type(d.mem[k]) == "table" then
            f(k, d.mem[k])
        end
    end
    if type(d.md) == "table" then
        w24.md.TK = d.md.TK == true or (d.md.TK == nil and h)
    else
        w24.md.TK = h
    end
    if type(d.md) == "table" then
        w24.md.ML = d.md.ML == true or (d.md.ML == nil and h)
    else
        w24.md.ML = h
    end
    if type(d.tok) == "table" then
        g(d.tok)
    end
    if type(d.ml) == "table" then
        for _, k in ipairs(w20) do
            local l = (type(d.ml.cur) == "table" and d.ml.cur[k]) or nil
            local m = (type(d.ml.oth) == "table" and d.ml.oth[k]) or nil
            if l ~= nil then w24.ml.cur[k] = tostring(l) end
            if m ~= nil then w24.ml.oth[k] = tostring(m) end
        end
        if type(d.ml.ov) == "table" then
            for k, l in pairs(d.ml.ov) do
                if l == true then w24.ml.ov[k] = true end
            end
        end
        local n = tonumber(d.ml.tg)
        if n then w24.ml.tg = n end
        if d.ml.tm ~= nil then w24.ml.tm = tostring(d.ml.tm) end
    end
    if type(d.msg) == "table" then
        for k, l in pairs(d.msg) do
            local m = tostring(l)
            if w19[k] or k == "Tokens" or k == "ML" then
                w24.msg[k] = m
            elseif k == "Farming" and m ~= "" and w19[w24.cat] then
                w24.msg[w24.cat] = m
            end
        end
    end
end

w26 = function(a)
    if not writefile then return end
    if not isfolder or not isfolder("TrainingCalc") then
        pcall(function() makefolder("TrainingCalc") end)
    end
    if not a and os.clock() - w27 >= 5 then
        if w29 and w29.Visible and not w85 then
            w24.pos = {X = w29.Position.X.Offset, Y = w29.Position.Y.Offset}
        end
        if w34 then
            w24.icon = {X = w34.Position.X.Offset, Y = w34.Position.Y.Offset}
        end
    end
    pcall(function() writefile(w23, w4:JSONEncode(w24)) end)
end

w25()

local function w36(a, b)
    local c, d, e, f = false, false, nil, nil
    w12(a.InputBegan, function(g)
        if g.UserInputType == Enum.UserInputType.MouseButton1 or g.UserInputType == Enum.UserInputType.Touch then
            c, d, e, f = true, false, g.Position, a.Position
        end
    end)
    w12(w2.InputChanged, function(g)
        if c and (g.UserInputType == Enum.UserInputType.MouseMovement or g.UserInputType == Enum.UserInputType.Touch) then
            local h = g.Position - e
            if math.abs(h.X) > 4 or math.abs(h.Y) > 4 then d = true end
            a.Position = w7(f.X.Scale, f.X.Offset + h.X, f.Y.Scale, f.Y.Offset + h.Y)
        end
    end)
    w12(w2.InputEnded, function(g)
        if c and (g.UserInputType == Enum.UserInputType.MouseButton1 or g.UserInputType == Enum.UserInputType.Touch) then
            c = false
            if not d and b then b() end
            w26()
        end
    end)
end

local wH = 630

local function w37()
    if w84 then return end
    w84 = true
    task.spawn(function()
        if w29.Visible then
            w85 = true
            w13(w29, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = w7(w29.Position.X.Scale, w29.Position.X.Offset, w29.Position.Y.Scale, w29.Position.Y.Offset + 20),
                BackgroundTransparency = 1
            })
            task.wait(0.2)
            w29.Visible = false
            w85 = false
            w34.Visible = true
            w34.Size = w7(0, 0, 0, 0)
            w34.BackgroundTransparency = 1
            w13(w34, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = w7(0, 50, 0, 50),
                BackgroundTransparency = 0
            })
            task.wait(0.3)
        else
            w34.Visible = false
            w29.Visible = true
            w29.Size = w7(0, 0, 0, 0)
            w29.BackgroundTransparency = 1
            w13(w29, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = w7(0, 480, 0, wH),
                BackgroundTransparency = 0
            })
            task.wait(0.3)
        end
        w84 = false
        w26()
    end)
end

local function w38(a, b, c)
    local d = a.Size
    local e, f = false, false
    local function g()
        local h = e and UDim2.new(d.X.Scale, d.X.Offset - 6, d.Y.Scale, d.Y.Offset - 6) or d
        w13(a, TweenInfo.new(e and 0.1 or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = h,
            BackgroundColor3 = e and c or f and c or b
        })
    end
    w12(a.MouseEnter, function() f = true g() end)
    w12(a.MouseLeave, function() f, e = false, false g() end)
    w12(a.MouseButton1Down, function() e = true g() end)
    w12(a.MouseButton1Up, function() e = false g() end)
end

local function w39(a, b, c)
    local d = w9("TextButton", a)
    d.Text = b
    d.Size = w7(1, 0, 0, 32)
    d.BackgroundColor3 = w11.item
    d.TextColor3 = w11.wht
    d.Font = w10
    d.TextSize = 18
    d.AutoButtonColor = false
    d.ZIndex = 10
    w38(d, w11.item, w11.prs)
    w12(d.MouseButton1Click, function() c(d) end)
    return d
end

local function w40(a, b, c, d)
    local e = w9("TextLabel", a)
    e.Text = b
    e.Size = w7(0, 130, 0, 32)
    e.Position = w7(0, 20, 0, c)
    e.TextColor3 = w11.wht
    e.BackgroundTransparency = 1
    e.Font = w10
    e.TextSize = 18
    e.TextXAlignment = Enum.TextXAlignment.Left

    local f = w9("TextButton", a)
    f.Text = "Select"
    f.Size = w7(0, 310, 0, 32)
    f.Position = w7(0, 150, 0, c)
    f.BackgroundColor3 = w11.btn
    f.TextColor3 = w11.wht
    f.Font = w10
    f.TextSize = 18
    f.AutoButtonColor = false
    w9("UICorner", f).CornerRadius = UDim.new(0, 4)
    w38(f, w11.btn, w11.hov)

    local g = w9("Frame", a)
    g.Size = w7(0, 310, 0, 150)
    g.Position = w7(0, 150, 0, c + 38)
    g.BackgroundColor3 = w11.drop
    g.Visible = false
    g.ZIndex = 10
    w9("UICorner", g).CornerRadius = UDim.new(0, 4)

    local h = w9("ScrollingFrame", g)
    h.Size = w7(1, 0, 1, 0)
    h.BackgroundTransparency = 1
    h.ScrollBarThickness = 4
    h.CanvasSize = w7(0, 0, 0, 0)
    h.AutomaticCanvasSize = Enum.AutomaticSize.Y
    h.ZIndex = 10

    local i = w9("UIListLayout", h)
    i.SortOrder = Enum.SortOrder.LayoutOrder
    i.Padding = UDim.new(0, 2)

    table.insert(d, g)
    w12(f.MouseButton1Click, function()
        for _, j in ipairs(d) do
            j.Visible = j == g and not g.Visible or false
        end
    end)

    return f, g, h, e
end

local w41 = {}

local function wR(a, b, c)
    local d = w9("ScrollingFrame", a)
    d.Size = w7(0, 440, 0, c)
    d.Position = w7(0, 20, 0, b)
    d.BackgroundTransparency = 1
    d.BorderSizePixel = 0
    d.ScrollBarThickness = 6
    d.ScrollBarImageColor3 = w11.sbr
    d.ScrollingDirection = Enum.ScrollingDirection.Y
    d.CanvasSize = w7(0, 0, 0, 0)

    local e = w9("UIPadding", d)
    e.PaddingTop = UDim.new(0, 4)
    e.PaddingBottom = UDim.new(0, 4)
    e.PaddingLeft = UDim.new(0, 4)
    e.PaddingRight = UDim.new(0, 4)

    local f = w9("UIListLayout", d)
    f.SortOrder = Enum.SortOrder.LayoutOrder
    f.Padding = UDim.new(0, 0)

    local g = {}
    local h = function()
        local k = 8
        for _, m in ipairs(g) do
            if m.Visible then
                k = k + m.AbsoluteSize.Y
            end
        end
        if d.CanvasSize.Y.Offset ~= k then
            d.CanvasSize = w7(0, 0, 0, k)
        end
    end
    w110[#w110 + 1] = h

    local i = function(j)
        local k = g[j]
        if not k then
            k = w9("TextLabel", d)
            k.Size = w7(1, 0, 0, 0)
            k.AutomaticSize = Enum.AutomaticSize.Y
            k.BackgroundTransparency = 1
            k.BorderSizePixel = 0
            k.Font = w10
            k.TextSize = 16
            k.LineHeight = 16
            k.TextWrapped = true
            k.TextColor3 = w11.wht
            k.TextXAlignment = Enum.TextXAlignment.Left
            k.TextYAlignment = Enum.TextYAlignment.Top
            k.LayoutOrder = j
            w12(k:GetPropertyChangedSignal("AbsoluteSize"), h)
            g[j] = k
        end
        return k
    end

    local n = function(o)
        local p = 0
        for q in tostring(o or ""):gmatch("[^\n]+") do
            p = p + 1
            local r = i(p)
            r.Text = q
            r.Visible = true
        end
        for q = #g, p + 1, -1 do
            g[q].Visible = false
        end
        h()
        d.CanvasPosition = Vector2.new(0, 0)
    end
    n("")
    return {s = n, f = d}
end

if w6:FindFirstChild("cLTRCalculators") then
    w6.cLTRCalculators:Destroy()
end

local w28 = w9("ScreenGui")
w28.Name = "cLTRCalculators"
w28.ResetOnSpawn = false
w28.Parent = w6
w.gui = w28

w29 = w9("Frame", w28)
w29.Name = "MainFrame"
w29.Size = w7(0, 480, 0, 630)
w29.Position = w24.pos and w7(0, w24.pos.X, 0, w24.pos.Y) or w7(0.5, -240, 0.5, -315)
w29.BackgroundColor3 = w11.bg
w29.BorderSizePixel = 0
w29.Visible = false
w29.Active = true
w9("UICorner", w29).CornerRadius = UDim.new(0, 8)

local w30 = w9("UIScale", w29)
w30.Scale = 1

local w31 = w9("TextLabel", w29)
w31.Text = "cLTR Calculators"
w31.Size = w7(0, 330, 0, 30)
w31.Position = w7(0, 60, 0, 12)
w31.TextColor3 = w11.wht
w31.BackgroundTransparency = 1
w31.Font = w10
w31.TextSize = 18
w31.TextXAlignment = Enum.TextXAlignment.Left

local w32 = w9("TextButton", w29)
w32.Text = "<"
w32.Size = w7(0, 30, 0, 30)
w32.Position = w7(0, 20, 0, 12)
w32.BackgroundColor3 = w11.btn
w32.TextColor3 = w11.wht
w32.Font = w10
w32.TextSize = 18
w32.AutoButtonColor = false
w32.Visible = false
w9("UICorner", w32).CornerRadius = UDim.new(0, 6)
w38(w32, w11.btn, w11.hov)

local w33 = w9("TextButton", w29)
w33.Text = "X"
w33.Size = w7(0, 30, 0, 30)
w33.Position = w7(1, -50, 0, 12)
w33.BackgroundColor3 = w11.red
w33.TextColor3 = w11.wht
w33.Font = w10
w33.TextSize = 18
w33.AutoButtonColor = false
w9("UICorner", w33).CornerRadius = UDim.new(0, 6)
w38(w33, w11.red, w11.redH)

w34 = w9("TextButton", w28)
w34.Name = "ReopenButton"
w34.Size = w7(0, 50, 0, 50)
w34.Position = w24.icon and w7(0, w24.icon.X, 0, w24.icon.Y) or w7(0, 100, 0, 100)
w34.BackgroundColor3 = w11.bg
w34.Text = "cLTR"
w34.TextColor3 = w11.wht
w34.Font = w10
w34.TextSize = 12
w34.Active = true
w34.AutoButtonColor = false
w9("UICorner", w34).CornerRadius = UDim.new(1, 0)
w38(w34, w11.bg, w11.item)

local w35 = w9("UIScale", w34)
w35.Scale = 1

local w43 = w9("Frame", w29)
w43.Name = "HomeView"
w43.Size = w7(1, 0, 1, 0)
w43.BackgroundTransparency = 1

local w44 = w9("TextLabel", w43)
w44.Text = "Select a calculator"
w44.Size = w7(1, -40, 0, 24)
w44.Position = w7(0, 20, 0, 150)
w44.TextColor3 = w11.dim
w44.BackgroundTransparency = 1
w44.Font = w10
w44.TextSize = 18
w44.TextXAlignment = Enum.TextXAlignment.Center

local w45 = w9("TextButton", w43)
w45.Text = "Farming"
w45.Size = w7(0, 140, 0, 100)
w45.Position = w7(0, 20, 0, 210)
w45.BackgroundColor3 = w11.org
w45.TextColor3 = w11.wht
w45.Font = w10
w45.TextSize = 20
w45.AutoButtonColor = false
w9("UICorner", w45).CornerRadius = UDim.new(0, 8)
w38(w45, w11.org, w11.orgH)

local w46 = w9("TextButton", w43)
w46.Text = "Tokens"
w46.Size = w7(0, 140, 0, 100)
w46.Position = w7(0, 170, 0, 210)
w46.BackgroundColor3 = w11.cy
w46.TextColor3 = w11.wht
w46.Font = w10
w46.TextSize = 20
w46.AutoButtonColor = false
w9("UICorner", w46).CornerRadius = UDim.new(0, 8)
w38(w46, w11.cy, w11.cyH)

local w111 = w9("TextButton", w43)
w111.Text = "Multipliers"
w111.Size = w7(0, 140, 0, 100)
w111.Position = w7(0, 320, 0, 210)
w111.BackgroundColor3 = w11.pu
w111.TextColor3 = w11.wht
w111.Font = w10
w111.TextSize = 20
w111.AutoButtonColor = false
w9("UICorner", w111).CornerRadius = UDim.new(0, 8)
w38(w111, w11.pu, w11.puH)

local w47 = w9("Frame", w29)
w47.Name = "FarmingView"
w47.Size = w7(1, 0, 1, 0)
w47.BackgroundTransparency = 1
w47.Visible = false

local w58
local wXl
local w48, w49, w50 = w40(w47, "Category", 56, w41)
local w51, w52, w53 = w40(w47, "Area", 102, w41)
local wW0, wW1, wW2, wW3 = w40(w47, "Weights", 148, w41)
wW0.Visible = false
wW1.Visible = false
wW3.Visible = false
local w54, w55, w56, wML = w40(w47, "Multiplier", 148, w41)

local w57 = w9("TextLabel", w52)
w57.Size = w7(1, 0, 1, 0)
w57.BackgroundTransparency = 1
w57.Text = "No category to show areas."
w57.TextColor3 = w11.dim
w57.Font = w10
w57.TextSize = 16
w57.ZIndex = 10
w53.Visible = false

local w59 = w9("TextLabel", w47)
w59.Text = "Current Power"
w59.Size = w7(0, 130, 0, 32)
w59.Position = w7(0, 20, 0, 194)
w59.TextColor3 = w11.wht
w59.BackgroundTransparency = 1
w59.Font = w10
w59.TextSize = 18
w59.TextXAlignment = Enum.TextXAlignment.Left

local w60 = w9("TextBox", w47)
w60.Text = w24.pw
w60.Size = w7(0, 310, 0, 32)
w60.Position = w7(0, 150, 0, 194)
w60.BackgroundColor3 = w11.inp
w60.TextColor3 = w11.wht
w60.Font = w10
w60.TextSize = 18
w60.ClearTextOnFocus = false
w60.PlaceholderText = "Enter your current power"
w60.PlaceholderColor3 = w11.dim
w9("UICorner", w60).CornerRadius = UDim.new(0, 4)
w12(w60.FocusLost, function()
    if w58 then
        wA(w58).pw = w60.Text
    else
        w24.pw = w60.Text
    end
    if wXl then wXl() end
    w26()
end)

local w87 = w9("TextLabel", w47)
w87.Text = "Power Objective"
w87.Size = w7(0, 130, 0, 32)
w87.Position = w7(0, 20, 0, 240)
w87.TextColor3 = w11.wht
w87.BackgroundTransparency = 1
w87.Font = w10
w87.TextSize = 16
w87.TextXAlignment = Enum.TextXAlignment.Left

local w88 = w9("TextBox", w47)
w88.Text = ""
w88.Size = w7(0, 310, 0, 32)
w88.Position = w7(0, 150, 0, 240)
w88.BackgroundColor3 = w11.inp
w88.TextColor3 = w11.wht
w88.Font = w10
w88.TextSize = 18
w88.ClearTextOnFocus = false
w88.PlaceholderText = "Enter your power objective"
w88.PlaceholderColor3 = w11.dim
w9("UICorner", w88).CornerRadius = UDim.new(0, 4)
w12(w88.FocusLost, function()
    if w58 then
        wA(w58).ob = w88.Text
        w26()
    end
end)

local w61 = w9("TextButton", w47)
w61.Size = w7(0, 210, 0, 32)
w61.Position = w7(0, 20, 0, 332)
w61.BackgroundColor3 = w11.btn
w61.TextColor3 = w11.wht
w61.Font = w10
w61.TextSize = 18
w61.AutoButtonColor = false
w9("UICorner", w61).CornerRadius = UDim.new(0, 4)

local w62 = w9("TextButton", w47)
w62.Size = w7(0, 210, 0, 32)
w62.Position = w7(0, 250, 0, 332)
w62.BackgroundColor3 = w11.btn
w62.TextColor3 = w11.wht
w62.Font = w10
w62.TextSize = 18
w62.AutoButtonColor = false
w9("UICorner", w62).CornerRadius = UDim.new(0, 4)

local w127 = w9("TextButton", w47)
w127.Text = "Stay on this area: OFF"
w127.Size = w7(0, 440, 0, 32)
w127.Position = w7(0, 20, 0, 378)
w127.BackgroundColor3 = w11.btn
w127.TextColor3 = w11.wht
w127.Font = w10
w127.TextSize = 18
w127.AutoButtonColor = false
w9("UICorner", w127).CornerRadius = UDim.new(0, 4)

local function w63()
    if w58 then
        w61.Text = "Speed 2x: " .. (w24.sp[w58] and "ON" or "OFF")
        w61.BackgroundColor3 = w24.sp[w58] and w11.cy or w11.btn
        w62.Text = "Training 2x: " .. (w24.gn[w58] and "ON" or "OFF")
        w62.BackgroundColor3 = w24.gn[w58] and w11.pu or w11.btn
        w127.Text = "Stay on this area: " .. (w24.st[w58] and "ON" or "OFF")
        w127.BackgroundColor3 = w24.st[w58] and w11.red or w11.btn
    else
        w61.Text = "Speed 2x: --"
        w61.BackgroundColor3 = w11.btn
        w62.Text = "Training 2x: --"
        w62.BackgroundColor3 = w11.btn
        w127.Text = "Stay on this area: --"
        w127.BackgroundColor3 = w11.btn
    end
    wXl()
end

w12(w61.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    w24.sp[w58] = not w24.sp[w58]
    w63()
    w26()
end)

w12(w62.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    w24.gn[w58] = not w24.gn[w58]
    w63()
    w26()
end)

w12(w127.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    w24.st[w58] = not w24.st[w58]
    w63()
    w26()
end)

local w64 = w9("TextButton", w47)
w64.Text = "Calculate"
w64.Size = w7(0, 440, 0, 40)
w64.Position = w7(0, 20, 0, 424)
w64.BackgroundColor3 = w11.org
w64.TextColor3 = w11.wht
w64.Font = w10
w64.TextSize = 18
w64.AutoButtonColor = false
w9("UICorner", w64).CornerRadius = UDim.new(0, 4)

local w89 = wR(w47, 470, 150)

local w66 = {}
for a = 0, 37 do
    local b = 2 ^ a
    table.insert(w66, {w15(b), b})
end

for _, a in ipairs(w66) do
    w39(w56, a[1], function()
        if not w58 then
            w109("Select a category first.")
            w55.Visible = false
            return
        end
        w54.Text = a[1]
        w54:SetAttribute("Val", a[2])
        w55.Visible = false
        local b = wA(w58)
        b.mu = a[1]
        b.mv = a[2]
        w26()
    end)
end

local function w97()
    local a = {}
    local b = w6:FindFirstChild("ScreenGui")
    local c = b and b:FindFirstChild("MenuFrame")
    local d = c and c:FindFirstChild("InfoFrame")
    if d then
        for _, e in ipairs(w20) do
            local f = {}
            local g = d:FindFirstChild(e .. "Txt")
            if g and g.Text and g.Text ~= "" then
                local h = string.match(g.Text, ".*:%s*(.-)%s*$") or string.match(g.Text, "([%d%.]+%a+)%s*$")
                if h and w16(h) then f.v = h end
            end
            local i = d:FindFirstChild(e .. "MultiplierTxt")
            if i and i.Text and i.Text ~= "" then
                local j = w16(i.Text)
                if j then f.m = j end
            end
            if f.v or f.m then a[e] = f end
        end
    end
    return a
end

local function wB(a, b)
    local c = w19[a] and w19[a][b]
    if not c then return end
    w51.Text = w18(c.name, c.req)
    w51:SetAttribute("Mult", c.multi)
    w51:SetAttribute("Min", c.min)
    w51:SetAttribute("Idx", b)
    w51:SetAttribute("Boost", not w22[a] or b >= w22[a])
    w52.Visible = false
end

local function wC()
    w51.Text = "Select"
    w51:SetAttribute("Mult", nil)
    w51:SetAttribute("Min", nil)
    w51:SetAttribute("Idx", nil)
    w51:SetAttribute("Boost", nil)
end

local function wWl(a)
    return a.name .. " -- " .. w15(w16(a.ms) or 0) .. " MS / " .. w15(w16(a.jf) or 0) .. " JF"
end

local function wWb(a)
    local b = wW[a]
    if not b then return end
    wW0.Text = wWl(b)
    wW1:SetAttribute("Idx", a)
    wW1.Visible = false
end

local function wWc()
    wW0.Text = "Select"
    wW1:SetAttribute("Idx", nil)
end

local function w101()
    local a = w97()
    local b, c = false, false
    for d, e in pairs(a) do
        local f = w24.mem[d]
        if f then
            f.cur = f.cur or {}
            if e.v then
                if f.cur.pw ~= e.v then c = true end
                f.cur.pw = e.v
                b = true
            end
            if e.m then
                local g = tostring(e.m)
                if f.cur.mu ~= g or f.cur.mv ~= e.m then c = true end
                f.cur.mu = g
                f.cur.mv = e.m
                b = true
            end
            if w24.md[d] and not w24.st[d] then
                local h = w16(f.cur.pw)
                if h and h > 0 then
                    if not (wWst[d] and h < w16(w19[d][1].req)) then
                        local i = w91(d, h)
                        if f.cur.ar ~= i then
                            f.cur.ar = i
                            c = true
                        end
                    end
                end
            end
        end
    end
    for _, d in ipairs(w20) do
        if wWst[d] and w24.md[d] and not w24.st[d] then
            local f = w24.mem[d]
            local g = w16(f.cur.pw)
            if g and g > 0 then
                local h, i
                if d == "MS" then
                    h = g
                    i = a.JF and a.JF.v and w16(a.JF.v) or nil
                else
                    i = g
                    h = a.MS and a.MS.v and w16(a.MS.v) or nil
                end
                local j = wW91(h, i)
                if f.cur.wt ~= j then
                    f.cur.wt = j
                    c = true
                end
            end
        end
    end
    return b, c
end

local function w102(a)
    local b = wA(a)
    if not b then return end
    w54.Text = b.mu or "Select"
    w54:SetAttribute("Val", b.mv)
    w60.Text = (b.pw ~= "" and b.pw) or "0"
    w88.Text = b.ob
    if b.ar and w19[a][b.ar] then
        wB(a, b.ar)
    else
        wC()
    end
    if wWst[a] then
        if b.wt and wW[b.wt] then
            wWb(b.wt)
        else
            wWc()
        end
    end
end

local w98 = w9("TextButton", w47)
w98.Text = "Use Current Stats"
w98.Size = w7(0, 210, 0, 32)
w98.Position = w7(0, 20, 0, 286)
w98.BackgroundColor3 = w11.btn
w98.TextColor3 = w11.wht
w98.Font = w10
w98.TextSize = 18
w98.AutoButtonColor = false
w9("UICorner", w98).CornerRadius = UDim.new(0, 4)

local w99 = w9("TextButton", w47)
w99.Text = "Use Other Stats"
w99.Size = w7(0, 210, 0, 32)
w99.Position = w7(0, 250, 0, 286)
w99.BackgroundColor3 = w11.btn
w99.TextColor3 = w11.wht
w99.Font = w10
w99.TextSize = 18
w99.AutoButtonColor = false
w9("UICorner", w99).CornerRadius = UDim.new(0, 4)

local function w100()
    if not w58 then
        w98.BackgroundColor3 = w11.btn
        w99.BackgroundColor3 = w11.btn
        return
    end
    local a = w24.md[w58]
    w98.BackgroundColor3 = a and w11.grn or w11.btn
    w99.BackgroundColor3 = a and w11.btn or w11.vio
end

w12(w98.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    if w24.md[w58] then return end
    w24.md[w58] = true
    w100()
    local a = w101()
    w102(w58)
    wXl()
    w26()
    if not a then
        w109("Couldn't read your current stats. Put them manually or use Other Stats.")
    end
end)

w12(w99.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    if not w24.md[w58] then return end
    w24.md[w58] = false
    w100()
    w102(w58)
    wXl()
    w26()
end)

wXl = function()
    local a = w58 ~= nil and wWst[w58] == true
    local b = false
    if a then
        local c = w16(w60.Text)
        b = c ~= nil and c > 0 and c < w16(w19[w58][1].req)
    end
    w61.Visible = not b
    w62.Visible = not b
    local c = a and 46 or 0
    local d = 332 + c
    w61.Position = w7(0, 20, 0, d)
    w62.Position = w7(0, 250, 0, d)
    local e = b and 0 or 46
    w127.Position = w7(0, 20, 0, d + e)
    w64.Position = w7(0, 20, 0, d + 46 + e)
    w89.f.Position = w7(0, 20, 0, d + 92 + e)
    w29.Size = w7(0, 480, 0, d + 92 + e + 160)
    wH = d + 92 + e + 160
end

local function wRL()
    local a = w58 ~= nil and wWst[w58] == true
    local b = a and 46 or 0
    wW0.Visible = a
    wW1.Visible = false
    wW3.Visible = a
    w54.Position = w7(0, 150, 0, 148 + b)
    wML.Position = w7(0, 20, 0, 148 + b)
    w55.Position = w7(0, 150, 0, 186 + b)
    w59.Position = w7(0, 20, 0, 194 + b)
    w60.Position = w7(0, 150, 0, 194 + b)
    w87.Position = w7(0, 20, 0, 240 + b)
    w88.Position = w7(0, 150, 0, 240 + b)
    w98.Position = w7(0, 20, 0, 286 + b)
    w99.Position = w7(0, 250, 0, 286 + b)
    wXl()
end

local function w67(a)
    w48.Text = a
    w49.Visible = false
    wC()
    w57.Visible = false
    w53.Visible = true
    w58 = a
    w24.cat = a
    for _, b in ipairs(w53:GetChildren()) do
        if b:IsA("TextButton") then b:Destroy() end
    end
    for c, d in ipairs(w19[a]) do
        local e = w18(d.name, d.req)
        w39(w53, e, function()
            wB(a, c)
            local f = wA(a)
            f.ar = c
            w26()
        end)
    end
    if wWst[a] then
        for _, b in ipairs(wW2:GetChildren()) do
            if b:IsA("TextButton") then b:Destroy() end
        end
        for c, d in ipairs(wW) do
            w39(wW2, wWl(d), function()
                wWb(c)
                local e = wA(a)
                e.wt = c
                w26()
            end)
        end
    end
    w100()
    w63()
    if w24.md[a] then
        w101()
    end
    w102(a)
    wRL()
    w89.s(w24.msg[a] or "")
    w26()
end

for _, a in ipairs(w20) do
    w39(w50, a, function() w67(a) end)
end

if w24.cat and w19[w24.cat] then
    w67(w24.cat)
end

w12(w64.MouseButton1Click, function()
    if not w58 then
        w109("Select a category first.")
        return
    end
    if w24.md[w58] then
        local a = w97()
        local b = a[w58]
        if b then
            local c = wA(w58)
            if b.v then
                c.pw = b.v
                w60.Text = b.v
            end
            if b.m then
                c.mu = tostring(b.m)
                c.mv = b.m
                w54.Text = tostring(b.m)
                w54:SetAttribute("Val", b.m)
            end
            local d = w16(c.pw)
            if d and d > 0 and not w24.st[w58] then
                if wWst[w58] and d < w16(w19[w58][1].req) then
                    local e, f
                    if w58 == "MS" then
                        e = d
                        f = a.JF and a.JF.v and w16(a.JF.v) or nil
                    else
                        f = d
                        e = a.MS and a.MS.v and w16(a.MS.v) or nil
                    end
                    local g = wW91(e, f)
                    if c.wt ~= g then
                        c.wt = g
                        if g then wWb(g) else wWc() end
                    end
                else
                    local e = w91(w58, d)
                    if c.ar ~= e then
                        c.ar = e
                        wB(w58, e)
                    end
                end
            end
            w26()
        end
    end
    local dP = w16(w60.Text)
    local wK
    local wKI = wW1:GetAttribute("Idx") or 0
    if wWst[w58] and (not dP or dP < w16(w19[w58][1].req)) then
        if wKI > 0 and wW[wKI] then
            local g = w58 == "MS" and wW[wKI].mm or wW[wKI].jm
            wK = {name = wW[wKI].name, multi = g or "?"}
        else
            wKI = 0
            wK = {name = "No Weight", multi = "x1"}
        end
    end
    local a = w51:GetAttribute("Mult")
    local b = w51:GetAttribute("Idx")
    if not wK and (not a or not b) then
        w109("Select an area.")
        return
    end
    local c = w54:GetAttribute("Val")
    if not c then
        w109("Select a multiplier.")
        return
    end
    local function wWk(e, d, wTg)
        local wS = e
        local g, h, i = 0, {}, false
        local wSl = wSmg(w58)
        local function j(m, n)
            local o = wSm91(w58, m) or 1
            local p = wSl[o]
            local q = w16(p.mu)
            local r = p.bo
            if not q then
                i = true
                h[#h + 1] = w15(m) .. " > " .. w15(n) .. " (" .. (p.dn or p.nm) .. "): ?"
                return
            end
            local s = q * c
            if w24.gn[w58] and r then s = s * 2 end
            local t = (n - m) / s
            if w24.sp[w58] and r then t = t / 2 end
            g = g + t
            h[#h + 1] = w15(m) .. " > " .. w15(n) .. " (" .. (p.dn or p.nm) .. "): " .. w17(t)
        end
        for k = 1, #wSl do
            local l = wSl[k]
            local m = l.th
            if m and m > e and m <= d then
                j(e, m)
                e = m
            end
        end
        if d > e then
            j(e, d)
        end
        w109(wTg .. w15(wS) .. " to " .. w15(d) .. " -- Total: " .. (i and "?" or w17(g)) ..
            "\n" .. table.concat(h, "\n") ..
            (i and "\n-- ? = unknown multiplier" or ""))
    end
    if w88.Text ~= "" then
        local d = w16(w88.Text)
        if not d or d <= 0 then
            w109("Power objective: enter a valid value above 0.")
            return
        end
        local e = w16(w60.Text)
        if not e or e <= 0 then
            if b then
                e = w16(w19[w58][b].req) or 0
            else
                e = 0
            end
        end
        if d <= e then
            w109("Power objective: you already have more than that! Put another value.")
            return
        end
        local f = e
        if w24.st[w58] then
            local g, k
            if wK then
                g = w16(wK.multi)
                k = wWn(wK.name)
            else
                g = w16(a)
                k = w19[w58][b].name
            end
            local h = wK and false or w51:GetAttribute("Boost")
            local i = g and g * c or nil
            if i and w24.gn[w58] and h then
                i = i * 2
            end
            local j = i and (d - f) / i or nil
            if j and w24.sp[w58] and h then
                j = j / 2
            end
            if not j then
                w109("Power objective -- staying in " .. k .. ": ?" ..
                    "\n-- ? = unknown " .. (wK and "weight" or "area") .. " multiplier")
                return
            end
            w109("Power objective -- " .. w15(f) .. " to " .. w15(d) .. " -- Staying in " .. k ..
                "\nGain per second: " .. w15(i) ..
                "\nGain per minute: " .. w15(i * 60) ..
                "\nGain per hour: " .. w15(i * 3600) ..
                "\nGain per day: " .. w15(i * 8.64e4) ..
                "\nGain per week: " .. w15(i * 6.048e5) ..
                "\nGain per month: " .. w15(i * 2.592e6) ..
                "\nGain per year: " .. w15(i * 3.1536e7) ..
                "\nTotal: " .. w17(j))
            return
        end
        wWk(e, d, "Power objective -- ")
        return
    end
    local wT, wTN
    if wK then
        if b and w19[w58][b] then
            wT = w16(w19[w58][b].req)
            wTN = w19[w58][b].name
        end
    elseif wWst[w58] and wKI > 0 and wW[wKI] then
        local g = w16(w58 == "MS" and wW[wKI].ms or wW[wKI].jf)
        if g and dP and g > dP then
            wT = g
            wTN = wWn(wW[wKI].name)
        end
    end
    if wT and not w24.st[w58] then
        wWk(dP or 0, wT, "Path to " .. wTN .. " -- ")
        return
    end
    local d, e, f
    if wK then
        d = w16(wK.multi)
        e = false
        if wW[wKI + 1] then
            f = w16(w58 == "MS" and wW[wKI + 1].ms or wW[wKI + 1].jf)
        else
            f = w16(w19[w58][1].req)
        end
    else
        d = w16(a)
        e = w51:GetAttribute("Boost")
        if w19[w58][b + 1] then
            local g = w19[w58][b + 1]
            f = w16(w58 == "BT" and g.min or g.req)
        end
    end
    if not d then
        if wK then
            local g = "Unknown weight multiplier."
            if f then
                g = g .. "\nNext: " .. (wW[wKI + 1] and wWn(wW[wKI + 1].name) or w19[w58][1].name) .. " at " .. w15(f)
            end
            w109(g)
        else
            w109("Unknown area multiplier.")
        end
        return
    end
    local h = d * c
    if w24.gn[w58] and e then h = h * 2 end
    local i = f and math.max(0, f - (w16(w60.Text) or 0)) or 0
    local j = f and i / h or 0
    if w24.sp[w58] and e then j = j / 2 end
    local k
    if w24.st[w58] then
        k = wK and "Staying with this weight -- put a Power Objective to calculate the time." or "Staying in this area -- put a Power Objective to calculate the time."
    elseif f then
        k = "Estimated time to next " .. (wK and (wW[wKI + 1] and "weight" or "area") or "area") .. ": " .. w17(j)
    else
        k = "Last area selected."
    end
    w109("Production per second: " .. w15(h) ..
        "\nPer minute: " .. w15(h * 60) ..
        "\nPer hour: " .. w15(h * 3600) ..
        "\nPer day: " .. w15(h * 8.64e4) ..
        "\n" .. k)
end)

w38(w64, w11.org, w11.orgH)

local w69 = w9("Frame", w29)
w69.Name = "TokensView"
w69.Size = w7(1, 0, 1, 0)
w69.BackgroundTransparency = 1
w69.Visible = false

local function w68(a, b, c, d)
    local e = w9("TextLabel", w69)
    e.Text = a
    e.Size = w7(0, 130, 0, 32)
    e.Position = w7(0, 20, 0, b)
    e.TextColor3 = w11.wht
    e.BackgroundTransparency = 1
    e.Font = w10
    e.TextSize = #a > 14 and 16 or 18
    e.TextXAlignment = Enum.TextXAlignment.Left

    local f = w24.md.TK and w24.tok.cur or w24.tok.oth
    local g = w9("TextBox", w69)
    g.Text = f[d]
    g.Size = w7(0, 310, 0, 32)
    g.Position = w7(0, 150, 0, b)
    g.BackgroundColor3 = w11.inp
    g.TextColor3 = w11.wht
    g.Font = w10
    g.TextSize = 18
    g.ClearTextOnFocus = false
    g.PlaceholderText = c
    g.PlaceholderColor3 = w11.dim
    w9("UICorner", g).CornerRadius = UDim.new(0, 4)

    w12(g.FocusLost, function()
        local h = w24.md.TK and w24.tok.cur or w24.tok.oth
        h[d] = g.Text
        w26()
    end)

    return g
end

local w70 = w68("Tokens", 56, "Enter your tokens", "tk")
local w71 = w68("TPM", 102, "Enter your TPM", "tp")
local w72 = w68("Tokens Objective", 148, "Enter your tokens objective", "ob")
local w86 = w68("TPM Objective", 194, "Enter your TPM objective", "to")
local w106 = w68("Time Spent", 240, "e.g. 9d10h22m or 9d 10h 22m", "sp")

local function wTf()
    local a = w24.md.TK and w24.tok.cur or w24.tok.oth
    w70.Text = a.tk
    w71.Text = a.tp
    w72.Text = a.ob
    w86.Text = a.to
    w106.Text = a.sp
end

local w73 = w9("TextLabel", w69)
w73.Text = "Passive growth: +1 TPM every 4H -- +6 TPM per day"
w73.Size = w7(0, 440, 0, 24)
w73.Position = w7(0, 20, 0, 324)
w73.TextColor3 = w11.dim
w73.BackgroundTransparency = 1
w73.Font = w10
w73.TextSize = 16
w73.TextXAlignment = Enum.TextXAlignment.Left

local w107 = w9("TextLabel", w69)
w107.Text = "Those numbers are based if you 24/7"
w107.Size = w7(0, 440, 0, 20)
w107.Position = w7(0, 20, 0, 346)
w107.TextColor3 = w11.dim
w107.BackgroundTransparency = 1
w107.Font = w10
w107.TextSize = 14
w107.TextXAlignment = Enum.TextXAlignment.Left

local w74 = w9("TextButton", w69)
w74.Text = "Calculate"
w74.Size = w7(0, 440, 0, 40)
w74.Position = w7(0, 20, 0, 382)
w74.BackgroundColor3 = w11.org
w74.TextColor3 = w11.wht
w74.Font = w10
w74.TextSize = 18
w74.AutoButtonColor = false
w9("UICorner", w74).CornerRadius = UDim.new(0, 4)

local w90 = wR(w69, 428, 192)

local function w76(a, b, c)
    local d = math.floor(c / 240)
    local e = c - d * 240
    return a + b * c + 240 * d * (d - 1) / 2 + e * d
end

local function w108(a)
    a = tostring(a):lower():gsub("%s", "")
    if a == "" then return nil end
    local b, c = 0, nil
    for d, e in a:gmatch("([%d%.]+)([wdhms])") do
        local f = tonumber(d)
        if f then
            c = true
            b = b + f * (e == "w" and 1.008e4 or e == "d" and 1440 or e == "h" and 60 or e == "m" and 1 or 1 / 60)
        end
    end
    if c then return b end
    return tonumber(a)
end

local function w96(a, b, c, d)
    if c <= d then return a + b * c end
    return a + b * d + w76(0, b + 1, c - d)
end

local function w77(a, b, c)
    local d = c - a
    if d <= 0 then return 0 end
    if b <= 0 then return nil end
    local e = 240 * (-b + math.sqrt(b * b + d / 120))
    local f = math.max(1, math.ceil(e))
    while w76(a, b, f) < c do f = f * 2 end
    local g = 0
    while g < f do
        local h = math.floor((g + f) / 2)
        if w76(a, b, h) < c then g = h + 1 else f = h end
    end
    return g
end

local function w92()
    local a, b, c = nil, nil, nil
    local d = w6:FindFirstChild("ScreenGui")
    if d then
        local e = d:FindFirstChild("MenuFrame")
        local f = e and e:FindFirstChild("SpecialFrame")
        if f then
            local g = f:FindFirstChild("CurrentTokenEarning_Txt")
            if g and g.Text and g.Text ~= "" then
                b = w16(g.Text)
            end
            local h = f:FindFirstChild("NextTokenEarningUpgrade_Txt")
            if h and h.Text and h.Text ~= "" then
                local i = string.match(h.Text, "(%d+)%s*[mM]in") or string.match(h.Text, "(%d+)")
                if i then
                    c = math.clamp(tonumber(i), 1, 240)
                end
            end
        end
        local j = d:FindFirstChild("CurrentGemImgBtn")
        local k = j and j:FindFirstChild("AmountTxtBtn")
        if k and k.Text and k.Text ~= "" then
            a = w16(k.Text)
        end
    end
    return a, b, c
end

local w93 = w9("TextButton", w69)
w93.Text = "Use Current Stats"
w93.Size = w7(0, 210, 0, 32)
w93.Position = w7(0, 20, 0, 286)
w93.BackgroundColor3 = w11.btn
w93.TextColor3 = w11.wht
w93.Font = w10
w93.TextSize = 18
w93.AutoButtonColor = false
w9("UICorner", w93).CornerRadius = UDim.new(0, 4)

local w94 = w9("TextButton", w69)
w94.Text = "Use Other Stats"
w94.Size = w7(0, 210, 0, 32)
w94.Position = w7(0, 250, 0, 286)
w94.BackgroundColor3 = w11.btn
w94.TextColor3 = w11.wht
w94.Font = w10
w94.TextSize = 18
w94.AutoButtonColor = false
w9("UICorner", w94).CornerRadius = UDim.new(0, 4)

local function w95()
    local a = w24.md.TK
    w93.BackgroundColor3 = a and w11.grn or w11.btn
    w94.BackgroundColor3 = a and w11.btn or w11.vio
end

w12(w93.MouseButton1Click, function()
    if w24.md.TK then return end
    w24.md.TK = true
    w95()
    local a, b = w92()
    if a then
        w24.tok.cur.tk = tostring(a)
    end
    if b then
        w24.tok.cur.tp = tostring(b)
    end
    wTf()
    w26()
    if not a and not b then
        w109("Couldn't read your current stats. Put them manually or use Other Stats.")
    end
end)

w12(w94.MouseButton1Click, function()
    if not w24.md.TK then return end
    w24.md.TK = false
    w95()
    wTf()
    w26()
end)

w12(w74.MouseButton1Click, function()
    local a = w16(w70.Text)
    local b = w16(w71.Text)
    local c = w16(w72.Text)
    local d = w16(w86.Text)
    local e, f, p = nil, nil, nil
    local g = 240
    if w24.md.TK then
        local h, i, j = w92()
        if i then
            b = i
            w71.Text = tostring(i)
            w24.tok.cur.tp = tostring(i)
        end
        if h then
            a = h
            w70.Text = tostring(h)
            w24.tok.cur.tk = tostring(h)
        end
        if j then
            g = j
        end
        if h or i then
            w26()
        end
        if not i then
            w109("Current stats: couldn't read your TPM. Put it manually or use Other Stats.")
            return
        end
    end
    if c then
        if not a then
            e = "Token objective: enter valid tokens."
        elseif not b or b <= 0 then
            e = "Token objective: enter a TPM above 0."
        elseif c <= a then
            e = "Token objective: you already have more than that! Put another value."
        else
            local k
            if c - a <= b * g then
                k = math.ceil((c - a) / b)
            else
                k = g + w77(a + b * g, b + 1, c)
            end
            local m = k > g and math.floor((k - g - 1) / 240) + 1 or 0
            e = "Token objective -- Remaining: " .. w15(c - a) ..
                "\nEstimated time: " .. w17(k * 60) ..
                "\nTPM on arrival: " .. w15(b + m)
        end
    end
    if d then
        if not b then
            f = "TPM objective: enter a valid TPM."
        elseif d <= b then
            f = "TPM objective: you already have more than that! Put another value."
        else
            local k = g + (d - b - 1) * 240
            f = "TPM objective -- TPM to gain: " .. w15(d - b) ..
                "\nEstimated time: " .. w17(k * 60)
            if a then
                f = f .. "\nTokens by then: " .. w15(w96(a, b, k, g))
            else
                f = f .. "\nTokens gained: " .. w15(w96(0, b, k, g))
            end
        end
    end
    local l = w108(w106.Text)
    if l then
        if not b or b <= 0 then
            p = "Time spent: enter a TPM above 0."
        elseif l <= 0 then
            p = "Time spent: enter a valid duration above 0."
        else
            local o, r
            if l <= g then
                o = b * l
                r = 0
            else
                o = b * g + w76(0, b + 1, l - g)
                r = 1 + math.floor((l - g) / 240)
            end
            p = "Time spent -- " .. w17(l * 60) ..
                "\nTokens gained: " .. w15(o) ..
                (a and "\nTokens at end: " .. w15(a + o) or "") ..
                "\nTPM at end: " .. w15(b + r)
        end
    end
    local n = ""
    if w24.md.TK then
        n = "Current stats -- Tokens: " .. (a and w15(a) or "?") .. " -- TPM: " .. (b and w15(b) or "?") ..
            " -- Next +1 TPM in " .. g .. " min\n\n"
    end
    local s = {}
    if e then s[#s + 1] = e end
    if f then s[#s + 1] = f end
    if p then s[#s + 1] = p end
    w109(n .. (s[1] and table.concat(s, "\n-- --\n") or "Fill TPM and at least one objective or a time spent to calculate."))
end)

w38(w74, w11.org, w11.orgH)

local w112 = w9("Frame", w29)
w112.Name = "MultipliersView"
w112.Size = w7(1, 0, 1, 0)
w112.BackgroundTransparency = 1
w112.Visible = false

local w119 = {
    {2, 100}, {4, 200}, {8, 500},
    {16, 1000}, {32, 2000}, {64, 5000},
    {128, 1e4}, {256, 1.5e4}, {512, 2e4},
    {1024, 5e4}, {2048, 1e5}, {4096, 2e5},
    {8192, 5e5}, {1.6384e4, 1e6}, {3.2768e4, 2e6},
    {6.5536e4, 5e6}, {1.31072e5, 1e7}, {2.62144e5, 2e7},
    {5.24288e5, 5e7}, {1.048576e6, 1e8}, {2.097152e6, 2e8},
    {4.194304e6, 5e8}, {8.388608e6, 1e9}, {1.6777216e7, 2e9},
    {3.3554432e7, 5e9}, {6.7108864e7, 1e10}, {1.34217728e8, 2e10},
    {2.68435456e8, 5e10}, {5.36870912e8, 1e11}, {1.073741824e9, 2e11}
}

local function wM(a)
    if not a or a <= 0 then return nil end
    local b = math.clamp(math.floor(math.log(a) / math.log(2) + 0.5), 1, #w119)
    return w119[b][1]
end

local function wN(a)
    if not a or a == "" then return nil end
    local b = w16(a)
    return b and wM(b) or nil
end

for _, a in ipairs(w20) do
    for _, b in ipairs({w24.ml.cur, w24.ml.oth}) do
        local c = wN(b[a])
        b[a] = c and tostring(c) or nil
    end
end

local w113 = {}

local function w114(a, b)
    local c, d, e = w40(w112, a, b, w41)
    for _, f in ipairs(w119) do
        w39(e, "x" .. w15(f[1]), function()
            c.Text = "x" .. w15(f[1])
            c:SetAttribute("Val", f[1])
            d.Visible = false
            local h = w24.md.ML and w24.ml.cur or w24.ml.oth
            h[a] = tostring(f[1])
            if w24.md.ML then
                w24.ml.ov[a] = true
            end
            w26()
        end)
    end
    local f = w24.md.ML and w24.ml.cur or w24.ml.oth
    local g = wN(f[a])
    if g then
        c.Text = "x" .. w15(g)
        c:SetAttribute("Val", g)
    end
    w113[a] = c
end

w114("FS", 56)
w114("BT", 102)
w114("MS", 148)
w114("JF", 194)
w114("PP", 240)

local function w115()
    local a = w24.md.ML and w24.ml.cur or w24.ml.oth
    for _, b in ipairs(w20) do
        local c = w113[b]
        local d = wN(a[b])
        if d then
            c.Text = "x" .. w15(d)
            c:SetAttribute("Val", d)
        else
            c.Text = "Select"
            c:SetAttribute("Val", nil)
        end
    end
end

local w116, w117, w118 = w40(w112, "Objective", 286, w41)

for _, a in ipairs(w119) do
    w39(w118, "x" .. w15(a[1]) .. " -- " .. w15(a[2]), function()
        w116.Text = "x" .. w15(a[1]) .. " -- " .. w15(a[2])
        w116:SetAttribute("Val", a[1])
        w117.Visible = false
        w24.ml.tg = a[1]
        w24.ml.tm = w116.Text
        w26()
    end)
end

if w24.ml.tg then
    w116.Text = w24.ml.tm or ("x" .. w15(w24.ml.tg))
    w116:SetAttribute("Val", w24.ml.tg)
end

local w120 = w9("TextButton", w112)
w120.Text = "Use Current Stats"
w120.Size = w7(0, 210, 0, 32)
w120.Position = w7(0, 20, 0, 332)
w120.BackgroundColor3 = w11.btn
w120.TextColor3 = w11.wht
w120.Font = w10
w120.TextSize = 18
w120.AutoButtonColor = false
w9("UICorner", w120).CornerRadius = UDim.new(0, 4)

local w121 = w9("TextButton", w112)
w121.Text = "Use Other Stats"
w121.Size = w7(0, 210, 0, 32)
w121.Position = w7(0, 250, 0, 332)
w121.BackgroundColor3 = w11.btn
w121.TextColor3 = w11.wht
w121.Font = w10
w121.TextSize = 18
w121.AutoButtonColor = false
w9("UICorner", w121).CornerRadius = UDim.new(0, 4)

local function w122()
    local a = w24.md.ML
    w120.BackgroundColor3 = a and w11.grn or w11.btn
    w121.BackgroundColor3 = a and w11.btn or w11.vio
end

local function w123()
    local a = w97()
    local b, c = false, false
    for _, d in ipairs(w20) do
        local e = a[d]
        if e and e.m then
            b = true
            if not w24.ml.ov[d] then
                local f = wM(e.m)
                if f and w24.ml.cur[d] ~= tostring(f) then
                    w24.ml.cur[d] = tostring(f)
                    c = true
                end
            end
        end
    end
    return b, c
end

local function w124()
    local a, b = w123()
    if a and w24.msg.ML and w24.msg.ML:find("Couldn't read") then
        w109("")
    end
    for _, c in ipairs(w20) do
        local d = w113[c]
        local e = wN(w24.ml.cur[c])
        if d and e and d:GetAttribute("Val") ~= e then
            d.Text = "x" .. w15(e)
            d:SetAttribute("Val", e)
        end
    end
    return b
end

w12(w120.MouseButton1Click, function()
    if w24.md.ML then return end
    w24.md.ML = true
    w122()
    for _, a in ipairs(w20) do
        w24.ml.ov[a] = nil
    end
    local a = w123()
    w115()
    w26()
    if a then
        if w24.msg.ML and w24.msg.ML:find("Couldn't read") then
            w109("")
        end
    else
        w109("Couldn't read your multipliers. Select them from the dropdowns.")
    end
end)

w12(w121.MouseButton1Click, function()
    if not w24.md.ML then return end
    w24.md.ML = false
    w122()
    w115()
    w26()
    if w24.msg.ML and w24.msg.ML:find("Couldn't read") then
        w109("")
    end
end)

local w125 = w9("TextButton", w112)
w125.Text = "Calculate"
w125.Size = w7(0, 440, 0, 40)
w125.Position = w7(0, 20, 0, 378)
w125.BackgroundColor3 = w11.org
w125.TextColor3 = w11.wht
w125.Font = w10
w125.TextSize = 18
w125.AutoButtonColor = false
w9("UICorner", w125).CornerRadius = UDim.new(0, 4)

local w126 = wR(w112, 424, 196)

w12(w125.MouseButton1Click, function()
    if w24.md.ML then
        w124()
    end
    local a = w116:GetAttribute("Val")
    if not a then
        w109("Select an objective multiplier.")
        return
    end
    local b, c, d = {}, 0, 0
    for _, e in ipairs(w20) do
        local f = (w24.md.ML and w24.ml.cur or w24.ml.oth)[e]
        local g = wN(f)
        if not g then
            b[#b + 1] = e .. ": no multiplier"
        else
            d = d + 1
            local h, i = 0, 0
            for _, j in ipairs(w119) do
                if j[1] > g and j[1] <= a then
                    h = h + j[2]
                    i = i + 1
                end
            end
            if i == 0 then
                b[#b + 1] = e .. ": already x" .. w15(g) .. " or higher"
            else
                b[#b + 1] = e .. ": " .. w15(h) .. " Tokens (" .. i .. (i > 1 and " upgrades)" or " upgrade)")
                c = c + h
            end
        end
    end
    if d == 0 then
        w109("Multipliers -- select your multipliers or use Current Stats.")
        return
    end
    w109("Multipliers -- objective x" .. w15(a) .. "\n" .. table.concat(b, "\n") ..
        (c > 0 and "\nTotal: " .. w15(c) .. " Tokens" or "\nNothing to buy for this objective."))
end)

w38(w125, w11.org, w11.orgH)

local function w103()
    local a, b = w101()
    if w58 and w24.md[w58] then
        local c = wA(w58)
        if not w60:IsFocused() then
            w60.Text = (c.pw ~= "" and c.pw) or "0"
            wXl()
        end
        if c.mu and w54.Text ~= c.mu then
            w54.Text = c.mu
        end
        if c.mv ~= nil and w54:GetAttribute("Val") ~= c.mv then
            w54:SetAttribute("Val", c.mv)
        end
        if c.ar and w19[w58][c.ar] and w51:GetAttribute("Idx") ~= c.ar then
            wB(w58, c.ar)
        end
        if wWst[w58] then
            if not c.ar and w51:GetAttribute("Idx") then
                wC()
            end
            if c.wt and wW[c.wt] then
                if wW1:GetAttribute("Idx") ~= c.wt then
                    wWb(c.wt)
                end
            elseif wW1:GetAttribute("Idx") then
                wWc()
            end
        end
    end
    return b
end

local function w104()
    local a, b = w92()
    local c = false
    if a then
        local d = tostring(a)
        if w24.tok.cur.tk ~= d then
            w24.tok.cur.tk = d
            c = true
        end
        if not w70:IsFocused() and w70.Text ~= d then
            w70.Text = d
        end
    end
    if b then
        local d = tostring(b)
        if w24.tok.cur.tp ~= d then
            w24.tok.cur.tp = d
            c = true
        end
        if not w71:IsFocused() and w71.Text ~= d then
            w71.Text = d
        end
    end
    return c
end

w109 = function(a)
    if w24.view == "Farming" then
        if w58 then
            w24.msg[w58] = a
        end
        w89.s(a)
    elseif w24.view == "Tokens" then
        w24.msg.Tokens = a
        w90.s(a)
    elseif w24.view == "Multipliers" then
        w24.msg.ML = a
        w126.s(a)
    end
    w26()
end

w.th[#w.th + 1] = task.spawn(function()
    while true do
        task.wait(0.1)
        for _, a in ipairs(w110) do
            pcall(a)
        end
    end
end)

w.th[#w.th + 1] = task.spawn(function()
    local a = false
    local b = 0
    while true do
        task.wait(1)
        local c = false
        local d = false
        for _, e in ipairs(w20) do
            if w24.md[e] then
                d = true
                break
            end
        end
        if d then
            local f, g = pcall(w103)
            if f and g then
                c = true
            end
        end
        if w24.md.TK then
            local h, i = pcall(w104)
            if h and i then
                c = true
            end
        end
        if w24.md.ML then
            local j, k = pcall(w124)
            if j and k then
                c = true
            end
        end
        if c then
            a = true
        end
        if a and os.time() - b >= 10 then
            a = false
            b = os.time()
            w26()
        end
    end
end)

local function w42(a)
    for _, b in ipairs(w41) do
        b.Visible = false
    end
    w43.Visible = a == "Home"
    w47.Visible = a == "Farming"
    w69.Visible = a == "Tokens"
    w112.Visible = a == "Multipliers"
    w32.Visible = a ~= "Home"
    w31.Text = a == "Home" and "cLTR Calculators" or "cLTR " .. a
    w24.view = a
    if a == "Farming" then
        w89.s(w58 and w24.msg[w58] or "")
    elseif a == "Tokens" then
        w90.s(w24.msg.Tokens or "")
    elseif a == "Multipliers" then
        w126.s(w24.msg.ML or "")
    end
    w26()
end

w12(w45.MouseButton1Click, function() w42("Farming") end)
w12(w46.MouseButton1Click, function() w42("Tokens") end)
w12(w111.MouseButton1Click, function() w42("Multipliers") end)
w12(w32.MouseButton1Click, function() w42("Home") end)

local w78
pcall(function() w78 = Enum.KeyCode[w24.key] end)

w12(w2.InputBegan, function(a, b)
    if b or w84 or w85 or not w78 or a.KeyCode ~= w78 then return end
    w37()
end)

local function w79()
    return workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
end

local function w80()
    local a = w79()
    return math.clamp(math.min(a.X / 1920, a.Y / 1080), 0.75, 1.2)
end

local function w81()
    local a = w80()
    w30.Scale = a
    w35.Scale = a
    return a
end

local function w82(a)
    local b = w81()
    local c = w79()
    local d = 480 * b
    local e = wH * b
    local f = 50 * b
    local g, h = w24.pos and not a, w24.icon and not a
    w29.Position = g and w7(
        0, math.clamp(w24.pos.X, 0, math.max(0, c.X - d)),
        0, math.clamp(w24.pos.Y, 0, math.max(0, c.Y - e))
    ) or w7(0, math.max(0, (c.X - d) / 2), 0, math.max(0, (c.Y - e) / 2))
    w34.Position = h and w7(
        0, math.clamp(w24.icon.X, 0, math.max(0, c.X - f)),
        0, math.clamp(w24.icon.Y, 0, math.max(0, c.Y - f))
    ) or w7(0, math.max(0, 20 * b), 0, math.max(0, math.min(30 * b, c.Y - f)))
    if a then
        w24.pos = nil
        w24.icon = nil
        w26(true)
    end
end

local function w83()
    if os.clock() - w27 < 5 then
        w82()
    else
        w82(true)
    end
end

w12(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w83)
w12(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
    if workspace.CurrentCamera then
        w12(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w83)
    end
end)

w36(w29, nil)
w36(w34, w37)
w12(w33.MouseButton1Click, w37)

w63()
w95()
w100()
w122()
w42(w24.view)
if w24.md.TK then
    local a, b = w92()
    if a then
        w24.tok.cur.tk = tostring(a)
        w70.Text = tostring(a)
    end
    if b then
        w24.tok.cur.tp = tostring(b)
        w71.Text = tostring(b)
    end
end
if w24.md.ML then
    w124()
end
w82()
