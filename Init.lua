local w, w1, w2, w3, w4 = game:GetService("Players"), game:GetService("RunService"), game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("HttpService")

local w5, w6, w7, w8, w9 = Color3.fromRGB, UDim2.new, UDim.new, Vector2.new, Instance.new
local w10, w11, w12 = Enum.Font.Gotham, Enum.Font.GothamBold, Enum.Font.Code
local w13, w14, w15 = Enum.TextXAlignment.Left, Enum.TextYAlignment.Top, Enum.TextYAlignment.Center

local w16 = w.LocalPlayer
local w17 = w16:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

local w18 = w17:FindFirstChild("eSPTSUI")
if w18 then w18:Destroy() task.wait(.1) end

if w19 then
	for _, w20 in pairs(w19.w21 or {}) do pcall(function() w20:Disconnect() end) end
	for _, w20 in pairs(w19.w3 or {}) do pcall(function() w20:Cancel() end) end
	for _, w20 in pairs(w19.th or {}) do
		if typeof(w20) == "thread" and coroutine.status(w20) ~= "dead" then pcall(task.cancel, w20) end
	end
end

w19 = { w21 = {}, w3 = {}, th = {} }

local w22, w23 = w16.Name, w16.UserId
if not w22 or w22 == "" then repeat w22 = w16.Name task.wait() until w22 and w22 ~= "" end

local w24 = { w25 = "G", st = nil, w26 = false, as = true, tb = "Auto Farm", sv = nil, up = nil, rp = nil, fm = nil, ah = false }
local w27, w28
local w29, w30, w31 = 0, false, 0
local w32 = "eSPTS/Accounts/" .. w22 .. ".json"

local w33 = w17:WaitForChild("MenuFrame"):WaitForChild("InfoFrame")
local w34 = workspace:WaitForChild("Map"):WaitForChild("Training_Collisions")
local w35 = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent")

local function w36(w20) w35:FireServer(w20) end

local function w37()
	if not makefolder or not isfolder then return end
	if not isfolder("eSPTS") then makefolder("eSPTS") end
	if not isfolder("eSPTS/Accounts") then makefolder("eSPTS/Accounts") end
end

local function w38()
	if not writefile then return false end
	w37()
	if w27 and w27.Visible then w24.up = { X = w27.Position.X.Offset, Y = w27.Position.Y.Offset } end
	if w28 and w28.Visible then w24.rp = { X = w28.Position.X.Offset, Y = w28.Position.Y.Offset } end
	local w20 = w24.sv and { w24.sv:GetComponents() } or nil
	local w39 = { w23 = w23, w22 = w22, w25 = w24.w25, st = w24.st, w26 = w24.w26, as = w24.as, tb = w24.tb, sv = w20, up = w24.up, rp = w24.rp, fm = w24.fm, ah = w24.ah }
	local w40 = pcall(function() writefile(w32, w4:JSONEncode(w39)) end)
	if w40 then w29 = tick() w30 = false return true end
	w30 = false
	return false
end

local function w41()
	if w30 then return end
	w30 = true
	local w20 = tick() - w29
	if w20 >= .1 then w38()
	else task.delay(.1 - w20, function() if w30 then w38() end end) end
end

local function w42()
	if not readfile or not isfile or not isfile(w32) then return false end
	local w40, w20 = pcall(function() return w4:JSONDecode(readfile(w32)) end)
	if not w40 or not w20 or w20.w23 ~= w23 then return false end
	w24.w25 = w20.w25 or "G"
	w24.st = w20.st
	w24.w26 = w20.w26 or false
	w24.as = w20.as ~= nil and w20.as or true
	w24.tb = w20.tb or "Auto Farm"
	if w20.sv and #w20.sv == 12 then w24.sv = CFrame.new(unpack(w20.sv)) end
	w24.up = w20.up
	w24.rp = w20.rp
	w24.fm = w20.fm
	w24.ah = w20.ah or false
	return true
end

