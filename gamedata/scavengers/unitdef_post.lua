-- this file gets included in alldefs_post.lua

local scavUnit = {}
for name,uDef in pairs(UnitDefs) do
    scavUnit[#scavUnit+1] = name..'_scav'
end

local rana = math.random(3,1000)
local ranb = math.random(2,a)
local ranc = math.random(1,b)

function scav_Udef_Post(name, uDef)
	if not uDef.customparams then
		uDef.customparams = {}
	end

	-- add unit category
	uDef.category = uDef.category..' SCAVENGER'

	-- add model vertex displacement

	--local udefVertDisp = uDef.customparams.vertdisp1 or 0
	--uDef.customparams.vertdisp = 2.0 * udefVertDisp
	uDef.customparams.healthlookmod = 0.40

	-- make barrelshot purple
	if uDef.customparams.firingceg then
		if string.find(uDef.customparams.firingceg, 'barrelshot') then
			uDef.customparams.firingceg = uDef.customparams.firingceg..'-purple'
		end
	end
	if uDef.sfxtypes then
		-- make barrelshot purple
		if uDef.sfxtypes.explosiongenerators then
			for k,v in pairs(uDef.sfxtypes.explosiongenerators) do
				if string.find(v, 'barrelshot') then
					uDef.sfxtypes.explosiongenerators[k] = v..'-purple'
				end
			end
		end
		-- make deathcegs purple
		if uDef.sfxtypes.pieceexplosiongenerators then
			for k,v in pairs(uDef.sfxtypes.pieceexplosiongenerators) do
				if string.find(v, 'deathceg') then
					uDef.sfxtypes.pieceexplosiongenerators[k] = v..'-purple'
				end
			end
		end
	end
	-- make unit explosion purple
	if uDef.explodeas then
		if string.find(string.lower(uDef.explodeas), 'explosiongeneric') or
			string.find(string.lower(uDef.explodeas), 'buildingexplosiongeneric') or
			string.find(string.lower(uDef.explodeas), 'explosiont3') or
			string.find(string.lower(uDef.explodeas), 'bantha') or
			string.find(string.lower(uDef.explodeas), 'lootbox')
		then
			uDef.explodeas = uDef.explodeas..'-purple'
		end
	end
	if uDef.selfdestructas then
		if string.find(string.lower(uDef.selfdestructas), 'explosiongeneric') or
			string.find(string.lower(uDef.selfdestructas), 'buildingexplosiongeneric') or
		 	string.find(string.lower(uDef.selfdestructas), 'explosiont3') or
			string.find(string.lower(uDef.selfdestructas), 'bantha') or
			string.find(string.lower(uDef.selfdestructas), 'lootbox')
		then
			uDef.selfdestructas = uDef.selfdestructas..'-purple'
		end
	end

	-- replace buillists with _scav units
	if uDef.buildoptions then
        for k, v in pairs(uDef.buildoptions) do
            if UnitDefs[v..'_scav'] then
                uDef.buildoptions[k] = v..'_scav'
            end
        end
    end

	-- add Scavenger name prefix to wrecks
	if uDef.featuredefs then
		if uDef.featuredefs.dead then
			if uDef.featuredefs.dead.description then
				uDef.featuredefs.dead.description = "Scavenger "..uDef.featuredefs.dead.description
			end
			-- if uDef.featuredefs.dead.metal then
				-- uDef.featuredefs.dead.metal = math.ceil(uDef.featuredefs.dead.metal*0.5)
			-- end
		end
		if uDef.featuredefs.heap then
			if uDef.featuredefs.heap.description then
				uDef.featuredefs.heap.description = "Scavenger "..uDef.featuredefs.heap.description
			end
			-- if uDef.featuredefs.heap.metal then
				-- uDef.featuredefs.heap.metal = math.ceil(uDef.featuredefs.heap.metal*0.5)
			-- end
		end
	end

	-- add Scavenger name prefix to units
	if uDef.name then
		uDef.name = "Scavenger "..uDef.name
	end

	if uDef.buildcostenergy then
		uDef.buildcostenergy = math.ceil(uDef.buildcostenergy*0.85)
	end

	if uDef.buildcostmetal then
		uDef.buildcostmetal = math.ceil(uDef.buildcostmetal*0.85)
	end

	if uDef.buildtime then
		uDef.buildtime = math.ceil(uDef.buildtime*0.85)
	end
	
	if uDef.energymake then
		uDef.energymake = math.ceil(uDef.energymake*0.85)
	end

	if uDef.metalmake then
		uDef.metalmake = math.ceil(uDef.metalmake*0.85)
	end

	if uDef.maxdamage then
		uDef.maxdamage = math.ceil(uDef.maxdamage*0.85)
	end

	if uDef.maxvelocity then
		uDef.maxvelocity = uDef.maxvelocity*1.1
	end

	if uDef.radardistancejam then
		uDef.radardistancejam = math.ceil(uDef.radardistancejam*1.5)
	end

	if uDef.maxdamage then
		uDef.autoheal = math.ceil(math.sqrt(uDef.maxdamage))
		uDef.idleautoheal = math.ceil(math.sqrt(uDef.maxdamage))
	else
		uDef.autoheal = 3
		uDef.idleautoheal = 3
	end

	if uDef.turnrate then
		uDef.turnrate = uDef.turnrate*1.1
	end

	if uDef.turninplaceanglelimit then
		uDef.turninplaceanglelimit = 360
	end

	-- don't let players get scav constructors
	if uDef.buildoptions then
		--uDef.capturable = false
		if uDef.maxvelocity then
			uDef.maxvelocity = uDef.maxvelocity*2
		end
		if uDef.workertime and uDef.canmove == true then
			uDef.workertime = uDef.workertime*5
		end
	end
	
	if uDef.featuredefs then
		if uDef.featuredefs.dead then
			if uDef.featuredefs.dead.metal then
				uDef.featuredefs.dead.metal = uDef.featuredefs.dead.metal * 5
			end
		end
		if uDef.featuredefs.heap then
			if uDef.featuredefs.heap.metal then
				uDef.featuredefs.heap.metal = uDef.featuredefs.heap.metal * 5
			end
		end
	end
	
	-- if uDef.weapondefs then
		-- for weaponDefName, weaponDef in pairs (uDef.weapondefs) do
			-- for category, damage in pairs (weaponDef.damage) do
				-- uDef.weapondefs[weaponDefName].damage[category] = math.floor((damage * 2))
			-- end
		-- end
	-- end

	if uDef.customparams.fighter then
		uDef.maxvelocity = uDef.maxvelocity*2
	end

	return uDef

end
