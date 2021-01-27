function widget:GetInfo()
	return {
		name = "Game info",
		desc = "",
		author = "Floris",
		date = "May 2017",
		license = "",
		layer = 2,
		enabled = true,
	}
end

local texts = {        -- fallback (if you want to change this, also update: language/en.lua, or it will be overwritten)
	title = 'Game info',
	engine = 'Engine',
	engineversionerror = 'engine version error',
	size = 'Size',
	gravity = 'Gravity',
	hardness = 'Hardness',
	tidalspeed = 'Tidal speed',
	windspeed = 'Wind speed',
	waterdamage = 'Water damage',
	chickenoptions = 'Chicken options',
	modoptions = 'Mod options',
}

local vsx, vsy = Spring.GetViewGeometry()
local fontfile2 = "fonts/" .. Spring.GetConfigString("bar_font2", "Exo2-SemiBold.otf")

local ui_opacity = Spring.GetConfigFloat("ui_opacity", 0.6)

local titlecolor = "\255\255\205\100"
local keycolor = ""
local valuecolor = "\255\255\255\255"
local valuegreycolor = "\255\180\180\180"
local vcolor = valuegreycolor
local separator = "::"

local font, font2, loadedFontSize, mainDList, titleRect, chobbyInterface, backgroundGuishader, show

local teams = Spring.GetTeamList()
for i = 1, #teams do
	local luaAI = Spring.GetTeamLuaAI(teams[i])
	if luaAI and luaAI ~= "" and string.sub(luaAI, 1, 9) == 'Chicken: ' then
		chickensEnabled = true
	end
end

local content = ''

local tidal = Game.tidal
if Spring.GetModOptions() and Spring.GetModOptions().map_tidal then
	map_tidal = Spring.GetModOptions().map_tidal
	if map_tidal == "unchanged" then
	elseif map_tidal == "low" then
		tidal = 13
	elseif map_tidal == "medium" then
		tidal = 18
	elseif map_tidal == "high" then
		tidal = 23
	end
end
if Spring.GetTidal then
	tidal = Spring.GetTidal()
end

-- modoptions
local defaultModoptions = VFS.Include("modoptions.lua")
local modoptionsDefault = {}

for key, value in pairs(defaultModoptions) do
	local v = value.def
	if value.def == false then
		v = 0
	elseif value.def == true then
		v = 1
	end
	modoptionsDefault[tostring(value.key)] = tostring(v)
end

local modoptions = Spring.GetModOptions()
local vcolor = valuegreycolor
local changedModoptions = {}
local unchangedModoptions = {}
local changedChickenModoptions = {}
local unchangedChickenModoptions = {}

for key, value in pairs(modoptions) do
	if string.sub(key, 1, 8) == 'chicken_' then
		if chickensEnabled then
			if value == modoptionsDefault[key] then
				unchangedChickenModoptions[key] = value
			else
				changedChickenModoptions[key] = value
			end
		end
		modoptions[key] = nil    -- filter chicken modoptions
	end
end

for key, value in pairs(modoptions) do
	if value == modoptionsDefault[key] then
		unchangedModoptions[key] = value
	else
		changedModoptions[key] = value
	end
end


local screenHeightOrg = 540
local screenWidthOrg = 540
local screenHeight = screenHeightOrg
local screenWidth = screenWidthOrg

local textareaMinLines = 20        -- wont scroll down more, will show at least this amount of lines

local customScale = 1.1

local startLine = 1

local vsx, vsy = Spring.GetViewGeometry()
local screenX = (vsx * 0.5) - (screenWidth / 2)
local screenY = (vsy * 0.5) + (screenHeight / 2)

local spIsGUIHidden = Spring.IsGUIHidden

local bgColorMultiplier = 0

local glCreateList = gl.CreateList
local glCallList = gl.CallList
local glDeleteList = gl.DeleteList

local widgetScale = 1

local fileLines = {}
local totalFileLines = 0
local bgpadding

local myTeamID = Spring.GetMyTeamID()
local amNewbie = (Spring.GetTeamRulesParam(myTeamID, 'isNewbie') == 1)

