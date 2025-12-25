-- Code Sensei
-- Author: username_invalid

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local THEME = {
	Background = Color3.fromRGB(30, 30, 35),
	Panel = Color3.fromRGB(40, 40, 45),
	Accent = Color3.fromRGB(0, 170, 255),
	Text = Color3.fromRGB(240, 240, 240),
	SubText = Color3.fromRGB(150, 150, 160),
	Success = Color3.fromRGB(100, 255, 100),
	Error = Color3.fromRGB(255, 80, 80)
}

-- 1. UI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CodeSenseiGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("CanvasGroup") 
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.GroupTransparency = 0 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- [[ CUSTOM AUDIO SETUP ]]

local SuccessAudio = Instance.new("Sound")
SuccessAudio.Name = "SuccessSFX"
SuccessAudio.SoundId = "rbxassetid://80691547303377" 
SuccessAudio.Volume = 0.6
SuccessAudio.Parent = MainFrame

local ErrorAudio = Instance.new("Sound")
ErrorAudio.Name = "ErrorSFX"
ErrorAudio.SoundId = "rbxassetid://16903690359" -- Warning Beep
ErrorAudio.Volume = 0.8
ErrorAudio.Parent = MainFrame

local BGM = Instance.new("Sound")
BGM.Name = "BackgroundMusic"
BGM.SoundId = "rbxassetid://133460181971095" -- Calm Seas Starry Skies
BGM.Volume = 0.3 -- Gentle background volume
BGM.Looped = true
BGM.Parent = MainFrame
BGM:Play() -- Start playing immediately since UI is open by default

-- UI Elements
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -20, 0, 50)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Code Sensei ⚡"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 24
TitleLabel.TextColor3 = THEME.Text
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local InputFrame = Instance.new("Frame")
InputFrame.Size = UDim2.new(0.45, 0, 0.75, 0)
InputFrame.Position = UDim2.new(0.03, 0, 0.12, 0)
InputFrame.BackgroundColor3 = THEME.Panel
InputFrame.Parent = MainFrame
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 8)

local InputScroller = Instance.new("ScrollingFrame")
InputScroller.Size = UDim2.new(1, -10, 1, -10)
InputScroller.Position = UDim2.new(0, 5, 0, 5)
InputScroller.BackgroundTransparency = 1
InputScroller.ScrollBarThickness = 4
InputScroller.BorderSizePixel = 0
InputScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y
InputScroller.CanvasSize = UDim2.new(0,0,0,0)
InputScroller.Parent = InputFrame

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(1, 0, 0, 0)
InputBox.AutomaticSize = Enum.AutomaticSize.Y 
InputBox.BackgroundTransparency = 1
InputBox.Text = "-- Paste your Lua script here..."
InputBox.TextColor3 = THEME.SubText
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.TextYAlignment = Enum.TextYAlignment.Top
InputBox.MultiLine = true
InputBox.ClearTextOnFocus = true
InputBox.TextWrapped = true
InputBox.Font = Enum.Font.Code
InputBox.TextSize = 13
InputBox.Parent = InputScroller

local OutputFrame = Instance.new("ScrollingFrame")
OutputFrame.Size = UDim2.new(0.45, 0, 0.75, 0)
OutputFrame.Position = UDim2.new(0.52, 0, 0.12, 0)
OutputFrame.BackgroundColor3 = THEME.Panel
OutputFrame.ScrollBarThickness = 4
OutputFrame.Parent = MainFrame
Instance.new("UICorner", OutputFrame).CornerRadius = UDim.new(0, 8)

local OutputLabel = Instance.new("TextLabel")
OutputLabel.Size = UDim2.new(1, -10, 0, 0)
OutputLabel.Position = UDim2.new(0, 5, 0, 5)
OutputLabel.BackgroundTransparency = 1
OutputLabel.Text = "Your lesson will appear here..."
OutputLabel.TextColor3 = THEME.Accent
OutputLabel.TextXAlignment = Enum.TextXAlignment.Left
OutputLabel.TextYAlignment = Enum.TextYAlignment.Top
OutputLabel.TextWrapped = true
OutputLabel.Font = Enum.Font.Gotham
OutputLabel.TextSize = 14
OutputLabel.Parent = OutputFrame

