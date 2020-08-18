function widget:GetInfo()
	return {
		name = "Info",
		desc = "",
		author = "Floris",
		date = "April 2020",
		license = "GNU GPL, v2 or later",
		layer = 0,
		enabled = true
	}
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local width = 0
local addonWidth = 0
local height = 0
local alternativeUnitpics = false

local zoomMult = 1.5
local defaultCellZoom = 0 * zoomMult
local rightclickCellZoom = 0.065 * zoomMult
local clickCellZoom = 0.065 * zoomMult
local hoverCellZoom = 0.03 * zoomMult

local iconBorderOpacity = 0.07
local showSelectionTotals = true

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local fontfile = "fonts/" .. Spring.GetConfigString("bar_font", "Poppins-Regular.otf")
local fontfile2 = "fonts/" .. Spring.GetConfigString("bar_font2", "Exo2-SemiBold.otf")

local vsx, vsy = Spring.GetViewGeometry()

local barGlowCenterTexture = ":l:LuaUI/Images/barglow-center.png"
local barGlowEdgeTexture = ":l:LuaUI/Images/barglow-edge.png"

local hoverType, hoverData = '', ''
local sound_button = 'LuaUI/Sounds/buildbar_add.wav'
local sound_button2 = 'LuaUI/Sounds/buildbar_rem.wav'

local ui_opacity = tonumber(Spring.GetConfigFloat("ui_opacity", 0.66) or 0.66)
local ui_scale = tonumber(Spring.GetConfigFloat("ui_scale", 1) or 1)
local glossMult = 1 + (2 - (ui_opacity * 2))    -- increase gloss/highlight so when ui is transparant, you can still make out its boundaries and make it less flat

local backgroundRect = { 0, 0, 0, 0 }
local currentTooltip = ''
local lastUpdateClock = 0

local hpcolormap = { { 1, 0.0, 0.0, 1 }, { 0.8, 0.60, 0.0, 1 }, { 0.0, 0.75, 0.0, 1 } }

local tooltipTitleColor = '\255\205\255\205'
local tooltipTextColor = '\255\255\255\255'
local tooltipLabelTextColor = '\255\200\200\200'
local tooltipDarkTextColor = '\255\133\133\133'
local tooltipValueColor = '\255\255\245\175'

local selectionHowto = tooltipTextColor .. "Left click" .. tooltipLabelTextColor .. ": Select\n " .. tooltipTextColor .. "   + CTRL" .. tooltipLabelTextColor .. ": Select units of this type on map\n " .. tooltipTextColor .. "   + ALT" .. tooltipLabelTextColor .. ": Select 1 single unit of this unit type\n " .. tooltipTextColor .. "Right click" .. tooltipLabelTextColor .. ": Remove\n " .. tooltipTextColor .. "    + CTRL" .. tooltipLabelTextColor .. ": Remove only 1 unit from that unit type\n " .. tooltipTextColor .. "Middle click" .. tooltipLabelTextColor .. ": Move to center location\n " .. tooltipTextColor .. "    + CTRL" .. tooltipLabelTextColor .. ": Move to center off whole selection"

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local spGetCurrentTooltip = Spring.GetCurrentTooltip
local spGetSelectedUnitsCounts = Spring.GetSelectedUnitsCounts
local spGetSelectedUnitsSorted = Spring.GetSelectedUnitsSorted
local spGetSelectedUnitsCount = Spring.GetSelectedUnitsCount
local SelectedUnitsCount = Spring.GetSelectedUnitsCount()
local selectedUnits = Spring.GetSelectedUnits()
local spGetUnitDefID = Spring.GetUnitDefID
local spTraceScreenRay = Spring.TraceScreenRay
local spGetMouseState = Spring.GetMouseState
local spGetModKeyState = Spring.GetModKeyState
local spSelectUnitArray = Spring.SelectUnitArray
local spGetTeamUnitsSorted = Spring.GetTeamUnitsSorted
local spSelectUnitMap = Spring.SelectUnitMap
local spGetUnitHealth = Spring.GetUnitHealth
local spGetUnitResources = Spring.GetUnitResources
local spGetUnitMaxRange = Spring.GetUnitMaxRange
local spGetUnitExperience = Spring.GetUnitExperience
local spGetUnitMetalExtraction = Spring.GetUnitMetalExtraction
local spGetUnitStates = Spring.GetUnitStates
local spGetUnitStockpile = Spring.GetUnitStockpile
local spGetUnitWeaponState = Spring.GetUnitWeaponState
local spGetUnitWeaponDamages = Spring.GetUnitWeaponDamages


local math_floor = math.floor
local math_ceil = math.ceil
local math_min = math.min
local math_max = math.max

local os_clock = os.clock

local isSpec = Spring.GetSpectatingState()
local myTeamID = Spring.GetMyTeamID()

local GL_QUADS = GL.QUADS
local GL_TRIANGLE_FAN = GL.TRIANGLE_FAN
local glBeginEnd = gl.BeginEnd
local glTexture = gl.Texture
local glTexRect = gl.TexRect
local glColor = gl.Color
local glRect = gl.Rect
local glVertex = gl.Vertex
local glBlending = gl.Blending
local GL_SRC_ALPHA = GL.SRC_ALPHA
local GL_ONE_MINUS_SRC_ALPHA = GL.ONE_MINUS_SRC_ALPHA
local GL_ONE = GL.ONE

