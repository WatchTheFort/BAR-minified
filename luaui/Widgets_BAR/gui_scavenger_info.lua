
if not (Spring.GetModOptions and (tonumber(Spring.GetModOptions().scavengers) or 0) ~= 0) then
	return
end

function widget:GetInfo()
return {
	name    = "Scavenger Info",
	desc    = "",
	author  = "Floris",
	date    = "Jan 2020",
	layer   = -99990,
	enabled = true,
}
end

local show = true	-- gets disabled when it has been loaded before

local fontfile = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("bar_font", "Poppins-Regular.otf")
local vsx,vsy = Spring.GetViewGeometry()
local fontfileScale = (0.5 + (vsx*vsy / 5700000))
local fontfileSize = 36
local fontfileOutlineSize = 9
local fontfileOutlineStrength = 1.4
local font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
local fontfile2 = LUAUI_DIRNAME .. "fonts/" .. Spring.GetConfigString("bar_font2", "Exo2-SemiBold.otf")
local font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
local loadedFontSize = fontfileSize*fontfileScale

local bgcorner = ":l:LuaUI/Images/bgcorner.png"

local textFile = VFS.LoadFile("gamedata/scavengers/infotext.txt")

local bgMargin = 6
local numGames = 0

local screenHeight = 520-bgMargin-bgMargin
local screenWidth = 1050-bgMargin-bgMargin

local textareaMinLines = 10		-- wont scroll down more, will show at least this amount of lines

local playSounds = true
local buttonclick = 'LuaUI/Sounds/buildbar_waypoint.wav'

local startLine = 1

local customScale = 1.1
local centerPosX = 0.51	-- note: dont go too far from 0.5
local centerPosY = 0.49		-- note: dont go too far from 0.5
local screenX = (vsx*centerPosX) - (screenWidth/2)
local screenY = (vsy*centerPosY) + (screenHeight/2)
  
local spIsGUIHidden = Spring.IsGUIHidden
local showHelp = false

local glColor = gl.Color
local glLineWidth = gl.LineWidth
local glPolygonMode = gl.PolygonMode
local glRect = gl.Rect
local glText = gl.Text
local glShape = gl.Shape

local bgColorMultiplier = 0

local glCreateList = gl.CreateList
local glCallList = gl.CallList
local glDeleteList = gl.DeleteList

local glPopMatrix = gl.PopMatrix
local glPushMatrix = gl.PushMatrix
local glTranslate = gl.Translate
local glScale = gl.Scale

local GL_FILL = GL.FILL
local GL_FRONT_AND_BACK = GL.FRONT_AND_BACK
local GL_LINE_STRIP = GL.LINE_STRIP

local widgetScale = 1
local vsx, vsy = Spring.GetViewGeometry()

local textLines = {}
local totalTextLines = 0