local showOnceMore = false        -- used because of GUI shader delay

local RectRound = Spring.FlowUI.Draw.RectRound
local UiElement = Spring.FlowUI.Draw.Element
local elementCorner = Spring.FlowUI.elementCorner

function widget:ViewResize()
	vsx, vsy = Spring.GetViewGeometry()
	widgetScale = ((vsx + vsy) / 2000) * 0.65    --(0.5 + (vsx*vsy / 5700000)) * customScale
	widgetScale = widgetScale * (1 - (0.11 * ((vsx / vsy) - 1.78)))        -- make smaller for ultrawide screens

	screenHeight = math.floor(screenHeightOrg * widgetScale)
	screenWidth = math.floor(screenWidthOrg * widgetScale)

	screenX = math.floor((vsx * 0.5) - (screenWidth / 2))
	screenY = math.floor((vsy * 0.5) + (screenHeight / 2))

	font, loadedFontSize = WG['fonts'].getFont()
	font2 = WG['fonts'].getFont(fontfile2)

	bgpadding = Spring.FlowUI.elementPadding
	elementCorner = Spring.FlowUI.elementCorner

	if mainDList then
		gl.DeleteList(mainDList)
	end
	mainDList = gl.CreateList(DrawWindow)
end

function DrawTextarea(x, y, width, height, scrollbar)
	local scrollbarOffsetTop = 0    -- note: wont add the offset to the bottom, only to top
	local scrollbarOffsetBottom = 0    -- note: wont add the offset to the top, only to bottom
	local scrollbarMargin = 14 * widgetScale
	local scrollbarWidth = 8 * widgetScale
	local scrollbarPosWidth = 4 * widgetScale
	local scrollbarPosMinHeight = 8 * widgetScale
	local scrollbarBackgroundColor = { 0, 0, 0, 0.24 }
	local scrollbarBarColor = { 1, 1, 1, 0.15 }

	local fontSizeTitle = 18 * widgetScale
	local fontSizeDate = 14 * widgetScale
	local fontSizeLine = 16 * widgetScale
	local lineSeparator = 2 * widgetScale

	local fontColorTitle = { 1, 1, 1, 1 }
	local fontColorDate = { 0.66, 0.88, 0.66, 1 }
	local fontColorLine = { 0.8, 0.77, 0.74, 1 }
	local fontColorCommand = { 0.9, 0.6, 0.2, 1 }

	local textRightOffset = scrollbar and scrollbarMargin + scrollbarWidth + scrollbarWidth or 0
	local maxLines = math.floor((height - 5) / fontSizeLine)

	-- textarea scrollbar
	if scrollbar then
		if totalFileLines > maxLines or startLine > 1 then
			-- only show scroll above X lines
			local scrollbarTop = y - scrollbarOffsetTop - scrollbarMargin
			local scrollbarBottom = y - scrollbarOffsetBottom - height + scrollbarMargin
			local scrollbarPosHeight = math.max(((height - scrollbarMargin - scrollbarMargin) / totalFileLines) * ((height - scrollbarMargin - scrollbarMargin) / 25), scrollbarPosMinHeight)
			if scrollbarPosHeight > scrollbarTop - scrollbarBottom then
				scrollbarPosHeight = scrollbarTop - scrollbarBottom
			end
			local scrollbarPos = scrollbarTop + (scrollbarBottom - scrollbarTop) * ((startLine - 1) / totalFileLines)
			scrollbarPos = scrollbarPos + ((startLine - 1) / totalFileLines) * scrollbarPosHeight    -- correct position taking position bar height into account

			-- background
			gl.Color(scrollbarBackgroundColor)
			RectRound(
				x + width - scrollbarMargin - scrollbarWidth,
				scrollbarBottom - (scrollbarWidth - scrollbarPosWidth),
				x + width - scrollbarMargin,
				scrollbarTop + (scrollbarWidth - scrollbarPosWidth),
				scrollbarWidth / 2.5
				, 1, 1, 1, 1,
				{ scrollbarBackgroundColor[1], scrollbarBackgroundColor[2], scrollbarBackgroundColor[3], scrollbarBackgroundColor[4] * 0.66 },
				{ scrollbarBackgroundColor[1], scrollbarBackgroundColor[2], scrollbarBackgroundColor[3], scrollbarBackgroundColor[4] * 1.25 }
			)
			-- bar
			gl.Color(scrollbarBarColor)
			RectRound(
				x + width - scrollbarMargin - (scrollbarWidth * 0.75),
				scrollbarPos - (scrollbarPosHeight),
				x + width - scrollbarMargin - (scrollbarWidth * 0.25),
				scrollbarPos,
				scrollbarPosWidth / 2.5
			)
		end
	end

	-- draw textarea
	if content then
		font:Begin()
		local lineKey = startLine
		local j = 1
		while j < maxLines do
			-- maxlines is not exact, just a failsafe
			if (lineSeparator + fontSizeTitle) * j > height then
				break ;
			end
			if fileLines[lineKey] == nil then
				break ;
			end

			local numLines
			local line = fileLines[lineKey]
			if string.find(line, '::') then
				local cmd = string.match(line, '^[ %+a-zA-Z0-9_-]*')        -- escaping the escape: \\ doesnt work in lua !#$@&*()&5$#
				local descr = string.sub(line, string.len(string.match(line, '^[ %+a-zA-Z0-9_-]*::')) + 1)
				descr, numLines = font:WrapText(descr, (width - scrollbarMargin - scrollbarWidth - 250 - textRightOffset) * (loadedFontSize / fontSizeLine))
				if (lineSeparator + fontSizeTitle) * (j + numLines - 1) > height then
					break ;
				end

				font:SetTextColor(fontColorCommand)
				font:Print(cmd, x + (18*widgetScale), y - (lineSeparator + fontSizeTitle) * j, fontSizeLine, "n")

				font:SetTextColor(fontColorLine)
				font:Print(descr, x + (screenWidth*0.47), y - (lineSeparator + fontSizeTitle) * j, fontSizeLine, "n")
				j = j + (numLines - 1)
			else
				-- line
				font:SetTextColor(fontColorLine)
				line = "" .. line
				line, numLines = font:WrapText(line, (width - scrollbarMargin - scrollbarWidth) * (loadedFontSize / fontSizeLine))
				if (lineSeparator + fontSizeTitle) * (j + numLines - 1) > height then
					break ;
				end
				font:Print(line, x + (18*widgetScale), y - (lineSeparator + fontSizeTitle) * j, fontSizeLine, "n")
				j = j + (numLines - 1)
			end

			j = j + 1
			lineKey = lineKey + 1
		end
		font:End()
	end
