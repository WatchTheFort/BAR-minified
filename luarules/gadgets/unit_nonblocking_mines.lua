function gadget:GetInfo()
	return {
		name = 'Nonblocking mines',
		desc = 'For 92.+ mines need to be manually unblocked. But other units cannot be built on them.',
		author = 'Beherith',
		date = 'Jan 2013',
		license = 'GNU GPL, v2 or later',
		layer = 0,
		enabled = true
	}
end

if not gadgetHandler:IsSyncedCode() then
	return false
end

--local nummines = 0
local mines = {}
local isMine = {}
for udid, ud in pairs(UnitDefs) do
	if ud.customParams and ud.customParams.detonaterange then
		isMine[udid] = true
	end
end

local spSetUnitBlocking = Spring.SetUnitBlocking
local spGetUnitPosition = Spring.GetUnitPosition
local spGetMyTeamID = Spring.GetMyTeamID

function gadget:UnitCreated(uID, uDefID, uTeam)
	if isMine[uDefID] then
		local x, _, z = Spring.GetUnitPosition(uID)
		mines[uID] = { x, z }
		spSetUnitBlocking(uID, false, false, false)
	end
end

function gadget:UnitDestroyed(uID, uDefID, uTeam)
	if isMine[uDefID] and mines[uID] then
		mines[uID] = nil
		spSetUnitBlocking(uID, false, false, false)
	end
end

function gadget:AllowUnitCreation(unitDefID, builderID, builderTeam, x, y, z)
	if x and y and z then
		local footprintx = UnitDefs[unitDefID]['xsize'] * 4 + 8 --add 8 for the mines size too
		local footprintz = UnitDefs[unitDefID]['zsize'] * 4 + 8  --size is 2x footprint in engine
		for mine, pos in pairs(mines) do
			if math.abs(x - pos[1]) < footprintx and math.abs(z - pos[2]) < footprintz then
				-- if builderTeam ~= spGetMyTeamID() then --no getmyteamid in synced code :(
				-- local udef = UnitDefs[builderID]
				-- Spring.Echo( udef.humanName  .. ": Can't build on top of mines!" )
				-- end

				return false
			end
		end
	end
	return true
end
