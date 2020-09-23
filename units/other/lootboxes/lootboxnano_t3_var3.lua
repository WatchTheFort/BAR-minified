unitName = "lootboxnano_t3_var3"
humanName = "Specialist NanoTurret T3"
sizeMultiplier = 2.35
collisionVolumeScales = "74 75 74"

local Rmodel = math.random()
if Rmodel < 0.5 then
	objectName = "lootboxes/lootboxnanoarmT3.s3o"
	script = "lootboxes/lootboxnanoarm.cob"
else
	objectName = "lootboxes/lootboxnanocorT3.s3o"
	script = "lootboxes/lootboxnanocor.cob"
end

VFS.Include("unitbasedefs/lootboxes/lootboxnanounitlists.lua")

buildlistRNG = {}
for a = 1,6 do
	local choosenOne = buildPossibleOptionsT3[math.ceil(#buildPossibleOptionsT3*math.random())]
	buildlistRNG[a] = choosenOne
end


VFS.Include("unitbasedefs/lootboxes/lootboxnano.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------