local AnalyzeBtn = Instance.new("TextButton")
AnalyzeBtn.Size = UDim2.new(0.4, 0, 0.08, 0)
AnalyzeBtn.Position = UDim2.new(0.3, 0, 0.9, 0)
AnalyzeBtn.BackgroundColor3 = THEME.Accent
AnalyzeBtn.Text = "EXPLAIN THIS SCRIPT"
AnalyzeBtn.Font = Enum.Font.GothamBold
AnalyzeBtn.TextColor3 = Color3.new(1,1,1)
AnalyzeBtn.TextSize = 14
AnalyzeBtn.Parent = MainFrame
Instance.new("UICorner", AnalyzeBtn).CornerRadius = UDim.new(0, 6)

-- 2. EXPANDED KNOWLEDGE BASE
local knowledgeBase = {
	-- [[ HIGH PRIORITY: COMPLEX SYSTEMS ]]
	{id = "DataStore", pattern = "DataStoreService", msg = "💾 **Data Persistence**: `DataStoreService` handles saving/loading player data across sessions."},
	{id = "Remote", pattern = "RemoteEvent", msg = "📡 **Networking**: `RemoteEvent` detected. This bridges the Client (Player) and Server (Game)."},
	{id = "Tween", pattern = "TweenService", msg = "✨ **Animation**: `TweenService` is used to smoothly interpolate properties (like fading or moving)."},
	{id = "Raycast", pattern = "Raycast", msg = "🎯 **Raycasting**: You are shooting invisible rays. Used for guns, line-of-sight, or ground detection."},
	{id = "Market", pattern = "MarketplaceService", msg = "💰 **Economy**: `MarketplaceService` manages Robux purchases and Gamepasses."},
	{id = "Tags", pattern = "CollectionService", msg = "🏷️ **Tagging**: `CollectionService` allows you to manage groups of objects efficiently without folders."},
	{id = "Modules", pattern = "require%(", msg = "📦 **Modular Code**: You are using `require()`. This loads external ModuleScripts to keep code clean."},
	{id = "Physics", pattern = "LinearVelocity", msg = "🚀 **Physics**: You are using BodyMovers (LinearVelocity/AngularVelocity) to push objects."},
	{id = "Pathfinding", pattern = "PathfindingService", msg = "🗺️ **AI Navigation**: `PathfindingService` calculates routes for NPCs to walk around obstacles."},

	-- [[ MEDIUM PRIORITY: GAMEPLAY & SERVICES ]]
	{id = "Input", pattern = "UserInputService", msg = "🎮 **Controls**: `UserInputService` is listening for Keyboard, Mouse, or Touch input."},
	{id = "Loop_Game", pattern = "RunService", msg = "⏱️ **Game Loop**: `RunService` (Heartbeat/RenderStepped) runs code every single frame."},
	{id = "Task", pattern = "task%.", msg = "⚡ **Task Library**: You are using the modern `task` library (wait/spawn). This is faster than global wait()."},
	{id = "Leaderstats", pattern = "leaderstats", msg = "🏆 **Leaderboards**: `leaderstats` displays scores in the player list."},
	{id = "Teams", pattern = "Teams", msg = "🚩 **Teams**: You are referencing the `Teams` service to manage player groups."},
	{id = "Sound", pattern = "SoundService", msg = "🔊 **Audio**: You are interacting with `SoundService` or playing sounds."},
	{id = "Lighting", pattern = "Lighting", msg = "☀️ **Atmosphere**: You are modifying `Lighting` to change the game's time of day or fog."},

	-- [[ LOW PRIORITY: LOGIC & SYNTAX ]]
	{id = "Touch", pattern = "Touched:Connect", msg = "👇 **Collision**: A `.Touched` event triggers when parts collide."},
	{id = "Click", pattern = "MouseButton1Click", msg = "🖱️ **UI Click**: You are detecting a GUI button press."},
	{id = "Clone", pattern = ":Clone%(%)", msg = "📄 **Spawning**: `:Clone()` creates a copy of an object."},
	{id = "Destroy", pattern = ":Destroy%(%)", msg = "🗑️ **Cleanup**: `:Destroy()` removes objects to save memory."},
	{id = "CFrame", pattern = "CFrame%.new", msg = "📍 **3D Space**: `CFrame` (Coordinate Frame) sets Position and Rotation."},
	{id = "Vector3", pattern = "Vector3%.new", msg = "📐 **Positioning**: `Vector3` represents a point in X, Y, Z space."},
	{id = "Math", pattern = "math%.", msg = "🧮 **Math**: You are using the `math` library (random, floor, etc)."},
	{id = "Loop_For", pattern = "for%s+([%w_]+)%s*=", msg = "🔄 **Numeric Loop**: A 'for' loop counting with variable '%s'."},
	{id = "Loop_Pairs", pattern = "pairs%(", msg = "🗂️ **Table Loop**: Iterating through a list using `pairs`."},
	{id = "Function", pattern = "function%s+([%w_]+)%(", msg = "⚡ **Function**: Defined reusable block **'%s'**."},
	{id = "Instance", pattern = "Instance%.new%(['\"](%w+)['\"]%)", msg = "🔨 **Construction**: Building a new **'%s'** via code."},
	{id = "Variable", pattern = "local%s+([%w_]+)%s*=", msg = "📦 **Variable**: Stored data in container **'%s'**."}
}

