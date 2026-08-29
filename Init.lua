local pl, rs, ui, tw, hs = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("HttpService")

local p = pl.LocalPlayer
local sg = p:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

local og = sg:FindFirstChild("eSPTSUI")
if og then og:Destroy() task.wait(.1) end

if _eSPTS then
        for _, w in pairs(_eSPTS.cn or {}) do pcall(function() w:Disconnect() end) end
        for _, w in pairs(_eSPTS.tw or {}) do pcall(function() w:Cancel() end) end
        for _, w in pairs(_eSPTS.th or {}) do
                if typeof(w) == "thread" and coroutine.status(w) ~= "dead" then pcall(task.cancel, w) end
        end
end

_eSPTS = { cn = {}, tw = {}, th = {} }

local nm = p.Name
local id = p.UserId
if not nm or nm == "" then repeat nm = p.Name task.wait() until nm and nm ~= "" end

local cf = { kb = "G", st = nil, aw = false, as = true, tb = "Auto Farm", sv = nil, up = nil, rp = nil, fm = nil, ah = false }
local mf
local lt = 0
local vp = false
local fq = 0
local fp = "eSPTS/Accounts/" .. nm .. ".json"

local inf = sg:WaitForChild("MenuFrame"):WaitForChild("InfoFrame")
local ap = workspace:WaitForChild("Map"):WaitForChild("Training_Collisions")
local re = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")

local function ef()
        if not makefolder or not isfolder then return end
        if not isfolder("eSPTS") then makefolder("eSPTS") end
        if not isfolder("eSPTS/Accounts") then makefolder("eSPTS/Accounts") end
end

local function sv2()
        if not writefile then return false end
        ef()
        if mf and mf.Visible then cf.up = { X = mf.Position.X.Offset, Y = mf.Position.Y.Offset } end
        if rb and rb.Visible then cf.rp = { X = rb.Position.X.Offset, Y = rb.Position.Y.Offset } end
        local a, b, c, d, e, f, g, h, i, j, k, l, m
        if cf.sv then a, b, c, d, e, f, g, h, i, j, k, l, m = cf.sv:GetComponents() end
        local sv = { a, b, c, d, e, f, g, h, i, j, k, l, m }
        local dt = { id = id, nm = nm, kb = cf.kb, st = cf.st, aw = cf.aw, as = cf.as, tb = cf.tb, sv = a and sv or nil, up = cf.up, rp = cf.rp, fm = cf.fm, ah = cf.ah }
        local ok = pcall(function() writefile(fp, hs:JSONEncode(dt)) end)
        if ok then lt = tick() vp = false return true end
        vp = false
        return false
end

local function ds()
        if vp then return end
        vp = true
        local w = tick() - lt
        if w >= .1 then sv2()
        else task.delay(.1 - w, function() if vp then sv2() end end) end
end

local function lc()
        if not readfile or not isfile or not isfile(fp) then return false end
        local ok, dt = pcall(function() return hs:JSONDecode(readfile(fp)) end)
        if not ok or not dt or dt.id ~= id then return false end
        cf.kb = dt.kb or "G"
        cf.st = dt.st
        cf.aw = dt.aw or false
        cf.as = dt.as ~= nil and dt.as or true
        cf.tb = dt.tb or "Auto Farm"
        if dt.sv and #dt.sv == 12 then cf.sv = CFrame.new(unpack(dt.sv)) end
        cf.up = dt.up
        cf.rp = dt.rp
        cf.fm = dt.fm
        cf.ah = dt.ah or false
        return true
end

