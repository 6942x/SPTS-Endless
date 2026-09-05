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
    red = w8(180, 0, 0),
    redH = w8(220, 30, 30),
    cy = w8(0, 168, 255),
    cyH = w8(64, 196, 255),
    pu = w8(168, 85, 247),
    org = w8(245, 158, 11),
    orgH = w8(251, 191, 36),
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
    local b = math.floor(a / 86400)
    if b >= 1e6 then return w15(b) .. " days" end
    local c = math.floor((a % 86400) / 3600)
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

local w23 = "TrainingCalc/" .. w5.Name .. ".json"
local w24 = {key = "G", pos = nil, icon = nil, speed = false, train = false, power = "0", cat = nil, view = "Home", mem = {}, tok = {tokens = "", tpm = "", obj = "", tpo = ""}}
local w26, w29, w34
local w84, w85 = false, false
local w27 = os.clock()

local function w25()
    if not readfile then return end
    local a, b = pcall(function()
        if isfile and not isfile(w23) then return end
        return readfile(w23)
    end)
    if not a or not b then return end
    local c, d = pcall(function() return w4:JSONDecode(b) end)
    if c and type(d) == "table" then
        w24.key = d.key or "G"
        if type(d.pos) == "table" and type(d.pos.X) == "number" and type(d.pos.Y) == "number" then
            w24.pos = d.pos
        end
        if type(d.icon) == "table" and type(d.icon.X) == "number" and type(d.icon.Y) == "number" then
            w24.icon = d.icon
        end
        w24.speed = d.speed or false
        w24.train = d.train or false
        w24.power = d.power or "0"
        w24.cat = d.cat
        if d.view == "Farming" or d.view == "Tokens" then
            w24.view = d.view
        end
        if type(d.mem) == "table" then
            w24.mem = {}
            for e, f in pairs(d.mem) do
                if type(f) == "table" then
                    f.val = tonumber(f.val)
                    f.area = tonumber(f.area)
                    if f.mult ~= nil then f.mult = tostring(f.mult) end
                    if f.power ~= nil then f.power = tostring(f.power) end
                    if f.pobj ~= nil then f.pobj = tostring(f.pobj) end
                    w24.mem[e] = f
                end
            end
        end
        if type(d.tok) == "table" then
            w24.tok.tokens = tostring(d.tok.tokens or "")
            w24.tok.tpm = tostring(d.tok.tpm or "")
            w24.tok.obj = tostring(d.tok.obj or "")
            w24.tok.tpo = tostring(d.tok.tpo or "")
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
                Size = w7(0, 480, 0, 546),
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
w29.Size = w7(0, 480, 0, 546)
w29.Position = w24.pos and w7(0, w24.pos.X, 0, w24.pos.Y) or w7(0.5, -240, 0.5, -273)
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

    return f, g, h
end

local w41 = {}

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
w45.Size = w7(0, 210, 0, 100)
w45.Position = w7(0, 20, 0, 210)
w45.BackgroundColor3 = w11.org
w45.TextColor3 = w11.wht
w45.Font = w10
w45.TextSize = 22
w45.AutoButtonColor = false
w9("UICorner", w45).CornerRadius = UDim.new(0, 8)
w38(w45, w11.org, w11.orgH)

local w46 = w9("TextButton", w43)
w46.Text = "Tokens"
w46.Size = w7(0, 210, 0, 100)
w46.Position = w7(0, 250, 0, 210)
w46.BackgroundColor3 = w11.cy
w46.TextColor3 = w11.wht
w46.Font = w10
w46.TextSize = 22
w46.AutoButtonColor = false
w9("UICorner", w46).CornerRadius = UDim.new(0, 8)
w38(w46, w11.cy, w11.cyH)

local w47 = w9("Frame", w29)
w47.Name = "FarmingView"
w47.Size = w7(1, 0, 1, 0)
w47.BackgroundTransparency = 1
w47.Visible = false

local w58
local w48, w49, w50 = w40(w47, "Category", 56, w41)
local w51, w52, w53 = w40(w47, "Area", 102, w41)
local w54, w55, w56 = w40(w47, "Multiplier", 148, w41)

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
w60.Text = w24.power
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
        w24.mem[w58] = w24.mem[w58] or {}
        w24.mem[w58].power = w60.Text
    else
        w24.power = w60.Text
    end
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
        w24.mem[w58] = w24.mem[w58] or {}
        w24.mem[w58].pobj = w88.Text
        w26()
    end
end)

