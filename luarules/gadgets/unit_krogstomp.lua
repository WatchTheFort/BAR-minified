function gadget:GetInfo()
  return {
    name      = "KrogSteps Damages",
    desc      = "Controls damages done by Krog's footsteps",
    author    = "Doo",
    date      = "July 2017",
    license   = "Whatever you want, lua will make it",
    layer     = 0,
    enabled   = true
  }
end

if (not gadgetHandler:IsSyncedCode()) then return end
-- Exhaustive list of all units that will take damages from krog's footsteps (must be completed)
local StompedUnits = {
    [UnitDefNames["corfav"].id] = true,
    [UnitDefNames["armfav"].id] = true,
    [UnitDefNames["corak"].id] = true,
    [UnitDefNames["armpw"].id] = true,
    [UnitDefNames["armflea"].id] = true,
}

function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, projectileID, attackerID, attackerDefID, attackerTeam)
	-- debris damage occurs when weaponDefID == -1
	-- in this case attackerID and attackerDefID are nil
	if WeaponDefs[weaponDefID] then
	if WeaponDefs[weaponDefID].name == "corkrog_krogkick" then 
	Spring.Echo("ok")
		if (unitTeam) and (attackerTeam) then
		if Spring.AreTeamsAllied(unitTeam, attackerTeam) == false then

			if StompedUnits[unitDefID] then	
				return 2000
			else
				return 0
			end
		else
			return 0
		end
		end		
    end
	end
	return damage, nil
end