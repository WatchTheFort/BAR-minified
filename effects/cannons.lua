-- cannon particles

local definitions = {
	["cannonblaze-small"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.65 0.3 0.01   0.9 0.6 0.2 0.01   0.9 0.3 0.1 0.01   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = [[-1.9 r0.2]],
                --pos                = [[-4, 0, 0]],
                sidetexture        = [[shot]],
                size               = 5.9,
                sizegrowth         = [[-0.2 r0.1]],
                ttl                = 1,
                useairlos          = true,
            },
        },
    	sparks = {
			air                = true,
			class              = [[CSimpleParticleSystem]],
			count              = 1,
			ground             = true,
			water              = true,
			underwater         = true,
			properties = {
				airdrag            = 0.85,
				colormap           = [[0.9 0.85 0.77 0.017   0.8 0.55 0.3 0.011   0 0 0 0]],
				directional        = true,
				emitrot            = 25,
				emitrotspread      = 30,
				emitvector         = [[0, 1, 0]],
				gravity            = [[0, -0.15, 0]],
				numparticles       = 1,
				particlelife       = 3,
				particlelifespread = 5,
				particlesize       = 13,
				particlesizespread = 10,
				particlespeed      = 1.2,
				particlespeedspread = 1.2,
				pos                = [[0, 0, 0]],
				sizegrowth         = 0.77,
				sizemod            = 0.8,
				texture            = [[gunshotglow]],
				useairlos          = true,
      		},
    	},
    	fireback = {
			air                = true,
			class              = [[CSimpleParticleSystem]],
			count              = 1,
			ground             = true,
			water              = true,
			underwater         = false,
			properties = {
		        airdrag            = 0.90,
		        colormap           = [[0.9 0.50 0.10 0.01   0.95 0.65 0.4 0.019   0.95 0.45 0.08 0.006   0.05 0.05 0.05 0.005    0 0 0 0]],
		        directional        = true,
		        emitrot            = 20,
		        emitrotspread      = 30,
		        emitvector         = [[0, 1, 0]],
		        gravity            = [[0, -0.15, 0]],
		        numparticles       = 1,
		        particlelife       = 3,
		        particlelifespread = 5,
		        particlesize       = 3.0,
		        particlesizespread = 0,
		        particlespeed      = 0.5,
		        particlespeedspread = 0.5,
		        pos                = [[-4, -1, 0]],
		        sizegrowth         = -0.8,
		        sizemod            = 1,
		        texture            = [[dirt]],
		        useairlos          = true,
	        },
	    },

	},
	["arty-fast"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.65 0.3 0.006   0.9 0.6 0.2 0.005   0.9 0.3 0.1 0.004   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = -3.2,
                sidetexture        = [[trail]],
                size               = 2.4,
                sizegrowth         = -0.05,
                ttl                = 4,
                useairlos          = true,
            },
        },
	-- traillight = {
	--         air                = true,
	--         class              = [[CBitmapMuzzleFlame]],
	--         count              = 1,
	--         ground             = true,
	--         underwater         = 1,
	--         water              = true,
	--         properties = {
	--             colormap           = [[0.7 0.40 0.08 0.008   0.6 0.35 0.32 0.009   0.5 0.28 0.08 0.004   0.05 0.05 0.05 0.003    0 0 0 0]],
	--             dir                = [[dir]],
	--             frontoffset        = 0,
	--             fronttexture       = [[trans]],
	--             length             = -1.5,
	--             sidetexture        = [[shot]],
	--             size               = 2.0,
	--             sizegrowth         = -0.3,
	--             ttl                = 3,
 --        	},
 --    	},
	},
	["arty-small"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.75 0.4 0.006   0.8 0.70 0.3 0.005   0.8 0.5 0.1 0.005   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = -2.8,
                sidetexture        = [[trail]],
                size               = 2.0,
                sizegrowth         = -0.15,
                ttl                = 6,
                useairlos          = true,
            },
        },
    -- traillight = {
	   --      air                = true,
	   --      class              = [[CBitmapMuzzleFlame]],
	   --      count              = 1,
	   --      ground             = true,
	   --      underwater         = 1,
	   --      water              = true,
	   --      properties = {
	   --          colormap           = [[0.7 0.40 0.08 0.008   0.6 0.35 0.32 0.009  0.5 0.28 0.08 0.004   0.05 0.05 0.05 0.003    0 0 0 0]],
	   --          dir                = [[dir]],
	   --          frontoffset        = 0,
	   --          fronttexture       = [[trans]],
	   --          length             = -5,
	   --          sidetexture        = [[shot]],
	   --          size               = 2.7,
	   --          sizegrowth         = 0,
	   --          ttl                = 3,
    --     	},
    -- 	},
	},
    ["arty-medium"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.65 0.3 0.006   0.9 0.6 0.2 0.005   0.8 0.3 0.1 0.004   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0.12,
                fronttexture       = [[trans]],
                length             = -3.5,
                sidetexture        = [[trail]],
                size               = 3.4,
                sizegrowth         = -0.1,
                ttl                = 5,
                useairlos          = true,
        },
    },
    -- traillight = {
	   --      air                = true,
	   --      class              = [[CBitmapMuzzleFlame]],
	   --      count              = 1,
	   --      ground             = true,
	   --      underwater         = 1,
	   --      water              = true,
	   --      properties = {
	   --          colormap           = [[0.7 0.40 0.08 0.008   0.6 0.35 0.32 0.009   0.5 0.28 0.08 0.004   0.05 0.05 0.05 0.003    0 0 0 0]],
	   --          dir                = [[dir]],
	   --          frontoffset        = 0,
	   --          fronttexture       = [[trans]],
	   --          length             = -4.7,
	   --          --pos                = [[0, -1, 0]],
	   --          sidetexture        = [[shot]],
	   --          size               = 3.0,
	   --          sizegrowth         = 0,
	   --          ttl                = 3,
    --    		},
   	-- 	},
	},
	["arty-heavy"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.65 0.3 0.005   0.9 0.6 0.2 0.004   0.9 0.3 0.1 0.004   0 0 0 0.001]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = -4.0,
                sidetexture        = [[trail]],
                size               = 3.9,
                sizegrowth         = -0.1,
                ttl                = 9,
                useairlos          = true,
            },
        },
        sparks = {
			air                = true,
			class              = [[CSimpleParticleSystem]],
			count              = 1,
			ground             = true,
			water              = true,
			underwater         = true,
			properties = {
				airdrag            = 0.85,
				colormap           = [[0.9 0.85 0.77 0.017   0.8 0.55 0.3 0.011   0 0 0 0]],
				directional        = true,
				emitrot            = 25,
				emitrotspread      = 30,
				emitvector         = [[0, 1, 0]],
				gravity            = [[0, -0.15, 0]],
				numparticles       = 2,
				particlelife       = 5,
				particlelifespread = 7,
				particlesize       = 18,
				particlesizespread = 24,
				particlespeed      = 1.1,
				particlespeedspread = 1.5,
				pos                = [[0, 0, 0]],
				sizegrowth         = -0.3,
				sizemod            = 0.7,
				texture            = [[gunshotglow]],
				useairlos          = true,
      		},
    	},
    -- traillight = {
	   --      air                = true,
	   --      class              = [[CBitmapMuzzleFlame]],
	   --      count              = 1,
	   --      ground             = true,
	   --      underwater         = 1,
	   --      water              = true,
	   --      properties = {
	   --          colormap           = [[0.7 0.40 0.08 0.008   0.6 0.35 0.32 0.009   0.5 0.28 0.08 0.004   0.05 0.05 0.05 0.003    0 0 0 0]],
	   --          dir                = [[dir]],
	   --          frontoffset        = 0,
	   --          fronttexture       = [[trans]],
	   --          length             = -6.0,
	   --          sidetexture        = [[shot]],
	   --          size               = 5.9,
	   --          sizegrowth         = -0.3,
	   --          ttl                = 3,
    --    		},
   	-- 	},
	},
	["arty-huge"] = {
		flame = {
            air                = true,
            class              = [[CBitmapMuzzleFlame]],
            count              = 1,
            ground             = true,
            underwater         = true,
            water              = true,
            properties = {
                colormap           = [[0.9 0.65 0.3 0.01   0.9 0.6 0.2 0.01   0.9 0.3 0.1 0.01   0 0 0 0.01]],
                dir                = [[dir]],
                frontoffset        = 0,
                fronttexture       = [[none]],
                length             = -3.9,
                sidetexture        = [[shot]],
                size               = 5.2,
                sizegrowth         = -0.15,
                ttl                = 12,
                useairlos          = true,
            },
        },
        sparks = {
			air                = true,
			class              = [[CSimpleParticleSystem]],
			count              = 1,
			ground             = true,
			water              = true,
			underwater         = true,
			properties = {
				airdrag            = 0.87,
				colormap           = [[0.9 0.85 0.77 0.017   0.8 0.55 0.3 0.011   0 0 0 0]],
				directional        = true,
				emitrot            = 25,
				emitrotspread      = 30,
				emitvector         = [[0, 1, 0]],
				gravity            = [[0, -0.15, 0]],
				numparticles       = 3,
				particlelife       = 6,
				particlelifespread = 8,
				particlesize       = 30,
				particlesizespread = 30,
				particlespeed      = 1.5,
				particlespeedspread = 2.0,
				pos                = [[0, 0, 0]],
				sizegrowth         = -0.3,
				sizemod            = 0.8,
				texture            = [[gunshotglow]],
				useairlos          = true,
      		},
    	},
 --    traillight = {
	--         air                = true,
	--         class              = [[CBitmapMuzzleFlame]],
	--         count              = 1,
	--         ground             = true,
	--         underwater         = 1,
	--         water              = true,
	--         properties = {
	--             colormap           = [[0.7 0.40 0.08 0.008   0.6 0.35 0.32 0.009   0.5 0.28 0.08 0.004   0.05 0.05 0.05 0.003    0 0 0 0]],
	--             dir                = [[dir]],
	--             frontoffset        = 0,
	--             fronttexture       = [[trans]],
	--             length             = -6.0,
	--             sidetexture        = [[shot]],
	--             size               = 7.9,
	--             sizegrowth         = -0.3,
	--             ttl                = 3,
 --       		},
 --   		},
	},
}