end

function DrawWindow()
	-- title
	local titleFontSize = 18 * widgetScale
	titleRect = { screenX, screenY, math.floor(screenX + (font2:GetTextWidth(texts.title) * titleFontSize) + (titleFontSize*1.5)), math.floor(screenY + (titleFontSize*1.7)) }

	UiElement(screenX, screenY - screenHeight, screenX + screenWidth, screenY, 0, 1, 1, 1, 1,1,1,1, Spring.GetConfigFloat("ui_opacity", 0.6) + 0.2)

	--UiElement(titleRect[1], titleRect[2], titleRect[3], titleRect[4], 1, 1, 0, 0, 1,1,0,1, Spring.GetConfigFloat("ui_opacity", 0.6) + 0.2, {0.05,0.15,0,Spring.GetConfigFloat("ui_opacity", 0.6) + 0.2})

	gl.Color(0, 0, 0, Spring.GetConfigFloat("ui_opacity", 0.6) + 0.2)
	RectRound(titleRect[1], titleRect[2], titleRect[3], titleRect[4], elementCorner, 1, 1, 0, 0)

	font2:Begin()
	font2:SetTextColor(1, 1, 1, 1)
	font2:SetOutlineColor(0, 0, 0, 0.4)
	font2:Print(texts.title, screenX + (titleFontSize * 0.75), screenY + (8*widgetScale), titleFontSize, "on")
	font2:End()

	-- textarea
	DrawTextarea(screenX, screenY - (8 * widgetScale), screenWidth, screenHeight - (24 * widgetScale), 1)