-- 3. LOGIC FUNCTIONS
local function checkSanity(code)
	if string.len(code) < 5 then return false, "Script is too short or empty." end

	local _, openParen = string.gsub(code, "%(", "")
	local _, closeParen = string.gsub(code, "%)", "")

	if openParen ~= closeParen then
		return false, "⚠️ **Syntax Error**: Mismatched Parentheses!\n\nYou have " .. openParen .. " '(' but " .. closeParen .. " ')'. Check your brackets."
	end

	local _, countEnd = string.gsub(code, "end", "") 
	if countEnd == 0 and (string.find(code, "function") or string.find(code, "if%s") or string.find(code, "do%s")) then
		return false, "⚠️ **Logic Error**: You started a block (function/if/loop) but I found zero 'end' statements."
	end

	return true, "OK"
end

local function analyzeCode(sourceCode)
	local insights = {}
	local complexFound = false

	local function addHeader(text)
		table.insert(insights, "\n" .. text .. "\n" .. string.rep("—", 25))
	end

	-- 1. COMPLEX SYSTEMS SCAN
	local systemNotes = {}
	for _, entry in ipairs(knowledgeBase) do
		local isSimple = (entry.id == "Variable" or entry.id == "Function" or entry.id == "Instance" or entry.id == "Loop_For" or entry.id == "Loop_Pairs" or entry.id == "Touch" or entry.id == "Clone" or entry.id == "Destroy" or entry.id == "Math")

		if not isSimple then
			if string.match(sourceCode, entry.pattern) then
				table.insert(systemNotes, entry.msg)
				complexFound = true
			end
		end
	end

	if #systemNotes > 0 then
		addHeader("🔥 KEY SYSTEMS DETECTED")
		for _, note in ipairs(systemNotes) do table.insert(insights, note) end
	end

	-- 2. DETAILED LOGIC SCAN (FULL)
	local logicNotes = {}
	for _, entry in ipairs(knowledgeBase) do
		local isSimple = (entry.id == "Variable" or entry.id == "Function" or entry.id == "Instance" or entry.id == "Loop_For" or entry.id == "Loop_Pairs" or entry.id == "Touch" or entry.id == "Clone" or entry.id == "Destroy" or entry.id == "Math")

		if isSimple then
			for capture in string.gmatch(sourceCode, entry.pattern) do
				local message = entry.msg
				if string.find(message, "%%s") then message = string.format(message, capture) end
				table.insert(logicNotes, message)
			end
		end
	end

	if #logicNotes > 0 then
		addHeader("🧱 CODE STRUCTURE")
		for _, note in ipairs(logicNotes) do
			table.insert(insights, note)
		end
	end

	if not complexFound and #logicNotes == 0 then return nil end

	local complexity = "Beginner"
	if complexFound then complexity = "Advanced" 
	elseif #logicNotes > 10 then complexity = "Intermediate" end

	table.insert(insights, 1, "📊 **Script Complexity**: " .. complexity)
	return table.concat(insights, "\n\n")
