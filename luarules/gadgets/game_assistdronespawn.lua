local droneSpawnEnabled = false
local PvEEnabled = Spring.Utilities.Gametype.IsPvE()
if Spring.GetModOptions().assistdronesenabled == "enabled" or (Spring.GetModOptions().assistdronesenabled == "pve_only" and PvEEnabled) then
	droneSpawnEnabled = true
end
local droneCount = Spring.GetModOptions().assistdronescount

local UDN = UnitDefNames

function gadget:GetInfo()
    return {
      name      = "assistdrone spawn",
      desc      = "123",
      author    = "Damgam",
      date      = "2021",
	  license   = "GNU GPL, v2 or later",
      layer     = -100,
      enabled   = droneSpawnEnabled,
    }
end

if not gadgetHandler:IsSyncedCode() then
	return false
end

local drones = {}
if Spring.GetModOptions().assistdronesair == true then
    drones = {
        [UDN.armcom.id] = "armassistdrone",
        [UDN.corcom.id] = "corassistdrone",
        [UDN.legcom.id] = "legassistdrone",
    }
else
    drones = {
        [UDN.armcom.id] = "armassistdrone_land",
        [UDN.corcom.id] = "corassistdrone_land",
        [UDN.legcom.id] = "legassistdrone_land",
    }
end


function SpawnAssistDrones(unitID, unitDefID, unitTeam)
	local posx, posy, posz = Spring.GetUnitPosition(unitID)
    local droneunit = drones[unitDefID]
	for i = 1,droneCount do
		local posx = posx+math.random(-64,64)
		local posz = posz+math.random(-64,64)
		local droneID = Spring.CreateUnit(droneunit, posx, posy+10, posz, 0, unitTeam)
        if droneID then
            Spring.SpawnCEG("scav-spawnexplo", posx, posy+10, posz,0,0,0)
            Spring.GiveOrderToUnit(droneID, CMD.GUARD, unitID, {})
        end
	end
end

local commandersList = {}
function gadget:UnitCreated(unitID, unitDefID, unitTeam, builderID)
    if drones[unitDefID] and not builderID then
        commandersList[unitID] = true
    end
end

function gadget:UnitDestroyed(unitID, unitDefID, unitTeam) 
    if commandersList[unitID] then 
        commandersList[unitID] = nil 
    end
end

function gadget:GameFrame(n)
    if n == 90 then
        local units = Spring.GetAllUnits()
        for i = 1,#units do
            if commandersList[units[i]] then
                local unitID = units[i]
                local unitDefID = Spring.GetUnitDefID(unitID)
                local unitTeam = Spring.GetUnitTeam(unitID)
                SpawnAssistDrones(unitID, unitDefID, unitTeam)
            end
        end
    end
    if n > 90 and n%1800 == 0 then -- Drone respawn
        for comID, _ in pairs(commandersList) do
            local comDefID = Spring.GetUnitDefID(comID)
            local comTeam = Spring.GetUnitTeam(comID)
            local droneName = drones[comDefID]
            local droneDefID = UnitDefNames[droneName].id
            if Spring.GetTeamUnitDefCount(comTeam, droneDefID) < droneCount then
                local posx, posy, posz = Spring.GetUnitPosition(comID)
                posx = posx+math.random(-64,64)
                posz = posz+math.random(-64,64)
                local droneID = Spring.CreateUnit(droneName, posx, posy+10, posz, 0, comTeam)
                if droneID then
                    Spring.SpawnCEG("scav-spawnexplo", posx, posy+10, posz,0,0,0)
                    Spring.GiveOrderToUnit(droneID, CMD.GUARD, comID, {})
                end
            end
        end
    end
end