end

function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1, 18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1, 19) == 'LobbyOverlayActive1')
	end
end

local uiOpacitySec = 0
function widget:Update(dt)
	uiOpacitySec = uiOpacitySec + dt
	if uiOpacitySec > 0.5 then
		uiOpacitySec = 0
		if ui_opacity ~= Spring.GetConfigFloat("ui_opacity", 0.6) then
			ui_opacity = Spring.GetConfigFloat("ui_opacity", 0.6)
			widget:ViewResize()
		end
	end
end

function widget:DrawScreen()
	if chobbyInterface then
		return
	end
	if spIsGUIHidden() then
		return
	end
	if amNewbie then
		return
	end

	-- draw the help
	if not mainDList then
		mainDList = gl.CreateList(DrawWindow)
	end

	if show or showOnceMore then

		-- draw the panel
		glCallList(mainDList)
		if WG['guishader'] then
			if backgroundGuishader ~= nil then
				glDeleteList(backgroundGuishader)
			end
			backgroundGuishader = glCreateList(function()
				-- background
				RectRound(screenX, screenY - screenHeight, screenX + screenWidth, screenY, elementCorner, 0, 1, 1, 1)
				-- title
				RectRound(titleRect[1], titleRect[2], titleRect[3], titleRect[4], elementCorner, 1, 1, 0, 0)
			end)
			WG['guishader'].InsertDlist(backgroundGuishader, 'gameinfo')
		end
		showOnceMore = false

		local x, y, pressed = Spring.GetMouseState()
		if IsOnRect(x, y, screenX, screenY - screenHeight, screenX + screenWidth, screenY) or IsOnRect(x, y, titleRect[1], titleRect[2], titleRect[3], titleRect[4]) then
			Spring.SetMouseCursor('cursornormal')
		end

	else
		if WG['guishader'] then
			WG['guishader'].DeleteDlist('gameinfo')
		end
	end
end

function widget:KeyPress(key)
	if key == 27 then
		-- ESC
		show = false
	end
end

function IsOnRect(x, y, BLcornerX, BLcornerY, TRcornerX, TRcornerY)

	-- check if the mouse is in a rectangle
	return x >= BLcornerX and x <= TRcornerX and y >= BLcornerY and y <= TRcornerY
end

function widget:MouseWheel(up, value)

	if show then
		local addLines = value * -3 -- direction is retarded

		startLine = startLine + addLines
		if startLine < 1 then
			startLine = 1
		end
		if startLine > totalFileLines - textareaMinLines then
			startLine = totalFileLines - textareaMinLines
		end

		if mainDList then
			glDeleteList(mainDList)
		end

		mainDList = gl.CreateList(DrawWindow)
		return true
	else
		return false
	end
end

function widget:MouseMove(x, y)
	if show then
		if not IsOnRect(x, y, screenX, screenY - screenHeight, screenX + screenWidth, screenY) then

		end
	end
end

function widget:MousePress(x, y, button)
	return mouseEvent(x, y, button, false)
end

function widget:MouseRelease(x, y, button)
	return mouseEvent(x, y, button, true)
end

function mouseEvent(x, y, button, release)
	if spIsGUIHidden() then
		return false
	end

	if show then
		-- on window
		if IsOnRect(x, y, screenX, screenY - screenHeight, screenX + screenWidth, screenY) or IsOnRect(x, y, titleRect[1], titleRect[2], titleRect[3], titleRect[4]) then
			return true
		else
			show = false
		end
	end
end