function widget:ViewResize()
	vsx,vsy = Spring.GetViewGeometry()
	screenX = (vsx*centerPosX) - (screenWidth/2)
	screenY = (vsy*centerPosY) + (screenHeight/2)
	widgetScale = (0.5 + (vsx*vsy / 5700000)) * customScale
  local newFontfileScale = (0.5 + (vsx*vsy / 5700000))
  if (fontfileScale ~= newFontfileScale) then
    fontfileScale = newFontfileScale
    gl.DeleteFont(font)
    font = gl.LoadFont(fontfile, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
	gl.DeleteFont(font2)
	font2 = gl.LoadFont(fontfile2, fontfileSize*fontfileScale, fontfileOutlineSize*fontfileScale, fontfileOutlineStrength)
	loadedFontSize = fontfileSize*fontfileScale
  end
	if textList then gl.DeleteList(textList) end
	textList = gl.CreateList(DrawWindow)
end

local myTeamID = Spring.GetMyTeamID()

local showOnceMore = false		-- used because of GUI shader delay

local function DrawRectRound(px,py,sx,sy,cs, tl,tr,br,bl)
	gl.TexCoord(0.8,0.8)
	gl.Vertex(px+cs, py, 0)
	gl.Vertex(sx-cs, py, 0)
	gl.Vertex(sx-cs, sy, 0)
	gl.Vertex(px+cs, sy, 0)
	
	gl.Vertex(px, py+cs, 0)
	gl.Vertex(px+cs, py+cs, 0)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.Vertex(px, sy-cs, 0)
	
	gl.Vertex(sx, py+cs, 0)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.Vertex(sx, sy-cs, 0)
	
	local offset = 0.07		-- texture offset, because else gaps could show
	
	-- bottom left
	if ((py <= 0 or px <= 0)  or (bl ~= nil and bl == 0)) and bl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, py, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(px+cs, py, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(px+cs, py+cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(px, py+cs, 0)
	-- bottom right
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(sx-cs, py, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(sx-cs, py+cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(sx, py+cs, 0)
	-- top left
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(px, sy, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(px+cs, sy, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(px+cs, sy-cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(px, sy-cs, 0)
	-- top right
	if ((sy >= vsy or sx >= vsx)  or (tr ~= nil and tr == 0)) and tr ~= 2   then o = 0.5 else o = offset end
	gl.TexCoord(o,o)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(o,1-offset)
	gl.Vertex(sx-cs, sy, 0)
	gl.TexCoord(1-offset,1-offset)
	gl.Vertex(sx-cs, sy-cs, 0)
	gl.TexCoord(1-offset,o)
	gl.Vertex(sx, sy-cs, 0)
end
function RectRound(px,py,sx,sy,cs, tl,tr,br,bl)		-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(bgcorner)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px,py,sx,sy,cs, tl,tr,br,bl)
	gl.Texture(false)
end


function DrawTextarea(x,y,width,height,scrollbar)
	local scrollbarOffsetTop 		= 0	-- note: wont add the offset to the bottom, only to top
	local scrollbarOffsetBottom 	= 0	-- note: wont add the offset to the top, only to bottom
	local scrollbarMargin    		= 10
	local scrollbarWidth     		= 8
	local scrollbarPosWidth  		= 4
	local scrollbarPosMinHeight 	= 8
	local scrollbarBackgroundColor	= {0,0,0,0.24}
	local scrollbarBarColor			= {1,1,1,0.08}
	
	local fontSizeTitle				= 17		-- is version number
	local fontSizeDate				= 13
	local fontSizeLine				= 15
	local lineSeparator				= 2
	
	local fontColorTitle			= {1,1,1,1}
	local fontColorDate				= {0.66,0.88,0.66,1}
	local fontColorLine				= {0.8,0.77,0.74,1}
	local fontColorLineBullet		= {0.9,0.6,0.2,1}
	
	local textRightOffset = scrollbar and scrollbarMargin+scrollbarWidth+scrollbarWidth or 0
	local maxLines = math.floor((height-5)/fontSizeLine)
	
	-- textarea scrollbar
	if scrollbar then
		if (totalTextLines > maxLines or startLine > 1) then	-- only show scroll above X lines
			local scrollbarTop       = y-scrollbarOffsetTop-scrollbarMargin-(scrollbarWidth-scrollbarPosWidth)
			local scrollbarBottom    = y-scrollbarOffsetBottom-height+scrollbarMargin+(scrollbarWidth-scrollbarPosWidth)
			local scrollbarPosHeight = math.max(((height-scrollbarMargin-scrollbarMargin) / totalTextLines) * ((height-scrollbarMargin-scrollbarMargin) / 25), scrollbarPosMinHeight)
			if scrollbarPosHeight > scrollbarTop-scrollbarBottom then scrollbarPosHeight = scrollbarTop-scrollbarBottom end
			local scrollbarPos       = scrollbarTop + (scrollbarBottom - scrollbarTop) * ((startLine-1) / totalTextLines)
			scrollbarPos             = scrollbarPos + ((startLine-1) / totalTextLines) * scrollbarPosHeight	-- correct position taking position bar height into account

			-- background
			gl.Color(scrollbarBackgroundColor)
			RectRound(
				x+width-scrollbarMargin-scrollbarWidth,
				scrollbarBottom-(scrollbarWidth-scrollbarPosWidth),
				x+width-scrollbarMargin,
				scrollbarTop+(scrollbarWidth-scrollbarPosWidth),
				scrollbarWidth/2
			)
			-- bar
			gl.Color(scrollbarBarColor)
			RectRound(
				x+width-scrollbarMargin-scrollbarWidth + (scrollbarWidth - scrollbarPosWidth),
				scrollbarPos,
				x+width-scrollbarMargin-(scrollbarWidth - scrollbarPosWidth),
				scrollbarPos - (scrollbarPosHeight),
				scrollbarPosWidth/2
			)
		end
	end
	
	-- draw textarea
	if textFile then
		font:Begin()
		local lineKey = startLine
		local j = 1
		while j < maxLines do	-- maxlines is not exact, just a failsafe
			if (lineSeparator+fontSizeTitle)*j > height then
				break;
			end
			if textLines[lineKey] == nil then
				break;
			end
			
			local line = textLines[lineKey]
			--if string.find(line, '^([0-9][0-9][/][0-9][0-9][/][0-9][0-9])') or string.find(line, '^([0-9][/][0-9][0-9][/][0-9][0-9])') then
			--	-- date line
			--	line = "  " .. line
			--	font:SetTextColor(fontColorDate)
			--	font:Print(line, x, y-(lineSeparator+fontSizeTitle)*j, fontSizeDate, "n")
			--elseif string.find(line, '^(%d*%d.?%d+)') then
			--	-- version line
			--	local versionStrip = string.match(line, '( %d*%d.?%d+)')
			--	if versionStrip ~= nil then
			--		line = " " .. versionStrip
 			--	else
			--		line = " " .. line
			--	end
			--	font:SetTextColor(fontColorTitle)
			--	font:Print(line, x-9, y-(lineSeparator+fontSizeTitle)*j, fontSizeTitle, "n")
				
			--else
				font:SetTextColor(fontColorLine)
				-- line
				line, numLines = font:WrapText(line, (width-50)*(loadedFontSize/fontSizeLine))
				if (lineSeparator+fontSizeTitle)*(j+numLines-1) > height then
					break;
				end
				font:Print(line, x, y-(lineSeparator+fontSizeTitle)*j, fontSizeLine, "n")
				j = j + (numLines - 1)
			--end

			j = j + 1
			lineKey = lineKey + 1
		end
		font:End()
	end
end


function DrawWindow()
    local vsx,vsy = Spring.GetViewGeometry()
    local x = screenX --rightwards
    local y = screenY --upwards
	
	-- background
	if WG['guishader'] then
		gl.Color(0,0,0,0.8)
	else
		gl.Color(0,0,0,0.85)
	end
	RectRound(x-bgMargin,y-screenHeight-bgMargin,x+screenWidth+bgMargin,y+bgMargin,8, 0,1,1,1)
	-- content area
	gl.Color(0.33,0.33,0.33,0.15)
	RectRound(x,y-screenHeight,x+screenWidth,y,5.5)
	
	-- title
    local title = "Scavengers"
	local titleFontSize = 18
	if WG['guishader'] then
		gl.Color(0,0,0,0.8)
	else
		gl.Color(0,0,0,0.85)
	end
    titleRect = {x-bgMargin, y+bgMargin, x+(font2:GetTextWidth(title)*titleFontSize)+27-bgMargin, y+37}
	RectRound(titleRect[1], titleRect[2], titleRect[3], titleRect[4], 8, 1,1,0,0)
	font2:Begin()
	font2:SetTextColor(1,1,1,1)
	font2:SetOutlineColor(0,0,0,0.4)
	font2:Print(title, x-bgMargin+(titleFontSize*0.75), y+bgMargin+8, titleFontSize, "on")
	font2:End()
	
	-- textarea
	DrawTextarea(x+10, y-10, screenWidth-10, screenHeight-24, 1)
end


function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1,18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1,19) == 'LobbyOverlayActive1')
	end
end

function widget:DrawScreen()
  if chobbyInterface then return end
  if spIsGUIHidden() then return end
  
  -- draw the help
  if not textList then
      textList = gl.CreateList(DrawWindow)
  end
  
  if show or showOnceMore then
    
		-- draw the text panel
		glPushMatrix()
			glTranslate(-(vsx * (widgetScale-1))/2, -(vsy * (widgetScale-1))/2, 0)
			glScale(widgetScale, widgetScale, 1)
			glCallList(textList)
		glPopMatrix()
		if WG['guishader'] then
			local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
			local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
			local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
			local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
			if backgroundGuishader ~= nil then
				glDeleteList(backgroundGuishader)
			end
			backgroundGuishader = glCreateList( function()
				-- background
				RectRound(rectX1, rectY2, rectX2, rectY1, 9*widgetScale, 0,1,1,1)
				-- title
				rectX1 = (titleRect[1] * widgetScale) - ((vsx * (widgetScale-1))/2)
				rectY1 = (titleRect[2] * widgetScale) - ((vsy * (widgetScale-1))/2)
				rectX2 = (titleRect[3] * widgetScale) - ((vsx * (widgetScale-1))/2)
				rectY2 = (titleRect[4] * widgetScale) - ((vsy * (widgetScale-1))/2)
				RectRound(rectX1, rectY1, rectX2, rectY2, 9*widgetScale, 1,1,0,0)
			end)
			dlistcreated = true
			WG['guishader'].InsertDlist(backgroundGuishader, 'text')
		end
		showOnceMore = false

  elseif dlistcreated and WG['guishader'] then
	WG['guishader'].DeleteDlist('text')
	dlistcreated = nil
  end
end

function widget:KeyPress(key)
	if key == 27 then	-- ESC
		show = false
	end
end

function IsOnRect(x, y, BLcornerX, BLcornerY,TRcornerX,TRcornerY)
	
	-- check if the mouse is in a rectangle
	return x >= BLcornerX and x <= TRcornerX
	                      and y >= BLcornerY
	                      and y <= TRcornerY
end

function widget:MouseWheel(up, value)
	
	if show then	
		local addLines = value*-3 -- direction is retarded
		
		startLine = startLine + addLines
		if startLine > totalTextLines - textareaMinLines then startLine = totalTextLines - textareaMinLines end
		if startLine < 1 then startLine = 1 end

		if textList then
			glDeleteList(textList)
		end
		
		textList = gl.CreateList(DrawWindow)
		return true
	else
		return false
	end
end

function widget:MousePress(x, y, button)
	return mouseEvent(x, y, button, false)
end

function widget:MouseRelease(x, y, button)
	return mouseEvent(x, y, button, true)
end

function mouseEvent(x, y, button, release)
  if spIsGUIHidden() then return end
  
  if show then 
		-- on window
		local rectX1 = ((screenX-bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
		local rectY1 = ((screenY+bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
		local rectX2 = ((screenX+screenWidth+bgMargin) * widgetScale) - ((vsx * (widgetScale-1))/2)
		local rectY2 = ((screenY-screenHeight-bgMargin) * widgetScale) - ((vsy * (widgetScale-1))/2)
		if IsOnRect(x, y, rectX1, rectY2, rectX2, rectY1) then
			if button == 1 or button == 3 then
				return true
			end
		elseif titleRect == nil or not IsOnRect(x, y, (titleRect[1] * widgetScale) - ((vsx * (widgetScale-1))/2), (titleRect[2] * widgetScale) - ((vsy * (widgetScale-1))/2), (titleRect[3] * widgetScale) - ((vsx * (widgetScale-1))/2), (titleRect[4] * widgetScale) - ((vsy * (widgetScale-1))/2)) then
			if release then
				showOnceMore = true		-- show once more because the guishader lags behind, though this will not fully fix it
				show = false
			end
			return true
		end
	end
end

function lines(str)
  local t = {}
  local function helper(line) t[#t+1] = line return "" end
  helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

function widget:Initialize()
	if textFile then

		WG['scavengerinfo'] = {}
		WG['scavengerinfo'].toggle = function(state)
			if state ~= nil then
				show = state
			else
				show = not show
			end
		end
		WG['scavengerinfo'].isvisible = function()
			return show
		end
	
		-- somehow there are a few characters added at the start that we need to remove
		--textFile = string.sub(textFile, 4)
		
		-- store text into array
		textLines = lines(textFile)

		for i, line in ipairs(textLines) do
			totalTextLines = i
		end
		widget:ViewResize()
	else
		Spring.Echo("Text: couldn't load the text file")
		widgetHandler:RemoveWidget(self)
	end
end

function widget:Shutdown()
    if buttonGL then
        glDeleteList(buttonGL)
        buttonGL = nil
    end
    if textList then
        glDeleteList(textList)
        textList = nil
    end
	if WG['guishader'] then
		WG['guishader'].DeleteDlist('text')
	end
	gl.DeleteFont(font)
	gl.DeleteFont(font2)
end



function widget:GetConfigData(data)
	savedTable = {}
	savedTable.numGames	= numGames
	return savedTable
end

function widget:SetConfigData(data)
	if data.numGames ~= nil then
		numGames = data.numGames + 1
	end
	if numGames > 1 then
		show = false
	end
end