local w43 = {
	w44 = TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	m = TweenInfo.new(.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
	b = TweenInfo.new(.50, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	bi = TweenInfo.new(.35, Enum.EasingStyle.Back, Enum.EasingDirection.In),
	sm = TweenInfo.new(.30, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
}

local w45, w46 = w19.w3, w19.th

local function w47(w20)
	if w45[w20] then w45[w20]:Cancel() w45[w20] = nil end
end

local function w48(w20, w39, w49)
	w47(w20)
	local w50 = w3:Create(w20, w39, w49)
	w45[w20] = w50
	w50:Play()
	w50.Completed:Connect(function(w51) if w51 == Enum.TweenStatus.Completed then w45[w20] = nil end end)
	return w50
end

local function w21(w20, w44)
	local w39 = w20:Connect(w44)
	w19.w21[#w19.w21 + 1] = w39
	return w39
end

local function w52(w53)
	if w46[w53] then
		local w20 = w46[w53] w46[w53] = nil
		if typeof(w20) == "thread" and coroutine.status(w20) ~= "dead" then pcall(task.cancel, w20) end
	end
end

local w54 = {}

local function w55(w53, w56)
	if w54[w53] then return false end
	w54[w53] = true
	task.delay(w56 or .3, function() w54[w53] = false end)
	return true
end

local w57 = {
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

local w58 = {
	{ w53 = "100 LB", m = 100, j = 5000 }, { w53 = "1 TON", m = 5000, j = 200000 },
	{ w53 = "10 TON", m = 500000, j = 2000000 }, { w53 = "100 TON", m = 10000000, j = 10000000 },
	{ w53 = "1 K TON", m = 100000000, j = 200000000 }, { w53 = "10 K TON", m = 1000000000, j = 1000000000 },
	{ w53 = "100 K TON", m = 10000000000, j = 10000000000 }, { w53 = "1 M TON", m = 100000000000, j = 100000000000 },
	{ w53 = "10 M TON", m = 1e12, j = 1e12 }, { w53 = "1 B TON", m = 1e13, j = 1e13 },
	{ w53 = "100 B TON", m = 2.56e28, j = 1.54e28 }, { w53 = "10 T TON", m = 0, j = 6e26 },
	{ w53 = "1 Qa TON", m = 1.68e32, j = 2.221e31 }, { w53 = "100 Qa TON", m = 4.288e33, j = 8.48e31 },
	{ w53 = "10 Qi TON", m = 1.082e34, j = 3.226e33 }, { w53 = "1 Sx TON", m = 2.823e36, j = 1.229e36 },
	{ w53 = "100 Sx TON", m = 7.02e37, j = 4.683e37 }, { w53 = "10 Sp TON", m = 1.852e39, j = 1.785e39 },
	{ w53 = "10 Oc TON", m = 4.744e39, j = 6.8e39 }
}

local w59 = {
	{ "K", 1e3 }, { "M", 1e6 }, { "B", 1e9 }, { "T", 1e12 },
	{ "Qa", 1e15 }, { "Qi", 1e18 }, { "Sx", 1e21 }, { "Sp", 1e24 },
	{ "Oc", 1e27 }, { "No", 1e30 }, { "Dc", 1e33 }, { "Ud", 1e36 }, { "Dd", 1e39 }
}

local function w60(w61)
	if not w61 then return 0 end
	local w20 = tostring(w61):gsub("%s+", "")
	local w39, w49 = w20:match("([%d%.]+)(%a*)$")
	local w50 = tonumber(w39) or 0
	if w49 == "" then return w50 end
	for _, w51 in ipairs(w59) do if w51[1] == w49 then return w50 * w51[2] end end
	return w50
end

local w62 = {
	FistStrength = w33:WaitForChild("FSTxt"),
	BodyToughness = w33:WaitForChild("BTTxt"),
	PsychicPower = w33:WaitForChild("PPTxt"),
	JumpForce = w33:WaitForChild("JFTxt"),
	MovementSpeed = w33:WaitForChild("MSTxt")
}

local function w63(w20)
	local w39 = w62[w20]
	if not w39 then return 0 end
	return w60(w39.Text)
end

local function w64(w20, w39)
	local w49 = w57[w20]
	if not w49 then return nil end
	local w50, w51 = nil, -1
	for w65, w66 in pairs(w49) do
		local w67 = w60(w66.req)
		if w39 >= w67 and w67 > w51 then w50 = w65 w51 = w67 end
	end
	return w50
end

local function w68(w20, w39)
	local w49 = w57[w20]
	if not w49 then return nil end
	local w50, w51 = nil, -1
	local w65, w66 = nil, -1
	for w67, w69 in pairs(w49) do
		local w70 = w60(w69.req)
		if w39 >= w70 and w70 > w51 then
			w65 = w50 w66 = w51
			w50 = w67 w51 = w70
		elseif w39 >= w70 and w70 > w66 and w70 < w51 then
			w65 = w67 w66 = w70
		end
	end
	return w65
end

local function w71(w20, w39)
	local w49 = w34:FindFirstChild(w20)
	if not w49 then return nil end
	return w49:FindFirstChild(w39)
end

local function w72(w20)
	if not w20 then return false end
	local w39 = w16.Character
	if not w39 then return false end
	local w49 = w39:FindFirstChild("HumanoidRootPart")
	if not w49 then return false end
	local w50
	if w20:IsA("BasePart") then
		w50 = w20.CFrame
	else
		local w51 = w20.PrimaryPart or w20:FindFirstChildWhichIsA("BasePart")
		if w51 then w50 = w51.CFrame end
	end
	if w50 then
		w49.CFrame = w50 + Vector3.new(0, 5, 0)
		return true, w50 + Vector3.new(0, 5, 0)
	end
	return false
end

local function w73()
	local w20 = w63("MovementSpeed")
	local w39 = w63("JumpForce")
	local w49, w50 = nil, 1
	for w51, w65 in ipairs(w58) do
		if w20 >= w65.m and w39 >= w65.j then w49 = w65 w50 = w51 else break end
	end
	if w49 then w36({ "EquipWeight_Request", w50 }) end
end

local function w74(w20, w39)
	local w49 = w9("UICorner", w20)
	w49.CornerRadius = w7(0, w39 or 8)
	return w49
end

local function w75(w20, w39, w49, w50)
	local w51 = w9("UIGradient", w20)
	w51.Color = ColorSequence.new { ColorSequenceKeypoint.new(0, w39), ColorSequenceKeypoint.new(1, w49) }
	w51.Rotation = w50 or 90
	return w51
end

local function w76(w20, w39, w49)
	local w50 = w9("Frame", w20)
	w50.Size = w6(1, 0, 0, w39)
	w50.BackgroundColor3 = w5(32, 24, 45)
	w50.BorderSizePixel = 0
	w50.LayoutOrder = w49 or 1
	w74(w50, 10)
	w75(w50, w5(32, 24, 45), w5(38, 28, 52), 90)
	return w50
end

local function w77(w20, w39, w49)
	local w50 = w9("TextLabel", w20)
	w50.Size = w6(1, -20, 0, 20)
	w50.Position = w6(0, 10, 0, w49)
	w50.BackgroundTransparency = 1
	w50.Text = w39
	w50.Font = w10
	w50.TextSize = 12
	w50.TextColor3 = w5(150, 150, 150)
	w50.TextXAlignment = w13
	return w50
end

local function w78(w20, w39, w49)
	local w50 = w9("TextLabel", w20)
	w50.Size = w6(1, -20, 0, 26)
	w50.Position = w6(0, 10, 0, w49)
	w50.BackgroundTransparency = 1
	w50.Text = w39
	w50.Font = w11
	w50.TextSize = 18
	w50.TextXAlignment = w13
	return w50
end

local function w79(w20, w39, w49)
	local w50 = w9("Frame", w20)
	w50.Size = w6(1, -20, 0, 40)
	w50.Position = w6(0, 10, 0, w49)
	w50.BackgroundColor3 = w5(38, 28, 52)
	w50.BorderSizePixel = 0
	w74(w50, 8)
	local w51 = w9("TextLabel", w50)
	w51.Size = w6(1, -70, 1, 0)
	w51.Position = w6(0, 14, 0, 0)
	w51.BackgroundTransparency = 1
	w51.Text = w39
	w51.Font = w11
	w51.TextSize = 14
	w51.TextColor3 = w5(200, 200, 200)
	w51.TextXAlignment = w13
	return w50, w51
end

local function w80(w20, w39, w49, w50)
	local w51 = w39.X.Offset or 56
	local w65 = w39.Y.Offset or 28
	local w66 = w65 - 6
	local w67 = 3
	local w69 = w51 - w66 - 3
	local w70 = w9("Frame", w20)
	w70.Size = w6(0, w51, 0, w65)
	w70.Position = w6(1, -(w51 + 14), 0.5, 0)
	w70.AnchorPoint = w8(0, 0.5)
	w70.BorderSizePixel = 0
	w70.BackgroundColor3 = w50 and w5(50, 220, 100) or w5(70, 50, 90)
	w74(w70, w65 / 2)
	local w81 = w9("Frame", w70)
	w81.Size = w6(0, w66, 0, w66)
	w81.Position = w6(0, w50 and w69 or w67, 0.5, 0)
	w81.AnchorPoint = w8(0, 0.5)
	w81.BackgroundColor3 = w5(255, 255, 255)
	w81.BorderSizePixel = 0
	w74(w81, w66 / 2)
	local w82 = w9("TextButton", w70)
	w82.Size = w6(1, 0, 1, 0)
	w82.BackgroundTransparency = 1
	w82.Text = ""
	w82.ZIndex = w70.ZIndex + 2
	local w83 = { w84 = w50, t = w70, k = w81, ox = w67, nx = w69 }
	return w82, w83
end

local function w85(w20, w39)
	if not w20 then return end
	w20.w84 = w39
	w48(w20.t, w43.w44, { BackgroundColor3 = w39 and w5(50, 220, 100) or w5(70, 50, 90) })
	w48(w20.k, w43.w44, { Position = w6(0, w39 and w20.nx or w20.ox, 0.5, 0) })
end

local function w86(w20, w39, w49, w50)
	w21(w20.MouseEnter, function() w48(w20, w43.w44, w49) end)
	w21(w20.MouseLeave, function() w48(w20, w43.w44, w39) end)
	w21(w20.MouseButton1Down, function() w48(w20, w43.w44, w50) end)
	w21(w20.MouseButton1Up, function() w48(w20, w43.w44, w49) end)
end

local function w87(w20, w39, w49, w50)
	w21(w20.MouseEnter, function() if not w50() then w48(w20, w43.w44, { BackgroundColor3 = w39 }) end end)
	w21(w20.MouseLeave, function() if not w50() then w48(w20, w43.w44, { BackgroundColor3 = w49 }) end end)
end

local function w88(w20, w39, w49, w50)
	local w51 = w9("Frame", w20)
	w51.Size = w39
	w51.Position = w49
	w51.BackgroundColor3 = w5(28, 20, 40)
	w51.BorderSizePixel = 0
	w74(w51, 8)
	w9("UIStroke", w51).Color = w5(70, 45, 95)
	local w65 = w9("TextLabel", w51)
	w65.Size = w6(1, -10, 1, -10)
	w65.Position = w6(0, 5, 0, 5)
	w65.BackgroundTransparency = 1
	w65.Text = w50
	w65.Font = w10
	w65.TextSize = 14
	w65.TextColor3 = w5(180, 180, 180)
	w65.TextXAlignment = w13
	w65.TextWrapped = true
	w65.TextYAlignment = w14
	return w51, w65
end

local function w89(w20, w39)
	local w49 = w9("Frame", w20)
	w49.Size = w6(1, -20, 0, 1)
	w49.Position = w6(0, 10, 0, w39)
	w49.BackgroundColor3 = w5(70, 45, 95)
	w49.BorderSizePixel = 0
	return w49
end

local function w90(w20, w39, w49)
	local w50 = w9("Frame", w20)
	w50.Size = w39
	w50.Position = w49
	w50.BackgroundColor3 = w5(18, 14, 26)
	w50.BorderSizePixel = 0
	w74(w50, 8)
	w9("UIStroke", w50).Color = w5(70, 45, 95)
	local w51 = w9("ScrollingFrame", w50)
	w51.Size = w6(1, -4, 1, -4)
	w51.Position = w6(0, 2, 0, 2)
	w51.BackgroundTransparency = 1
	w51.BorderSizePixel = 0
	w51.ScrollBarThickness = 3
	w51.ScrollBarImageColor3 = w5(150, 80, 255)
	w51.ScrollBarImageTransparency = 0.5
	w51.CanvasSize = w6(0, 0, 0, 0)
	w51.AutomaticCanvasSize = Enum.AutomaticSize.Y
	local w65 = w9("UIListLayout", w51)
	w65.SortOrder = Enum.SortOrder.LayoutOrder
	w65.Padding = w7(0, 2)
	local w66 = w9("UIPadding", w51)
	w66.PaddingLeft = w7(0, 6) w66.PaddingRight = w7(0, 6)
	w66.PaddingTop = w7(0, 4) w66.PaddingBottom = w7(0, 4)
	local w67 = w9("TextLabel", w51)
	w67.Size = w6(1, 0, 0, 20)
	w67.BackgroundTransparency = 1
	w67.Font = w12
	w67.TextSize = 11
	w67.TextColor3 = w5(90, 90, 100)
	w67.TextXAlignment = w13
	w67.LayoutOrder = 1
	local w69 = 1
	local function w70(w81, w82)
		w67.Visible = false
		w69 = w69 + 1
		local w83 = os.date and os.date("%H:%M:%S") or "\xe2\x80\x94"
		local w91 = w9("TextLabel", w51)
		w91.Size = w6(1, 0, 0, 0)
		w91.AutomaticSize = Enum.AutomaticSize.Y
		w91.BackgroundTransparency = 1
		w91.Text = "[" .. w83 .. "] " .. w81
		w91.Font = w12
		w91.TextSize = 11
		w91.TextColor3 = w82 or w5(220, 220, 220)
		w91.TextXAlignment = w13
		w91.TextYAlignment = w14
		w91.TextWrapped = true
		w91.LayoutOrder = w69
		task.defer(function() w51.CanvasPosition = w8(0, math.huge) end)
		return w91
	end
	local function w92()
		for _, w15 in ipairs(w51:GetChildren()) do
			if w15:IsA("TextLabel") and w15 ~= w67 then w15:Destroy() end
		end
		w69 = 1
		w67.Visible = true
	end
	return w50, w51, w67, w70, w92
end

local w93 = {}
local w94

local function w95(w20, w39)
	if w94 then w94(w20, w39)
	else w93[#w93 + 1] = { w20, w39 } end
end

local w96 = w9("ScreenGui")
w96.Name = "eSPTSUI"
w96.ResetOnSpawn = false
w96.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
w96.Parent = w17
w19.w2 = w96

local w97, w98, w99 = 600, 480, 56
local w100 = 1
local w101

local function w102()
	return workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or w8(1920, 1080)
end

local function w103(w84)
	return math.clamp(math.min(w84.X / 1920, w84.Y / 1080), 0.75, 1.4)
end

local function w104(w84, w61)
	local w20, w39 = w97 * w61, w98 * w61
	return math.max(0, (w84.X - w20) / 2), math.max(0, (w84.Y - w39) / 2)
end

local function w105(w84, w61)
	local w20 = math.floor(w99 * w61)
	return w20, math.max(0, (w84.X - w20) / 3), math.max(0, math.min(30, w84.Y - w20))
end

local function w106()
	local w20 = w102()
	if w20.X < 100 or w20.Y < 100 then repeat task.wait() until w102().X > 100 end
	return w102()
end

w27 = w9("Frame", w96)
w27.Name = "MainFrame"
w27.Size = w6(0, 0, 0, 0)
w27.Position = w6(0, 0, 0, 0)
w27.BackgroundColor3 = w5(22, 18, 32)
w27.BorderSizePixel = 0
w27.Active = true
w27.ClipsDescendants = true
w27.Visible = false
w74(w27, 16)

w101 = w9("UIScale", w27)
w101.Scale = 1

local function w107(w20, w108)
	local w39, w49, w50, w51 = false, nil, nil, nil
	w21(w20.InputBegan, function(w65)
		if w65.UserInputType == Enum.UserInputType.MouseButton1 or w65.UserInputType == Enum.UserInputType.Touch then
			w39 = true w50 = w65.Position w51 = w20.Position
			if w49 then w49:Disconnect() end
			w49 = w2.InputChanged:Connect(function(w66)
				if (w66.UserInputType == Enum.UserInputType.MouseMovement or w66.UserInputType == Enum.UserInputType.Touch) and w39 then
					local w67 = w66.Position - w50
					w20.Position = w6(w51.X.Scale, w51.X.Offset + w67.X, w51.Y.Scale, w51.Y.Offset + w67.Y)
				end
			end)
			w65.Changed:Connect(function()
				if w65.UserInputState == Enum.UserInputState.End then
					w39 = false
					if w49 then w49:Disconnect() w49 = nil end
					if w108 then w108() end
				end
			end)
		end
	end)
end

w107(w27, function() w41() end)

local w109 = w9("ImageLabel", w27)
w109.BackgroundTransparency = 1
w109.Position = w6(0, -15, 0, -15)
w109.Size = w6(1, 30, 1, 30)
w109.ZIndex = 0
w109.Image = "rbxassetid://6014261993"
w109.ImageColor3 = w5(10, 5, 15)
w109.ImageTransparency = 0.5
w109.ScaleType = Enum.ScaleType.Slice
w109.SliceCenter = Rect.new(49, 49, 450, 450)

local w110 = w9("Frame", w27)
w110.Size = w6(1, 0, 0, 46)
w110.BackgroundColor3 = w5(32, 24, 45)
w110.BorderSizePixel = 0
w74(w110, 16)
w75(w110, w5(35, 26, 48), w5(26, 20, 38), 90)

local w111 = w9("TextLabel", w110)
w111.Size = w6(1, -60, 1, 0)
w111.Position = w6(0, 14, 0, 0)
w111.BackgroundTransparency = 1
w111.Text = "eSPTS"
w111.Font = w11
w111.TextSize = 22
w111.TextColor3 = w5(255, 255, 255)
w111.TextXAlignment = w13

local w112 = w9("ImageButton", w110)
w112.Size = w6(0, 28, 0, 28)
w112.Position = w6(1, -14, 0.5, 0)
w112.AnchorPoint = w8(1, 0.5)
w112.BackgroundColor3 = w5(180, 50, 220)
w112.BorderSizePixel = 0
w112.Image = "rbxassetid://3926305904"
w112.ImageRectOffset = w8(284, 4)
w112.ImageRectSize = w8(24, 24)
w112.ImageColor3 = w5(255, 255, 255)
w74(w112, 8)

w21(w112.MouseEnter, function()
	w48(w112, w43.w44, { BackgroundColor3 = w5(240, 70, 70), Size = w6(0, 32, 0, 32), Rotation = 90 })
end)
w21(w112.MouseLeave, function()
	w48(w112, w43.w44, { BackgroundColor3 = w5(180, 50, 220), Size = w6(0, 28, 0, 28), Rotation = 0 })
end)
w21(w112.MouseButton1Down, function()
	w48(w112, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = w6(0, 24, 0, 24) })
end)
w21(w112.MouseButton1Up, function()
	w48(w112, w43.w44, { Size = w6(0, 28, 0, 28) })
end)

local w113 = w9("Frame", w27)
w113.Size = w6(0, 165, 1, -52)
w113.Position = w6(0, 5, 0, 52)
w113.BackgroundColor3 = w5(28, 20, 40)
w113.BorderSizePixel = 0
w74(w113, 10)
w75(w113, w5(28, 20, 40), w5(22, 18, 32), 90)

local w114 = w9("Frame", w27)
w114.Size = w6(1, -180, 1, -57)
w114.Position = w6(0, 178, 0, 52)
w114.BackgroundTransparency = 1
w114.BorderSizePixel = 0
w114.ClipsDescendants = true

local function w115() return math.floor(w99 * w100) end

w28 = w9("ImageButton", w96)
w28.Name = "ReopenButton"
w28.Size = w6(0, w115(), 0, w115())
w28.Position = w6(0, 100, 0, 100)
w28.BackgroundColor3 = w5(150, 80, 255)
w28.BorderSizePixel = 0
w28.Visible = false
w28.ZIndex = 10
w28.Active = true
w28.ImageTransparency = 1
w74(w28, 100)
w75(w28, w5(150, 80, 255), w5(130, 60, 235), 45)

local w116 = w9("TextLabel", w28)
w116.Size = w6(1, 0, 1, 0)
w116.BackgroundTransparency = 1
w116.Text = "eSPTS"
w116.Font = w11
w116.TextSize = 13
w116.TextColor3 = w5(255, 255, 255)
w116.TextTransparency = 0

local w117, w118 = nil, false

local function w119()
	if w117 then w117:Disconnect() w117 = nil end
	w118 = false
end

local function w120()
	if w118 then return end
	w118 = true
	if w117 then w117:Disconnect() end
	w117 = w1.RenderStepped:Connect(function(w20)
		if w28.Visible then w28.Rotation = (w28.Rotation + (w20 * 180)) % 360
		else w119() end
	end)
end

local w121, w122, w123 = false, false, false
local w124, w125, w126

w21(w28.InputBegan, function(w20)
	if w20.UserInputType == Enum.UserInputType.MouseButton1 or w20.UserInputType == Enum.UserInputType.Touch then
		w122 = false
		w123 = false
		w121 = true
		w125 = w20.Position
		w126 = w28.Position
		w120()
		if w124 then w124:Disconnect() end
		w124 = w2.InputChanged:Connect(function(w39)
			if (w39.UserInputType == Enum.UserInputType.MouseMovement or w39.UserInputType == Enum.UserInputType.Touch) and w121 then
				local w49 = w39.Position - w125
				if math.abs(w49.X) > 5 or math.abs(w49.Y) > 5 then w122 = true end
				w28.Position = w6(0, w126.X.Offset + w49.X, 0, w126.Y.Offset + w49.Y)
			end
		end)
		w20.Changed:Connect(function()
			if w20.UserInputState == Enum.UserInputState.End or w20.UserInputState == Enum.UserInputState.Cancel then
				w121 = false
				if w124 then w124:Disconnect() w124 = nil end
				if w122 then
					w123 = true
					w24.rp = { X = w28.Position.X.Offset, Y = w28.Position.Y.Offset }
					w38()
					task.delay(.05, function() w123 = false end)
				end
				w122 = false
			end
		end)
	end
end)

w21(w28.MouseEnter, function()
	if not w121 then
		w48(w28, w43.m, { Size = w6(0, math.floor(w115() * 1.17), 0, math.floor(w115() * 1.17)) })
		w120()
	end
end)
w21(w28.MouseLeave, function()
	if not w121 then
		w119()
		w48(w28, w43.m, { Size = w6(0, w115(), 0, w115()), Rotation = 0 })
	end
end)

local function w127(w20, w39, w49, w50)
	w28.Size = w6(0, 0, 0, 0)
	w28.Position = w6(0, w20, 0, w39)
	w28.ImageTransparency = 1
	w28.Rotation = -180
	w116.TextTransparency = 1
	w28.Visible = true
	w48(w28, w43.b, { Size = w6(0, w115(), 0, w115()), Position = w6(0, w49, 0, w50), ImageTransparency = 0, Rotation = 0 })
	task.delay(.15, function() w48(w116, w43.w44, { TextTransparency = 0 }) end)
end

local function w128(w20, w39, w49)
	w27.Visible = true
	w101.Scale = 0
	w27.Size = w6(0, w97, 0, w98)
	w27.Position = w6(0, w20, 0, w39 + 18)
	w27.BackgroundTransparency = 1
	w48(w27, w43.m, { Position = w6(0, w20, 0, w39), BackgroundTransparency = 0 })
	w48(w101, w49, { Scale = w100 })
end

local w129, w130 = {}, {}
local w131 = {
	{ w53 = "Auto Farm", w132 = "\xf0\x9f\x94\xa5", o = 1 },
	{ w53 = "Auto Weights", w132 = "\xf0\x9f\x8f\x8b\xef\xb8\x8f", o = 2 },
	{ w53 = "Position Man", w132 = "\xf0\x9f\x8e\xaf", o = 3 },
	{ w53 = "Settings", w132 = "\xe2\x9a\x99\xef\xb8\x8f", o = 4 }
}

local function w133(w20, w39, w49)
	local w50 = w9("TextButton", w113)
	w50.Name = w20 .. "Tab"
	w50.Size = w6(1, -10, 0, 50)
	w50.Position = w6(0.5, 0, 0, 8 + ((w49 - 1) * 55) + 27)
	w50.AnchorPoint = w8(0.5, 0.5)
	w50.BackgroundColor3 = w5(32, 24, 45)
	w50.BorderSizePixel = 0
	w50.Text = ""
	w50.AutoButtonColor = false
	w74(w50, 8)
	local w51 = w9("TextLabel", w50)
	w51.Size = w6(0, 30, 1, 0)
	w51.Position = w6(0, 10, 0, 0)
	w51.BackgroundTransparency = 1
	w51.Text = w39
	w51.Font = w11
	w51.TextSize = 18
	w51.TextColor3 = w5(180, 180, 180)
	w51.TextXAlignment = w13
	local w65 = w9("TextLabel", w50)
	w65.Size = w6(1, -50, 1, 0)
	w65.Position = w6(0, 45, 0, 0)
	w65.BackgroundTransparency = 1
	w65.Text = w20
	w65.Font = w11
	w65.TextSize = 13
	w65.TextColor3 = w5(180, 180, 180)
	w65.TextXAlignment = w13
	w129[w20] = { b = w50, w132 = w51, l = w65 }
	w21(w50.MouseEnter, function()
		local w66 = w24.tb == w20
		if w66 then
			w48(w50, w43.w44, { Size = w6(1, -4, 0, 54) })
			w48(w51, w43.w44, { TextSize = 21 })
			w48(w65, w43.w44, { TextSize = 14 })
		else
			w48(w50, w43.w44, { BackgroundColor3 = w5(45, 32, 62), Size = w6(1, -4, 0, 54) })
			w48(w51, w43.w44, { TextColor3 = w5(200, 200, 200), TextSize = 21 })
			w48(w65, w43.w44, { TextColor3 = w5(200, 200, 200), TextSize = 14 })
		end
	end)
	w21(w50.MouseLeave, function()
		local w66 = w24.tb == w20
		if w66 then
			w48(w50, w43.w44, { BackgroundColor3 = w5(150, 80, 255), Size = w6(1, -10, 0, 50) })
			w48(w51, w43.w44, { TextColor3 = w5(255, 255, 255), TextSize = 18 })
			w48(w65, w43.w44, { TextColor3 = w5(255, 255, 255), TextSize = 13 })
		else
			w48(w50, w43.w44, { BackgroundColor3 = w5(32, 24, 45), Size = w6(1, -10, 0, 50) })
			w48(w51, w43.w44, { TextColor3 = w5(180, 180, 180), TextSize = 18 })
			w48(w65, w43.w44, { TextColor3 = w5(180, 180, 180), TextSize = 13 })
		end
	end)
	w21(w50.MouseButton1Down, function()
		local w66 = w24.tb == w20
		if w66 then w48(w50, w43.w44, { Size = w6(1, -14, 0, 46) })
		else w48(w50, w43.w44, { BackgroundColor3 = w5(55, 38, 72), Size = w6(1, -14, 0, 46) }) end
		w48(w51, w43.w44, { TextSize = 16 })
	end)
	w21(w50.MouseButton1Up, function()
		local w66 = w24.tb == w20
		if w66 then w48(w50, w43.w44, { BackgroundColor3 = w5(150, 80, 255), Size = w6(1, -4, 0, 54) })
		else w48(w50, w43.w44, { BackgroundColor3 = w5(45, 32, 62), Size = w6(1, -4, 0, 54) }) end
		w48(w51, w43.w44, { TextSize = 21 })
	end)
	return w50
end

local function w134(w20)
	local w39 = w9("ScrollingFrame", w114)
	w39.Name = w20 .. "Content"
	w39.Size = w6(1, -10, 1, -10)
	w39.Position = w6(0, 5, 0, 5)
	w39.BackgroundTransparency = 1
	w39.BorderSizePixel = 0
	w39.ScrollBarThickness = 4
	w39.ScrollBarImageColor3 = w5(150, 80, 255)
	w39.ScrollBarImageTransparency = 0.5
	w39.CanvasSize = w6(0, 0, 0, 0)
	w39.Visible = false
	w39.AutomaticCanvasSize = Enum.AutomaticSize.Y
	local w49 = w9("UIListLayout", w39)
	w49.SortOrder = Enum.SortOrder.LayoutOrder
	w49.Padding = w7(0, 10)
	local w50 = w9("UIPadding", w39)
	w50.PaddingLeft = w7(0, 5) w50.PaddingRight = w7(0, 5)
	w50.PaddingTop = w7(0, 5) w50.PaddingBottom = w7(0, 5)
	w130[w20] = w39
	return w39
end

for _, w20 in ipairs(w131) do w133(w20.w53, w20.w132, w20.o) w134(w20.w53) end

local function w135(w20)
	for w39, w49 in pairs(w129) do
		w47(w49.b) w47(w49.w132) w47(w49.l)
		local w50 = w39 == w20
		w49.b.BackgroundColor3 = w50 and w5(150, 80, 255) or w5(32, 24, 45)
		w49.b.Size = w50 and w6(1, -4, 0, 54) or w6(1, -10, 0, 50)
		w49.w132.TextColor3 = w50 and w5(255, 255, 255) or w5(180, 180, 180)
		w49.w132.TextSize = w50 and 19 or 18
		w49.l.TextColor3 = w50 and w5(255, 255, 255) or w5(180, 180, 180)
	end
end

local function w136(w20)
	if w24.tb == w20 and w54["T"] then return end
	if not w55("T", .15) then return end
	w24.tb = w20
	w41()
	for w39, w49 in pairs(w130) do
		if w39 == w20 then
			w49.Visible = true
			w49.Position = w6(0, 15, 0, 0)
			w48(w49, w43.sm, { Position = w6(0, 5, 0, 0) })
		else
			w49.Visible = false
		end
	end
	w135(w20)
end

for _, w20 in ipairs(w131) do
	w21(w129[w20.w53].b.MouseButton1Click, function() w136(w20.w53) end)
end

local w137 = w130["Auto Farm"]

local w138 = w76(w137, 50, 1)
local _, w139 = w88(w138, w6(1, -20, 0, 32), w6(0, 10, 0, 9), "No active training")
w139.TextYAlignment = w15

local w140 = w76(w137, 410, 2)
w78(w140, "\xf0\x9f\x94\xa5 Stat Training", 8)
w77(w140, "Select a stat to automatically train at the best available area", 34)
w89(w140, 56)

local w141, w142
local w143 = {
	FistStrength = "Fist Strength", BodyToughness = "Body Toughness",
	PsychicPower = "Psychic Power", JumpForce = "Jump Force", MovementSpeed = "Movement Speed"
}
local w144 = { "FistStrength", "BodyToughness", "PsychicPower", "JumpForce", "MovementSpeed" }
local w145, w146 = {}, {}
local w147

for w132, w20 in ipairs(w144) do
	local w39, w49 = w79(w140, w143[w20], 64 + ((w132 - 1) * 42))
	local w50, w51 = w80(w39, w6(0, 56, 0, 28), w6(1, -35, 0.5, 0), false)
	w145[w20] = { w44 = w39, l = w49, tg = w51 }
	w87(w39, w5(45, 32, 62), w5(38, 28, 52), function() return w24.st == w20 end)
	w21(w50.MouseButton1Click, function()
		if not w55("S" .. w20, .3) then return end
		local w65 = not w51.w84
		w85(w51, w65)
		if w65 then
			for w66, w67 in pairs(w145) do
				if w66 ~= w20 then
					w85(w67.tg, false)
					w48(w67.w44, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
					w67.l.TextColor3 = w5(200, 200, 200)
				end
			end
			w24.st = w20
			if w20 ~= "BodyToughness" then w24.fm = nil end
			w48(w39, w43.w44, { BackgroundColor3 = w5(55, 30, 75) })
			w49.TextColor3 = w5(255, 255, 255)
			local w69 = w63(w20)
			local w70 = w64(w20, w69)
			if not w70 then
				w139.Text = w143[w20] .. " \xe2\x80\x94 No available area"
				w141 = nil w24.fm = nil
				w147() w41()
				w95(w143[w20] .. " \xe2\x80\x94 No area found", w5(255, 150, 80))
				return
			end
			local w81 = w71(w20, w70)
			w141 = w81
			if not w81 then
				w139.Text = "Area '" .. w70 .. "' not found!"
				w141 = nil w24.fm = nil
				w147() w41()
				w95("Area '" .. w70 .. "' not found", w5(255, 150, 80))
				return
			end
			local w82, w83 = w72(w81)
			if w82 then
				w142 = w83
				w139.Text = w143[w20] .. " \xe2\x80\x94 Area: " .. w70 .. " (req " .. w57[w20][w70].req .. ")"
				w95(w143[w20] .. " \xe2\x80\x94 " .. w70, w5(80, 220, 120))
			else
				w139.Text = "Teleport failed!"
				w95("Teleport failed", w5(255, 80, 80))
			end
		else
			w24.st = nil w141 = nil w142 = nil w24.fm = nil
			w48(w39, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
			w49.TextColor3 = w5(200, 200, 200)
			w139.Text = "No active training"
			w95(w143[w20] .. " \xe2\x80\x94 Stopped", w5(180, 180, 180))
		end
		w147() w41()
	end)
end

w89(w140, 278)
w77(w140, "Body Toughness Mode", 288)

local function w148(w20, w39, w49)
	local w50 = w9("Frame", w140)
	w50.Size = w6(1, -20, 0, 40)
	w50.Position = w6(0, 10, 0, w20)
	w50.BackgroundColor3 = w5(38, 28, 52)
	w50.BorderSizePixel = 0
	w74(w50, 10)
	local w51 = w9("TextButton", w50)
	w51.Size = w6(1, 0, 1, 0)
	w51.BackgroundTransparency = 1
	w51.Text = w39
	w51.TextColor3 = w49
	w51.Font = w11
	w51.TextSize = 13
	w51.AutoButtonColor = false
	w51.TextXAlignment = Enum.TextXAlignment.Center
	return w50, w51
end

local w149, w150 = w148(312, "BT: Current Area", w5(180, 160, 220))
w146.c = { w44 = w149, l = w150 }
local w151, w152 = w148(358, "BT: Next Area", w5(160, 160, 220))
w146.w53 = { w44 = w151, l = w152 }

w87(w149, w5(50, 35, 68), w5(38, 28, 52), function() return w24.fm == "c" end)
w87(w151, w5(50, 35, 68), w5(38, 28, 52), function() return w24.fm == "n" end)

w21(w150.MouseButton1Down, function()
	w48(w149, w43.w44, { BackgroundColor3 = w24.fm ~= "c" and w5(60, 42, 75) or w5(45, 35, 60) })
end)
w21(w150.MouseButton1Up, function() w147() end)

w21(w152.MouseButton1Down, function()
	w48(w151, w43.w44, { BackgroundColor3 = w24.fm ~= "n" and w5(60, 42, 75) or w5(45, 35, 60) })
end)
w21(w152.MouseButton1Up, function() w147() end)

w147 = function()
	local w20 = w24.fm == "c"
	local w39 = w24.fm == "n"
	w48(w146.c.w44, w43.w44, { BackgroundColor3 = w20 and w5(55, 30, 75) or w5(38, 28, 52) })
	w146.c.l.TextColor3 = w20 and w5(255, 255, 255) or w5(180, 160, 220)
	w48(w146.w53.w44, w43.w44, { BackgroundColor3 = w39 and w5(55, 30, 75) or w5(38, 28, 52) })
	w146.w53.l.TextColor3 = w39 and w5(255, 255, 255) or w5(160, 160, 220)
end

local function w153(m)
	local w20 = w24.fm ~= m
	if w20 then
		w24.fm = m
		w24.st = "BodyToughness"
		for w39, w49 in pairs(w145) do
			if w39 == "BodyToughness" then
				w85(w49.tg, true)
				w48(w49.w44, w43.w44, { BackgroundColor3 = w5(55, 30, 75) })
				w49.l.TextColor3 = w5(255, 255, 255)
			else
				w85(w49.tg, false)
				w48(w49.w44, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
				w49.l.TextColor3 = w5(200, 200, 200)
			end
		end
		local w39 = w63("BodyToughness")
		local w49 = m == "c" and w68("BodyToughness", w39) or w64("BodyToughness", w39)
		if not w49 then
			w139.Text = "Body Toughness \xe2\x80\x94 No available area"
			w141 = nil w24.fm = nil
			w147() w41()
			w95("BT " .. (m == "n" and "Next" or "Current") .. " \xe2\x80\x94 No area", w5(255, 150, 80))
			return
		end
		local w50 = w71("BodyToughness", w49)
		w141 = w50
		if not w50 then
			w139.Text = "Area '" .. w49 .. "' not found!"
			w141 = nil w24.fm = nil
			w147() w41()
			w95("Area not found", w5(255, 80, 80))
			return
		end
		local w51, w65 = w72(w50)
		if w51 then
			w142 = w65
			local w66 = m == "n" and "Next" or "Current"
			w139.Text = "Body Toughness (" .. w66 .. ") \xe2\x80\x94 Area: " .. w49 .. " (req " .. w57.BodyToughness[w49].req .. ")"
			w95("BT " .. w66 .. " \xe2\x80\x94 " .. w49, w5(80, 220, 120))
		else
			w139.Text = "Teleport failed!"
			w95("Teleport failed", w5(255, 80, 80))
		end
	else
		w24.fm = nil w24.st = nil w141 = nil w142 = nil
		for w39, w49 in pairs(w145) do
			w85(w49.tg, false)
			w48(w49.w44, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
			w49.l.TextColor3 = w5(200, 200, 200)
		end
		w139.Text = "No active training"
		w95("BT mode off", w5(180, 180, 180))
	end
	w147() w41()
end

w21(w150.MouseButton1Click, function()
	if w55("BC", .3) then w153("c") end
end)
w21(w152.MouseButton1Click, function()
	if w55("BN", .3) then w153("n") end
end)

local w154 = w130["Auto Weights"]

local w26 = w76(w154, 135, 1)
w78(w26, "\xf0\x9f\x8f\x8b\xef\xb8\x8f Auto Weight", 8)
w77(w26, "Automatically equip the best available weight based on your stats", 32)

local _, w155 = w88(w26, w6(1, -20, 0, 30), w6(0, 10, 0, 54), "Auto weight system inactive")
w155.TextYAlignment = w15

local w156, w157 = w79(w26, "Auto Weight", 90)
local w158, w159 = w80(w156, w6(0, 52, 0, 26), w6(1, -35, 0.5, 0), false)

local function w160()
	w52("W")
	if not w24.w26 then return end
	w46.W = task.spawn(function()
		while w24.w26 do
			task.wait(1)
			if w24.w26 and w96 and w96.Parent then
				w36({ "Add_MS_Request" })
				w36({ "Add_JF_Request" })
				w73()
			end
		end
		w46.W = nil
	end)
end

local function w161()
	if w24.w26 then
		w48(w156, w43.w44, { BackgroundColor3 = w5(55, 30, 75) })
		w157.TextColor3 = w5(255, 255, 255)
		w155.Text = "Auto Weight active \xe2\x80\x94 farming MS and JF automatically"
		w73() w160()
		w95("Auto Weight enabled", w5(80, 220, 120))
	else
		w48(w156, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
		w157.TextColor3 = w5(200, 200, 200)
		w155.Text = "Auto weight system inactive"
		w52("W")
		w95("Auto Weight disabled", w5(180, 180, 180))
	end
end

w21(w158.MouseButton1Click, function()
	if not w55("AW", .3) then return end
	w24.w26 = not w24.w26
	w85(w159, w24.w26)
	w161() w41()
end)
w87(w156, w5(45, 32, 62), w5(38, 28, 52), function() return w24.w26 end)

local w162 = w130["Position Man"]

local w163 = w76(w162, 130, 1)
w78(w163, "\xf0\x9f\x93\x8c Position Manager", 8)
w77(w163, "Save and restore your position for automatic respawning and pullback", 32)

local _, w164 = w88(w163, w6(1, -20, 0, 48), w6(0, 10, 0, 54), "No position saved")
w164.TextYAlignment = w15

local function w165(w20, w39)
	local w49 = w9("Frame", w162)
	w49.Size = w6(1, 0, 0, 55)
	w49.BackgroundColor3 = w5(38, 28, 52)
	w49.BorderSizePixel = 0
	w49.LayoutOrder = w39
	w74(w49, 10)
	local w50 = w9("TextButton", w49)
	w50.Size = w6(1, 0, 1, 0)
	w50.BackgroundTransparency = 1
	w50.Text = w20
	w50.TextColor3 = w5(200, 200, 200)
	w50.Font = w11
	w50.TextSize = 14
	w50.AutoButtonColor = false
	w86(w50,
		{ BackgroundColor3 = w5(38, 28, 52), Size = w6(1, 0, 0, 55) },
		{ BackgroundColor3 = w5(50, 36, 68), Size = w6(1, 0, 0, 58) },
		{ BackgroundColor3 = w5(60, 44, 78), Size = w6(1, 0, 0, 51) }
	)
	return w49, w50
end

local w166, w167 = w165("Save Current Position", 2)
local w168, w169 = w165("Clear Saved Position", 3)

w21(w167.MouseButton1Click, function()
	if w16.Character and w16.Character:FindFirstChild("HumanoidRootPart") then
		w24.sv = w16.Character.HumanoidRootPart.CFrame
		w48(w166, w43.w44, { BackgroundColor3 = w5(50, 220, 100) })
		w167.TextColor3 = w5(255, 255, 255)
		w164.Text = "Position saved! You will respawn here and be pulled back if you go too far."
		w95("Position saved", w5(80, 220, 120))
		task.wait(.5)
		w48(w166, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
		w167.TextColor3 = w5(200, 200, 200)
		w41()
	end
end)

w21(w169.MouseButton1Click, function()
	w24.sv = nil
	w48(w168, w43.w44, { BackgroundColor3 = w5(180, 50, 220) })
	w169.TextColor3 = w5(255, 255, 255)
	w164.Text = "Position cleared!"
	w95("Position cleared", w5(255, 150, 100))
	task.wait(.5)
	w48(w168, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
	w169.TextColor3 = w5(200, 200, 200)
	w164.Text = "No position saved"
	w41()
end)

local w170 = w130["Settings"]

local w171 = w76(w170, 510, 1)
w78(w171, "\xe2\x9a\x99\xef\xb8\x8f UI Configuration", 8)
w77(w171, "Customize interface preferences and keybinds", 34)
w89(w171, 60)
w77(w171, "Toggle Keybind", 70)

local w25 = w9("TextButton", w171)
w25.Size = w6(1, -20, 0, 40)
w25.Position = w6(0, 10, 0, 90)
w25.BackgroundColor3 = w5(45, 32, 62)
w25.BorderSizePixel = 0
w25.Text = "Current Key: " .. w24.w25
w25.TextColor3 = w5(255, 255, 255)
w25.Font = w11
w25.TextSize = 13
w25.AutoButtonColor = false
w74(w25, 8)
w86(w25,
	{ BackgroundColor3 = w5(45, 32, 62), Size = w6(1, -20, 0, 40) },
	{ BackgroundColor3 = w5(55, 42, 72), Size = w6(1, -15, 0, 44) },
	{ BackgroundColor3 = w5(68, 52, 85), Size = w6(1, -25, 0, 36) }
)

local w172 = false
w21(w25.MouseButton1Click, function()
	if w172 then return end
	w172 = true
	w25.Text = "Press any key..."
	w95("Changing keybind...", w5(255, 200, 100))
	w25.Active = false
	local w20, w39
	w39 = task.delay(5, function()
		if w172 then
			w172 = false
			w25.Text = "Current Key: " .. w24.w25
			w25.Active = true
			w95("Keybind timeout", w5(255, 100, 100))
		end
	end)
	w20 = w21(w2.InputBegan, function(w49, w173)
		if w173 then return end
		if w49.UserInputType == Enum.UserInputType.Keyboard then
			pcall(task.cancel, w39)
			w24.w25 = w49.KeyCode.Name
			w25.Text = "Current Key: " .. w24.w25
			w95("Keybind \xe2\x80\x94 " .. w24.w25, w5(100, 200, 255))
			w41() w172 = false
			w25.Active = true
			w20:Disconnect()
		end
	end)
end)

w89(w171, 145)

local w174, w175 = w79(w171, "Auto Hide UI", 157)
local w176, w177 = w80(w174, w6(0, 52, 0, 26), w6(1, -35, 0.5, 0), w24.ah)

local w178 = w9("TextLabel", w171)
w178.Size = w6(1, -20, 0, 20)
w178.Position = w6(0, 10, 0, 206)
w178.BackgroundTransparency = 1
w178.Font = w10
w178.TextSize = 12
w178.TextXAlignment = w13
w178.TextWrapped = true

local function w179()
	w85(w177, w24.ah)
	if w24.ah then
		w178.Text = "Auto Hide enabled \xe2\x80\x94 UI starts hidden on next execution."
		w178.TextColor3 = w5(50, 220, 100)
		w175.TextColor3 = w5(255, 255, 255)
		w48(w174, w43.w44, { BackgroundColor3 = w5(55, 30, 75) })
	else
		w178.Text = "Auto Hide disabled \xe2\x80\x94 UI shows normally on start."
		w178.TextColor3 = w5(180, 180, 180)
		w175.TextColor3 = w5(200, 200, 200)
		w48(w174, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
	end
end

w179()

w21(w176.MouseButton1Click, function()
	if not w55("AH", .3) then return end
	w24.ah = not w24.ah
	w85(w177, w24.ah)
	w179()
	w95(w24.ah and "Auto Hide enabled" or "Auto Hide disabled", w24.ah and w5(50, 220, 100) or w5(180, 180, 180))
	w41()
end)

w89(w171, 238)
w77(w171, "Activity Log", 248)

local w180 = w9("TextButton", w171)
w180.Size = w6(0, 50, 0, 18)
w180.Position = w6(1, -60, 0, 246)
w180.BackgroundColor3 = w5(70, 45, 95)
w180.BorderSizePixel = 0
w180.Text = "Clear"
w180.Font = w10
w180.TextSize = 11
w180.TextColor3 = w5(200, 180, 220)
w180.AutoButtonColor = false
w74(w180, 5)
w86(w180,
	{ BackgroundColor3 = w5(70, 45, 95), Size = w6(0, 50, 0, 18) },
	{ BackgroundColor3 = w5(90, 60, 115), Size = w6(0, 54, 0, 20) },
	{ BackgroundColor3 = w5(110, 70, 130), Size = w6(0, 46, 0, 16) }
)

local _, _, w181, w182, w183 = w90(w171, w6(1, -20, 0, 200), w6(0, 10, 0, 270))
w181.Text = "No activity yet."
w94 = w182
for _, w20 in ipairs(w93) do w182(w20[1], w20[2]) end
w93 = {}

w21(w180.MouseButton1Click, function() w183() end)

local w184 = false

local function w185()
	if w184 then return end
	w184 = true
	task.spawn(function()
		if w27.Visible then
			w24.up = { X = w27.Position.X.Offset, Y = w27.Position.Y.Offset }
			w48(w101, w43.sm, { Scale = 0 })
			w27.Size = w6(0, w97, 0, w98)
			w48(w27, w43.bi, { Size = w6(0, 0, 0, 0), BackgroundTransparency = 1 })
			task.wait(.35)
			w27.Visible = false
			w27.BackgroundTransparency = 0
			local w20, w39
			if w24.rp and w24.rp.X and w24.rp.Y then w20, w39 = w24.rp.X, w24.rp.Y
			else
				local _, w49, w50 = w105(w102(), w100)
				w20, w39 = w49, w50
			end
			w127(w20 + 270, w39 + 210, w20, w39)
		else
			w119()
			if w28.Visible then w24.rp = { X = w28.Position.X.Offset, Y = w28.Position.Y.Offset } end
			w48(w28, w43.bi, { Size = w6(0, 0, 0, 0), Rotation = 90, ImageTransparency = 1 })
			w48(w116, w43.w44, { TextTransparency = 1 })
			task.wait(.35)
			w28.Visible = false
			w28.Rotation = 0
			w28.ImageTransparency = 0
			w116.TextTransparency = 0
			local w20, w39
			if w24.up and w24.up.X and w24.up.Y then w20, w39 = w24.up.X, w24.up.Y
			else w20, w39 = w104(w102(), w100) end
			w128(w20, w39, w43.b)
		end
		w41()
		w184 = false
	end)
end

local w186, w187 = w8(0, 0), false

local function w188()
	if w187 then return end
	w187 = true
	task.delay(.1, function()
		w187 = false
		local w20 = w102()
		if math.abs(w20.X - w186.X) < 2 and math.abs(w20.Y - w186.Y) < 2 then return end
		w186 = w20
		local w39 = w103(w20)
		w100 = w39
		local w49, w50 = w104(w20, w100)
		local w51, w65, w66 = w105(w20, w100)
		if w27.Visible then
			w24.up = { X = w27.Position.X.Offset, Y = w27.Position.Y.Offset }
			w48(w101, w43.sm, { Scale = w100 })
			w27.Size = w6(0, w97, 0, w98)
			w27.Position = w6(0, w49, 0, w50)
			w24.up = nil
			w24.rp = nil
			w28.Size = w6(0, w51, 0, w51)
			w28.Position = w6(0, w65, 0, w66)
		elseif w28.Visible then
			w24.rp = { X = w28.Position.X.Offset, Y = w28.Position.Y.Offset }
			w24.up = nil
			w24.rp = nil
			w28.Size = w6(0, w51, 0, w51)
			w28.Position = w6(0, w65, 0, w66)
		else
			w24.up = nil
			w24.rp = nil
			w27.Size = w6(0, w97, 0, w98)
			w27.Position = w6(0, w49, 0, w50)
			w28.Size = w6(0, w51, 0, w51)
			w28.Position = w6(0, w65, 0, w66)
		end
		w38()
	end)
end

if workspace.CurrentCamera then w21(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w188) end
w21(workspace:GetPropertyChangedSignal("CurrentCamera"), function()
	if workspace.CurrentCamera then w21(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), w188) end
end)

w21(w112.MouseButton1Click, function() w185() end)
w21(w28.MouseButton1Click, function()
	if w123 then return end
	w185()
end)
w21(w2.InputBegan, function(w20, w173)
	if w173 then return end
	if w20.KeyCode == Enum.KeyCode[w24.w25] and not w184 then w185() end
end)

w21(w27.Destroying, function()
	w38()
	w119()
	for _, w20 in pairs(w46) do
		if typeof(w20) == "thread" and coroutine.status(w20) ~= "dead" then pcall(task.cancel, w20) end
	end
end)

local w189 = w42()
if w189 then
	if w24.w25 then w25.Text = "Current Key: " .. w24.w25 end
	w85(w159, w24.w26) w161()
	if w24.st then
		for w20, w39 in pairs(w145) do
			if w20 == w24.st then
				w85(w39.tg, true)
				w48(w39.w44, w43.w44, { BackgroundColor3 = w5(55, 30, 75) })
				w39.l.TextColor3 = w5(255, 255, 255)
				local w49 = w63(w20)
				local w50 = w20 == "BodyToughness" and w24.fm == "c" and w68(w20, w49) or w64(w20, w49)
				if w50 then
					local w51 = w71(w20, w50)
					w141 = w51
					if w51 then
						local w65, w66 = w72(w51)
						if w65 then
							w142 = w66
							if w20 == "BodyToughness" and w24.fm then
								local w67 = w24.fm == "n" and "Next" or "Current"
								w139.Text = w143[w20] .. " (" .. w67 .. ") \xe2\x80\x94 Area: " .. w50 .. " (req " .. w57[w20][w50].req .. ")"
							else
								w139.Text = w143[w20] .. " \xe2\x80\x94 Area: " .. w50 .. " (req " .. w57[w20][w50].req .. ")"
							end
						end
					end
				end
			else
				w85(w39.tg, false)
				w48(w39.w44, w43.w44, { BackgroundColor3 = w5(38, 28, 52) })
				w39.l.TextColor3 = w5(200, 200, 200)
			end
		end
	else
		w139.Text = "No active training"
	end
	w147()
	if w24.sv then w164.Text = "Position loaded from config!" end
	if w24.up and w24.up.X and w24.up.Y then w27.Position = w6(0, w24.up.X, 0, w24.up.Y) end
	w179()
	w136(w24.tb or "Auto Farm")
	w95("Config loaded for " .. w22, w5(100, 200, 255))
else
	w147() w179() w136("Auto Farm")
	w95("Fresh start \xe2\x80\x94 no saved config", w5(255, 200, 100))
end

w21(w1.Heartbeat, function()
	if not w96 or not w96.Parent then return end
	if w24.sv and w16.Character and w16.Character:FindFirstChild("HumanoidRootPart") then
		local w20 = w16.Character.HumanoidRootPart
		if (w20.Position - w24.sv.Position).Magnitude > 20 then w20.CFrame = w24.sv end
	end
	if not w24.st then return end
	local w20 = w16.Character
	if not w20 then return end
	local w39 = w20:FindFirstChild("HumanoidRootPart")
	if not w39 then return end
	local w49 = w63(w24.st)
	local w50 = w24.st == "BodyToughness" and w24.fm == "c" and w68(w24.st, w49) or w64(w24.st, w49)
	if w50 and (not w141 or w141.Name ~= w50) then
		local w51 = w71(w24.st, w50)
		if w51 then
			w141 = w51
			local w65, w66 = w72(w51)
			if w65 then
				w142 = w66
				if w24.st == "BodyToughness" and w24.fm then
					local w67 = w24.fm == "n" and "Next" or "Current"
					w139.Text = w143[w24.st] .. " (" .. w67 .. ") \xe2\x80\x94 Area: " .. w50 .. " (req " .. w57[w24.st][w50].req .. ")"
				else
					w139.Text = w143[w24.st] .. " \xe2\x80\x94 Area: " .. w50 .. " (req " .. w57[w24.st][w50].req .. ")"
				end
			end
		end
	end
	if w142 and (w39.Position - w142.Position).Magnitude > 15 then w39.CFrame = w142 end
	if w24.st == "FistStrength" then
		w36({ "Add_FS_Request" })
	elseif w24.st == "MovementSpeed" then
		if tick() - w31 >= 1 then w31 = tick() w36({ "Add_MS_Request" }) end
	elseif w24.st == "JumpForce" then
		if tick() - w31 >= 1 then w31 = tick() w36({ "Add_JF_Request" }) end
	end
end)

w21(w16.CharacterAdded, function(w20)
	if not w96 or not w96.Parent then return end
	task.wait(1)
	local w39 = w20:WaitForChild("HumanoidRootPart", 5)
	if w24.sv then task.wait(.2) w39.CFrame = w24.sv end
	if w24.w26 then task.wait(.33) w73() w160() end
	if w24.st and w141 then
		local w49, w50 = w72(w141)
		if w49 then w142 = w50 end
	end
end)

if w16.Character then
	task.wait(1)
	if w24.sv and w16.Character:FindFirstChild("HumanoidRootPart") then
		w16.Character.HumanoidRootPart.CFrame = w24.sv
	end
end

local w20 = w106()
w186 = w20
w100 = w103(w20)
if w24.ah then
	local w39, w49, w50 = w105(w20, w100)
	w127(w49 + w39 / 2, w50 + w39 / 2, w49, w50)
else
	local w39, w49
	if w24.up and w24.up.X and w24.up.Y then w39, w49 = w24.up.X, w24.up.Y
	else w39, w49 = w104(w20, w100) end
	w128(w39, w49, TweenInfo.new(.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
end