local ti = {
        f = TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        m = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        s = TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        b = TweenInfo.new(.50, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        bi = TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        sm = TweenInfo.new(.30, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
}

local yt = {}

local function xt(w)
        if yt[w] then yt[w]:Cancel() yt[w] = nil end
end

local function pt(w, w2, w3)
        xt(w)
        local w4 = tw:Create(w, w2, w3)
        yt[w] = w4
        w4:Play()
        w4.Completed:Connect(function(w5) if w5 == Enum.TweenStatus.Completed then yt[w] = nil end end)
        return w4
end

local function cn(w, f)
        local c = w:Connect(f)
        _eSPTS.cn[#_eSPTS.cn + 1] = c
        return c
end

local thr = {}

local function kl(n)
        if thr[n] then
                local w = thr[n] thr[n] = nil
                if typeof(w) == "thread" and coroutine.status(w) ~= "dead" then pcall(task.cancel, w) end
        end
end

local db = {}

local function dbn(n, d)
        if db[n] then return false end
        db[n] = true
        task.delay(d or .3, function() db[n] = false end)
        return true
end

local ar = {
        BodyToughness = {
                FireBathTouchPart = { req = "500", multi = "x10" }, Water = { req = "5", multi = "x5" },
                IcePart = { req = "5K", multi = "x20" }, LavaPart = { req = "500K", multi = "x100" },
                TornadoTouchPart = { req = "50K", multi = "x50" }, GreenFirePart = { req = "50M", multi = "x2000" },
                AcidPart = { req = "5B", multi = "x40000" }, LavaPart2 = { req = "500B", multi = "x800000" },
                AFK_BT_1 = { req = "7.383T", multi = "x6M" }, AFK_BT_2 = { req = "655T", multi = "x180M" },
                AFK_BT_3 = { req = "66.6Qa", multi = "x5.5B" }, AFK_BT_4 = { req = "5.1Qi", multi = "x162.5B" },
                AFK_BT_5 = { req = "460Qi", multi = "x5T" }, AFK_BT_6 = { req = "40.05Sx", multi = "x150T" },
                AFK_BT_7 = { req = "3.55Sp", multi = "x4.5Qa" }, AFK_BT_8 = { req = "314Sp", multi = "x131.2Qa" },
                AFK_BT_9 = { req = "27.78Oc", multi = "x3.925Qi" }, AFK_BT_10 = { req = "2.473No", multi = "x118Qi" },
                AFK_BT_11 = { req = "217.5No", multi = "x3.55Sx" }, AFK_BT_12 = { req = "19.5Dc", multi = "x106.2Sx" },
                AFK_BT_13 = { req = "1.7Ud", multi = "x3.2Sp" }, AFK_BT_14 = { req = "155Ud", multi = "x95.74Sp" },
                AFK_BT_15 = { req = "13.56Dd", multi = "x2.5Oc" }
        },
        FistStrength = {
                TrainingArea_2 = { req = "0", multi = "x10" }, AFK_FS_1 = { req = "1Qa", multi = "x6M" },
                TrainingArea_3 = { req = "1M", multi = "x100" }, StarFSTraining1 = { req = "1B", multi = "x2000" },
                StarFSTraining2 = { req = "100B", multi = "x40000" }, StarFSTraining3 = { req = "10T", multi = "x800000" },
                AFK_FS_2 = { req = "100Qa", multi = "x300M" }, AFK_FS_3 = { req = "15Qi", multi = "x21B" },
                AFK_FS_4 = { req = "2.5Sx", multi = "x2.308T" }, AFK_FS_5 = { req = "1Sp", multi = "x347.5T" },
                AFK_FS_6 = { req = "500Sp", multi = "x52Qa" }, AFK_FS_7 = { req = "250Oc", multi = "x7.8Qi" },
                AFK_FS_8 = { req = "150No", multi = "??" }, AFK_FS_9 = { req = "55Dc", multi = "??" },
                AFK_FS_10 = { req = "30Ud", multi = "??" }, AFK_FS_11 = { req = "11Dd", multi = "??" }
        },
        MovementSpeed = {
                AFK_MS_1 = { req = "100T", multi = "x1.3M" }, AFK_MS_2 = { req = "2.22Qa", multi = "x16.9M" },
                AFK_MS_3 = { req = "60Qa", multi = "x219.7M" }, AFK_MS_4 = { req = "1.5Qi", multi = "x2.85B" },
                AFK_MS_5 = { req = "40Qi", multi = "x37.2B" }, AFK_MS_6 = { req = "1Sx", multi = "x482.4B" },
                AFK_MS_7 = { req = "25Sx", multi = "x6.274T" }, AFK_MS_8 = { req = "750Sx", multi = "x81.5T" },
                AFK_MS_9 = { req = "15.5Sp", multi = "x2.12Qa" }, AFK_MS_10 = { req = "400Sp", multi = "x13.77Qa" },
                AFK_MS_11 = { req = "10Oc", multi = "x179.2Qa" }
        },
        PsychicPower = {
                PPTrainingPart1 = { req = "1M", multi = "x100" }, PPTrainingPart2 = { req = "1B", multi = "x10k" },
                PPTrainingPart3 = { req = "1T", multi = "x1M" }, PPTrainingPart4 = { req = "1Qa", multi = "x100M" },
                AFK_PP_1 = { req = "333Qa", multi = "x2.5B" }, AFK_PP_2 = { req = "111Qi", multi = "x250B" },
                AFK_PP_3 = { req = "33.3Sx", multi = "x25T" }, AFK_PP_4 = { req = "11.1Sp", multi = "x2.5Qa" },
                AFK_PP_5 = { req = "3.36Oc", multi = "x250Qa" }, AFK_PP_6 = { req = "1.11No", multi = "x25Qi" },
                AFK_PP_7 = { req = "444No", multi = "x2.5Sx" }, AFK_PP_8 = { req = "111Dc", multi = "??" },
                AFK_PP_9 = { req = "55.5Ud", multi = "??" }, AFK_PP_10 = { req = "22.2Dd", multi = "??" }
        },
        JumpForce = {
                AFK_JF_1 = { req = "100T", multi = "x1.7M" }, AFK_JF_2 = { req = "5Qa", multi = "x30.5M" },
                AFK_JF_3 = { req = "150Qa", multi = "x550M" }, AFK_JF_4 = { req = "5Qi", multi = "x9.92B" },
                AFK_JF_5 = { req = "200Qi", multi = "??" }, AFK_JF_6 = { req = "10Sx", multi = "??" },
                AFK_JF_7 = { req = "300Sx", multi = "??" }, AFK_JF_8 = { req = "15Sp", multi = "??" },
                AFK_JF_9 = { req = "400Sp", multi = "??" }
        }
}

local wl = {
        { n = "100 LB", m = 100, j = 5000 }, { n = "1 TON", m = 5000, j = 200000 },
        { n = "10 TON", m = 500000, j = 2000000 }, { n = "100 TON", m = 10000000, j = 10000000 },
        { n = "1 K TON", m = 100000000, j = 200000000 }, { n = "10 K TON", m = 1000000000, j = 1000000000 },
        { n = "100 K TON", m = 10000000000, j = 10000000000 }, { n = "1 M TON", m = 100000000000, j = 100000000000 },
        { n = "10 M TON", m = 1e12, j = 1e12 }, { n = "1 B TON", m = 1e13, j = 1e13 },
        { n = "100 B TON", m = 2.56e28, j = 1.54e28 }, { n = "10 T TON", m = 0, j = 6e26 },
        { n = "1 Qa TON", m = 1.68e32, j = 2.221e31 }, { n = "100 Qa TON", m = 4.288e33, j = 8.48e31 },
        { n = "10 Qi TON", m = 1.082e34, j = 3.226e33 }, { n = "1 Sx TON", m = 2.823e36, j = 1.229e36 },
        { n = "100 Sx TON", m = 7.02e37, j = 4.683e37 }, { n = "10 Sp TON", m = 1.852e39, j = 1.785e39 },
        { n = "10 Oc TON", m = 4.744e39, j = 6.8e39 }
}

local uo = {
        { "K", 1e3 }, { "M", 1e6 }, { "B", 1e9 }, { "T", 1e12 },
        { "Qa", 1e15 }, { "Qi", 1e18 }, { "Sx", 1e21 }, { "Sp", 1e24 },
        { "Oc", 1e27 }, { "No", 1e30 }, { "Dc", 1e33 }, { "Ud", 1e36 }, { "Dd", 1e39 }
}

local function ctn(s)
        if not s then return 0 end
        local w = tostring(s):gsub("%s+", "")
        local w1, w2 = w:match("([%d%.]+)(%a*)$")
        local w3 = tonumber(w1) or 0
        if w2 == "" then return w3 end
        for _, w4 in ipairs(uo) do if w4[1] == w2 then return w3 * w4[2] end end
        return w3
end

local sp = {
        FistStrength = inf:WaitForChild("FSTxt"),
        BodyToughness = inf:WaitForChild("BTTxt"),
        PsychicPower = inf:WaitForChild("PPTxt"),
        JumpForce = inf:WaitForChild("JFTxt"),
        MovementSpeed = inf:WaitForChild("MSTxt")
}

local function gcs(w)
        local w1 = sp[w]
        if not w1 then return 0 end
        return ctn(w1.Text)
end

local function fba(w, w2)
        local w3 = ar[w]
        if not w3 then return nil end
        local w4, w5 = nil, -1
        for w6, w7 in pairs(w3) do
                local w8 = ctn(w7.req)
                if w2 >= w8 and w8 > w5 then w4 = w6 w5 = w8 end
        end
        return w4, w5
end

local function fna(w, w2)
        local w3 = ar[w]
        if not w3 then return nil end
        local w4, w5 = nil, math.huge
        for w6, w7 in pairs(w3) do
                local w8 = ctn(w7.req)
                if w8 > w2 and w8 < w5 then w4 = w6 w5 = w8 end
        end
        return w4, w5
end

local function fbp(w, w2)
        local w3 = ar[w]
        if not w3 then return nil end
        local w4, w5 = nil, -1
        local w6, w7 = nil, -1
        for w8, w9 in pairs(w3) do
                local w10 = ctn(w9.req)
                if w2 >= w10 and w10 > w5 then
                        w6 = w4 w7 = w5
                        w4 = w8 w5 = w10
                elseif w2 >= w10 and w10 > w7 and w10 < w5 then
                        w6 = w8 w7 = w10
                end
        end
        return w6
end

local function gao(w, w2)
        local w3 = ap:FindFirstChild(w)
        if not w3 then return nil end
        return w3:FindFirstChild(w2)
end

local function tta(w)
        if not w then return false end
        local w1 = p.Character
        if not w1 then return false end
        local w2 = w1:FindFirstChild("HumanoidRootPart")
        if not w2 then return false end
        local w3
        if w:IsA("BasePart") then
                w3 = w.CFrame
        else
                local w4 = w.PrimaryPart or w:FindFirstChildWhichIsA("BasePart")
                if w4 then w3 = w4.CFrame end
        end
        if w3 then
                w2.CFrame = w3 + Vector3.new(0, 5, 0)
                return true, w3 + Vector3.new(0, 5, 0)
        end
        return false
end

local function ebw()
        local w = gcs("MovementSpeed")
        local w1 = gcs("JumpForce")
        local w2, w3 = nil, 1
        for w4, w5 in ipairs(wl) do
                if w >= w5.m and w1 >= w5.j then w2 = w5 w3 = w4 else break end
        end
        if w2 then re:FireServer(unpack({ { "EquipWeight_Request", w3 } })) end
end

local function cr(w, w2)
        local w3 = Instance.new("UICorner", w)
        w3.CornerRadius = UDim.new(0, w2 or 8)
        return w3
end

local function gr(w, w2, w3, w4)
        local w5 = Instance.new("UIGradient", w)
        w5.Color = ColorSequence.new { ColorSequenceKeypoint.new(0, w2), ColorSequenceKeypoint.new(1, w3) }
        w5.Rotation = w4 or 90
        return w5
end

local function cd(w, w2, w3)
        local w4 = Instance.new("Frame", w)
        w4.Size = UDim2.new(1, 0, 0, w2)
        w4.BackgroundColor3 = Color3.fromRGB(32, 24, 45)
        w4.BorderSizePixel = 0
        w4.LayoutOrder = w3 or 1
        cr(w4, 10)
        gr(w4, Color3.fromRGB(32, 24, 45), Color3.fromRGB(38, 28, 52), 90)
        return w4
end

local function sh(w, w2, w3)
        local w4 = Instance.new("TextLabel", w)
        w4.Size = UDim2.new(1, -20, 0, 20)
        w4.Position = UDim2.new(0, 10, 0, w3)
        w4.BackgroundTransparency = 1
        w4.Text = w2
        w4.Font = Enum.Font.Gotham
        w4.TextSize = 12
        w4.TextColor3 = Color3.fromRGB(150, 150, 150)
        w4.TextXAlignment = Enum.TextXAlignment.Left
        return w4
end

local function stl(w, w2, w3)
        local w4 = Instance.new("TextLabel", w)
        w4.Size = UDim2.new(1, -20, 0, 26)
        w4.Position = UDim2.new(0, 10, 0, w3)
        w4.BackgroundTransparency = 1
        w4.Text = w2
        w4.Font = Enum.Font.GothamBold
        w4.TextSize = 18
        w4.TextXAlignment = Enum.TextXAlignment.Left
        return w4
end

local function tp(w, w2, w3)
        local w4 = Instance.new("Frame", w)
        w4.Size = UDim2.new(1, -20, 0, 40)
        w4.Position = UDim2.new(0, 10, 0, w3)
        w4.BackgroundColor3 = Color3.fromRGB(38, 28, 52)
        w4.BorderSizePixel = 0
        cr(w4, 8)
        local w5 = Instance.new("TextLabel", w4)
        w5.Size = UDim2.new(1, -70, 1, 0)
        w5.Position = UDim2.new(0, 14, 0, 0)
        w5.BackgroundTransparency = 1
        w5.Text = w2
        w5.Font = Enum.Font.GothamBold
        w5.TextSize = 14
        w5.TextColor3 = Color3.fromRGB(200, 200, 200)
        w5.TextXAlignment = Enum.TextXAlignment.Left
        return w4, w5
end

local function mt(w, w2, w3, w4)
        local w5 = w2.X.Offset or 56
        local w6 = w2.Y.Offset or 28
        local w7 = w6 - 6
        local w8 = 3
        local w9 = w5 - w7 - 3
        local w10 = Instance.new("Frame", w)
        w10.Size = UDim2.new(0, w5, 0, w6)
        w10.Position = UDim2.new(1, -(w5 + 14), 0.5, 0)
        w10.AnchorPoint = Vector2.new(0, 0.5)
        w10.BorderSizePixel = 0
        w10.BackgroundColor3 = w4 and Color3.fromRGB(50, 220, 100) or Color3.fromRGB(70, 50, 90)
        cr(w10, w6 / 2)
        local w11 = Instance.new("Frame", w10)
        w11.Size = UDim2.new(0, w7, 0, w7)
        w11.Position = UDim2.new(0, w4 and w9 or w8, 0.5, 0)
        w11.AnchorPoint = Vector2.new(0, 0.5)
        w11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        w11.BorderSizePixel = 0
        cr(w11, w7 / 2)
        local w12 = Instance.new("TextButton", w10)
        w12.Size = UDim2.new(1, 0, 1, 0)
        w12.BackgroundTransparency = 1
        w12.Text = ""
        w12.ZIndex = w10.ZIndex + 2
        local w13 = { v = w4, t = w10, k = w11, ox = w8, nx = w9 }
        return w12, w13
end

local function stg(w, w2)
        if not w then return end
        w.v = w2
        pt(w.t, ti.f, { BackgroundColor3 = w2 and Color3.fromRGB(50, 220, 100) or Color3.fromRGB(70, 50, 90) })
        pt(w.k, ti.f, { Position = UDim2.new(0, w2 and w.nx or w.ox, 0.5, 0) })
end

local function ba(w, w2, w3, w4)
        cn(w.MouseEnter, function() pt(w, ti.f, w3) end)
        cn(w.MouseLeave, function() pt(w, ti.f, w2) end)
        cn(w.MouseButton1Down, function() pt(w, ti.f, w4) end)
        cn(w.MouseButton1Up, function() pt(w, ti.f, w3) end)
end

local function ip(w, w2, w3, w4)
        local w5 = Instance.new("Frame", w)
        w5.Size = w2
        w5.Position = w3
        w5.BackgroundColor3 = Color3.fromRGB(28, 20, 40)
        w5.BorderSizePixel = 0
        cr(w5, 8)
        Instance.new("UIStroke", w5).Color = Color3.fromRGB(70, 45, 95)
        local w6 = Instance.new("TextLabel", w5)
        w6.Size = UDim2.new(1, -10, 1, -10)
        w6.Position = UDim2.new(0, 5, 0, 5)
        w6.BackgroundTransparency = 1
        w6.Text = w4
        w6.Font = Enum.Font.Gotham
        w6.TextSize = 14
        w6.TextColor3 = Color3.fromRGB(180, 180, 180)
        w6.TextXAlignment = Enum.TextXAlignment.Left
        w6.TextWrapped = true
        w6.TextYAlignment = Enum.TextYAlignment.Top
        return w5, w6
end

local function sr(w, w2)
        local w3 = Instance.new("Frame", w)
        w3.Size = UDim2.new(1, -20, 0, 1)
        w3.Position = UDim2.new(0, 10, 0, w2)
        w3.BackgroundColor3 = Color3.fromRGB(70, 45, 95)
        w3.BorderSizePixel = 0
        return w3
end

local function lg(w, w2, w3, w4)
        local w5 = Instance.new("Frame", w)
        w5.Size = w2
        w5.Position = w3
        w5.BackgroundColor3 = Color3.fromRGB(18, 14, 26)
        w5.BorderSizePixel = 0
        cr(w5, 8)
        Instance.new("UIStroke", w5).Color = Color3.fromRGB(70, 45, 95)
        local w6 = Instance.new("ScrollingFrame", w5)
        w6.Size = UDim2.new(1, -4, 1, -4)
        w6.Position = UDim2.new(0, 2, 0, 2)
        w6.BackgroundTransparency = 1
        w6.BorderSizePixel = 0
        w6.ScrollBarThickness = 3
        w6.ScrollBarImageColor3 = w4 or Color3.fromRGB(150, 80, 255)
        w6.ScrollBarImageTransparency = 0.5
        w6.CanvasSize = UDim2.new(0, 0, 0, 0)
        w6.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local w7 = Instance.new("UIListLayout", w6)
        w7.SortOrder = Enum.SortOrder.LayoutOrder
        w7.Padding = UDim.new(0, 2)
        local w8 = Instance.new("UIPadding", w6)
        w8.PaddingLeft = UDim.new(0, 6) w8.PaddingRight = UDim.new(0, 6)
        w8.PaddingTop = UDim.new(0, 4) w8.PaddingBottom = UDim.new(0, 4)
        local w9 = Instance.new("TextLabel", w6)
        w9.Size = UDim2.new(1, 0, 0, 20)
        w9.BackgroundTransparency = 1
        w9.Font = Enum.Font.Code
        w9.TextSize = 11
        w9.TextColor3 = Color3.fromRGB(90, 90, 100)
        w9.TextXAlignment = Enum.TextXAlignment.Left
        w9.LayoutOrder = 1
        local w10 = 1
        local function w11(w12, w13)
                w9.Visible = false
                w10 = w10 + 1
                local w14 = os.date and os.date("%H:%M:%S") or "\xe2\x80\x94"
                local w15 = Instance.new("TextLabel", w6)
                w15.Size = UDim2.new(1, 0, 0, 0)
                w15.AutomaticSize = Enum.AutomaticSize.Y
                w15.BackgroundTransparency = 1
                w15.Text = "[" .. w14 .. "] " .. w12
                w15.Font = Enum.Font.Code
                w15.TextSize = 11
                w15.TextColor3 = w13 or Color3.fromRGB(220, 220, 220)
                w15.TextXAlignment = Enum.TextXAlignment.Left
                w15.TextYAlignment = Enum.TextYAlignment.Top
                w15.TextWrapped = true
                w15.LayoutOrder = w10
                task.defer(function() w6.CanvasPosition = Vector2.new(0, math.huge) end)
                return w15
        end
        local function w16()
                for _, w17 in ipairs(w6:GetChildren()) do
                        if w17:IsA("TextLabel") and w17 ~= w9 then w17:Destroy() end
                end
                w10 = 1
                w9.Visible = true
        end
        return w5, w6, w9, w11, w16
end

local _pl = {}
local alFn
local function al(w2, w3)
        if alFn then alFn(w2, w3)
        else table.insert(_pl, { w2, w3 }) end
end

local mg = Instance.new("ScreenGui")
mg.Name = "eSPTSUI"
mg.ResetOnSpawn = false
mg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
mg.Parent = sg
_eSPTS.ui = mg

local bW, bH, bR = 600, 480, 56
local sc = 1
local us = nil

local function gVp()
        return workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
end

local function gSc(v)
        return math.clamp(math.min(v.X / 1920, v.Y / 1080), 0.75, 1.4)
end

local function gMP(v, s)
        local w = bW * s local h = bH * s
        return math.max(0, (v.X - w) / 2), math.max(0, (v.Y - h) / 2)
end

local function gRP(v, s)
        local r = math.floor(bR * s)
        return r, math.max(0, (v.X - r) / 3), math.max(0, math.min(30, v.Y - r))
end

mf = Instance.new("Frame", mg)
mf.Name = "MainFrame"
mf.Size = UDim2.new(0, 0, 0, 0)
mf.Position = UDim2.new(0, 0, 0, 0)
mf.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
mf.BorderSizePixel = 0
mf.Active = true
mf.ClipsDescendants = true
mf.Visible = false
cr(mf, 16)

us = Instance.new("UIScale", mf)
us.Scale = 1

local function dr(fr, cb)
        local w1, w2, w3, w4 = false, nil, nil, nil
        cn(fr.InputBegan, function(w5)
                if w5.UserInputType == Enum.UserInputType.MouseButton1 or w5.UserInputType == Enum.UserInputType.Touch then
                        w1 = true w3 = w5.Position w4 = fr.Position
                        if w2 then w2:Disconnect() end
                        w2 = ui.InputChanged:Connect(function(w6)
                                if (w6.UserInputType == Enum.UserInputType.MouseMovement or w6.UserInputType == Enum.UserInputType.Touch) and w1 then
                                        local w7 = w6.Position - w3
                                        fr.Position = UDim2.new(w4.X.Scale, w4.X.Offset + w7.X, w4.Y.Scale, w4.Y.Offset + w7.Y)
                                end
                        end)
                        w5.Changed:Connect(function()
                                if w5.UserInputState == Enum.UserInputState.End then
                                        w1 = false
                                        if w2 then w2:Disconnect() w2 = nil end
                                        if cb then cb() end
                                end
                        end)
                end
        end)
end

dr(mf, function() ds() end)

local shd = Instance.new("ImageLabel", mf)
shd.BackgroundTransparency = 1
shd.Position = UDim2.new(0, -15, 0, -15)
shd.Size = UDim2.new(1, 30, 1, 30)
shd.ZIndex = 0
shd.Image = "rbxassetid://6014261993"
shd.ImageColor3 = Color3.fromRGB(10, 5, 15)
shd.ImageTransparency = 0.5
shd.ScaleType = Enum.ScaleType.Slice
shd.SliceCenter = Rect.new(49, 49, 450, 450)

local tbr = Instance.new("Frame", mf)
tbr.Size = UDim2.new(1, 0, 0, 46)
tbr.BackgroundColor3 = Color3.fromRGB(32, 24, 45)
tbr.BorderSizePixel = 0
cr(tbr, 16)
gr(tbr, Color3.fromRGB(35, 26, 48), Color3.fromRGB(26, 20, 38), 90)

local ttl = Instance.new("TextLabel", tbr)
ttl.Size = UDim2.new(1, -60, 1, 0)
ttl.Position = UDim2.new(0, 14, 0, 0)
ttl.BackgroundTransparency = 1
ttl.Text = "eSPTS"
ttl.Font = Enum.Font.GothamBold
ttl.TextSize = 22
ttl.TextColor3 = Color3.fromRGB(255, 255, 255)
ttl.TextXAlignment = Enum.TextXAlignment.Left

local clb = Instance.new("ImageButton", tbr)
clb.Size = UDim2.new(0, 28, 0, 28)
clb.Position = UDim2.new(1, -14, 0.5, 0)
clb.AnchorPoint = Vector2.new(1, 0.5)
clb.BackgroundColor3 = Color3.fromRGB(180, 50, 220)
clb.BorderSizePixel = 0
clb.Image = "rbxassetid://3926305904"
clb.ImageRectOffset = Vector2.new(284, 4)
clb.ImageRectSize = Vector2.new(24, 24)
clb.ImageColor3 = Color3.fromRGB(255, 255, 255)
cr(clb, 8)

cn(clb.MouseEnter, function()
        pt(clb, ti.f, { BackgroundColor3 = Color3.fromRGB(240, 70, 70), Size = UDim2.new(0, 32, 0, 32), Rotation = 90 })
end)
cn(clb.MouseLeave, function()
        pt(clb, ti.f, { BackgroundColor3 = Color3.fromRGB(180, 50, 220), Size = UDim2.new(0, 28, 0, 28), Rotation = 0 })
end)
cn(clb.MouseButton1Down, function()
        pt(clb, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.new(0, 24, 0, 24) })
end)
cn(clb.MouseButton1Up, function()
        pt(clb, ti.f, { Size = UDim2.new(0, 28, 0, 28) })
end)

local nv = Instance.new("Frame", mf)
nv.Size = UDim2.new(0, 165, 1, -52)
nv.Position = UDim2.new(0, 5, 0, 52)
nv.BackgroundColor3 = Color3.fromRGB(28, 20, 40)
nv.BorderSizePixel = 0
cr(nv, 10)
gr(nv, Color3.fromRGB(28, 20, 40), Color3.fromRGB(22, 18, 32), 90)

local cv = Instance.new("Frame", mf)
cv.Size = UDim2.new(1, -180, 1, -57)
cv.Position = UDim2.new(0, 178, 0, 52)
cv.BackgroundTransparency = 1
cv.BorderSizePixel = 0
cv.ClipsDescendants = true

local function gRSz() return math.floor(bR * sc) end

local rb = Instance.new("ImageButton", mg)
rb.Name = "ReopenButton"
rb.Size = UDim2.new(0, gRSz(), 0, gRSz())
rb.Position = UDim2.new(0, 100, 0, 100)
rb.BackgroundColor3 = Color3.fromRGB(150, 80, 255)
rb.BorderSizePixel = 0
rb.Visible = false
rb.ZIndex = 10
rb.Active = true
rb.ImageTransparency = 1
cr(rb, 100)
gr(rb, Color3.fromRGB(150, 80, 255), Color3.fromRGB(130, 60, 235), 45)

local rtl = Instance.new("TextLabel", rb)
rtl.Size = UDim2.new(1, 0, 1, 0)
rtl.BackgroundTransparency = 1
rtl.Text = "eSPTS"
rtl.Font = Enum.Font.GothamBold
rtl.TextSize = 13
rtl.TextColor3 = Color3.fromRGB(255, 255, 255)
rtl.TextTransparency = 0

local spnC = nil
local spnA = false

local function spnStop()
        if spnC then spnC:Disconnect() spnC = nil end
        spnA = false
end

local function spnStart()
        if spnA then return end
        spnA = true
        if spnC then spnC:Disconnect() end
        spnC = rs.RenderStepped:Connect(function(w)
                if rb.Visible then rb.Rotation = (rb.Rotation + (w * 180)) % 360
                else spnStop() end
        end)
end

local rDrg = false
local rMvd = false
local rDrgC = nil
local rDrgStart = nil
local rDrgPos = nil
local rClkBlk = false

cn(rb.InputBegan, function(w)
        if w.UserInputType == Enum.UserInputType.MouseButton1 or w.UserInputType == Enum.UserInputType.Touch then
                rMvd = false
                rClkBlk = false
                rDrg = true
                rDrgStart = w.Position
                rDrgPos = rb.Position
                spnStart()
                if rDrgC then rDrgC:Disconnect() end
                rDrgC = ui.InputChanged:Connect(function(w1)
                        if (w1.UserInputType == Enum.UserInputType.MouseMovement or w1.UserInputType == Enum.UserInputType.Touch) and rDrg then
                                local w2 = w1.Position - rDrgStart
                                if math.abs(w2.X) > 5 or math.abs(w2.Y) > 5 then rMvd = true end
                                rb.Position = UDim2.new(0, rDrgPos.X.Offset + w2.X, 0, rDrgPos.Y.Offset + w2.Y)
                        end
                end)
                w.Changed:Connect(function()
                        if w.UserInputState == Enum.UserInputState.End or w.UserInputState == Enum.UserInputState.Cancel then
                                rDrg = false
                                if rDrgC then rDrgC:Disconnect() rDrgC = nil end
                                if rMvd then
                                        rClkBlk = true
                                        cf.rp = { X = rb.Position.X.Offset, Y = rb.Position.Y.Offset }
                                        sv2()
                                        task.delay(.05, function() rClkBlk = false end)
                                end
                                rMvd = false
                        end
                end)
        end
end)

cn(rb.MouseEnter, function()
        if not rDrg then
                pt(rb, ti.m, { Size = UDim2.new(0, math.floor(gRSz() * 1.17), 0, math.floor(gRSz() * 1.17)) })
                spnStart()
        end
end)
cn(rb.MouseLeave, function()
        if not rDrg then
                spnStop()
                pt(rb, ti.m, { Size = UDim2.new(0, gRSz(), 0, gRSz()), Rotation = 0 })
        end
end)

local tbd, tcd = {}, {}
local tds = {
        { n = "Auto Farm", i = "\xf0\x9f\x94\xa5", o = 1 },
        { n = "Auto Weights", i = "\xf0\x9f\x8f\x8b\xef\xb8\x8f", o = 2 },
        { n = "Position Man", i = "\xf0\x9f\x8e\xaf", o = 3 },
        { n = "Settings", i = "\xe2\x9a\x99\xef\xb8\x8f", o = 4 }
}

local function ctb(w2, w3, w4)
        local w5 = Instance.new("TextButton", nv)
        w5.Name = w2 .. "Tab"
        w5.Size = UDim2.new(1, -10, 0, 50)
        w5.Position = UDim2.new(0.5, 0, 0, 8 + ((w4 - 1) * 55) + 27)
        w5.AnchorPoint = Vector2.new(0.5, 0.5)
        w5.BackgroundColor3 = Color3.fromRGB(32, 24, 45)
        w5.BorderSizePixel = 0
        w5.Text = ""
        w5.AutoButtonColor = false
        cr(w5, 8)
        local w6 = Instance.new("TextLabel", w5)
        w6.Size = UDim2.new(0, 30, 1, 0)
        w6.Position = UDim2.new(0, 10, 0, 0)
        w6.BackgroundTransparency = 1
        w6.Text = w3
        w6.Font = Enum.Font.GothamBold
        w6.TextSize = 18
        w6.TextColor3 = Color3.fromRGB(180, 180, 180)
        w6.TextXAlignment = Enum.TextXAlignment.Left
        local w7 = Instance.new("TextLabel", w5)
        w7.Size = UDim2.new(1, -50, 1, 0)
        w7.Position = UDim2.new(0, 45, 0, 0)
        w7.BackgroundTransparency = 1
        w7.Text = w2
        w7.Font = Enum.Font.GothamBold
        w7.TextSize = 13
        w7.TextColor3 = Color3.fromRGB(180, 180, 180)
        w7.TextXAlignment = Enum.TextXAlignment.Left
        tbd[w2] = { b = w5, i = w6, l = w7 }
        cn(w5.MouseEnter, function()
                local w8 = cf.tb == w2
                if w8 then
                        pt(w5, ti.f, { Size = UDim2.new(1, -4, 0, 54) })
                        pt(w6, ti.f, { TextSize = 21 })
                        pt(w7, ti.f, { TextSize = 14 })
                else
                        pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(45, 32, 62), Size = UDim2.new(1, -4, 0, 54) })
                        pt(w6, ti.f, { TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 21 })
                        pt(w7, ti.f, { TextColor3 = Color3.fromRGB(200, 200, 200), TextSize = 14 })
                end
        end)
        cn(w5.MouseLeave, function()
                local w8 = cf.tb == w2
                if w8 then
                        pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(150, 80, 255), Size = UDim2.new(1, -10, 0, 50) })
                        pt(w6, ti.f, { TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 18 })
                        pt(w7, ti.f, { TextColor3 = Color3.fromRGB(255, 255, 255), TextSize = 13 })
                else
                        pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(32, 24, 45), Size = UDim2.new(1, -10, 0, 50) })
                        pt(w6, ti.f, { TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 18 })
                        pt(w7, ti.f, { TextColor3 = Color3.fromRGB(180, 180, 180), TextSize = 13 })
                end
        end)
        cn(w5.MouseButton1Down, function()
                local w8 = cf.tb == w2
                if w8 then pt(w5, ti.f, { Size = UDim2.new(1, -14, 0, 46) })
                else pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 38, 72), Size = UDim2.new(1, -14, 0, 46) }) end
                pt(w6, ti.f, { TextSize = 16 })
        end)
        cn(w5.MouseButton1Up, function()
                local w8 = cf.tb == w2
                if w8 then pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(150, 80, 255), Size = UDim2.new(1, -4, 0, 54) })
                else pt(w5, ti.f, { BackgroundColor3 = Color3.fromRGB(45, 32, 62), Size = UDim2.new(1, -4, 0, 54) }) end
                pt(w6, ti.f, { TextSize = 21 })
        end)
        return w5