function lines(str)
	local t = {}
	local function helper(line)
		t[#t + 1] = line
		return ""
	end
	helper((str:gsub("(.-)\r?\n", helper)))
	return t
end

function wrap(str, limit)
	limit = limit or 72
	local here = 1
	local buf = ""
	local t = {}
	str:gsub("(%s*)()(%S+)()",
		function(sp, st, word, fi)
			if fi - here > limit then
				--# Break the line
				here = st
				t[#t + 1] = buf
				buf = word
			else
				buf = buf .. sp .. word  --# Append
			end
		end)
	--# Tack on any leftovers
	if (buf ~= "") then
		t[#t + 1] = buf
	end
	return t
end

function round(value, numDecimalPlaces)
	if value then
		return string.format("%0." .. numDecimalPlaces .. "f", math.round(value, numDecimalPlaces))
	else
		return 0
	end
end

local function convertColor(r, g, b)
	return string.char(255, (r * 255), (g * 255), (b * 255))
end

local hasAlternativeUnitpic = {}
local unitBuildPic = {}
local unitEnergyCost = {}
local unitMetalCost = {}
local unitBuildTime = {}
local unitGroup = {}
local isBuilder = {}
local unitHumanName = {}
local unitDescriptionLong = {}
local unitTooltip = {}
local unitIconType = {}
local isMex = {}
local isTransport = {}
local isAaUnit = {}
local isAirUnit = {}
local unitMaxWeaponRange = {}
local unitHealth = {}
local unitBuildOptions = {}
local unitBuildSpeed = {}
local unitWeapons = {}
local unitDPS = {}
local unitMainWeapon = {}
local unitReloadTime = {}
local unitEnergyPerShot = {}
local unitMetalPerShot = {}
local unitCanStockpile = {}
local unitLosRadius = {}
local unitAirLosRadius = {}
local unitRadarRadius = {}
local unitSonarRadius = {}
local unitJammerRadius = {}
local unitSonarJamRadius = {}
local unitSeismicRadius = {}
local unitArmorType = {}
local unitWreckMetal = {}
local unitHeapMetal = {}
local unitParalyzeMult = {}
local unitMetalmaker = {}
for unitDefID, unitDef in pairs(UnitDefs) do

	if unitDef.isAirUnit then
		isAirUnit[unitDefID] = true
	end

	unitHumanName[unitDefID] = unitDef.humanName
	if unitDef.maxWeaponRange > 16 then
		unitMaxWeaponRange[unitDefID] = unitDef.maxWeaponRange
	end
	if unitDef.customParams.description_long then
		unitDescriptionLong[unitDefID] = wrap(unitDef.customParams.description_long, 58)
	end
	if unitDef.isTransport then
		isTransport[unitDefID] = { unitDef.transportMass, unitDef.transportSize, unitDef.transportCapacity }
	end
	if unitDef.customParams.paralyzemultiplier then
		unitParalyzeMult[unitDefID] = tonumber(unitDef.customParams.paralyzemultiplier)
	end
	if unitDef.wreckName then
		if FeatureDefNames[unitDef.wreckName] then
			unitWreckMetal[unitDefID] = FeatureDefNames[unitDef.wreckName].metal
			if FeatureDefNames[unitDef.wreckName].deathFeatureID and FeatureDefs[FeatureDefNames[unitDef.wreckName].deathFeatureID] then
				unitHeapMetal[unitDefID] = FeatureDefs[FeatureDefNames[unitDef.wreckName].deathFeatureID].metal
			end
		end
	end
	unitArmorType[unitDefID] = Game.armorTypes[unitDef.armorType or 0] or '???'

	if unitDef.losRadius > 0 then
		unitLosRadius[unitDefID] = unitDef.losRadius
	end
	if unitDef.airLosRadius > 0 then
		unitAirLosRadius[unitDefID] = unitDef.airLosRadius
	end
	if unitDef.radarRadius > 0 then
		unitRadarRadius[unitDefID] = unitDef.radarRadius
	end
	if unitDef.sonarRadius > 0 then
		unitSonarRadius[unitDefID] = unitDef.sonarRadius
	end
	if unitDef.jammerRadius > 0 then
		unitJammerRadius[unitDefID] = unitDef.jammerRadius
	end
	if unitDef.sonarJamRadius > 0 then
		unitSonarJamRadius[unitDefID] = unitDef.sonarJamRadius
	end
	if unitDef.seismicRadius > 0 then
		unitSeismicRadius[unitDefID] = unitDef.seismicRadius
	end

	if unitDef.customParams.energyconv_capacity and unitDef.customParams.energyconv_efficiency then
		unitMetalmaker[unitDefID] = { tonumber(unitDef.customParams.energyconv_capacity), tonumber(unitDef.customParams.energyconv_efficiency) }
	end

	unitTooltip[unitDefID] = unitDef.tooltip
	unitIconType[unitDefID] = unitDef.iconType
	unitEnergyCost[unitDefID] = unitDef.energyCost
	unitMetalCost[unitDefID] = unitDef.metalCost
	unitHealth[unitDefID] = unitDef.health
	unitBuildTime[unitDefID] = unitDef.buildTime
	unitBuildPic[unitDefID] = unitDef.buildpicname
	if unitDef.canStockpile then
		unitCanStockpile[unitDefID] = true
	end
	if VFS.FileExists('unitpics/alternative/' .. string.gsub(unitDef.buildpicname, '(.*/)', '')) then
		hasAlternativeUnitpic[unitDefID] = true
	end
	if unitDef.buildSpeed > 0 then
		unitBuildSpeed[unitDefID] = unitDef.buildSpeed
	end
	if unitDef.buildOptions[1] then
		unitBuildOptions[unitDefID] = unitDef.buildOptions
	end
	if unitDef.extractsMetal > 0 then
		isMex[unitDefID] = true
	end

	for i = 1, #unitDef.weapons do
		if not unitWeapons[unitDefID] then
			unitWeapons[unitDefID] = {}
			unitDPS[unitDefID] = 0
			unitReloadTime[unitDefID] = 0
			unitMainWeapon[unitDefID] = i
		end
		unitWeapons[unitDefID][i] = unitDef.weapons[i].weaponDef
		local weaponDef = WeaponDefs[unitDef.weapons[i].weaponDef]
		if weaponDef.damages then
			-- get highest damage category
			local maxDmg = 0
			local reloadTime = 0
			for _, v in pairs(weaponDef.damages) do
				if v > maxDmg then
					maxDmg = v
					reloadTime = weaponDef.reload
				end
			end
			local dps = math_floor(maxDmg * weaponDef.salvoSize / weaponDef.reload)
			if dps > unitDPS[unitDefID] then
				unitDPS[unitDefID] = dps
				unitReloadTime[unitDefID] = reloadTime
				unitMainWeapon[unitDefID] = i
			end
		end
		if unitDef.weapons[i].onlyTargets['vtol'] ~= nil then
			isAaUnit[unitDefID] = true
		end
		if weaponDef.energyCost > 0 and (not unitEnergyPerShot[unitDefID] or weaponDef.energyCost > unitEnergyPerShot[unitDefID]) then
			unitEnergyPerShot[unitDefID] = weaponDef.energyCost
		end
		if weaponDef.metalCost > 0 and (not unitMetalPerShot[unitDefID] or weaponDef.metalCost > unitMetalPerShot[unitDefID]) then
			unitMetalPerShot[unitDefID] = weaponDef.metalCost
		end
	end
end


-- order units, add higher value for order importance
local unitOrder = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	unitOrder[unitDefID] = 0
	if unitDef.buildSpeed > 0 then
		unitOrder[unitDefID] = unitOrder[unitDefID] + (unitDef.buildSpeed * 10000)
	end
	if unitDef.buildOptions[1] then
		if unitDef.isBuilding then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 200000000
		else
			unitOrder[unitDefID] = unitOrder[unitDefID] + 150000000
		end
		if unitDef.modCategories['notland'] or unitDef.modCategories['underwater'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] - 25000000
		end
	end
	if unitDef.isImmobile or unitDef.isBuilding then
		if unitDef.floatOnWater then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 11000000
		elseif unitDef.modCategories['underwater'] or unitDef.modCategories['canbeuw'] or unitDef.modCategories['notland'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 10000000
		else
			unitOrder[unitDefID] = unitOrder[unitDefID] + 12000000
		end
	else
		if unitDef.modCategories['ship'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 9000000
		elseif unitDef.modCategories['hover'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 8000000
		elseif unitDef.modCategories['tank'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 7000000
		elseif unitDef.modCategories['bot'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 6000000
		elseif unitDef.isAirUnit then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 5000000
		elseif unitDef.modCategories['underwater'] or unitDef.modCategories['canbeuw'] or unitDef.modCategories['notland'] then
			unitOrder[unitDefID] = unitOrder[unitDefID] + 8600000
		end
	end
	if unitDef.energyCost then
		unitOrder[unitDefID] = unitOrder[unitDefID] + (unitDef.energyCost / 70)
	end
	if unitDef.metalCost then
		unitOrder[unitDefID] = unitOrder[unitDefID] + unitDef.metalCost
	end
	if unitDPS[unitDefID] then
		unitOrder[unitDefID] = unitOrder[unitDefID] + unitDPS[unitDefID]
	end
	unitOrder[unitDefID] = math_floor(unitOrder[unitDefID])
	--Spring.Echo(unitHumanName[unitDefID]..' = '..unitOrder[unitDefID])
end

local function getHighestOrderedUnit()
	local highest = { 0, 0 }
	for unitDefID, orderValue in pairs(unitOrder) do
		if orderValue > highest[2] then
			highest = { unitDefID, orderValue }
		end
	end
	return highest[1]
end

local unitsOrdered = {}
for unitDefID, unitDef in pairs(UnitDefs) do
	local uDefID = getHighestOrderedUnit()
	unitsOrdered[#unitsOrdered + 1] = uDefID
	unitOrder[uDefID] = nil
end

unitOrder = unitsOrdered
unitsOrdered = nil

--for k, unitDefID in pairs(unitOrder) do
--  Spring.Echo(k..'  '..unitHumanName[unitDefID])
--end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------



-- load all icons to prevent briefly showing white unit icons (will happen due to the custom texture filtering options)
local function cacheUnitIcons()
	local radarIconSize = math_floor((height * vsy * 0.17) + 0.5)   -- when changine this also update radarIconSize formula at other place in code
	for id, unit in pairs(UnitDefs) do
		if hasAlternativeUnitpic[id] then
			gl.Texture(':lr200,200:unitpics/alternative/' .. unitBuildPic[id])
		else
			gl.Texture(':lr200,200:unitpics/' .. unitBuildPic[id])
		end
		gl.TexRect(-1, -1, 0, 0)
		if alternativeUnitpics and hasAlternativeUnitpic[id] then
			gl.Texture(':lr100,100:unitpics/alternative/' .. unitBuildPic[id])
		else
			gl.Texture(':lr100,100:unitpics/' .. unitBuildPic[id])
		end
		gl.TexRect(-1, -1, 0, 0)
		if alternativeUnitpics and hasAlternativeUnitpic[id] then
			gl.Texture(':lr160,160:unitpics/alternative/' .. unitBuildPic[id])
		else
			gl.Texture(':lr160,160:unitpics/' .. unitBuildPic[id])
		end
		if iconTypesMap[unitIconType[id]] then
			gl.TexRect(-1, -1, 0, 0)
			gl.Texture(':lr' .. (radarIconSize * 2) .. ',' .. (radarIconSize * 2) .. ':' .. iconTypesMap[unitIconType[id]])
			gl.TexRect(-1, -1, 0, 0)
		end
		gl.Texture(false)
	end
end

local function refreshUnitIconCache()
	if dlistCache then
		dlistCache = gl.DeleteList(dlistCache)
	end
	dlistCache = gl.CreateList(function()
		cacheUnitIcons()
	end)
end

local function checkGuishader(force)
	if WG['guishader'] then
		if force and dlistGuishader then
			dlistGuishader = gl.DeleteList(dlistGuishader)
		end
		if not dlistGuishader then
			dlistGuishader = gl.CreateList(function()
				RectRound(backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4], bgpadding * 1.6)
			end)
			WG['guishader'].InsertDlist(dlistGuishader, 'info')
		end
	elseif dlistGuishader then
		dlistGuishader = gl.DeleteList(dlistGuishader)
	end
end

function widget:PlayerChanged(playerID)
	isSpec = Spring.GetSpectatingState()
	myTeamID = Spring.GetMyTeamID()
end

function widget:ViewResize()
	ViewResizeUpdate = true

	vsx, vsy = Spring.GetViewGeometry()

	width = 0.2125
	height = 0.14
	width = width / (vsx / vsy) * 1.78        -- make smaller for ultrawide screens
	width = width * ui_scale
	-- make pixel aligned
	height = math_floor(height * vsy) / vsy
	width = math_floor(width * vsx) / vsx

	local widgetSpaceMargin = math_floor(0.0045 * vsy * ui_scale) / vsy
	bgpadding = math_ceil(widgetSpaceMargin * 0.66 * vsy)

	backgroundRect = { 0, 0, (width - addonWidth) * vsx, height * vsy }

	doUpdate = true
	clear()

	checkGuishader(true)

	font, loadedFontSize = WG['fonts'].getFont(fontfile)
	font2 = WG['fonts'].getFont(fontfile2)
end

function GetColor(colormap, slider)
	local coln = #colormap
	if (slider >= 1) then
		local col = colormap[coln]
		return col[1], col[2], col[3], col[4]
	end
	if (slider < 0) then
		slider = 0
	elseif (slider > 1) then
		slider = 1
	end
	local posn = 1 + (coln - 1) * slider
	local iposn = math_floor(posn)
	local aa = posn - iposn
	local ia = 1 - aa

	local col1, col2 = colormap[iposn], colormap[iposn + 1]

	return col1[1] * ia + col2[1] * aa, col1[2] * ia + col2[2] * aa,
	col1[3] * ia + col2[3] * aa, col1[4] * ia + col2[4] * aa
end

function widget:Initialize()
	widget:ViewResize()

	WG['info'] = {}
	WG['info'].getPosition = function()
		return width, height
	end
	WG['info'].getAlternativeIcons = function()
		return alternativeUnitpics
	end
	WG['info'].setAlternativeIcons = function(value)
		alternativeUnitpics = value
		doUpdate = true
		refreshUnitIconCache()
	end
	iconTypesMap = {}
	if Script.LuaRules('GetIconTypes') then
		iconTypesMap = Script.LuaRules.GetIconTypes()
	end
	Spring.SetDrawSelectionInfo(false)    -- disables springs default display of selected units count
	Spring.SendCommands("tooltip 0")

	if WG['rankicons'] then
		rankTextures = WG['rankicons'].getRankTextures()
	end

	bfcolormap = {}
	for hp = 0, 100 do
		bfcolormap[hp] = { GetColor(hpcolormap, hp * 0.01) }
	end

	refreshUnitIconCache()
end

function clear()
	dlistInfo = gl.DeleteList(dlistInfo)
end

function widget:Shutdown()
	Spring.SetDrawSelectionInfo(true) --disables springs default display of selected units count
	Spring.SendCommands("tooltip 1")
	clear()
	if WG['guishader'] and dlistGuishader then
		WG['guishader'].DeleteDlist('info')
		dlistGuishader = nil
	end
end

local uiOpacitySec = 0
local sec = 0
function widget:Update(dt)
	uiOpacitySec = uiOpacitySec + dt
	if uiOpacitySec > 0.5 then
		uiOpacitySec = 0
		checkGuishader()
		if WG['buildpower'] then
			addonWidth, _ = WG['buildpower'].getSize()
			if not addonWidth then
				addonWidth = 0
			end
			widget:ViewResize()
		elseif addonWidth > 0 then
			addonWidth = 0
			widget:ViewResize()
		end
		if ui_scale ~= Spring.GetConfigFloat("ui_scale", 1) then
			ui_scale = Spring.GetConfigFloat("ui_scale", 1)
			widget:ViewResize()
			refreshUnitIconCache()
		end
		if ui_opacity ~= Spring.GetConfigFloat("ui_opacity", 0.66) then
			ui_opacity = Spring.GetConfigFloat("ui_opacity", 0.66)
			glossMult = 1 + (2 - (ui_opacity * 2))
			doUpdate = true
		end
		if not rankTextures and WG['rankicons']  then
			rankTextures = WG['rankicons'].getRankTextures()
		end
	end

	sec = sec + dt
	if sec > 0.05 then
		sec = 0
		checkChanges()
	end
end

local function DrawRectRound(px, py, sx, sy, cs, tl, tr, br, bl, c1, c2)
	local csyMult = 1 / ((sy - py) / cs)

	if c2 then
		gl.Color(c1[1], c1[2], c1[3], c1[4])
	end
	gl.Vertex(px + cs, py, 0)
	gl.Vertex(sx - cs, py, 0)
	if c2 then
		gl.Color(c2[1], c2[2], c2[3], c2[4])
	end
	gl.Vertex(sx - cs, sy, 0)
	gl.Vertex(px + cs, sy, 0)

	-- left side
	if c2 then
		gl.Color(c1[1] * (1 - csyMult) + (c2[1] * csyMult), c1[2] * (1 - csyMult) + (c2[2] * csyMult), c1[3] * (1 - csyMult) + (c2[3] * csyMult), c1[4] * (1 - csyMult) + (c2[4] * csyMult))
	end
	gl.Vertex(px, py + cs, 0)
	gl.Vertex(px + cs, py + cs, 0)
	if c2 then
		gl.Color(c2[1] * (1 - csyMult) + (c1[1] * csyMult), c2[2] * (1 - csyMult) + (c1[2] * csyMult), c2[3] * (1 - csyMult) + (c1[3] * csyMult), c2[4] * (1 - csyMult) + (c1[4] * csyMult))
	end
	gl.Vertex(px + cs, sy - cs, 0)
	gl.Vertex(px, sy - cs, 0)

	-- right side
	if c2 then
		gl.Color(c1[1] * (1 - csyMult) + (c2[1] * csyMult), c1[2] * (1 - csyMult) + (c2[2] * csyMult), c1[3] * (1 - csyMult) + (c2[3] * csyMult), c1[4] * (1 - csyMult) + (c2[4] * csyMult))
	end
	gl.Vertex(sx, py + cs, 0)
	gl.Vertex(sx - cs, py + cs, 0)
	if c2 then
		gl.Color(c2[1] * (1 - csyMult) + (c1[1] * csyMult), c2[2] * (1 - csyMult) + (c1[2] * csyMult), c2[3] * (1 - csyMult) + (c1[3] * csyMult), c2[4] * (1 - csyMult) + (c1[4] * csyMult))
	end
	gl.Vertex(sx - cs, sy - cs, 0)
	gl.Vertex(sx, sy - cs, 0)

	local offset = 0.15        -- texture offset, because else gaps could show

	-- bottom left
	if c2 then
		gl.Color(c1[1], c1[2], c1[3], c1[4])
	end
	if ((py <= 0 or px <= 0) or (bl ~= nil and bl == 0)) and bl ~= 2 then
		gl.Vertex(px, py, 0)
	else
		gl.Vertex(px + cs, py, 0)
	end
	gl.Vertex(px + cs, py, 0)
	if c2 then
		gl.Color(c1[1] * (1 - csyMult) + (c2[1] * csyMult), c1[2] * (1 - csyMult) + (c2[2] * csyMult), c1[3] * (1 - csyMult) + (c2[3] * csyMult), c1[4] * (1 - csyMult) + (c2[4] * csyMult))
	end
	gl.Vertex(px + cs, py + cs, 0)
	gl.Vertex(px, py + cs, 0)
	-- bottom right
	if c2 then
		gl.Color(c1[1], c1[2], c1[3], c1[4])
	end
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2 then
		gl.Vertex(sx, py, 0)
	else
		gl.Vertex(sx - cs, py, 0)
	end
	gl.Vertex(sx - cs, py, 0)
	if c2 then
		gl.Color(c1[1] * (1 - csyMult) + (c2[1] * csyMult), c1[2] * (1 - csyMult) + (c2[2] * csyMult), c1[3] * (1 - csyMult) + (c2[3] * csyMult), c1[4] * (1 - csyMult) + (c2[4] * csyMult))
	end
	gl.Vertex(sx - cs, py + cs, 0)
	gl.Vertex(sx, py + cs, 0)
	-- top left
	if c2 then
		gl.Color(c2[1], c2[2], c2[3], c2[4])
	end
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2 then
		gl.Vertex(px, sy, 0)
	else
		gl.Vertex(px + cs, sy, 0)
	end
	gl.Vertex(px + cs, sy, 0)
	if c2 then
		gl.Color(c2[1] * (1 - csyMult) + (c1[1] * csyMult), c2[2] * (1 - csyMult) + (c1[2] * csyMult), c2[3] * (1 - csyMult) + (c1[3] * csyMult), c2[4] * (1 - csyMult) + (c1[4] * csyMult))
	end
	gl.Vertex(px + cs, sy - cs, 0)
	gl.Vertex(px, sy - cs, 0)
	-- top right
	if c2 then
		gl.Color(c2[1], c2[2], c2[3], c2[4])
	end
	if ((sy >= vsy or sx >= vsx) or (tr ~= nil and tr == 0)) and tr ~= 2 then
		gl.Vertex(sx, sy, 0)
	else
		gl.Vertex(sx - cs, sy, 0)
	end
	gl.Vertex(sx - cs, sy, 0)
	if c2 then
		gl.Color(c2[1] * (1 - csyMult) + (c1[1] * csyMult), c2[2] * (1 - csyMult) + (c1[2] * csyMult), c2[3] * (1 - csyMult) + (c1[3] * csyMult), c2[4] * (1 - csyMult) + (c1[4] * csyMult))
	end
	gl.Vertex(sx - cs, sy - cs, 0)
	gl.Vertex(sx, sy - cs, 0)
end
function RectRound(px, py, sx, sy, cs, tl, tr, br, bl, c1, c2)
	-- (coordinates work differently than the RectRound func in other widgets)
	gl.Texture(false)
	gl.BeginEnd(GL.QUADS, DrawRectRound, px, py, sx, sy, cs, tl, tr, br, bl, c1, c2)
end

local function DrawRectRoundCircle(x, y, z, radius, cs, centerOffset, color1, color2)
	if not color2 then
		color2 = color1
	end
	--centerOffset = 0
	local coords = {
		{ x - radius + cs, z + radius, y }, -- top left
		{ x + radius - cs, z + radius, y }, -- top right
		{ x + radius, z + radius - cs, y }, -- right top
		{ x + radius, z - radius + cs, y }, -- right bottom
		{ x + radius - cs, z - radius, y }, -- bottom right
		{ x - radius + cs, z - radius, y }, -- bottom left
		{ x - radius, z - radius + cs, y }, -- left bottom
		{ x - radius, z + radius - cs, y }, -- left top
	}
	local cs2 = cs * (centerOffset / radius)
	local coords2 = {
		{ x - centerOffset + cs2, z + centerOffset, y }, -- top left
		{ x + centerOffset - cs2, z + centerOffset, y }, -- top right
		{ x + centerOffset, z + centerOffset - cs2, y }, -- right top
		{ x + centerOffset, z - centerOffset + cs2, y }, -- right bottom
		{ x + centerOffset - cs2, z - centerOffset, y }, -- bottom right
		{ x - centerOffset + cs2, z - centerOffset, y }, -- bottom left
		{ x - centerOffset, z - centerOffset + cs2, y }, -- left bottom
		{ x - centerOffset, z + centerOffset - cs2, y }, -- left top
	}
	for i = 1, 8 do
		local i2 = (i >= 8 and 1 or i + 1)
		gl.Color(color2)
		gl.Vertex(coords[i][1], coords[i][2], coords[i][3])
		gl.Vertex(coords[i2][1], coords[i2][2], coords[i2][3])
		gl.Color(color1)
		gl.Vertex(coords2[i2][1], coords2[i2][2], coords2[i2][3])
		gl.Vertex(coords2[i][1], coords2[i][2], coords2[i][3])
	end
end
local function RectRoundCircle(x, y, z, radius, cs, centerOffset, color1, color2)
	gl.BeginEnd(GL_QUADS, DrawRectRoundCircle, x, y, z, radius, cs, centerOffset, color1, color2)
end

function IsOnRect(x, y, BLcornerX, BLcornerY, TRcornerX, TRcornerY)
	return x >= BLcornerX and x <= TRcornerX and y >= BLcornerY and y <= TRcornerY
end

local function RectQuad(px, py, sx, sy, offset)
	gl.TexCoord(offset, 1 - offset)
	gl.Vertex(px, py, 0)
	gl.TexCoord(1 - offset, 1 - offset)
	gl.Vertex(sx, py, 0)
	gl.TexCoord(1 - offset, offset)
	gl.Vertex(sx, sy, 0)
	gl.TexCoord(offset, offset)
	gl.Vertex(px, sy, 0)
end
function DrawRect(px, py, sx, sy, zoom)
	gl.BeginEnd(GL.QUADS, RectQuad, px, py, sx, sy, zoom)
end

local function DrawTexRectRound(px, py, sx, sy, cs, tl, tr, br, bl, offset)
	local csyMult = 1 / ((sy - py) / cs)

	local function drawTexCoordVertex(x, y)
		local yc = 1 - ((y - py) / (sy - py))
		local xc = (offset * 0.5) + ((x - px) / (sx - px)) + (-offset * ((x - px) / (sx - px)))
		yc = 1 - (offset * 0.5) - ((y - py) / (sy - py)) + (offset * ((y - py) / (sy - py)))
		gl.TexCoord(xc, yc)
		gl.Vertex(x, y, 0)
	end

	-- mid section
	drawTexCoordVertex(px + cs, py)
	drawTexCoordVertex(sx - cs, py)
	drawTexCoordVertex(sx - cs, sy)
	drawTexCoordVertex(px + cs, sy)

	-- left side
	drawTexCoordVertex(px, py + cs)
	drawTexCoordVertex(px + cs, py + cs)
	drawTexCoordVertex(px + cs, sy - cs)
	drawTexCoordVertex(px, sy - cs)

	-- right side
	drawTexCoordVertex(sx, py + cs)
	drawTexCoordVertex(sx - cs, py + cs)
	drawTexCoordVertex(sx - cs, sy - cs)
	drawTexCoordVertex(sx, sy - cs)

	-- bottom left
	if ((py <= 0 or px <= 0) or (bl ~= nil and bl == 0)) and bl ~= 2 then
		drawTexCoordVertex(px, py)
	else
		drawTexCoordVertex(px + cs, py)
	end
	drawTexCoordVertex(px + cs, py)
	drawTexCoordVertex(px + cs, py + cs)
	drawTexCoordVertex(px, py + cs)
	-- bottom right
	if ((py <= 0 or sx >= vsx) or (br ~= nil and br == 0)) and br ~= 2 then
		drawTexCoordVertex(sx, py)
	else
		drawTexCoordVertex(sx - cs, py)
	end
	drawTexCoordVertex(sx - cs, py)
	drawTexCoordVertex(sx - cs, py + cs)
	drawTexCoordVertex(sx, py + cs)
	-- top left
	if ((sy >= vsy or px <= 0) or (tl ~= nil and tl == 0)) and tl ~= 2 then
		drawTexCoordVertex(px, sy)
	else
		drawTexCoordVertex(px + cs, sy)
	end
	drawTexCoordVertex(px + cs, sy)
	drawTexCoordVertex(px + cs, sy - cs)
	drawTexCoordVertex(px, sy - cs)
	-- top right
	if ((sy >= vsy or sx >= vsx) or (tr ~= nil and tr == 0)) and tr ~= 2 then
		drawTexCoordVertex(sx, sy)
	else
		drawTexCoordVertex(sx - cs, sy)
	end
	drawTexCoordVertex(sx - cs, sy)
	drawTexCoordVertex(sx - cs, sy - cs)
	drawTexCoordVertex(sx, sy - cs)
end
function TexRectRound(px, py, sx, sy, cs, tl, tr, br, bl, zoom)
	gl.BeginEnd(GL.QUADS, DrawTexRectRound, px, py, sx, sy, cs, tl, tr, br, bl, zoom)
end

local function drawSelectionCell(cellID, uDefID, usedZoom, highlightColor)
	if not usedZoom then
		usedZoom = defaultCellZoom
	end

	glColor(1, 1, 1, 1)
	glTexture(texSetting .. "unitpics/" .. ((alternativeUnitpics and hasAlternativeUnitpic[uDefID]) and 'alternative/' or '') .. unitBuildPic[uDefID])
	--glTexRect(cellRect[cellID][1]+cellPadding, cellRect[cellID][2]+cellPadding, cellRect[cellID][3]-cellPadding, cellRect[cellID][4]-cellPadding)
	--DrawRect(cellRect[cellID][1]+cellPadding, cellRect[cellID][2]+cellPadding, cellRect[cellID][3]-cellPadding, cellRect[cellID][4]-cellPadding,0.06)
	TexRectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][4], cornerSize, 1, 1, 1, 1, usedZoom)
	glTexture(false)
	-- darkening bottom
	RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][4], cornerSize, 0, 0, 1, 1, { 0, 0, 0, 0.15 }, { 0, 0, 0, 0 })
	-- gloss
	glBlending(GL_SRC_ALPHA, GL_ONE)
	RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][4] - ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.77), cellRect[cellID][3], cellRect[cellID][4], cornerSize, 1, 1, 0, 0, { 1, 1, 1, 0 }, { 1, 1, 1, 0.1 })
	RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][4] - ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.14), cellRect[cellID][3], cellRect[cellID][4], cornerSize, 1, 1, 0, 0, { 1, 1, 1, 0 }, { 1, 1, 1, 0.06 })
	RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][2] + cellPadding + ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.14), cornerSize, 0, 0, 1, 1, { 1, 1, 1, 0.08 }, { 1, 1, 1, 0 })
	glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

	-- lighten cell edges
	if highlightColor then
		local halfSize = (((cellRect[cellID][3] - cellPadding)) - (cellRect[cellID][1])) * 0.5
		glBlending(GL_SRC_ALPHA, GL_ONE)
		RectRoundCircle(
			cellRect[cellID][1] + cellPadding + halfSize,
			0,
			cellRect[cellID][2] + cellPadding + halfSize,
			halfSize, cornerSize, halfSize * 0.5, { highlightColor[1], highlightColor[2], highlightColor[3], 0 }, { highlightColor[1], highlightColor[2], highlightColor[3], highlightColor[4] * 0.75 }
		)
		RectRoundCircle(
			cellRect[cellID][1] + cellPadding + halfSize,
			0,
			cellRect[cellID][2] + cellPadding + halfSize,
			halfSize, cornerSize, halfSize * 0.82, { highlightColor[1], highlightColor[2], highlightColor[3], 0 }, highlightColor
		)
		glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	end

	-- lighten border
	if iconBorderOpacity > 0 then
		local halfSize = (((cellRect[cellID][3] - cellPadding)) - (cellRect[cellID][1])) * 0.5
		glBlending(GL_SRC_ALPHA, GL_ONE)
		RectRoundCircle(
			cellRect[cellID][1] + cellPadding + halfSize,
			0,
			cellRect[cellID][2] + cellPadding + halfSize,
			halfSize, cornerSize, halfSize - math_max(1, cellPadding), { 1, 1, 1, iconBorderOpacity }, { 1, 1, 1, iconBorderOpacity }
		)
		glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
	end

	-- unitcount
	if selUnitsCounts[uDefID] > 1 then
		local fontSize = math_min(gridHeight * 0.19, cellsize * 0.6) * (1 - ((1 + string.len(selUnitsCounts[uDefID])) * 0.066))
		font2:Begin()
		font2:Print(selUnitsCounts[uDefID], cellRect[cellID][3] - cellPadding - (fontSize * 0.09), cellRect[cellID][2] + (fontSize * 0.3), fontSize, "ro")
		font2:End()
	end