end

local function typeWriterEffect(targetLabel, fullText)
	targetLabel.Text = ""
	for i = 1, #fullText do
		targetLabel.Text = string.sub(fullText, 1, i)
		local textBounds = targetLabel.TextBounds
		targetLabel.Size = UDim2.new(1, -10, 0, textBounds.Y + 20)
		OutputFrame.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 50)

		if textBounds.Y > OutputFrame.AbsoluteSize.Y then
			OutputFrame.CanvasPosition = Vector2.new(0, textBounds.Y)
		end

		if i % 5 == 0 then RunService.Heartbeat:Wait() end
	end
end

-- 4. INTERACTION
local processing = false

AnalyzeBtn.MouseButton1Click:Connect(function()
	if processing then return end
	processing = true

	local code = InputBox.Text

	OutputLabel.TextColor3 = THEME.Text
	OutputLabel.Text = "Analyzing..."

	local isSafe, errorMsg = checkSanity(code)

	if not isSafe then
		ErrorAudio:Play()
		TweenService:Create(AnalyzeBtn, TweenInfo.new(0.3), {BackgroundColor3 = THEME.Error}):Play()
		OutputLabel.TextColor3 = THEME.Error
		OutputLabel.Text = errorMsg
		task.wait(1)
		TweenService:Create(AnalyzeBtn, TweenInfo.new(0.5), {BackgroundColor3 = THEME.Accent}):Play()
		processing = false
		return
	end

	task.wait(0.5)
	local explanation = analyzeCode(code)

	if explanation == nil then
		ErrorAudio:Play()
		TweenService:Create(AnalyzeBtn, TweenInfo.new(0.3), {BackgroundColor3 = THEME.Error}):Play()
		OutputLabel.TextColor3 = THEME.Error
		OutputLabel.Text = "⚠️ **Analysis Failed**: I couldn't recognize any standard Lua patterns. Check your spelling."
	else
		SuccessAudio:Play()
		TweenService:Create(AnalyzeBtn, TweenInfo.new(0.2), {BackgroundColor3 = THEME.Success}):Play()
		typeWriterEffect(OutputLabel, explanation)
	end

	task.wait(1)
	TweenService:Create(AnalyzeBtn, TweenInfo.new(0.5), {BackgroundColor3 = THEME.Accent}):Play()
	processing = false
end)

AnalyzeBtn.MouseEnter:Connect(function()
	TweenService:Create(AnalyzeBtn, TweenInfo.new(0.2), {Size = UDim2.new(0.42, 0, 0.09, 0)}):Play()
end)
AnalyzeBtn.MouseLeave:Connect(function()
	TweenService:Create(AnalyzeBtn, TweenInfo.new(0.2), {Size = UDim2.new(0.4, 0, 0.08, 0)}):Play()
end)

-- 5. DRAG, FADE & TOGGLE LOGIC
local dragging, dragInput, dragStart, startPos

-- Key Toggle (Z)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Z then
		if MainFrame.Visible then
			-- Close
			BGM:Pause() -- Pause music
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {GroupTransparency = 1})
			tween:Play()
			tween.Completed:Wait()
			MainFrame.Visible = false
		else
			-- Open
			MainFrame.Visible = true
			BGM:Resume() -- Resume music
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
		end
	end
end)

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		TweenService:Create(MainFrame, TweenInfo.new(0.2), {GroupTransparency = 0.5}):Play()

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
				TweenService:Create(MainFrame, TweenInfo.new(0.3), {GroupTransparency = 0}):Play()
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