end

local function ctc(w2)
        local w3 = Instance.new("ScrollingFrame", cv)
        w3.Name = w2 .. "Content"
        w3.Size = UDim2.new(1, -10, 1, -10)
        w3.Position = UDim2.new(0, 5, 0, 5)
        w3.BackgroundTransparency = 1
        w3.BorderSizePixel = 0
        w3.ScrollBarThickness = 4
        w3.ScrollBarImageColor3 = Color3.fromRGB(150, 80, 255)
        w3.ScrollBarImageTransparency = 0.5
        w3.CanvasSize = UDim2.new(0, 0, 0, 0)
        w3.Visible = false
        w3.AutomaticCanvasSize = Enum.AutomaticSize.Y
        local w4 = Instance.new("UIListLayout", w3)
        w4.SortOrder = Enum.SortOrder.LayoutOrder
        w4.Padding = UDim.new(0, 10)
        local w5 = Instance.new("UIPadding", w3)
        w5.PaddingLeft = UDim.new(0, 5) w5.PaddingRight = UDim.new(0, 5)
        w5.PaddingTop = UDim.new(0, 5) w5.PaddingBottom = UDim.new(0, 5)
        tcd[w2] = w3
        return w3
end

for _, w2 in ipairs(tds) do ctb(w2.n, w2.i, w2.o) ctc(w2.n) end

