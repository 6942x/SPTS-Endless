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
    bg = w8(4.5e1, 4.5e1, 4.5e1),
    btn = w8(6e1, 6e1, 6e1),
    item = w8(7e1, 7e1, 7e1),
    hov = w8(8e1, 8e1, 8e1),
    prs = w8(9e1, 9e1, 9e1),
    inp = w8(1.1e2, 1.1e2, 1.1e2),
    drop = w8(5e1, 5e1, 5e1),
    dim = w8(1.5e2, 1.5e2, 1.5e2),
    red = w8(1.8e2, 0e0, 0e0),
    redH = w8(2.2e2, 3e1, 3e1),
    cy = w8(0e0, 1.68e2, 2.55e2),
    pu = w8(1.68e2, 8.5e1, 2.47e2),
    org = w8(2.45e2, 1.58e2, 1.1e1),
    orgH = w8(2.51e2, 1.91e2, 3.6e1),
    wht = w8(2.55e2, 2.55e2, 2.55e2),
    blk = w8(0e0, 0e0, 0e0)
}

local function w12(a, b)
    local c = a:Connect(b)
    w.cn[#w.cn + 1e0] = c
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
w14.m = {Million = 1e6, Billion = 1e9, Trillion = 1e12}
for _, a in ipairs(w14) do w14.m[a[1e0]] = a[2e0] end

local function w15(a)
    a = tonumber(a)
    if not a then return "0" end
    local b = math.abs(a)
    for c = #w14, 1e0, -1e0 do
        local d = w14[c]
        if b >= d[2e0] then
            return (string.format("%.2f", a / d[2e0]):gsub("%.?0+$", "")) .. d[1e0]
        end
    end
    return tostring(a)
end

local function w16(a)
    a = tostring(a):gsub("^%s*[xX]%s*", "")
    local b = tonumber(a)
    if b then return b end
    local c, d = string.match(a, "([%d%.]+)%s*(%a+)")
    if c then return tonumber(c) * (w14.m[d] or 1e0) end
    return nil
end

local function w17(a)
    a = tonumber(a)
    if not a or a ~= a then return "0d 0h 0m" end
    if a == math.huge or a <= -1e18 then return "Never" end
    if a < 0e0 then a = 0e0 end
    local b = math.floor(a / 8.64e4)
    if b >= 1e6 then return w15(b) .. " days" end
    local c = math.floor((a % 8.64e4) / 3.6e3)
    local d = math.floor((a % 3.6e3) / 6e1)
    return string.format("%.0fd %.0fh %.0fm", b, c, d)
end

local function w66(a, b)
    return a .. " -- " .. w15(w16(b) or 0e0)
end

local w18 = {
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

local w19 = {"FS", "BT", "MS", "JF", "PP"}

local w63 = {FS = "1e15", BT = "7.383e12", PP = "3.33e17"}
local w64 = {}
for a, b in pairs(w63) do
    for c, d in ipairs(w18[a]) do
        if d.req == b then
            w64[a] = c
            break
        end
    end
end

local w20 = "TrainingCalc/" .. w5.Name .. ".json"
local w21 = {key = "G", pos = nil, icon = nil, speed = false, train = false, power = "0", cat = nil, mem = {}}
local w22, w25, w28
local w30, w31 = false, false
local w67 = os.clock()

local function w23()
    if not readfile or not isfile(w20) then return end
    local a, b = pcall(function() return w4:JSONDecode(readfile(w20)) end)
    if a and type(b) == "table" then
        w21.key = b.key or "G"
        if type(b.pos) == "table" and type(b.pos.X) == "number" and type(b.pos.Y) == "number" then
            w21.pos = b.pos
        end
        if type(b.icon) == "table" and type(b.icon.X) == "number" and type(b.icon.Y) == "number" then
            w21.icon = b.icon
        end
        w21.speed = b.speed or false
        w21.train = b.train or false
        w21.power = b.power or "0"
        w21.cat = b.cat
        if type(b.mem) == "table" then
            w21.mem = {}
            for c, d in pairs(b.mem) do
                if type(d) == "table" then
                    d.val = tonumber(d.val)
                    d.area = tonumber(d.area)
                    w21.mem[c] = d
                end
            end
        end
    end
end

w22 = function(a)
    if not writefile then return end
    if not isfolder("TrainingCalc") then makefolder("TrainingCalc") end
    if not a and os.clock() - w67 >= 5e0 then
        if w25 and w25.Visible and not w31 then
            w21.pos = {X = w25.Position.X.Offset, Y = w25.Position.Y.Offset}
        end
        if w28 then
            w21.icon = {X = w28.Position.X.Offset, Y = w28.Position.Y.Offset}
        end
    end
    pcall(function() writefile(w20, w4:JSONEncode(w21)) end)
end

w23()

if w6:FindFirstChild("TrainingCalculatorGUI") then
    w6.TrainingCalculatorGUI:Destroy()
end

local w24 = w9("ScreenGui")
w24.Name = "TrainingCalculatorGUI"
w24.ResetOnSpawn = false
w24.Parent = w6
w.gui = w24

w25 = w9("Frame", w24)
w25.Name = "MainFrame"
w25.Size = w7(0e0, 4.8e2, 0e0, 4.7e2)
w25.Position = w21.pos and w7(0e0, w21.pos.X, 0e0, w21.pos.Y) or w7(5e-1, -2.4e2, 5e-1, -2.35e2)
w25.BackgroundColor3 = w11.bg
w25.BorderSizePixel = 0e0
w25.Visible = false
w25.Active = true
w9("UICorner", w25).CornerRadius = UDim.new(0e0, 8e0)

local w26 = w9("UIScale", w25)
w26.Scale = 1e0

local w61 = w9("TextLabel", w25)
w61.Text = "cLTR Training Calculator"
w61.Size = w7(0e0, 3e2, 0e0, 3e1)
w61.Position = w7(0e0, 2e1, 0e0, 1.2e1)
w61.TextColor3 = w11.wht
w61.BackgroundTransparency = 1e0
w61.Font = w10
w61.TextSize = 1.8e1
w61.TextXAlignment = Enum.TextXAlignment.Left

local w27 = w9("TextButton", w25)
w27.Size = w7(0e0, 3e1, 0e0, 3e1)
w27.Position = w7(1e0, -5e1, 0e0, 1.2e1)
w27.BackgroundColor3 = w11.red
w27.Text = "X"
w27.TextColor3 = w11.wht
w27.Font = w10
w27.TextSize = 1.8e1
w27.AutoButtonColor = false
w9("UICorner", w27).CornerRadius = UDim.new(0e0, 6e0)

w28 = w9("TextButton", w24)
w28.Name = "ReopenButton"
w28.Size = w7(0e0, 5e1, 0e0, 5e1)
w28.Position = w21.icon and w7(0e0, w21.icon.X, 0e0, w21.icon.Y) or w7(0e0, 1e2, 0e0, 1e2)
w28.BackgroundColor3 = w11.bg
w28.Text = "cLTR"
w28.TextColor3 = w11.wht
w28.Font = w10
w28.TextSize = 1.2e1
w28.Active = true
w28.AutoButtonColor = false
w9("UICorner", w28).CornerRadius = UDim.new(1e0, 0e0)

local w29 = w9("UIScale", w28)
w29.Scale = 1e0

local function w32(a, b)
    local c, d, e, f = false, false, nil, nil
    w12(a.InputBegan, function(g)
        if g.UserInputType == Enum.UserInputType.MouseButton1 or g.UserInputType == Enum.UserInputType.Touch then
            c, d, e, f = true, false, g.Position, a.Position
        end
    end)
    w12(w2.InputChanged, function(g)
        if c and (g.UserInputType == Enum.UserInputType.MouseMovement or g.UserInputType == Enum.UserInputType.Touch) then
            local h = g.Position - e
            if math.abs(h.X) > 4e0 or math.abs(h.Y) > 4e0 then d = true end
            a.Position = w7(f.X.Scale, f.X.Offset + h.X, f.Y.Scale, f.Y.Offset + h.Y)
        end
    end)
    w12(w2.InputEnded, function(g)
        if c and (g.UserInputType == Enum.UserInputType.MouseButton1 or g.UserInputType == Enum.UserInputType.Touch) then
            c = false
            if not d and b then b() end
            w22()
        end
    end)
end

local function w33()
    if w30 then return end
    w30 = true
    task.spawn(function()
        if w25.Visible then
            w31 = true
            w13(w25, TweenInfo.new(2e-1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = w7(w25.Position.X.Scale, w25.Position.X.Offset, w25.Position.Y.Scale, w25.Position.Y.Offset + 2e1),
                BackgroundTransparency = 1e0
            })
            task.wait(2e-1)
            w25.Visible = false
            w31 = false
            w28.Visible = true
            w28.Size = w7(0e0, 0e0, 0e0, 0e0)
            w28.BackgroundTransparency = 1e0
            w13(w28, TweenInfo.new(3e-1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = w7(0e0, 5e1, 0e0, 5e1),
                BackgroundTransparency = 0e0
            })
            task.wait(3e-1)
        else
            w28.Visible = false
            w25.Visible = true
            w25.Size = w7(0e0, 0e0, 0e0, 0e0)
            w25.BackgroundTransparency = 1e0
            w13(w25, TweenInfo.new(3e-1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = w7(0e0, 4.8e2, 0e0, 4.7e2),
                BackgroundTransparency = 0e0
            })
            task.wait(3e-1)
        end
        w30 = false
        w22()
    end)
end

local function w34(a, b, c)
    local d = a.Size
    local e, f = false, false
    local function g()
        local h = e and UDim2.new(d.X.Scale, d.X.Offset - 6e0, d.Y.Scale, d.Y.Offset - 6e0) or d
        w13(a, TweenInfo.new(e and 1e-1 or 2e-1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = h,
            BackgroundColor3 = e and c or f and c or b
        })
    end
    w12(a.MouseEnter, function() f = true g() end)
    w12(a.MouseLeave, function() f, e = false, false g() end)
    w12(a.MouseButton1Down, function() e = true g() end)
    w12(a.MouseButton1Up, function() e = false g() end)
end

w34(w27, w11.red, w11.redH)
w34(w28, w11.bg, w11.item)

local function w35(a, b, c)
    local d = w9("TextButton", a)
    d.Text = b
    d.Size = w7(1e0, 0e0, 0e0, 3.2e1)
    d.BackgroundColor3 = w11.item
    d.TextColor3 = w11.wht
    d.Font = w10
    d.TextSize = 1.8e1
    d.AutoButtonColor = false
    d.ZIndex = 1e1
    w34(d, w11.item, w11.prs)
    w12(d.MouseButton1Click, function() c(d) end)
    return d
end

local function w36(a, b, c, d)
    local e = w9("TextLabel", a)
    e.Text = b
    e.Size = w7(0e0, 1.2e2, 0e0, 3.2e1)
    e.Position = w7(0e0, 2e1, 0e0, c)
    e.TextColor3 = w11.wht
    e.BackgroundTransparency = 1e0
    e.Font = w10
    e.TextSize = 1.8e1
    e.TextXAlignment = Enum.TextXAlignment.Left

    local f = w9("TextButton", a)
    f.Text = "Select"
    f.Size = w7(0e0, 3.2e2, 0e0, 3.2e1)
    f.Position = w7(0e0, 1.4e2, 0e0, c)
    f.BackgroundColor3 = w11.btn
    f.TextColor3 = w11.wht
    f.Font = w10
    f.TextSize = 1.8e1
    f.AutoButtonColor = false
    w9("UICorner", f).CornerRadius = UDim.new(0e0, 4e0)
    w34(f, w11.btn, w11.hov)

    local g = w9("Frame", a)
    g.Size = w7(0e0, 3.2e2, 0e0, 1.5e2)
    g.Position = w7(0e0, 1.4e2, 0e0, c + 3.8e1)
    g.BackgroundColor3 = w11.drop
    g.Visible = false
    g.ZIndex = 1e1
    w9("UICorner", g).CornerRadius = UDim.new(0e0, 4e0)

    local h = w9("ScrollingFrame", g)
    h.Size = w7(1e0, 0e0, 1e0, 0e0)
    h.BackgroundTransparency = 1e0
    h.ScrollBarThickness = 4e0
    h.CanvasSize = w7(0e0, 0e0, 0e0, 0e0)
    h.AutomaticCanvasSize = Enum.AutomaticSize.Y
    h.ZIndex = 1e1

    local i = w9("UIListLayout", h)
    i.SortOrder = Enum.SortOrder.LayoutOrder
    i.Padding = UDim.new(0e0, 2e0)

    table.insert(d, g)
    w12(f.MouseButton1Click, function()
        for _, j in ipairs(d) do
            j.Visible = j == g and not g.Visible or false
        end
    end)

    return f, g, h
end

local w37 = {}
local w62
local w38, w39, w40 = w36(w25, "Category", 5.6e1, w37)
local w41, w42, w43 = w36(w25, "Area", 1.02e2, w37)
local w44, w45, w46 = w36(w25, "Multiplier", 1.48e2, w37)

local w54 = w9("TextLabel", w42)
w54.Size = w7(1e0, 0e0, 1e0, 0e0)
w54.BackgroundTransparency = 1e0
w54.Text = "No category to show areas."
w54.TextColor3 = w11.dim
w54.Font = w10
w54.TextSize = 1.6e1
w54.ZIndex = 1e1
w43.Visible = false

local w47 = w9("TextLabel", w25)
w47.Text = "Current Power"
w47.Size = w7(0e0, 1.2e2, 0e0, 3.2e1)
w47.Position = w7(0e0, 2e1, 0e0, 1.94e2)
w47.TextColor3 = w11.wht
w47.BackgroundTransparency = 1e0
w47.Font = w10
w47.TextSize = 1.8e1
w47.TextXAlignment = Enum.TextXAlignment.Left

local w48 = w9("TextBox", w25)
w48.Text = w21.power
w48.Size = w7(0e0, 3.2e2, 0e0, 3.2e1)
w48.Position = w7(0e0, 1.4e2, 0e0, 1.94e2)
w48.BackgroundColor3 = w11.inp
w48.TextColor3 = w11.wht
w48.Font = w10
w48.TextSize = 1.8e1
w48.ClearTextOnFocus = true
w48.PlaceholderText = "Enter your current power"
w48.PlaceholderColor3 = w11.dim
w9("UICorner", w48).CornerRadius = UDim.new(0e0, 4e0)
w12(w48.FocusLost, function(a)
    if a then
        if w62 then
            w21.mem[w62] = w21.mem[w62] or {}
            w21.mem[w62].power = w48.Text
        else
            w21.power = w48.Text
        end
        w22()
    end
end)

local w49 = w9("TextButton", w25)
w49.Size = w7(0e0, 2.1e2, 0e0, 3.2e1)
w49.Position = w7(0e0, 2e1, 0e0, 2.4e2)
w49.BackgroundColor3 = w11.btn
w49.TextColor3 = w11.wht
w49.Font = w10
w49.TextSize = 1.8e1
w49.AutoButtonColor = false
w9("UICorner", w49).CornerRadius = UDim.new(0e0, 4e0)

local w50 = w9("TextButton", w25)
w50.Size = w7(0e0, 2.1e2, 0e0, 3.2e1)
w50.Position = w7(0e0, 2.5e2, 0e0, 2.4e2)
w50.BackgroundColor3 = w11.btn
w50.TextColor3 = w11.wht
w50.Font = w10
w50.TextSize = 1.8e1
w50.AutoButtonColor = false
w9("UICorner", w50).CornerRadius = UDim.new(0e0, 4e0)

local w52 = w9("TextButton", w25)
w52.Text = "Calculate"
w52.Size = w7(0e0, 4.4e2, 0e0, 4e1)
w52.Position = w7(0e0, 2e1, 0e0, 2.86e2)
w52.BackgroundColor3 = w11.org
w52.TextColor3 = w11.wht
w52.Font = w10
w52.TextSize = 1.8e1
w52.AutoButtonColor = false
w9("UICorner", w52).CornerRadius = UDim.new(0e0, 4e0)

local w53 = w9("TextLabel", w25)
w53.Text = ""
w53.Size = w7(0e0, 4.4e2, 0e0, 1.1e2)
w53.Position = w7(0e0, 2e1, 0e0, 3.4e2)
w53.TextColor3 = w11.wht
w53.BackgroundTransparency = 1e0
w53.Font = w10
w53.TextSize = 1.6e1
w53.TextWrapped = true
w53.TextXAlignment = Enum.TextXAlignment.Left
w53.TextYAlignment = Enum.TextYAlignment.Top

local w55 = {}
for _, a in ipairs({{1e0, 1.024e3}, {1.024e3, 1.048576e6}, {1.048576e6, 1.6777216e7 + 1e0}}) do
    local b = a[1e0]
    while b < a[2e0] do
        local c = b >= 1.048576e6 and tostring(math.floor(b / 1.048576e6)) .. "M" or b >= 1.024e3 and tostring(math.floor(b / 1.024e3)) .. "k" or tostring(math.floor(b))
        table.insert(w55, {c, b})
        b = b * 2e0
    end
end

for _, a in ipairs(w55) do
    w35(w46, a[1e0], function(b)
        w44.Text = a[1e0]
        w44:SetAttribute("Val", a[2e0])
        w45.Visible = false
        if w62 then
            w21.mem[w62] = w21.mem[w62] or {}
            w21.mem[w62].mult = a[1e0]
            w21.mem[w62].val = a[2e0]
            w22()
        end
    end)
end

local function w65(a)
    w38.Text = a
    w39.Visible = false
    w41.Text = "Select"
    w41:SetAttribute("Mult", nil)
    w41:SetAttribute("Min", nil)
    w41:SetAttribute("Idx", nil)
    w41:SetAttribute("Boost", nil)
    w54.Visible = false
    w43.Visible = true
    w62 = a
    w21.cat = a
    for _, c in ipairs(w43:GetChildren()) do
        if c:IsA("TextButton") then c:Destroy() end
    end
    for d, e in ipairs(w18[a]) do
        local f = not w64[a] or d >= w64[a]
        w35(w43, w66(e.name, e.req), function(g)
            w41.Text = g.Text
            w41:SetAttribute("Mult", e.multi)
            w41:SetAttribute("Min", e.min)
            w41:SetAttribute("Idx", d)
            w41:SetAttribute("Boost", f)
            w42.Visible = false
            w21.mem[a] = w21.mem[a] or {}
            w21.mem[a].area = d
            w22()
        end)
    end
    local h = w21.mem[a]
    w44.Text = h and h.mult or "Select"
    w44:SetAttribute("Val", h and h.val or nil)
    w48.Text = h and h.power or "0"
    if h and type(h.area) == "number" and w18[a][h.area] then
        local i = w18[a][h.area]
        w41.Text = w66(i.name, i.req)
        w41:SetAttribute("Mult", i.multi)
        w41:SetAttribute("Min", i.min)
        w41:SetAttribute("Idx", h.area)
        w41:SetAttribute("Boost", not w64[a] or h.area >= w64[a])
    end
    w22()
end

for _, a in ipairs(w19) do
    w35(w40, a, function() w65(a) end)
end

if w21.cat and w18[w21.cat] then
    w65(w21.cat)
end

local function w51()
    w49.Text = "Speed 2x: " .. (w21.speed and "ON" or "OFF")
    w49.BackgroundColor3 = w21.speed and w11.cy or w11.btn
    w50.Text = "Training 2x: " .. (w21.train and "ON" or "OFF")
    w50.BackgroundColor3 = w21.train and w11.pu or w11.btn
end

w12(w49.MouseButton1Click, function()
    w21.speed = not w21.speed
    w51()
    w22()
end)

w12(w50.MouseButton1Click, function()
    w21.train = not w21.train
    w51()
    w22()
end)

w12(w52.MouseButton1Click, function()
    local a = w41:GetAttribute("Mult")
    local b = w41:GetAttribute("Idx")
    if not a or not b then
        w53.Text = "Select an area."
        return
    end
    local c = w44:GetAttribute("Val")
    if not c then
        w53.Text = "Select a multiplier."
        return
    end
    local d = w16(a)
    if not d then
        w53.Text = "Unknown area multiplier."
        return
    end
    local e = w41:GetAttribute("Boost")
    local f = nil
    if w18[w38.Text][b + 1e0] then
        local g = w18[w38.Text][b + 1e0]
        f = w16(w38.Text == "BT" and g.min or g.req)
    end
    local h = d * c
    if w21.train and e then h = h * 2e0 end
    local i = f and math.max(0e0, f - (w16(w48.Text) or 0e0)) or 0e0
    local j = f and i / h or 0e0
    if w21.speed and e then j = j / 2e0 end
    local k = f and "Estimated time to next area: " .. w17(j) or "Last area selected."
    w53.Text = "Production per second: " .. w15(h) ..
        "\nPer minute: " .. w15(h * 6e1) ..
        "\nPer hour: " .. w15(h * 3.6e3) ..
        "\nPer day: " .. w15(h * 8.64e4) ..
        "\n" .. k
end)

w34(w52, w11.org, w11.orgH)

local function w56()
    return workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1.92e3, 1.08e3)
end

local function w57()
    local a = w56()
    return math.clamp(math.min(a.X / 1.92e3, a.Y / 1.08e3), 7.5e-1, 1.2e0)
end

local function w58()
    local a = w57()
    w26.Scale = a
    w29.Scale = a
    return a
end

local function w59(a)
    local b = w58()
    local c = w56()
    local d = 4.8e2 * b
    local e = 4.7e2 * b
    local f = 5e1 * b
    local g, h = w21.pos and not a, w21.icon and not a
    w25.Position = g and w7(
        0e0, math.clamp(w21.pos.X, 0e0, math.max(0e0, c.X - d)),
        0e0, math.clamp(w21.pos.Y, 0e0, math.max(0e0, c.Y - e))
    ) or w7(0e0, math.max(0e0, (c.X - d) / 2e0), 0e0, math.max(0e0, (c.Y - e) / 2e0))
    w28.Position = h and w7(
        0e0, math.clamp(w21.icon.X, 0e0, math.max(0e0, c.X - f)),
        0e0, math.clamp(w21.icon.Y, 0e0, math.max(0e0, c.Y - f))
    ) or w7(0e0, math.max(0e0, 2e1 * b), 0e0, math.max(0e0, math.min(3e1 * b, c.Y - f)))
    if a then
        w21.pos = nil
        w21.icon = nil
        w22(true)
    end
end

local function w68()
    if os.clock() - w67 < 5e0 then
        w59()
    else
        w59(true)
    end
end

w12(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w68)
w12(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
    if workspace.CurrentCamera then
        w12(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w68)
    end
end)

w32(w25, nil)
w32(w28, w33)
w12(w27.MouseButton1Click, w33)

local w60
pcall(function() w60 = Enum.KeyCode[w21.key] end)

w12(w2.InputBegan, function(a, b)
    if b or w30 or w31 or not w60 or a.KeyCode ~= w60 then return end
    w33()
end)

w51()
w59()