end

local function getSelectionTotals(cells, newlineEveryStat)
	local descriptionColor = '\255\240\240\240'
	local metalColor = '\255\245\245\245'
	local energyColor = '\255\255\255\000'
	local healthColor = '\255\100\255\100'

	local labelColor = '\255\205\205\205'
	local valueColor = '\255\255\255\255'
	local valuePlusColor = '\255\180\255\180'
	local valueMinColor = '\255\255\180\180'

	local statsIndent = '  '
	local stats = ''

	-- description
	if cellHovered then
		local text, numLines = font:WrapText(unitTooltip[selectionCells[cellHovered]], (backgroundRect[3] - backgroundRect[1]) * (loadedFontSize / 16))
		stats = stats .. statsIndent .. tooltipTextColor .. text .. '\n\n'
	end

	-- loop all unitdefs/cells (but not individual unitID's)
	local totalMetalValue = 0
	local totalEnergyValue = 0
	local totalDpsValue = 0
	for _, unitDefID in pairs(cells) do
		-- metal cost
		if unitMetalCost[unitDefID] then
			totalMetalValue = totalMetalValue + (unitMetalCost[unitDefID] * selUnitsCounts[unitDefID])
		end
		-- energy cost
		if unitEnergyCost[unitDefID] then
			totalEnergyValue = totalEnergyValue + (unitEnergyCost[unitDefID] * selUnitsCounts[unitDefID])
		end
		-- DPS
		if unitDPS[unitDefID] then
			totalDpsValue = totalDpsValue + (unitDPS[unitDefID] * selUnitsCounts[unitDefID])
		end
	end

	-- loop all unitID's
	local totalMaxHealthValue = 0
	local totalHealth = 0
	local totalMetalMake, totalMetalUse, totalEnergyMake, totalEnergyUse = 0, 0, 0, 0
	for _, unitID in pairs(cellHovered and selUnitsSorted[selectionCells[cellHovered]] or selectedUnits) do
		-- resources
		local metalMake, metalUse, energyMake, energyUse = spGetUnitResources(unitID)
		if metalMake then
			totalMetalMake = totalMetalMake + metalMake
			totalMetalUse = totalMetalUse + metalUse
			totalEnergyMake = totalEnergyMake + energyMake
			totalEnergyUse = totalEnergyUse + energyUse
		end
		-- health
		local health, maxHealth, _, _, buildProgress = spGetUnitHealth(unitID)
		if health and maxHealth then
			totalMaxHealthValue = totalMaxHealthValue + maxHealth
			totalHealth = totalHealth + health
		end
	end

	-- resources
	stats = stats .. statsIndent .. tooltipLabelTextColor .. "metal: " .. (totalMetalMake > 0 and valuePlusColor .. '+' .. (totalMetalMake < 10 and round(totalMetalMake, 1) or round(totalMetalMake, 0)) .. ' ' or '... ') .. (totalMetalUse > 0 and valueMinColor .. '-' .. (totalMetalUse < 10 and round(totalMetalUse, 1) or round(totalMetalUse, 0)) or tooltipLabelTextColor .. '... ')

	if newlineEveryStat then
		stats = stats .. '\n' .. statsIndent
	end
	stats = stats .. tooltipLabelTextColor .. "energy: " .. (totalEnergyMake > 0 and valuePlusColor .. '+' .. (totalEnergyMake < 10 and round(totalEnergyMake, 1) or round(totalEnergyMake, 0)) .. ' ' or '... ') .. (totalEnergyUse > 0 and valueMinColor .. '-' .. (totalEnergyUse < 10 and round(totalEnergyUse, 1) or round(totalEnergyUse, 0)) or tooltipLabelTextColor .. '... ')

	-- metal cost
	if totalMetalValue > 0 then
		stats = stats .. '\n' .. statsIndent .. tooltipLabelTextColor .. "metalcost: " .. tooltipValueColor .. totalMetalValue .. "   "
	end
	if newlineEveryStat then
		stats = stats .. '\n' .. statsIndent
	end

	-- energy cost
	if totalEnergyValue > 0 then
		stats = stats .. tooltipLabelTextColor .. "energycost: " .. tooltipValueColor .. totalEnergyValue .. "   "
	end

	-- health
	totalMaxHealthValue = math_floor(totalMaxHealthValue)
	if totalMaxHealthValue > 0 then
		totalHealth = math_floor(totalHealth)
		local percentage = math_floor((totalHealth / totalMaxHealthValue) * 100)
		stats = stats .. '\n' .. statsIndent .. tooltipLabelTextColor .. "health: " .. tooltipValueColor .. percentage .. "%" .. tooltipDarkTextColor .. "  ( " .. tooltipLabelTextColor .. totalHealth .. tooltipDarkTextColor .. ' of ' .. tooltipLabelTextColor .. totalMaxHealthValue .. tooltipDarkTextColor .. " )"
	end

	-- DPS
	if totalDpsValue > 0 then
		stats = stats .. '\n' .. statsIndent .. tooltipLabelTextColor .. "DPS: " .. tooltipValueColor .. totalDpsValue .. "   "
	end

	if stats ~= '' then
		stats = '\n' .. stats
		if not cellHovered then
			stats = '\n' .. stats
		end
	end

	return stats
end

local function drawSelection()

	selUnitsCounts = spGetSelectedUnitsCounts()
	selUnitsSorted = spGetSelectedUnitsSorted()
	local selUnitTypes = 0
	selectionCells = {}

	for k, uDefID in pairs(unitOrder) do
		if selUnitsSorted[uDefID] then
			if type(selUnitsSorted[uDefID]) == 'table' then
				selUnitTypes = selUnitTypes + 1
				selectionCells[selUnitTypes] = uDefID
			end
		end
	end

	-- draw selection totals
	if showSelectionTotals then
		local stats = getSelectionTotals(selectionCells, true)
		local text = tooltipTextColor .. #selectedUnits .. tooltipLabelTextColor .. " units selected" .. stats .. "\n " .. (stats == '' and '' or '\n')
		local fontSize = (height * vsy * 0.11) * (0.95 - ((1 - ui_scale) * 0.5))
		text, numLines = font:WrapText(text, contentWidth * (loadedFontSize / fontSize))
		font:Begin()
		font:Print(text, backgroundRect[1] + contentPadding, backgroundRect[4] - contentPadding - (fontSize * 0.8), fontSize, "o")
		font:End()
	end

	-- selected units grid area
	local gridWidth = math_floor((backgroundRect[3] - backgroundRect[1] - bgpadding) * 0.8)  -- leaving some room for the totals
	gridHeight = math_floor((backgroundRect[4] - backgroundRect[2]) - bgpadding - bgpadding)
	customInfoArea = { backgroundRect[3] - gridWidth, backgroundRect[2], backgroundRect[3] - bgpadding, backgroundRect[2] + gridHeight }

	-- draw selected unit icons
	local rows = 2
	local maxRows = 15  -- just to be sure
	local colls = math_ceil(selUnitTypes / rows)
	cellsize = math_floor(math_min(gridWidth / colls, gridHeight / rows))
	while cellsize < gridHeight / (rows + 1) do
		rows = rows + 1
		colls = math_ceil(selUnitTypes / rows)
		cellsize = math_min(gridWidth / colls, gridHeight / rows)
		if rows > maxRows then
			break
		end
	end

	-- adjust grid size to add some padding at the top and right side
	cellsize = math_floor((cellsize * (1 - (0.04 / rows))) + 0.5)  -- leave some space at the top
	cellPadding = math_max(1, math_floor(cellsize * 0.04))
	customInfoArea[3] = customInfoArea[3] - cellPadding -- leave space at the right side

	-- draw grid (bottom right to top left)
	cellRect = {}
	texOffset = (0.03 * rows) * zoomMult
	cornerSize = math_max(1, cellPadding * 0.9)
	if texOffset > 0.25 then
		texOffset = 0.25
	end
	--texDetail = math_floor((cellsize-cellPadding)*(1+texOffset))
	--texSetting = ':lr'..texDetail..','..texDetail..':'
	texSetting = cellsize > 38 and ':lr160,160:' or ':lr100,100:'
	local cellID = selUnitTypes
	for row = 1, rows do
		for coll = 1, colls do
			if selectionCells[cellID] then
				local uDefID = selectionCells[cellID]
				cellRect[cellID] = { math_ceil(customInfoArea[3] - cellPadding - (coll * cellsize)), math_ceil(customInfoArea[2] + cellPadding + ((row - 1) * cellsize)), math_ceil(customInfoArea[3] - cellPadding - ((coll - 1) * cellsize)), math_ceil(customInfoArea[2] + cellPadding + ((row) * cellsize)) }
				drawSelectionCell(cellID, selectionCells[cellID], texOffset)
			end
			cellID = cellID - 1
			if cellID <= 0 then
				break
			end
		end
		if cellID <= 0 then
			break
		end
	end
	glTexture(false)
	glColor(1, 1, 1, 1)
end

local function drawUnitInfo()
	local fontSize = (height * vsy * 0.123) * (0.95 - ((1 - ui_scale) * 0.5))

	local iconSize = fontSize * 5
	local iconPadding = 0
	local alternative = ''
	if hasAlternativeUnitpic[displayUnitDefID] then
		alternative = 'alternative/'
		iconPadding = bgpadding
	end

	glColor(1, 1, 1, 1)
	if unitBuildPic[displayUnitDefID] then
		glTexture(":lr200,200:unitpics/" .. alternative .. unitBuildPic[displayUnitDefID])
		glTexRect(backgroundRect[1] + iconPadding, backgroundRect[4] - iconPadding - iconSize - bgpadding, backgroundRect[1] + iconPadding + iconSize, backgroundRect[4] - iconPadding - bgpadding)
		glTexture(false)
	end
	iconSize = iconSize + iconPadding


	local dps, metalExtraction, stockpile, maxRange, exp, metalMake, metalUse, energyMake, energyUse
	local text, unitDescriptionLines = font:WrapText(unitTooltip[displayUnitDefID], (contentWidth - iconSize) * (loadedFontSize / fontSize))


	local radarIconSize = math_floor((height * vsy * 0.17) + 0.5)
	local radarIconMargin = math_floor((radarIconSize * 0.3) + 0.5)
	if unitIconType[displayUnitDefID] and iconTypesMap[unitIconType[displayUnitDefID]] then
		glColor(1, 1, 1, 0.88)
		glTexture(':lr' .. (radarIconSize * 2) .. ',' .. (radarIconSize * 2) .. ':' .. iconTypesMap[unitIconType[displayUnitDefID]])
		glTexRect(backgroundRect[3] - radarIconMargin - radarIconSize, backgroundRect[4] - radarIconMargin - radarIconSize, backgroundRect[3] - radarIconMargin, backgroundRect[4] - radarIconMargin)
		glTexture(false)
		glColor(1, 1, 1, 1)
	end

	if displayUnitID then
		exp = spGetUnitExperience(displayUnitID)
		if exp and exp > 0.009 and WG['rankicons'] and rankTextures then
			local rankIconSize = math_floor((height * vsy * 0.24) + 0.5)
			local rankIconMarginX = math_floor((height * vsy * 0.015) + 0.5)
			local rankIconMarginY = math_floor((height * vsy * 0.18) + 0.5)
			if displayUnitID then
				local rank = WG['rankicons'].getRank(displayUnitDefID, exp)
				if rankTextures[rank] then
					glColor(1, 1, 1, 0.88)
					glTexture(':lr' .. (rankIconSize * 2) .. ',' .. (rankIconSize * 2) .. ':' .. rankTextures[rank])
					glTexRect(backgroundRect[3] - rankIconMarginX - rankIconSize, backgroundRect[4] - rankIconMarginY - rankIconSize, backgroundRect[3] - rankIconMarginX, backgroundRect[4] - rankIconMarginY)
					glTexture(false)
					glColor(1, 1, 1, 1)
				end
			end
		end
	end

	-- unitID
	--if displayUnitID then
	--  local radarIconSpace = (radarIconMargin+radarIconSize)
	--  font:Begin()
	--  font:Print('\255\200\200\200#'..displayUnitID, backgroundRect[3]-radarIconMargin-radarIconSpace, backgroundRect[4]+(fontSize*0.6)-radarIconSpace, fontSize*0.8, "ro")
	--  font:End()
	--end


	local unitNameColor = '\255\205\255\205'
	if SelectedUnitsCount > 0 then
		if not displayMode == 'unitdef' or (WG['buildmenu'] and (WG['buildmenu'].selectedID and (not WG['buildmenu'].hoverID or (WG['buildmenu'].selectedID == WG['buildmenu'].hoverID)))) then
			unitNameColor = '\255\125\255\125'
		end
	end
	local descriptionColor = '\255\240\240\240'
	local metalColor = '\255\245\245\245'
	local energyColor = '\255\255\255\000'
	local healthColor = '\255\100\255\100'

	local labelColor = '\255\205\205\205'
	local valueColor = '\255\255\255\255'
	local valuePlusColor = '\255\180\255\180'
	local valueMinColor = '\255\255\180\180'

	-- unit tooltip
	font:Begin()
	font:Print(descriptionColor .. text, backgroundRect[1] + contentPadding + iconSize, backgroundRect[4] - contentPadding - (fontSize * 2.22), fontSize * 0.94, "o")
	font:End()

	-- unit name
	font2:Begin()
	font2:Print(unitNameColor .. unitHumanName[displayUnitDefID], backgroundRect[1] + iconSize + iconPadding, backgroundRect[4] - contentPadding - (fontSize * 0.91), fontSize * 1.12, "o")
	--font2:End()

	-- custom unit info background
	local width = contentWidth * 0.8
	local height = (backgroundRect[4] - backgroundRect[2]) * (unitDescriptionLines > 1 and 0.495 or 0.6)
	customInfoArea = { math_floor(backgroundRect[3] - width - bgpadding), math_floor(backgroundRect[2]), math_floor(backgroundRect[3] - bgpadding), math_floor(backgroundRect[2] + height) }

	if not displayMode == 'unitdef' or not unitBuildOptions[displayUnitDefID] or (not (WG['buildmenu'] and WG['buildmenu'].hoverID)) then
		RectRound(customInfoArea[1], customInfoArea[2], customInfoArea[3], customInfoArea[4], bgpadding, 1, 0, 0, 0, { 0.8, 0.8, 0.8, 0.06 }, { 0.8, 0.8, 0.8, 0.14 })
	end

	local contentPaddingLeft = contentPadding * 0.75
	local texPosY = backgroundRect[4] - iconSize - (contentPadding * 0.64)
	local texSize = fontSize * 0.6

	local leftSideHeight = (backgroundRect[4] - backgroundRect[2]) * 0.47
	local posY1 = math_floor(backgroundRect[2] + leftSideHeight) - contentPadding - ((math_floor(backgroundRect[2] + leftSideHeight) - math_floor(backgroundRect[2])) * 0.1)
	local posY2 = math_floor(backgroundRect[2] + leftSideHeight) - contentPadding - ((math_floor(backgroundRect[2] + leftSideHeight) - math_floor(backgroundRect[2])) * 0.38)
	local posY3 = math_floor(backgroundRect[2] + leftSideHeight) - contentPadding - ((math_floor(backgroundRect[2] + leftSideHeight) - math_floor(backgroundRect[2])) * 0.67)

	local valueY1 = ''
	local valueY2 = ''
	local valueY3 = ''
	local health, maxHealth, _, _, buildProgress
	if displayUnitID then
		local metalMake, metalUse, energyMake, energyUse = spGetUnitResources(displayUnitID)
		if metalMake then
			valueY1 = (metalMake > 0 and valuePlusColor .. '+' .. (metalMake < 10 and round(metalMake, 1) or round(metalMake, 0)) .. ' ' or '') .. (metalUse > 0 and valueMinColor .. '-' .. (metalUse < 10 and round(metalUse, 1) or round(metalUse, 0)) or '')
			valueY2 = (energyMake > 0 and valuePlusColor .. '+' .. (energyMake < 10 and round(energyMake, 1) or round(energyMake, 0)) .. ' ' or '') .. (energyUse > 0 and valueMinColor .. '-' .. (energyUse < 10 and round(energyUse, 1) or round(energyUse, 0)) or '')
			valueY3 = ''
		end

		-- display health value/bar
		health, maxHealth, _, _, buildProgress = spGetUnitHealth(displayUnitID)
		if health then
			local healthBarWidth = (backgroundRect[3] - backgroundRect[1]) * 0.15
			local healthBarHeight = healthBarWidth * 0.1
			local healthBarMargin = healthBarHeight * 0.7
			local healthBarPadding = healthBarHeight * 0.15
			local healthValueWidth = (healthBarWidth - healthBarPadding) * (health / maxHealth)
			local color = bfcolormap[math_min(math_max(math_floor((health / maxHealth) * 100), 0), 100)]
			valueY3 = convertColor(color[1], color[2], color[3]) .. math_floor(health)
		end
	else
		valueY1 = metalColor .. unitMetalCost[displayUnitDefID]
		valueY2 = energyColor .. unitEnergyCost[displayUnitDefID]
		valueY3 = healthColor .. unitHealth[displayUnitDefID]
	end

	glColor(1, 1, 1, 1)
	local texDetailSize = math_floor(texSize * 4)
	if valueY1 ~= '' then
		glTexture(":lr" .. texDetailSize .. "," .. texDetailSize .. ":LuaUI/Images/metal.png")
		glTexRect(backgroundRect[1] + contentPaddingLeft - (texSize * 0.6), posY1 - texSize, backgroundRect[1] + contentPaddingLeft + (texSize * 1.4), posY1 + texSize)
	end
	if valueY2 ~= '' then
		glTexture(":lr" .. texDetailSize .. "," .. texDetailSize .. ":LuaUI/Images/energy.png")
		glTexRect(backgroundRect[1] + contentPaddingLeft - (texSize * 0.6), posY2 - texSize, backgroundRect[1] + contentPaddingLeft + (texSize * 1.4), posY2 + texSize)
	end
	if valueY3 ~= '' then
		glTexture(":lr" .. texDetailSize .. "," .. texDetailSize .. ":LuaUI/Images/info_health.png")
		glTexRect(backgroundRect[1] + contentPaddingLeft - (texSize * 0.6), posY3 - texSize, backgroundRect[1] + contentPaddingLeft + (texSize * 1.4), posY3 + texSize)
	end
	glTexture(false)

	-- metal
	local fontSize2 = fontSize * 0.9
	local contentPaddingLeft = contentPaddingLeft + texSize + (contentPadding * 0.5)
	font2:Print(valueY1, backgroundRect[1] + contentPaddingLeft, posY1 - (fontSize2 * 0.31), fontSize2, "o")
	-- energy
	font2:Print(valueY2, backgroundRect[1] + contentPaddingLeft, posY2 - (fontSize2 * 0.31), fontSize2, "o")
	-- health
	font2:Print(valueY3, backgroundRect[1] + contentPaddingLeft, posY3 - (fontSize2 * 0.31), fontSize2, "o")
	font2:End()

	-- draw unit buildoption icons
	if displayMode == 'unitdef' and unitBuildOptions[displayUnitDefID] then
		local gridHeight = math_ceil(height * 0.975)
		local rows = 2
		local colls = math_ceil(#unitBuildOptions[displayUnitDefID] / rows)
		local cellsize = math_floor((math_min(width / colls, gridHeight / rows)) + 0.5)
		if cellsize < gridHeight / 3 then
			rows = 3
			colls = math_ceil(#unitBuildOptions[displayUnitDefID] / rows)
			cellsize = math_floor((math_min(width / colls, gridHeight / rows)) + 0.5)
		end
		-- draw grid (bottom right to top left)
		local cellID = #unitBuildOptions[displayUnitDefID]
		cellPadding = math_floor((cellsize * 0.022) + 0.5)
		cellRect = {}
		for row = 1, rows do
			for coll = 1, colls do
				if unitBuildOptions[displayUnitDefID][cellID] then
					local uDefID = unitBuildOptions[displayUnitDefID][cellID]
					cellRect[cellID] = { math_floor(customInfoArea[3] - cellPadding - (coll * cellsize)), math_floor(customInfoArea[2] + cellPadding + ((row - 1) * cellsize)), math_floor(customInfoArea[3] - cellPadding - ((coll - 1) * cellsize)), math_floor(customInfoArea[2] + cellPadding + ((row) * cellsize)) }
					glColor(0.9, 0.9, 0.9, 1)
					glTexture(":lr100,100:unitpics/" .. ((alternativeUnitpics and hasAlternativeUnitpic[uDefID]) and 'alternative/' or '') .. unitBuildPic[uDefID])
					--glTexRect(cellRect[cellID][1]+cellPadding, cellRect[cellID][2]+cellPadding, cellRect[cellID][3]-cellPadding, cellRect[cellID][4]-cellPadding)
					--DrawRect(cellRect[cellID][1]+cellPadding, cellRect[cellID][2]+cellPadding, cellRect[cellID][3]-cellPadding, cellRect[cellID][4]-cellPadding,0.06)
					TexRectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][4], cellPadding * 1.3, 1, 1, 1, 1, 0.11)
					glTexture(false)
					-- darkening bottom
					RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][4], cellPadding * 1.3, 0, 0, 1, 1, { 0, 0, 0, 0.15 }, { 0, 0, 0, 0 })
					-- gloss
					glBlending(GL_SRC_ALPHA, GL_ONE)
					RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][4] - cellPadding - ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.77), cellRect[cellID][3], cellRect[cellID][4], cellPadding * 1.3, 1, 1, 0, 0, { 1, 1, 1, 0 }, { 1, 1, 1, 0.1 })
					RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][2] + cellPadding + ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.14), cellPadding * 1.3, 0, 0, 1, 1, { 1, 1, 1, 0.08 }, { 1, 1, 1, 0 })

					local halfSize = (((cellRect[cellID][3] - cellPadding)) - (cellRect[cellID][1])) * 0.5
					RectRoundCircle(
						cellRect[cellID][1] + cellPadding + halfSize,
						0,
						cellRect[cellID][2] + cellPadding + halfSize,
						halfSize, cellPadding * 1.3, halfSize - math_max(1, cellPadding), { 1, 1, 1, iconBorderOpacity }, { 1, 1, 1, iconBorderOpacity }
					)
					glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
				end
				cellID = cellID - 1
				if cellID <= 0 then
					break
				end
			end
			if cellID <= 0 then
				break
			end
		end
		glTexture(false)
		glColor(1, 1, 1, 1)


	else
		-- unit/unitdef info (without buildoptions)


		contentPadding = contentPadding * 0.95
		local contentPaddingLeft = customInfoArea[1] + contentPadding

		local text = ''
		local separator = ''
		local infoFontsize = fontSize * 0.92
		-- to determine what to show in what order
		local function addTextInfo(label, value)
			text = text .. labelColor .. separator .. string.upper(label:sub(1, 1)) .. label:sub(2) .. (label ~= '' and ' ' or '') .. valueColor .. (value and value or '')
			separator = ',   '
		end


		-- unit specific info
		if unitDPS[displayUnitDefID] then
			dps = unitDPS[displayUnitDefID]
		end

		-- get unit specifc data
		if displayMode == 'unit' then
			-- get lots of unit info from functions: https://springrts.com/wiki/Lua_SyncedRead
			metalMake, metalUse, energyMake, energyUse = spGetUnitResources(displayUnitID)
			maxRange = spGetUnitMaxRange(displayUnitID)
			if not exp then
				exp = spGetUnitExperience(displayUnitID)
			end
			if isMex[displayUnitDefID] then
				metalExtraction = spGetUnitMetalExtraction(displayUnitID)
			end
			local unitStates = spGetUnitStates(displayUnitID)
			if unitCanStockpile[displayUnitDefID] then
				stockpile = spGetUnitStockpile(displayUnitID)
			end

		else
			-- get unitdef specific data


		end

		if unitWeapons[displayUnitDefID] then
			local reloadTime = 1
			if exp and exp > 0.009 then
				addTextInfo('xp', round(exp, 2))
				addTextInfo('max-health', '+'..round((maxHealth/unitHealth[displayUnitDefID]-1)*100, 0)..'%')
				reloadTime = spGetUnitWeaponState(displayUnitID, unitMainWeapon[displayUnitDefID], 'reloadTimeXP')
				reloadTime = tonumber(round((1-(reloadTime/unitReloadTime[displayUnitDefID]))*100, 0))
				if reloadTime > 0 then
					addTextInfo('reload', '-'..reloadTime..'%')
				end
			end
			if dps then
				dps = round(dps + (dps*(reloadTime/100)), 0)
				addTextInfo('dps', dps)
			end
			if maxRange then
				addTextInfo('max-range', maxRange)
			end

			--addTextInfo('weapons', #unitWeapons[displayUnitDefID])

			if unitEnergyPerShot[displayUnitDefID] then
				addTextInfo('energyPerShot', unitEnergyPerShot[displayUnitDefID])
			end
			if unitMetalPerShot[displayUnitDefID] then
				addTextInfo('metalPerShot', unitMetalPerShot[displayUnitDefID])
			end
		end


		--if metalExtraction then
		--  addTextInfo('metal extraction', round(metalExtraction, 2))
		--end
		if unitBuildSpeed[displayUnitDefID] then
			addTextInfo('buildspeed', unitBuildSpeed[displayUnitDefID])
		end
		if unitBuildOptions[displayUnitDefID] then
			addTextInfo('buildoptions', #unitBuildOptions[displayUnitDefID])
		end

		--if unitWreckMetal[displayUnitDefID] then
		--  addTextInfo('wreck', round(unitWreckMetal[displayUnitDefID],0))
		--end
		--if unitHeapMetal[displayUnitDefID] then
		--  addTextInfo('heap', round(unitHeapMetal[displayUnitDefID],0))
		--end

		if unitArmorType[displayUnitDefID] and unitArmorType[displayUnitDefID] ~= 'standard' then
			addTextInfo('armor', unitArmorType[displayUnitDefID])
		end

		if unitParalyzeMult[displayUnitDefID] then
			if unitParalyzeMult[displayUnitDefID] == 0 then
				addTextInfo('unparalyzable')
			else
				addTextInfo('paralyzeMult', round(unitParalyzeMult[displayUnitDefID], 2))
			end
		end

		if unitLosRadius[displayUnitDefID] then
			addTextInfo('los', round(unitLosRadius[displayUnitDefID], 0))
		end
		if unitAirLosRadius[displayUnitDefID] and (isAirUnit[displayUnitDefID] or isAaUnit[displayUnitDefID]) then

			addTextInfo('airlos', round(unitAirLosRadius[displayUnitDefID], 0))
		end
		if unitRadarRadius[displayUnitDefID] then
			addTextInfo('radar', round(unitRadarRadius[displayUnitDefID], 0))
		end
		if unitSonarRadius[displayUnitDefID] then
			addTextInfo('sonar', round(unitSonarRadius[displayUnitDefID], 0))
		end
		if unitJammerRadius[displayUnitDefID] then
			addTextInfo('jammer', round(unitJammerRadius[displayUnitDefID], 0))
		end
		if unitSonarJamRadius[displayUnitDefID] then
			addTextInfo('sonarjam', round(unitSonarJamRadius[displayUnitDefID], 0))
		end
		if unitSeismicRadius[displayUnitDefID] then
			addTextInfo('seismic', unitSeismicRadius[displayUnitDefID])
		end
		--addTextInfo('mass', round(Spring.GetUnitMass(displayUnitID),0))
		--addTextInfo('radius', round(Spring.GetUnitRadius(displayUnitID),0))
		--addTextInfo('height', round(Spring.GetUnitHeight(displayUnitID),0))

		if unitMetalmaker[displayUnitDefID] then
			addTextInfo('convertorEnergyCapacity', unitMetalmaker[displayUnitDefID][1])
			addTextInfo('convertorMetal', unitMetalmaker[displayUnitDefID][1] / (1 / unitMetalmaker[displayUnitDefID][2]))
		end

		local text, numLines = font:WrapText(text, ((backgroundRect[3] - bgpadding - bgpadding - bgpadding - bgpadding) - (backgroundRect[1] + contentPaddingLeft)) * (loadedFontSize / infoFontsize))

		-- prune number of lines
		local lines = lines(text)
		text = ''
		for i, line in pairs(lines) do
			text = text .. line
			-- only 4 fully fit, but showing 5, so the top part of text shows and indicates there is more to see somehow
			if i == 5 then
				break
			end
			text = text .. '\n'
		end
		lines = nil

		-- display unit(def) info text
		font:Begin()
		font:Print(text, customInfoArea[1] + contentPadding, customInfoArea[4] - contentPadding - (infoFontsize * 0.55), infoFontsize, "o")
		font:End()

	end
end

local function drawEngineTooltip()
	--local labelColor = '\255\205\205\205'
	--local valueColor = '\255\255\255\255'

	-- display default plaintext engine tooltip
	local fontSize = (height * vsy * 0.11) * (0.95 - ((1 - ui_scale) * 0.5))
	local text, numLines = font:WrapText(currentTooltip, contentWidth * (loadedFontSize / fontSize))
	font:Begin()
	font:Print(text, backgroundRect[1] + contentPadding, backgroundRect[4] - contentPadding - (fontSize * 0.8), fontSize, "o")
	font:End()
end

local function drawInfo()
	RectRound(backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4], bgpadding * 1.6, 1, (WG['buildpower'] and 0 or 1), 1, 1, { 0.05, 0.05, 0.05, ui_opacity }, { 0, 0, 0, ui_opacity })
	RectRound(backgroundRect[1], backgroundRect[2] + bgpadding, backgroundRect[3] - bgpadding, backgroundRect[4] - bgpadding, bgpadding, 0, (WG['buildpower'] and 0 or 1), 1, 0, { 0.3, 0.3, 0.3, ui_opacity * 0.1 }, { 1, 1, 1, ui_opacity * 0.1 })

	-- gloss
	glBlending(GL_SRC_ALPHA, GL_ONE)
	RectRound(backgroundRect[1], backgroundRect[4] - ((backgroundRect[4] - backgroundRect[2]) * 0.16), backgroundRect[3] - bgpadding, backgroundRect[4] - bgpadding, bgpadding, 0, (WG['buildpower'] and 0 or 1), 0, 0, { 1, 1, 1, 0.01 * glossMult }, { 1, 1, 1, 0.05 * glossMult })
	RectRound(backgroundRect[1], backgroundRect[2], backgroundRect[3] - bgpadding, backgroundRect[2] + ((backgroundRect[4] - backgroundRect[2]) * 0.15), bgpadding, 0, 0, 0, 0, { 1, 1, 1, 0.02 * glossMult }, { 1, 1, 1, 0 })
	RectRound(backgroundRect[1], backgroundRect[4] - ((backgroundRect[4] - backgroundRect[2]) * 0.4), backgroundRect[3] - bgpadding, backgroundRect[4] - bgpadding, bgpadding, 0, (WG['buildpower'] and 0 or 1), 0, 0, { 1, 1, 1, 0 }, { 1, 1, 1, 0.07 })
	glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

	contentPadding = (height * vsy * 0.075) * (0.95 - ((1 - ui_scale) * 0.5))
	contentWidth = backgroundRect[3] - backgroundRect[1] - contentPadding - contentPadding

	if displayMode == 'selection' then
		drawSelection()
	elseif displayMode ~= 'text' and displayUnitDefID then
		drawUnitInfo()
	else
		drawEngineTooltip()
	end
end

function widget:RecvLuaMsg(msg, playerID)
	if msg:sub(1, 18) == 'LobbyOverlayActive' then
		chobbyInterface = (msg:sub(1, 19) == 'LobbyOverlayActive1')
	end
end

local function LeftMouseButton(unitDefID, unitTable)
	local alt, ctrl, meta, shift = spGetModKeyState()
	local acted = false
	if not ctrl then
		-- select units of icon type
		if alt or meta then
			acted = true
			spSelectUnitArray({ unitTable[1] })  -- only 1
		else
			acted = true
			spSelectUnitArray(unitTable)
		end
	else
		-- select all units of the icon type
		local sorted = spGetTeamUnitsSorted(myTeamID)
		local units = sorted[unitDefID]
		if units then
			acted = true
			spSelectUnitArray(units, shift)
		end
	end
	if acted then
		Spring.PlaySoundFile(sound_button, 0.5, 'ui')
	end
end

local function MiddleMouseButton(unitDefID, unitTable)
	local alt, ctrl, meta, shift = spGetModKeyState()
	-- center the view
	if ctrl then
		-- center the view on the entire selection
		Spring.SendCommands({ "viewselection" })
	else
		-- center the view on this type on unit
		spSelectUnitArray(unitTable)
		Spring.SendCommands({ "viewselection" })
		spSelectUnitArray(selectedUnits)
	end
	Spring.PlaySoundFile(sound_button, 0.5, 'ui')
end

local function RightMouseButton(unitDefID, unitTable)
	local alt, ctrl, meta, shift = spGetModKeyState()
	-- remove selected units of icon type
	local map = {}
	for i = 1, #selectedUnits do
		map[selectedUnits[i]] = true
	end
	for _, uid in ipairs(unitTable) do
		map[uid] = nil
		if ctrl then
			break
		end -- only remove 1 unit
	end
	spSelectUnitMap(map)
	Spring.PlaySoundFile(sound_button2, 0.5, 'ui')
end

function widget:MousePress(x, y, button)
	if Spring.IsGUIHidden() then
		return
	end
	if IsOnRect(x, y, backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4]) then
		return true
	end