local w61 = w9("TextButton", w47)
w61.Size = w7(0, 210, 0, 32)
w61.Position = w7(0, 20, 0, 286)
w61.BackgroundColor3 = w11.btn
w61.TextColor3 = w11.wht
w61.Font = w10
w61.TextSize = 18
w61.AutoButtonColor = false
w9("UICorner", w61).CornerRadius = UDim.new(0, 4)

local w62 = w9("TextButton", w47)
w62.Size = w7(0, 210, 0, 32)
w62.Position = w7(0, 250, 0, 286)
w62.BackgroundColor3 = w11.btn
w62.TextColor3 = w11.wht
w62.Font = w10
w62.TextSize = 18
w62.AutoButtonColor = false
w9("UICorner", w62).CornerRadius = UDim.new(0, 4)

local function w63()
    w61.Text = "Speed 2x: " .. (w24.speed and "ON" or "OFF")
    w61.BackgroundColor3 = w24.speed and w11.cy or w11.btn
    w62.Text = "Training 2x: " .. (w24.train and "ON" or "OFF")
    w62.BackgroundColor3 = w24.train and w11.pu or w11.btn
end

w12(w61.MouseButton1Click, function()
    w24.speed = not w24.speed
    w63()
    w26()
end)

w12(w62.MouseButton1Click, function()
    w24.train = not w24.train
    w63()
    w26()
end)

local w64 = w9("TextButton", w47)
w64.Text = "Calculate"
w64.Size = w7(0, 440, 0, 40)
w64.Position = w7(0, 20, 0, 332)
w64.BackgroundColor3 = w11.org
w64.TextColor3 = w11.wht
w64.Font = w10
w64.TextSize = 18
w64.AutoButtonColor = false
w9("UICorner", w64).CornerRadius = UDim.new(0, 4)

local w89 = w9("ScrollingFrame", w47)
w89.Size = w7(0, 440, 0, 150)
w89.Position = w7(0, 20, 0, 386)
w89.BackgroundTransparency = 1
w89.ScrollBarThickness = 4
w89.CanvasSize = w7(0, 0, 0, 0)
w89.AutomaticCanvasSize = Enum.AutomaticSize.Y
w89.BorderSizePixel = 0

local w65 = w9("TextLabel", w89)
w65.Text = ""
w65.Size = w7(1, -8, 0, 0)
w65.Position = w7(0, 4, 0, 4)
w65.AutomaticSize = Enum.AutomaticSize.Y
w65.TextColor3 = w11.wht
w65.BackgroundTransparency = 1
w65.Font = w10
w65.TextSize = 16
w65.TextWrapped = true
w65.TextXAlignment = Enum.TextXAlignment.Left
w65.TextYAlignment = Enum.TextYAlignment.Top

local w66 = {}
for _, a in ipairs({{1, 1024}, {1024, 1048576}, {1048576, 16777217}}) do
    local b = a[1]
    while b < a[2] do
        local c = b >= 1048576 and tostring(math.floor(b / 1048576)) .. "M" or b >= 1024 and tostring(math.floor(b / 1024)) .. "k" or tostring(math.floor(b))
        table.insert(w66, {c, b})
        b = b * 2
    end
end

for _, a in ipairs(w66) do
    w39(w56, a[1], function()
        w54.Text = a[1]
        w54:SetAttribute("Val", a[2])
        w55.Visible = false
        if w58 then
            w24.mem[w58] = w24.mem[w58] or {}
            w24.mem[w58].mult = a[1]
            w24.mem[w58].val = a[2]
            w26()
        end
    end)
end

local function w67(a)
    w48.Text = a
    w49.Visible = false
    w51.Text = "Select"
    w51:SetAttribute("Mult", nil)
    w51:SetAttribute("Min", nil)
    w51:SetAttribute("Idx", nil)
    w51:SetAttribute("Boost", nil)
    w57.Visible = false
    w53.Visible = true
    w58 = a
    w24.cat = a
    for _, b in ipairs(w53:GetChildren()) do
        if b:IsA("TextButton") then b:Destroy() end
    end
    for c, d in ipairs(w19[a]) do
        local e = not w22[a] or c >= w22[a]
        local f = w18(d.name, d.req)
        w39(w53, f, function()
            w51.Text = f
            w51:SetAttribute("Mult", d.multi)
            w51:SetAttribute("Min", d.min)
            w51:SetAttribute("Idx", c)
            w51:SetAttribute("Boost", e)
            w52.Visible = false
            w24.mem[a] = w24.mem[a] or {}
            w24.mem[a].area = c
            w26()
        end)
    end
    local g = w24.mem[a]
    w54.Text = g and g.mult or "Select"
    w54:SetAttribute("Val", g and g.val or nil)
    w60.Text = g and g.power or "0"
    w88.Text = g and g.pobj or ""
    if g and type(g.area) == "number" and w19[a][g.area] then
        local h = w19[a][g.area]
        w51.Text = w18(h.name, h.req)
        w51:SetAttribute("Mult", h.multi)
        w51:SetAttribute("Min", h.min)
        w51:SetAttribute("Idx", g.area)
        w51:SetAttribute("Boost", not w22[a] or g.area >= w22[a])
    end
    w26()