local function apVis(w2)
        for w3, w4 in pairs(tbd) do
                xt(w4.b) xt(w4.i) xt(w4.l)
                local w5 = w3 == w2
                w4.b.BackgroundColor3 = w5 and Color3.fromRGB(150, 80, 255) or Color3.fromRGB(32, 24, 45)
                w4.b.Size = w5 and UDim2.new(1, -4, 0, 54) or UDim2.new(1, -10, 0, 50)
                w4.i.TextColor3 = w5 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
                w4.i.TextSize = w5 and 19 or 18
                w4.l.TextColor3 = w5 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        end
end

local function sw(w2)
        if cf.tb == w2 and db["T"] then return end
        if not dbn("T", .15) then return end
        cf.tb = w2
        ds()
        for w3, w4 in pairs(tcd) do
                if w3 == w2 then
                        w4.Visible = true
                        w4.Position = UDim2.new(0, 15, 0, 0)
                        pt(w4, ti.sm, { Position = UDim2.new(0, 5, 0, 0) })
                else
                        w4.Visible = false
                end
        end
        apVis(w2)
end

for _, w2 in ipairs(tds) do
        cn(tbd[w2.n].b.MouseButton1Click, function() sw(w2.n) end)
end

local fc = tcd["Auto Farm"]

local ic = cd(fc, 50, 1)
local _, it = ip(ic, UDim2.new(1, -20, 0, 32), UDim2.new(0, 10, 0, 9), "No active training")
it.TextYAlignment = Enum.TextYAlignment.Center