function lines(str)
	local t = {}
	local function helper(line)
		t[#t + 1] = line
		return ""
	end
	helper((str:gsub("(.-)\r?\n", helper)))
	return t
end


function toggle()
	local newShow = not show
	if newShow and WG['topbar'] then
		WG['topbar'].hideWindows()
	end
	show = newShow
end

function widget:Initialize()
	if WG['lang'] then
		texts = WG['lang'].getText('gameinfo')
	end

	content = content .. titlecolor .. Game.gameName .. valuegreycolor .. " (" .. Game.gameMutator .. ") " .. titlecolor .. Game.gameVersion .. "\n"
	content = content .. keycolor .. texts.engine .. separator .. valuegreycolor .. ((Game and Game.version) or (Engine and Engine.version) or texts.engineversionerror) .. "\n"
	content = content .. "\n"

	-- map info
	content = content .. titlecolor .. Game.mapName .. "\n"
	content = content .. valuegreycolor .. Game.mapDescription .. "\n"
	content = content .. keycolor .. texts.size .. separator .. valuegreycolor .. Game.mapX .. valuegreycolor .. " x " .. valuegreycolor .. Game.mapY .. "\n"
	content = content .. keycolor .. texts.gravity .. separator .. valuegreycolor .. Game.gravity .. "\n"
	content = content .. keycolor .. texts.hardness .. separator .. valuegreycolor .. Game.mapHardness .. keycolor .. "\n"
	content = content .. keycolor .. texts.tidalspeed .. separator .. valuegreycolor .. tidal .. keycolor .. "\n"

	if Game.windMin == Game.windMax then
		content = content .. keycolor .. texts.windspeed .. separator .. valuegreycolor .. Game.windMin .. valuegreycolor .. "\n"
	else
		content = content .. keycolor .. texts.windspeed .. separator .. valuegreycolor .. Game.windMin .. valuegreycolor .. "  -  " .. valuegreycolor .. Game.windMax .. "\n"
	end
	local vcolor
	if Game.waterDamage == 0 then
		vcolor = valuegreycolor
	else
		vcolor = valuecolor
	end
	content = content .. keycolor .. texts.waterdamage .. separator .. vcolor .. Game.waterDamage .. keycolor .. "\n"
	content = content .. "\n"
	if chickensEnabled then
		-- filter chicken modoptions
		content = content .. titlecolor .. texts.chickenoptions.."\n"
		for key, value in pairs(changedChickenModoptions) do
			content = content .. keycolor .. string.sub(key, 9) .. separator .. valuecolor .. value .. "\n"
		end
		for key, value in pairs(unchangedChickenModoptions) do
			content = content .. keycolor .. string.sub(key, 9) .. separator .. valuegreycolor .. value .. "\n"
		end
		content = content .. "\n"
	end
	content = content .. titlecolor .. texts.modoptions.."\n"
	for key, value in pairs(changedModoptions) do
		content = content .. keycolor .. key .. separator .. valuecolor .. value .. "\n"
	end
	for key, value in pairs(unchangedModoptions) do
		content = content .. keycolor .. key .. separator .. valuegreycolor .. value .. "\n"
	end

	widgetHandler:AddAction("customgameinfo", toggle)
	Spring.SendCommands("unbind any+i gameinfo")
	Spring.SendCommands("unbind i gameinfo")
	Spring.SendCommands("bind i customgameinfo")

	WG['gameinfo'] = {}
	WG['gameinfo'].toggle = function(state)
		local newShow = state
		if newShow == nil then
			newShow = not show
		end
		if newShow and WG['topbar'] then
			WG['topbar'].hideWindows()
		end
		show = newShow
	end
	WG['gameinfo'].isvisible = function()
		return show
	end
	-- somehow there are a few characters added at the start that we need to remove
	--content = string.sub(content, 4)

	-- store changelog into array
	fileLines = lines(content)

	for i, line in ipairs(fileLines) do
		totalFileLines = i
	end
	widget:ViewResize()
end

function widget:Shutdown()
	Spring.SendCommands("unbind i customgameinfo")
	Spring.SendCommands("bind any+i gameinfo")
	Spring.SendCommands("bind i gameinfo")
	widgetHandler:RemoveAction("customgameinfo", toggle)

	if mainDList then
		glDeleteList(mainDList)
		mainDList = nil
	end
	if WG['guishader'] then
		WG['guishader'].DeleteDlist('gameinfo')
	end
end