function tableMerge(t1, t2)
    for k,v in pairs(t2) do
    	if type(v) == "table" then
    		if type(t1[k] or false) == "table" then
    			tableMerge(t1[k] or {}, t2[k] or {})
    		else
    			t1[k] = v
    		end
    	else
    		t1[k] = v
    	end
    end
    return t1
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- add purple scavenger variants
local scavengerDefs = {}
for k,v in pairs(definitions) do
  scavengerDefs[k..'-purple'] = deepcopy(definitions[k])
end

local purpleEffects = {
  flame = {
    properties = {
      colormap           = [[0.8 0.5 1 0.01   0.65 0.2 0.9 0.01   0.35 0.07 0.6 0.01   0 0 0 0.01]],
    },
  },
  -- fireback = {
  --   properties = {
  --     colormap           = [[0.8 0.45 1 0.01   0.8 0.45 1 0.019   0.65 0.2 0.9 0.006   0.05 0.05 0.05 0.005    0 0 0 0]],
  --   },
  -- },
  -- traillight = {
  --   properties = {
  --     colormap           = [[0.8 0.45 1 0.01   0.8 0.45 1 0.019   0.65 0.2 0.9 0.006   0.05 0.05 0.05 0.005    0 0 0 0]],
  --   },
  -- },
}
for defName, def in pairs(scavengerDefs) do
  for effect, effectParams in pairs(purpleEffects) do
    if scavengerDefs[defName][effect] then
      for param, paramValue in pairs(effectParams) do
        if scavengerDefs[defName][effect][param] then
          if param == 'properties' then
            for property,propertyValue in pairs(paramValue) do
              if scavengerDefs[defName][effect][param][property] then
                scavengerDefs[defName][effect][param][property] = propertyValue
              end
            end
          else
            scavengerDefs[defName][effect][param] = paramValue
          end
        end
      end
    end
  end
end

definitions = tableMerge(definitions, scavengerDefs)

return definitions