local af = cd(fc, 410, 2)
stl(af, "\xf0\x9f\x94\xa5 Stat Training", 8)
sh(af, "Select a stat to automatically train at the best available area", 34)
sr(af, 56)

local ao = nil
local ac = nil
local dn = {
        FistStrength = "Fist Strength", BodyToughness = "Body Toughness",
        PsychicPower = "Psychic Power", JumpForce = "Jump Force", MovementSpeed = "Movement Speed"
}
local cg = { "FistStrength", "BodyToughness", "PsychicPower", "JumpForce", "MovementSpeed" }
local fb = {}
local btg = {}
local ubm

for i, w in ipairs(cg) do
        local w1, w2 = tp(af, dn[w], 64 + ((i - 1) * 42))
        local w3, w4 = mt(w1, UDim2.new(0, 56, 0, 28), UDim2.new(1, -35, 0.5, 0), false)
        fb[w] = { f = w1, l = w2, tg = w4 }
        cn(w1.MouseEnter, function()
                if cf.st ~= w then pt(w1, ti.f, { BackgroundColor3 = Color3.fromRGB(45, 32, 62) }) end
        end)
        cn(w1.MouseLeave, function()
                if cf.st ~= w then pt(w1, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) }) end
        end)
        cn(w3.MouseButton1Click, function()
                if not dbn("S" .. w, .3) then return end
                local on = not w4.v
                stg(w4, on)
                if on then
                        for w5, w6 in pairs(fb) do
                                if w5 ~= w then
                                        stg(w6.tg, false)
                                        pt(w6.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                                        w6.l.TextColor3 = Color3.fromRGB(200, 200, 200)
                                end
                        end
                        cf.st = w
                        if w ~= "BodyToughness" then cf.fm = nil end
                        pt(w1, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                        w2.TextColor3 = Color3.fromRGB(255, 255, 255)
                        local w5 = gcs(w)
                        local w6 = fba(w, w5)
                        if not w6 then
                                it.Text = dn[w] .. " \xe2\x80\x94 No available area"
                                ao = nil cf.fm = nil
                                ubm() ds()
                                al(dn[w] .. " \xe2\x80\x94 No area found", Color3.fromRGB(255, 150, 80))
                                return
                        end
                        local w7 = gao(w, w6)
                        ao = w7
                        if not w7 then
                                it.Text = "Area '" .. w6 .. "' not found!"
                                ao = nil cf.fm = nil
                                ubm() ds()
                                al("Area '" .. w6 .. "' not found", Color3.fromRGB(255, 150, 80))
                                return
                        end
                        local w8, w9 = tta(w7)
                        if w8 then
                                ac = w9
                                it.Text = dn[w] .. " \xe2\x80\x94 Area: " .. w6 .. " (req " .. ar[w][w6].req .. ")"
                                al(dn[w] .. " \xe2\x80\x94 " .. w6, Color3.fromRGB(80, 220, 120))
                        else
                                it.Text = "Teleport failed!"
                                al("Teleport failed", Color3.fromRGB(255, 80, 80))
                        end
                else
                        cf.st = nil ao = nil ac = nil cf.fm = nil
                        pt(w1, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                        w2.TextColor3 = Color3.fromRGB(200, 200, 200)
                        it.Text = "No active training"
                        al(dn[w] .. " \xe2\x80\x94 Stopped", Color3.fromRGB(180, 180, 180))
                end
                ubm() ds()
        end)
end

sr(af, 278)
sh(af, "Body Toughness Mode", 288)

local b1f = Instance.new("Frame", af)
b1f.Size = UDim2.new(1, -20, 0, 40)
b1f.Position = UDim2.new(0, 10, 0, 312)
b1f.BackgroundColor3 = Color3.fromRGB(38, 28, 52)
b1f.BorderSizePixel = 0
cr(b1f, 10)

local b1b = Instance.new("TextButton", b1f)
b1b.Size = UDim2.new(1, 0, 1, 0)
b1b.BackgroundTransparency = 1
b1b.Text = "BT: Current Area"
b1b.TextColor3 = Color3.fromRGB(180, 160, 220)
b1b.Font = Enum.Font.GothamBold
b1b.TextSize = 13
b1b.AutoButtonColor = false
b1b.TextXAlignment = Enum.TextXAlignment.Center
btg.c = { f = b1f, l = b1b }

local b2f = Instance.new("Frame", af)
b2f.Size = UDim2.new(1, -20, 0, 40)
b2f.Position = UDim2.new(0, 10, 0, 358)
b2f.BackgroundColor3 = Color3.fromRGB(38, 28, 52)
b2f.BorderSizePixel = 0
cr(b2f, 10)

local b2b = Instance.new("TextButton", b2f)
b2b.Size = UDim2.new(1, 0, 1, 0)
b2b.BackgroundTransparency = 1
b2b.Text = "BT: Next Area"
b2b.TextColor3 = Color3.fromRGB(160, 160, 220)
b2b.Font = Enum.Font.GothamBold
b2b.TextSize = 13
b2b.AutoButtonColor = false
b2b.TextXAlignment = Enum.TextXAlignment.Center
btg.n = { f = b2f, l = b2b }

cn(b1f.MouseEnter, function()
        if cf.fm ~= "c" then pt(b1f, ti.f, { BackgroundColor3 = Color3.fromRGB(50, 35, 68) }) end
end)
cn(b1f.MouseLeave, function()
        if cf.fm ~= "c" then pt(b1f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) }) end
end)
cn(b1b.MouseButton1Down, function()
        pt(b1f, ti.f, { BackgroundColor3 = cf.fm ~= "c" and Color3.fromRGB(60, 42, 75) or Color3.fromRGB(45, 35, 60) })
end)
cn(b1b.MouseButton1Up, function() ubm() end)

cn(b2f.MouseEnter, function()
        if cf.fm ~= "n" then pt(b2f, ti.f, { BackgroundColor3 = Color3.fromRGB(50, 35, 68) }) end
end)
cn(b2f.MouseLeave, function()
        if cf.fm ~= "n" then pt(b2f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) }) end
