
function widget:GetInfo()
	return {
		name = "Limit idle FPS",
		desc = "Reduces FPS when being offscreen or idle (by setting vsync to a high number)" ,
		author = "Floris",
		date = "february 2020",
		license = "",
		layer = 0,
		enabled = true
	}
end

local idleTime = 60
local vsyncValueActive = Spring.GetConfigInt("VSync",1)
if vsyncValueActive > 1 then
	vsyncValueActive = 1
end
local vsyncValueIdle = 4    -- sometimes vsync > 4 doesnt work at all


local isIdle = false
local lastUserInputTime = os.clock()
local lastMouseX, lastMouseY = Spring.GetMouseState()
local prevCamX, prevCamY, prevCamZ = Spring.GetCameraPosition()
local chobbyInterface = false

-- detect display frequency > 60 and set vsyncValueIdle to 6
local infolog = VFS.LoadFile("infolog.txt")
if infolog then
	function lines(str)
		local t = {}
		local function helper(line) table.insert(t, line) return "" end
		helper((str:gsub("(.-)\r?\n", helper)))
		return t
	end

	-- store changelog into table
	local fileLines = lines(infolog)

	for i, line in ipairs(fileLines) do
		if string.sub(line, 1, 3) == '[F='  then
			break
		end

		if line:find('(display%-mode set to )') then
			local s_displaymode = line:sub( line:find('(display%-mode set to )') + 20)
			if s_displaymode:find('%@') then
				local frequency = s_displaymode:sub(s_displaymode:find('%@')+1, s_displaymode:find('Hz ')-1)
				if tonumber(frequency) > 60 then
					vsyncValueIdle = 6
				end
			end
		end
	end
end


function widget:Shutdown()
	Spring.SetConfigInt("VSync", vsyncValueActive)
	WG['limitidlefps'] = nil
end

function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
		lastUserInputTime = os.clock()
		if chobbyInterface then
			isIdle = false
			Spring.SetConfigInt("VSync", (isIdle and vsyncValueIdle or vsyncValueActive))
		end
	end
end

function widget:Initialize()
	WG['limitidlefps'] = {}
	WG['limitidlefps'].isIdle = function()
		return isIdle
	end
end

function widget:Update()
	-- detect change by user
	local curVsync = Spring.GetConfigInt("VSync",1)
	if curVsync ~= vsyncValueIdle and curVsync ~= vsyncValueActive then
		vsyncValueActive = curVsync
	end

	if not chobbyInterface then
		local prevIsIdle = isIdle

		local mouseX, mouseY, lmb, mmb, rmb, mouseOffScreen, cameraPanMode  = Spring.GetMouseState()
		if mouseX ~= lastMouseX or mouseY ~= lastMouseY or lmb or mmb or rmb  then
			lastMouseX, lastMouseY = mouseX, mouseY
			lastUserInputTime = os.clock()
		end

		local camX, camY, camZ = Spring.GetCameraPosition()
		if camX ~= prevCamX or  camY ~= prevCamY or  camZ ~= prevCamZ  then
			prevCamX, prevCamY, prevCamZ = camX, camY, camZ
			lastUserInputTime = os.clock()
		end
		if cameraPanMode then	-- when camera panning
			lastUserInputTime = os.clock()
		end
		if mouseOffScreen then
			lastUserInputTime = os.clock() - idleTime-1
		end
		if lastUserInputTime < os.clock() - idleTime then
			isIdle = true
		else
			isIdle = false
		end
		if isIdle ~= prevIsIdle then
			Spring.SetConfigInt("VSync", (isIdle and vsyncValueIdle or vsyncValueActive))
		end
	end
end

function widget:MousePress()
	lastUserInputTime = os.clock()
end

function widget:MouseWheel()
	lastUserInputTime = os.clock()
end

function widget:KeyPress()
	lastUserInputTime = os.clock()
end