end

for _, a in ipairs(w20) do
    w39(w50, a, function() w67(a) end)
end

if w24.cat and w19[w24.cat] then
    w67(w24.cat)
end

local function w91(a, b)
    local d = 1
    for e, f in ipairs(w19[a]) do
        local g = w16(f.req)
        if g and g <= b then d = e else break end
    end
    return d
end

w12(w64.MouseButton1Click, function()
    local a = w51:GetAttribute("Mult")
    local b = w51:GetAttribute("Idx")
    if not a or not b then
        w65.Text = "Select an area."
        return
    end
    local c = w54:GetAttribute("Val")
    if not c then
        w65.Text = "Select a multiplier."
        return
    end
    if w88.Text ~= "" then
        local d = w16(w88.Text)
        if not d or d <= 0 then
            w65.Text = "Power objective: enter a valid value above 0."
            return
        end
        local e = w16(w60.Text)
        if not e or e <= 0 then
            e = w16(w19[w48.Text][b].req) or 0
        end
        if d <= e then
            w65.Text = "Power objective: you already have more than that! Put another value."
            return
        end
        local st = e
        local f, g, h = 0, {}, false
        local function i(m, n)
            local o = w91(w48.Text, m)
            local p = w19[w48.Text][o]
            local q = w16(p.multi)
            local r = not w22[w48.Text] or o >= w22[w48.Text]
            if not q then
                h = true
                g[#g + 1] = w15(m) .. " > " .. w15(n) .. " (" .. p.name .. "): ?"
                return
            end
            local s = q * c
            if w24.train and r then s = s * 2 end
            local t = (n - m) / s
            if w24.speed and r then t = t / 2 end
            f = f + t
            g[#g + 1] = w15(m) .. " > " .. w15(n) .. " (" .. p.name .. "): " .. w17(t)
        end
        for j = 1, #w19[w48.Text] do
            local k = w19[w48.Text][j]
            local l = w16(w48.Text == "BT" and k.min or k.req)
            if l and l > e and l <= d then
                i(e, l)
                e = l
            end
        end
        if d > e then
            i(e, d)
        end
        w65.Text = "Power objective -- " .. w15(st) .. " to " .. w15(d) .. " -- Total: " .. (h and "?" or w17(f)) ..
            "\n" .. table.concat(g, "\n") ..
            (h and "\n-- ? = unknown area multiplier" or "")
        w89.CanvasPosition = Vector2.new(0, 0)
        return
    end
    local d = w16(a)
    if not d then
        w65.Text = "Unknown area multiplier."
        return
    end
    local e = w51:GetAttribute("Boost")
    local f = nil
    if w19[w48.Text][b + 1] then
        local g = w19[w48.Text][b + 1]
        f = w16(w48.Text == "BT" and g.min or g.req)
    end
    local h = d * c
    if w24.train and e then h = h * 2 end
    local i = f and math.max(0, f - (w16(w60.Text) or 0)) or 0
    local j = f and i / h or 0
    if w24.speed and e then j = j / 2 end
    local k = f and "Estimated time to next area: " .. w17(j) or "Last area selected."
    w65.Text = "Production per second: " .. w15(h) ..
        "\nPer minute: " .. w15(h * 60) ..
        "\nPer hour: " .. w15(h * 3600) ..
        "\nPer day: " .. w15(h * 86400) ..
        "\n" .. k
    w89.CanvasPosition = Vector2.new(0, 0)
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

    local f = w9("TextBox", w69)
    f.Text = w24.tok[d]
    f.Size = w7(0, 310, 0, 32)
    f.Position = w7(0, 150, 0, b)
    f.BackgroundColor3 = w11.inp
    f.TextColor3 = w11.wht
    f.Font = w10
    f.TextSize = 18
    f.ClearTextOnFocus = false
    f.PlaceholderText = c
    f.PlaceholderColor3 = w11.dim
    w9("UICorner", f).CornerRadius = UDim.new(0, 4)

    w12(f.FocusLost, function()
        w24.tok[d] = f.Text
        w26()
    end)

    return f
end

local w70 = w68("Tokens", 56, "Enter your tokens", "tokens")
local w71 = w68("TPM", 102, "Enter your TPM", "tpm")
local w72 = w68("Tokens Objective", 148, "Enter your tokens objective", "obj")
local w86 = w68("TPM Objective", 194, "Enter your TPM objective", "tpo")

local w73 = w9("TextLabel", w69)
w73.Text = "Passive growth: +1 TPM every 4H -- +6 TPM per day"
w73.Size = w7(0, 440, 0, 32)
w73.Position = w7(0, 20, 0, 240)
w73.TextColor3 = w11.dim
w73.BackgroundTransparency = 1
w73.Font = w10
w73.TextSize = 16
w73.TextXAlignment = Enum.TextXAlignment.Left

local w74 = w9("TextButton", w69)
w74.Text = "Calculate"
w74.Size = w7(0, 440, 0, 40)
w74.Position = w7(0, 20, 0, 286)
w74.BackgroundColor3 = w11.org
w74.TextColor3 = w11.wht
w74.Font = w10
w74.TextSize = 18
w74.AutoButtonColor = false
w9("UICorner", w74).CornerRadius = UDim.new(0, 4)

local w90 = w9("ScrollingFrame", w69)
w90.Size = w7(0, 440, 0, 196)
w90.Position = w7(0, 20, 0, 340)
w90.BackgroundTransparency = 1
w90.ScrollBarThickness = 4
w90.CanvasSize = w7(0, 0, 0, 0)
w90.AutomaticCanvasSize = Enum.AutomaticSize.Y
w90.BorderSizePixel = 0

local w75 = w9("TextLabel", w90)
w75.Text = ""
w75.Size = w7(1, -8, 0, 0)
w75.Position = w7(0, 4, 0, 4)
w75.AutomaticSize = Enum.AutomaticSize.Y
w75.TextColor3 = w11.wht
w75.BackgroundTransparency = 1
w75.Font = w10
w75.TextSize = 16
w75.TextWrapped = true
w75.TextXAlignment = Enum.TextXAlignment.Left
w75.TextYAlignment = Enum.TextYAlignment.Top

local function w76(a, b, c)
    local d = math.floor(c / 240)
    local e = c - d * 240
    return a + b * c + 240 * d * (d - 1) / 2 + e * d
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

w12(w74.MouseButton1Click, function()
    local a = w16(w70.Text)
    local b = w16(w71.Text)
    local c = w16(w72.Text)
    local d = w16(w86.Text)
    local e, f = nil, nil
    if c then
        if not a then
            e = "Token objective: enter valid tokens."
        elseif not b or b <= 0 then
            e = "Token objective: enter a TPM above 0."
        elseif c <= a then
            e = "Token objective: you already have more than that! Put another value."
        else
            local g = w77(a, b, c)
            e = "Token objective -- Remaining: " .. w15(c - a) ..
                "\nEstimated time: " .. w17(g * 60) ..
                "\nTPM on arrival: " .. w15(b + math.floor(g / 240))
        end
    end
    if d then
        if not b then
            f = "TPM objective: enter a valid TPM."
        elseif d <= b then
            f = "TPM objective: you already have more than that! Put another value."
        else
            local g = (d - b) * 240
            f = "TPM objective -- TPM to gain: " .. w15(d - b) ..
                "\nEstimated time: " .. w17(g * 60)
            if a then
                f = f .. "\nTokens by then: " .. w15(w76(a, b, g))
            else
                f = f .. "\nTokens gained: " .. w15(w76(0, b, g))
            end
        end
    end
    w75.Text = e and (f and e .. "\n-- --\n" .. f or e) or (f or "Fill TPM and at least one objective to calculate.")
    w90.CanvasPosition = Vector2.new(0, 0)
end)

w38(w74, w11.org, w11.orgH)

local function w42(a)
    for _, b in ipairs(w41) do b.Visible = false end
    w43.Visible = a == "Home"
    w47.Visible = a == "Farming"
    w69.Visible = a == "Tokens"
    w32.Visible = a ~= "Home"
    w31.Text = a == "Home" and "cLTR Calculators" or "cLTR " .. a
    w24.view = a
    w26()
end

w12(w45.MouseButton1Click, function() w42("Farming") end)
w12(w46.MouseButton1Click, function() w42("Tokens") end)
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
    local e = 546 * b
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
w42(w24.view)
w82()