end)
cn(b2b.MouseButton1Down, function()
        pt(b2f, ti.f, { BackgroundColor3 = cf.fm ~= "n" and Color3.fromRGB(60, 42, 75) or Color3.fromRGB(45, 35, 60) })
end)
cn(b2b.MouseButton1Up, function() ubm() end)

ubm = function()
        local ic2 = cf.fm == "c"
        local jn = cf.fm == "n"
        if ic2 then
                pt(btg.c.f, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                btg.c.l.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
                pt(btg.c.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                btg.c.l.TextColor3 = Color3.fromRGB(180, 160, 220)
        end
        if jn then
                pt(btg.n.f, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                btg.n.l.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
                pt(btg.n.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                btg.n.l.TextColor3 = Color3.fromRGB(160, 160, 220)
        end
end

local function abt(m)
        local on = cf.fm ~= m
        if on then
                cf.fm = m
                cf.st = "BodyToughness"
                for w5, w6 in pairs(fb) do
                        if w5 == "BodyToughness" then
                                stg(w6.tg, true)
                                pt(w6.f, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                                w6.l.TextColor3 = Color3.fromRGB(255, 255, 255)
                        else
                                stg(w6.tg, false)
                                pt(w6.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                                w6.l.TextColor3 = Color3.fromRGB(200, 200, 200)
                        end
                end
                local w5 = gcs("BodyToughness")
                local w6 = m == "c" and fbp("BodyToughness", w5) or fba("BodyToughness", w5)
                if not w6 then
                        it.Text = "Body Toughness \xe2\x80\x94 No available area"
                        ao = nil cf.fm = nil
                        ubm() ds()
                        al("BT " .. (m == "n" and "Next" or "Current") .. " \xe2\x80\x94 No area", Color3.fromRGB(255, 150, 80))
                        return
                end
                local w7 = gao("BodyToughness", w6)
                ao = w7
                if not w7 then
                        it.Text = "Area '" .. w6 .. "' not found!"
                        ao = nil cf.fm = nil
                        ubm() ds()
                        al("Area not found", Color3.fromRGB(255, 80, 80))
                        return
                end
                local w8, w9 = tta(w7)
                if w8 then
                        ac = w9
                        local ml = m == "n" and "Next" or "Current"
                        it.Text = "Body Toughness (" .. ml .. ") \xe2\x80\x94 Area: " .. w6 .. " (req " .. ar.BodyToughness[w6].req .. ")"
                        al("BT " .. ml .. " \xe2\x80\x94 " .. w6, Color3.fromRGB(80, 220, 120))
                else
                        it.Text = "Teleport failed!"
                        al("Teleport failed", Color3.fromRGB(255, 80, 80))
                end
        else
                cf.fm = nil cf.st = nil ao = nil ac = nil
                for w5, w6 in pairs(fb) do
                        stg(w6.tg, false)
                        pt(w6.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                        w6.l.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
                it.Text = "No active training"
                al("BT mode off", Color3.fromRGB(180, 180, 180))
        end
        ubm() ds()
end

cn(b1b.MouseButton1Click, function()
        if not dbn("BC", .3) then return end
        abt("c")
end)
cn(b2b.MouseButton1Click, function()
        if not dbn("BN", .3) then return end
        abt("n")
end)

local wc = tcd["Auto Weights"]

local aw = cd(wc, 135, 1)
stl(aw, "\xf0\x9f\x8f\x8b\xef\xb8\x8f Auto Weight", 8)
sh(aw, "Automatically equip the best available weight based on your stats", 32)

local _, wit = ip(aw, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, 54), "Auto weight system inactive")
wit.TextYAlignment = Enum.TextYAlignment.Center

local w4r, w5r = tp(aw, "Auto Weight", 90)
local wbt, wts = mt(w4r, UDim2.new(0, 52, 0, 26), UDim2.new(1, -35, 0.5, 0), false)

local function dW()
        kl("W")
        if not cf.aw then return end
        thr.W = task.spawn(function()
                while cf.aw do
                        task.wait(1)
                        if cf.aw and mg and mg.Parent then
                                re:FireServer(unpack({ { "Add_MS_Request" } }))
                                re:FireServer(unpack({ { "Add_JF_Request" } }))
                                ebw()
                        end
                end
                thr.W = nil
        end)
end

local function uwb()
        if cf.aw then
                pt(w4r, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                w5r.TextColor3 = Color3.fromRGB(255, 255, 255)
                wit.Text = "Auto Weight active \xe2\x80\x94 farming MS and JF automatically"
                ebw() dW()
                al("Auto Weight enabled", Color3.fromRGB(80, 220, 120))
        else
                pt(w4r, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                w5r.TextColor3 = Color3.fromRGB(200, 200, 200)
                wit.Text = "Auto weight system inactive"
                kl("W")
                al("Auto Weight disabled", Color3.fromRGB(180, 180, 180))
        end
end

cn(wbt.MouseButton1Click, function()
        if not dbn("AW", .3) then return end
        cf.aw = not cf.aw
        stg(wts, cf.aw)
        uwb() ds()
end)
cn(w4r.MouseEnter, function()
        if not cf.aw then pt(w4r, ti.f, { BackgroundColor3 = Color3.fromRGB(45, 32, 62) }) end
end)
cn(w4r.MouseLeave, function()
        if not cf.aw then pt(w4r, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) }) end
end)

local pc = tcd["Position Man"]

local pm = cd(pc, 130, 1)
stl(pm, "\xf0\x9f\x93\x8c Position Manager", 8)
sh(pm, "Save and restore your position for automatic respawning and pullback", 32)

local _, px = ip(pm, UDim2.new(1, -20, 0, 48), UDim2.new(0, 10, 0, 54), "No position saved")
px.TextYAlignment = Enum.TextYAlignment.Center

local ps1 = Instance.new("Frame", pc)
ps1.Size = UDim2.new(1, 0, 0, 55)
ps1.BackgroundColor3 = Color3.fromRGB(38, 28, 52)
ps1.BorderSizePixel = 0
ps1.LayoutOrder = 2
cr(ps1, 10)

local ps2 = Instance.new("TextButton", ps1)
ps2.Size = UDim2.new(1, 0, 1, 0)
ps2.BackgroundTransparency = 1
ps2.Text = "Save Current Position"
ps2.TextColor3 = Color3.fromRGB(200, 200, 200)
ps2.Font = Enum.Font.GothamBold
ps2.TextSize = 14
ps2.AutoButtonColor = false
ba(ps2,
        { BackgroundColor3 = Color3.fromRGB(38, 28, 52), Size = UDim2.new(1, 0, 0, 55) },
        { BackgroundColor3 = Color3.fromRGB(50, 36, 68), Size = UDim2.new(1, 0, 0, 58) },
        { BackgroundColor3 = Color3.fromRGB(60, 44, 78), Size = UDim2.new(1, 0, 0, 51) }
)

cn(ps2.MouseButton1Click, function()
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                cf.sv = p.Character.HumanoidRootPart.CFrame
                pt(ps1, ti.f, { BackgroundColor3 = Color3.fromRGB(50, 220, 100) })
                ps2.TextColor3 = Color3.fromRGB(255, 255, 255)
                px.Text = "Position saved! You will respawn here and be pulled back if you go too far."
                al("Position saved", Color3.fromRGB(80, 220, 120))
                task.wait(.5)
                pt(ps1, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                ps2.TextColor3 = Color3.fromRGB(200, 200, 200)
                ds()
        end
end)

local pc1 = Instance.new("Frame", pc)
pc1.Size = UDim2.new(1, 0, 0, 55)
pc1.BackgroundColor3 = Color3.fromRGB(38, 28, 52)
pc1.BorderSizePixel = 0
pc1.LayoutOrder = 3
cr(pc1, 10)

local pc2 = Instance.new("TextButton", pc1)
pc2.Size = UDim2.new(1, 0, 1, 0)
pc2.BackgroundTransparency = 1
pc2.Text = "Clear Saved Position"
pc2.TextColor3 = Color3.fromRGB(200, 200, 200)
pc2.Font = Enum.Font.GothamBold
pc2.TextSize = 14
pc2.AutoButtonColor = false
ba(pc2,
        { BackgroundColor3 = Color3.fromRGB(38, 28, 52), Size = UDim2.new(1, 0, 0, 55) },
        { BackgroundColor3 = Color3.fromRGB(50, 36, 68), Size = UDim2.new(1, 0, 0, 58) },
        { BackgroundColor3 = Color3.fromRGB(60, 44, 78), Size = UDim2.new(1, 0, 0, 51) }
)

cn(pc2.MouseButton1Click, function()
        cf.sv = nil
        pt(pc1, ti.f, { BackgroundColor3 = Color3.fromRGB(180, 50, 220) })
        pc2.TextColor3 = Color3.fromRGB(255, 255, 255)
        px.Text = "Position cleared!"
        al("Position cleared", Color3.fromRGB(255, 150, 100))
        task.wait(.5)
        pt(pc1, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
        pc2.TextColor3 = Color3.fromRGB(200, 200, 200)
        px.Text = "No position saved"
        ds()
end)

local cc = tcd["Settings"]

local sc2 = cd(cc, 510, 1)
stl(sc2, "\xe2\x9a\x99\xef\xb8\x8f UI Configuration", 8)
sh(sc2, "Customize interface preferences and keybinds", 34)
sr(sc2, 60)
sh(sc2, "Toggle Keybind", 70)

local kb = Instance.new("TextButton", sc2)
kb.Size = UDim2.new(1, -20, 0, 40)
kb.Position = UDim2.new(0, 10, 0, 90)
kb.BackgroundColor3 = Color3.fromRGB(45, 32, 62)
kb.BorderSizePixel = 0
kb.Text = "Current Key: " .. cf.kb
kb.TextColor3 = Color3.fromRGB(255, 255, 255)
kb.Font = Enum.Font.GothamBold
kb.TextSize = 13
kb.AutoButtonColor = false
cr(kb, 8)
ba(kb,
        { BackgroundColor3 = Color3.fromRGB(45, 32, 62), Size = UDim2.new(1, -20, 0, 40) },
        { BackgroundColor3 = Color3.fromRGB(55, 42, 72), Size = UDim2.new(1, -15, 0, 44) },
        { BackgroundColor3 = Color3.fromRGB(68, 52, 85), Size = UDim2.new(1, -25, 0, 36) }
)

local kbw = false
cn(kb.MouseButton1Click, function()
        if kbw then return end
        kbw = true
        kb.Text = "Press any key..."
        al("Changing keybind...", Color3.fromRGB(255, 200, 100))
        kb.Active = false
        local w, w1
        w1 = task.delay(5, function()
                if kbw then
                        kbw = false
                        kb.Text = "Current Key: " .. cf.kb
                        kb.Active = true
                        al("Keybind timeout", Color3.fromRGB(255, 100, 100))
                end
        end)
        w = cn(ui.InputBegan, function(w2, gp)
                if gp then return end
                if w2.UserInputType == Enum.UserInputType.Keyboard then
                        pcall(task.cancel, w1)
                        cf.kb = w2.KeyCode.Name
                        kb.Text = "Current Key: " .. cf.kb
                        al("Keybind \xe2\x80\x94 " .. cf.kb, Color3.fromRGB(100, 200, 255))
                        ds() kbw = false
                        kb.Active = true
                        w:Disconnect()
                end
        end)
end)

sr(sc2, 145)

local ah1, ah2 = tp(sc2, "Auto Hide UI", 157)
local aht, ahs = mt(ah1, UDim2.new(0, 52, 0, 26), UDim2.new(1, -35, 0.5, 0), cf.ah)

local ahsx = Instance.new("TextLabel", sc2)
ahsx.Size = UDim2.new(1, -20, 0, 20)
ahsx.Position = UDim2.new(0, 10, 0, 206)
ahsx.BackgroundTransparency = 1
ahsx.Font = Enum.Font.Gotham
ahsx.TextSize = 12
ahsx.TextXAlignment = Enum.TextXAlignment.Left
ahsx.TextWrapped = true

local function uah()
        stg(ahs, cf.ah)
        if cf.ah then
                ahsx.Text = "Auto Hide enabled \xe2\x80\x94 UI starts hidden on next execution."
                ahsx.TextColor3 = Color3.fromRGB(50, 220, 100)
                ah2.TextColor3 = Color3.fromRGB(255, 255, 255)
                pt(ah1, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
        else
                ahsx.Text = "Auto Hide disabled \xe2\x80\x94 UI shows normally on start."
                ahsx.TextColor3 = Color3.fromRGB(180, 180, 180)
                ah2.TextColor3 = Color3.fromRGB(200, 200, 200)
                pt(ah1, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
        end
end

uah()

cn(aht.MouseButton1Click, function()
        if not dbn("AH", .3) then return end
        cf.ah = not cf.ah
        stg(ahs, cf.ah)
        uah()
        al(cf.ah and "Auto Hide enabled" or "Auto Hide disabled", cf.ah and Color3.fromRGB(50, 220, 100) or Color3.fromRGB(180, 180, 180))
        ds()
end)

sr(sc2, 238)
sh(sc2, "Activity Log", 248)

local clrBtn = Instance.new("TextButton", sc2)
clrBtn.Size = UDim2.new(0, 50, 0, 18)
clrBtn.Position = UDim2.new(1, -60, 0, 246)
clrBtn.BackgroundColor3 = Color3.fromRGB(70, 45, 95)
clrBtn.BorderSizePixel = 0
clrBtn.Text = "Clear"
clrBtn.Font = Enum.Font.Gotham
clrBtn.TextSize = 11
clrBtn.TextColor3 = Color3.fromRGB(200, 180, 220)
clrBtn.AutoButtonColor = false
cr(clrBtn, 5)
ba(clrBtn,
        { BackgroundColor3 = Color3.fromRGB(70, 45, 95), Size = UDim2.new(0, 50, 0, 18) },
        { BackgroundColor3 = Color3.fromRGB(90, 60, 115), Size = UDim2.new(0, 54, 0, 20) },
        { BackgroundColor3 = Color3.fromRGB(110, 70, 130), Size = UDim2.new(0, 46, 0, 16) }
)

local _, _, le, la, lclr = lg(sc2, UDim2.new(1, -20, 0, 200), UDim2.new(0, 10, 0, 270))
le.Text = "No activity yet."
alFn = la
for _, w in ipairs(_pl) do la(w[1], w[2]) end
_pl = {}

cn(clrBtn.MouseButton1Click, function() lclr() end)

local aqL = false

local function tu()
        if aqL then return end
        aqL = true
        task.spawn(function()
                if mf.Visible then
                        cf.up = { X = mf.Position.X.Offset, Y = mf.Position.Y.Offset }
                        pt(us, ti.sm, { Scale = 0 })
                        mf.Size = UDim2.new(0, bW, 0, bH)
                        pt(mf, ti.bi, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
                        task.wait(.35)
                        mf.Visible = false
                        mf.BackgroundTransparency = 0
                        local w, w1
                        if cf.rp and cf.rp.X and cf.rp.Y then w, w1 = cf.rp.X, cf.rp.Y
                        else local _, bx, by = gRP(gVp(), sc) w, w1 = bx, by end
                        rb.Size = UDim2.new(0, 0, 0, 0)
                        rb.Position = UDim2.new(0, w + 270, 0, w1 + 210)
                        rb.ImageTransparency = 1
                        rb.Rotation = -180
                        rb.Visible = true
                        rtl.TextTransparency = 1
                        pt(rb, ti.b, { Size = UDim2.new(0, gRSz(), 0, gRSz()), Position = UDim2.new(0, w, 0, w1), ImageTransparency = 0, Rotation = 0 })
                        task.delay(.15, function() pt(rtl, ti.f, { TextTransparency = 0 }) end)
                else
                        spnStop()
                        if rb.Visible then cf.rp = { X = rb.Position.X.Offset, Y = rb.Position.Y.Offset } end
                        pt(rb, ti.bi, { Size = UDim2.new(0, 0, 0, 0), Rotation = 90, ImageTransparency = 1 })
                        pt(rtl, ti.f, { TextTransparency = 1 })
                        task.wait(.35)
                        rb.Visible = false
                        rb.Rotation = 0
                        rb.ImageTransparency = 0
                        rtl.TextTransparency = 0
                        local w, w1
                        if cf.up and cf.up.X and cf.up.Y then w, w1 = cf.up.X, cf.up.Y
                        else w, w1 = gMP(gVp(), sc) end
                        mf.Visible = true
                        us.Scale = 0
                        mf.Size = UDim2.new(0, bW, 0, bH)
                        mf.Position = UDim2.new(0, w, 0, w1 + 18)
                        mf.BackgroundTransparency = 1
                        pt(mf, ti.m, { Position = UDim2.new(0, w, 0, w1), BackgroundTransparency = 0 })
                        pt(us, ti.b, { Scale = sc })
                end
                ds()
                aqL = false
        end)
end


local rPV = Vector2.new(0, 0)
local rBL = false
local function rCH()
        if rBL then return end
        rBL = true
        task.delay(.1, function()
                rBL = false
                local v = gVp()
                if math.abs(v.X - rPV.X) < 2 and math.abs(v.Y - rPV.Y) < 2 then return end
                rPV = v
                local s = gSc(v)
                sc = s
                local bx, by = gMP(v, sc)
                local rs, brx, bry = gRP(v, sc)
                if mf.Visible then
                        cf.up = { X = mf.Position.X.Offset, Y = mf.Position.Y.Offset }
                        pt(us, ti.sm, { Scale = sc })
                        mf.Size = UDim2.new(0, bW, 0, bH)
                        mf.Position = UDim2.new(0, bx, 0, by)
                        cf.up = nil
                        cf.rp = nil
                        rb.Size = UDim2.new(0, rs, 0, rs)
                        rb.Position = UDim2.new(0, brx, 0, bry)
                elseif rb.Visible then
                        cf.rp = { X = rb.Position.X.Offset, Y = rb.Position.Y.Offset }
                        cf.up = nil
                        cf.rp = nil
                        rb.Size = UDim2.new(0, rs, 0, rs)
                        rb.Position = UDim2.new(0, brx, 0, bry)
                else
                        cf.up = nil
                        cf.rp = nil
                        mf.Size = UDim2.new(0, bW, 0, bH)
                        mf.Position = UDim2.new(0, bx, 0, by)
                        rb.Size = UDim2.new(0, rs, 0, rs)
                        rb.Position = UDim2.new(0, brx, 0, bry)
                end
                sv2()
        end)
end
if workspace.CurrentCamera then
        table.insert(_eSPTS.cn, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rCH))
end
table.insert(_eSPTS.cn, workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        if workspace.CurrentCamera then
                table.insert(_eSPTS.cn, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(rCH))
        end
end))
cn(clb.MouseButton1Click, function() tu() end)
cn(rb.MouseButton1Click, function()
        if rClkBlk then return end
        tu()
end)
cn(ui.InputBegan, function(w, gp)
        if gp then return end
        if w.KeyCode == Enum.KeyCode[cf.kb] and not aqL then tu() end
end)

mf.Destroying:Connect(function()
        sv2()
        spnStop()
        for _, w in pairs(thr) do
                if typeof(w) == "thread" and coroutine.status(w) ~= "dead" then pcall(task.cancel, w) end
        end
end)

local ld = lc()
if ld then
        if cf.kb then kb.Text = "Current Key: " .. cf.kb end
        stg(wts, cf.aw) uwb()
        if cf.st then
                for w, w2 in pairs(fb) do
                        if w == cf.st then
                                stg(w2.tg, true)
                                pt(w2.f, ti.f, { BackgroundColor3 = Color3.fromRGB(55, 30, 75) })
                                w2.l.TextColor3 = Color3.fromRGB(255, 255, 255)
                        local w3 = gcs(w)
                        local w4 = w == "BodyToughness" and cf.fm == "c" and fbp(w, w3) or fba(w, w3)
                        if w4 then
                                local w5 = gao(w, w4)
                                ao = w5
                                if w5 then
                                        local w6, w7 = tta(w5)
                                        if w6 then
                                                ac = w7
                                                if w == "BodyToughness" and cf.fm then
                                                        local ml = cf.fm == "n" and "Next" or "Current"
                                                        it.Text = dn[w] .. " (" .. ml .. ") \xe2\x80\x94 Area: " .. w4 .. " (req " .. ar[w][w4].req .. ")"
                                                else
                                                        it.Text = dn[w] .. " \xe2\x80\x94 Area: " .. w4 .. " (req " .. ar[w][w4].req .. ")"
                                                end
                                        end
                                end
                        end
                        else
                                stg(w2.tg, false)
                                pt(w2.f, ti.f, { BackgroundColor3 = Color3.fromRGB(38, 28, 52) })
                                w2.l.TextColor3 = Color3.fromRGB(200, 200, 200)
                        end
                end
        else
                it.Text = "No active training"
        end
        ubm()
        if cf.sv then px.Text = "Position loaded from config!" end
        if cf.up and cf.up.X and cf.up.Y then mf.Position = UDim2.new(0, cf.up.X, 0, cf.up.Y) end
        uah()
        sw(cf.tb or "Auto Farm")
        al("Config loaded for " .. nm, Color3.fromRGB(100, 200, 255))
else
        ubm() uah() sw("Auto Farm")
        al("Fresh start \xe2\x80\x94 no saved config", Color3.fromRGB(255, 200, 100))
end

cn(rs.Heartbeat, function()
        if not mg or not mg.Parent then return end
        if cf.sv and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local w = p.Character.HumanoidRootPart
                if (w.Position - cf.sv.Position).Magnitude > 20 then w.CFrame = cf.sv end
        end
        if not cf.st then return end
        local w = p.Character
        if not w then return end
        local w1 = w:FindFirstChild("HumanoidRootPart")
        if not w1 then return end
        local w2 = gcs(cf.st)
        local w3 = cf.st == "BodyToughness" and cf.fm == "c" and fbp(cf.st, w2) or fba(cf.st, w2)
        if w3 and (not ao or ao.Name ~= w3) then
                local w4 = gao(cf.st, w3)
                if w4 then
                        ao = w4
                        local w5, w6 = tta(w4)
                        if w5 then
                                ac = w6
                                if cf.st == "BodyToughness" and cf.fm then
                                        local ml = cf.fm == "n" and "Next" or "Current"
                                        it.Text = dn[cf.st] .. " (" .. ml .. ") \xe2\x80\x94 Area: " .. w3 .. " (req " .. ar[cf.st][w3].req .. ")"
                                else
                                        it.Text = dn[cf.st] .. " \xe2\x80\x94 Area: " .. w3 .. " (req " .. ar[cf.st][w3].req .. ")"
                                end
                        end
                end
        end
        if ac then
                if (w1.Position - ac.Position).Magnitude > 15 then w1.CFrame = ac end
        end
        if cf.st == "FistStrength" then
                re:FireServer(unpack({ { "Add_FS_Request" } }))
        elseif cf.st == "MovementSpeed" then
                if tick() - fq >= 1 then fq = tick() re:FireServer(unpack({ { "Add_MS_Request" } })) end
        elseif cf.st == "JumpForce" then
                if tick() - fq >= 1 then fq = tick() re:FireServer(unpack({ { "Add_JF_Request" } })) end
        end
end)

cn(p.CharacterAdded, function(w)
        if not mg or not mg.Parent then return end
        task.wait(1)
        local w1 = w:WaitForChild("HumanoidRootPart", 5)
        if cf.sv then task.wait(.2) w1.CFrame = cf.sv end
        if cf.aw then task.wait(.33) ebw() dW() end
        if cf.st and ao then
                local w2, w3 = tta(ao)
                if w2 then ac = w3 end
        end
end)

if p.Character then
        task.wait(1)
        if cf.sv and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.CFrame = cf.sv
        end
end


if cf.ah then
        local v = gVp()
        if v.X < 100 or v.Y < 100 then repeat task.wait() until gVp().X > 100 end
        v = gVp()
        rPV = v
        sc = gSc(v)
        local rs, brx, bry = gRP(v, sc)
        rb.Size = UDim2.new(0, 0, 0, 0)
        rb.Position = UDim2.new(0, brx + rs / 2, 0, bry + rs / 2)
        rb.ImageTransparency = 1
        rb.Rotation = -180
        rtl.TextTransparency = 1
        rb.Visible = true
        pt(rb, ti.b, { Size = UDim2.new(0, rs, 0, rs), Position = UDim2.new(0, brx, 0, bry), ImageTransparency = 0, Rotation = 0 })
        task.delay(.15, function() pt(rtl, ti.f, { TextTransparency = 0 }) end)
else
        local v = gVp()
        if v.X < 100 or v.Y < 100 then repeat task.wait() until gVp().X > 100 end
        v = gVp()
        rPV = v
        sc = gSc(v)
        mf.Visible = true
        mf.BackgroundTransparency = 1
        mf.Size = UDim2.new(0, bW, 0, bH)
        local ix, iy
        if cf.up and cf.up.X and cf.up.Y then ix, iy = cf.up.X, cf.up.Y
        else
                ix, iy = gMP(v, sc)
        end
        mf.Position = UDim2.new(0, ix, 0, iy + 18)
        us.Scale = 0
        pt(mf, ti.m, { Position = UDim2.new(0, ix, 0, iy), BackgroundTransparency = 0 })
        pt(us, TweenInfo.new(.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = sc })
end