end

function widget:MouseRelease(x, y, button)
	if Spring.IsGUIHidden() then
		return
	end
	if displayMode and displayMode == 'selection' and customInfoArea and IsOnRect(x, y, customInfoArea[1], customInfoArea[2], customInfoArea[3], customInfoArea[4]) then
		if selectionCells and selectionCells[1] and cellRect then
			for cellID, unitDefID in pairs(selectionCells) do
				if cellRect[cellID] and IsOnRect(x, y, cellRect[cellID][1], cellRect[cellID][2], cellRect[cellID][3], cellRect[cellID][4]) then
					-- apply selection
					--if b then
					--  local alt, ctrl, meta, shift = spGetModKeyState()
					--  -- select all units of the icon type
					--  local sorted = spGetTeamUnitsSorted(myTeamID)
					--  local units = sorted[unitDefID]
					--  local acted = false
					--  if units then
					--    acted = true
					--    spSelectUnitArray(units, shift)
					--  end
					--  if acted then
					--    Spring.PlaySoundFile(sound_button, 0.75, 'ui')
					--  end
					--end


					local unitTable = nil
					local index = 0
					for udid, uTable in pairs(selUnitsSorted) do
						if udid == unitDefID then
							unitTable = uTable
							break
						end
						index = index + 1
					end
					if unitTable == nil then
						return -1
					end

					if button == 1 then
						LeftMouseButton(unitDefID, unitTable)
					elseif button == 2 then
						MiddleMouseButton(unitDefID, unitTable)
					elseif button == 3 then
						RightMouseButton(unitDefID, unitTable)
					end
					return -1
				end
			end
		end
	end

	if WG['smartselect'] and not WG['smartselect'].updateSelection then
		return
	end
	if (not activePress) then
		return -1
	end
	activePress = false
	local icon = MouseOverIcon(x, y)

	local units = spGetSelectedUnitsSorted()
	if (units.n ~= unitTypes) then
		return -1  -- discard this click
	end
	units.n = nil

	local unitDefID = -1
	local unitTable = nil
	local index = 0
	for udid, uTable in pairs(units) do
		if (index == icon) then
			unitDefID = udid
			unitTable = uTable
			break
		end
		index = index + 1
	end
	if (unitTable == nil) then
		return -1
	end

	local alt, ctrl, meta, shift = spGetModKeyState()

	if (button == 1) then
		LeftMouseButton(unitDefID, unitTable)
	elseif (button == 2) then
		MiddleMouseButton(unitDefID, unitTable)
	elseif (button == 3) then
		RightMouseButton(unitDefID, unitTable)
	end

	return -1
end

function widget:DrawScreen()
	if chobbyInterface then
		return
	end

	if ViewResizeUpdate then
		ViewResizeUpdate = nil
		refreshUnitIconCache()
	end
	local x, y, b, b2, b3 = spGetMouseState()

	if doUpdate or (doUpdateClock and os_clock() >= doUpdateClock) then
		doUpdateClock = nil
		clear()
		doUpdate = nil
		lastUpdateClock = os_clock()
	end

	if not dlistInfo then
		dlistInfo = gl.CreateList(function()
			drawInfo()
		end)
	end
	gl.CallList(dlistInfo)



	-- widget hovered
	if IsOnRect(x, y, backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4]) then

		-- selection grid
		if displayMode == 'selection' and selectionCells and selectionCells[1] and cellRect then

			local tooltipTitleColor = '\255\205\255\205'
			local tooltipTextColor = '\255\255\255\255'
			local tooltipLabelTextColor = '\255\200\200\200'
			local tooltipDarkTextColor = '\255\133\133\133'
			local tooltipValueColor = '\255\255\245\175'

			local cellHovered
			for cellID, unitDefID in pairs(selectionCells) do
				if cellRect[cellID] and IsOnRect(x, y, cellRect[cellID][1], cellRect[cellID][2], cellRect[cellID][3], cellRect[cellID][4]) then

					local cellZoom = hoverCellZoom
					local color = { 1, 1, 1 }
					if b then
						cellZoom = clickCellZoom
						color = { 0.36, 0.8, 0.3 }
					elseif b2 then
						cellZoom = clickCellZoom
						color = { 1, 0.66, 0.1 }
					elseif b3 then
						cellZoom = rightclickCellZoom
						color = { 1, 0.1, 0.1 }
					end
					cellZoom = cellZoom + math_min(0.33 * cellZoom * ((gridHeight / cellsize) - 2), 0.15) -- add extra zoom when small icons
					drawSelectionCell(cellID, selectionCells[cellID], texOffset + cellZoom, { color[1], color[2], color[3], 0.1 })
					-- highlight
					glBlending(GL_SRC_ALPHA, GL_ONE)
					if b or b2 or b3 then
						RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][4], cellPadding * 0.9, 1, 1, 1, 1, { color[1], color[2], color[3], (b or b2 or b3) and 0.4 or 0.2 }, { color[1], color[2], color[3], (b or b2 or b3) and 0.07 or 0.04 })
					end
					-- gloss
					RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][4] - cellPadding - ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.66), cellRect[cellID][3], cellRect[cellID][4], cellPadding * 0.9, 1, 1, 0, 0, { color[1], color[2], color[3], 0 }, { color[1], color[2], color[3], (b or b2 or b3) and 0.18 or 0.13 })
					RectRound(cellRect[cellID][1] + cellPadding, cellRect[cellID][2] + cellPadding, cellRect[cellID][3], cellRect[cellID][2] + cellPadding + ((cellRect[cellID][4] - cellRect[cellID][2]) * 0.18), cellPadding * 0.9, 0, 0, 1, 1, { color[1], color[2], color[3], (b or b2 or b3) and 0.15 or 0.1 }, { color[1], color[2], color[3], 0 })
					glBlending(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
					---- bottom darkening
					--RectRound(cellRect[cellID][1]+cellPadding, cellRect[cellID][2]+cellPadding, cellRect[cellID][3], cellRect[cellID][2]+cellPadding+((cellRect[cellID][4]-cellRect[cellID][2])*0.33), cellPadding*0.9, 0,0,1,1,{0,0,0,(b or b2 or b3) and 0.33 or 0.25}, {0,0,0,0})
					cellHovered = cellID
					break
				end
			end

			if WG['tooltip'] then
				local statsIndent = '  '
				local stats = ''
				local cells = cellHovered and { [cellHovered] = selectionCells[cellHovered] } or selectionCells
				-- description
				if cellHovered then
					local text, numLines = font:WrapText(unitTooltip[selectionCells[cellHovered]], (backgroundRect[3] - backgroundRect[1]) * (loadedFontSize / 16))
					stats = stats .. statsIndent .. tooltipTextColor .. text .. '\n\n'
				end
				local text
				stats = getSelectionTotals(cells)
				if cellHovered then
					text = tooltipTitleColor .. unitHumanName[selectionCells[cellHovered]] .. tooltipLabelTextColor .. (selUnitsCounts[selectionCells[cellHovered]] > 1 and ' x ' .. tooltipTextColor .. selUnitsCounts[selectionCells[cellHovered]] or '') .. stats
				else
					text = tooltipTitleColor .. "Selected units: " .. tooltipTextColor .. #selectedUnits .. stats .. "\n " .. (stats == '' and '' or '\n') .. selectionHowto
				end

				WG['tooltip'].ShowTooltip('info', text)
			end
		end
	end
end

function checkChanges()
	local x, y, b, b2, b3 = spGetMouseState()
	lastType = hoverType
	lastHoverData = hoverData
	hoverType, hoverData = spTraceScreenRay(x, y)
	if hoverType == 'unit' or hoverType == 'feature' then
		if lastHoverData ~= hoverData then
			lastHoverDataClock = os_clock()
		end
	else
		lastHoverDataClock = os_clock()
	end
	prevDisplayMode = displayMode
	prevDisplayUnitDefID = displayUnitDefID
	prevDisplayUnitID = displayUnitID

	-- determine what mode to display
	displayMode = 'text'
	displayUnitID = nil
	displayUnitDefID = nil

	-- buildmenu unitdef
	if WG['buildmenu'] and (WG['buildmenu'].hoverID or WG['buildmenu'].selectedID) then
		displayMode = 'unitdef'
		displayUnitDefID = WG['buildmenu'].hoverID or WG['buildmenu'].selectedID

		-- hovered unit
	elseif not IsOnRect(x, y, backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4]) and hoverType and hoverType == 'unit' and os_clock() - lastHoverDataClock > 0.08 then
		-- add small hover delay against eplilepsy
		displayMode = 'unit'
		displayUnitID = hoverData
		displayUnitDefID = spGetUnitDefID(displayUnitID)
		if lastUpdateClock + 0.6 < os_clock() then
			-- unit stats could have changed meanwhile
			doUpdate = true
		end

		-- hovered feature
	elseif not IsOnRect(x, y, backgroundRect[1], backgroundRect[2], backgroundRect[3], backgroundRect[4]) and hoverType and hoverType == 'feature' and os_clock() - lastHoverDataClock > 0.08 then
		-- add small hover delay against eplilepsy
		--displayMode = 'feature'
		--displayFeatureID = hoverData
		--displayFeatureDefID = spGetUnitDefID(displayUnitID)
		local newTooltip = spGetCurrentTooltip()
		if newTooltip ~= currentTooltip then
			currentTooltip = newTooltip
			doUpdate = true
		end

		-- selected unit
	elseif SelectedUnitsCount == 1 then
		displayMode = 'unit'
		displayUnitID = selectedUnits[1]
		displayUnitDefID = spGetUnitDefID(selectedUnits[1])
		if lastUpdateClock + 0.6 < os_clock() then
			-- unit stats could have changed meanwhile
			doUpdate = true
		end

		-- selection
	elseif SelectedUnitsCount > 1 then
		displayMode = 'selection'

		-- tooltip text
	else
		local newTooltip = spGetCurrentTooltip()
		if newTooltip ~= currentTooltip then
			currentTooltip = newTooltip
			doUpdate = true
		end
	end

	-- display changed
	if prevDisplayMode ~= displayMode or prevDisplayUnitDefID ~= displayUnitDefID or prevDisplayUnitID ~= displayUnitID then
		doUpdate = true
	end
end

function widget:SelectionChanged(sel)
	if SelectedUnitsCount ~= 0 and spGetSelectedUnitsCount() == 0 then
		doUpdate = true
		SelectedUnitsCount = 0
		selectedUnits = {}
	end
	if spGetSelectedUnitsCount() > 0 then
		SelectedUnitsCount = spGetSelectedUnitsCount()
		selectedUnits = sel
		if not doUpdateClock then
			doUpdateClock = os_clock() + 0.05  -- delay to save some performance
		end
	end
end

function widget:GetConfigData()
	--save config
	return {
		alternativeUnitpics = alternativeUnitpics,
	}
end

function widget:SetConfigData(data)
	--load config
	if data.alternativeUnitpics ~= nil then
		alternativeUnitpics = data.alternativeUnitpics
	end
end
