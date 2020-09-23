
local definitions = {
    ["fusexpl"] = {
        centerflare = {
            air                = true,
            class              = [[CHeatCloudProjectile]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                heat               = 11,
                heatfalloff        = 0.8,
                maxheat            = 20,
                pos                = [[r-10 r10, 50, r-10 r10]],
                size               = 8,
                sizegrowth         = 18,
                speed              = [[0, 0, 0]],
                texture            = [[orangenovaexplo]],
                alwaysvisible      = true,
            },
        },
        pop1 = {
            class = [[CHeatCloudProjectile]],
            air=1,
            water=1,
            ground=1,
            count=2,
            properties ={
                --alwaysVisible=1,
                texture=[[explo]],
                heat = 8,
                maxheat = 10,
                heatFalloff = 0.8,
                size = 2,
                sizeGrowth = 10,
                pos = [[r-10 r10, 20, r-10 r10]],
                speed=[[0, 0, 0]],
            },
        },
        groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = false,
            ground             = true,
            water              = true,
            properties = {
                colormap           = [[1 0.7 0.3 0.45   0 0 0 0.01]],
                size               = 300,
                ttl                = 80,
                sizegrowth         = -1,
                texture            = [[groundflash]],
                alwaysvisible      = true,
            },
        },
        -- groundflash_largequick = {
        --     class              = [[CSimpleGroundFlash]],
        --     count              = 1,
        --     air                = true,
        --     ground             = true,
        --     water              = true,
        --     properties = {
        --         colormap           = [[1 0.95 0.8 0.8   0.7 0.5 0.4 0.45   0 0 0 0.01]],
        --         size               = 600,
        --         ttl                = 70,
        --         sizegrowth         = 4,
        --         texture            = [[shotgunflare]],
        --     },
        -- },
        groundflash_white = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = false,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[1 0.9 0.75 0.77   0 0 0 0.01]],
                size               = 110,
                sizegrowth         = 0,
                ttl                = 80,
                texture            = [[groundflash]],
                alwaysvisible      = true,
            },
        },
        kickedupwater = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            air                = false,
            ground             = false,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.87,
                colormap           = [[0.7 0.7 0.9 0.35 0 0 0 0.0]],
                directional        = false,
                emitrot            = 90,
                emitrotspread      = 5,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, 0.1, 0]],
                numparticles       = 100,
                particlelife       = 2,
                particlelifespread = 45,
                particlesize       = 3,
                particlesizespread = 1.5,
                particlespeed      = 12,
                particlespeedspread = 20,
                pos                = [[0, 1, 0]],
                sizegrowth         = 0.5,
                sizemod            = 1.0,
                texture            = [[wake]],
                alwaysvisible      = true,
            },
        },
        explosion_flames = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.90,
                colormap           = [[0 0 0 0   1 0.95 0.8 0.02   0.92 0.67 0.35 0.015   0.56 0.23 0.05 0.01   0.1 0.04 0.015 0.005   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 8,
                particlelife       = 26,
                particlelifespread = 12,
                particlesize       = 14,
                particlesizespread = 32,
                particlespeed      = 6,
                particlespeedspread = 7,
                pos                = [[0, 15, 0]],
                sizegrowth         = -0.4,
                sizemod            = 1,
                texture            = [[flashside2]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        explosion = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.90,
                colormap           = [[0 0 0 0   1 0.93 0.7 0.008  0.9 0.53 0.21 0.012   0.70 0.32 0.04 0.008   0.60 0.22 0.01 0.003   0.20 0.06 0.004 0.005   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 5,
                particlelife       = 20,
                particlelifespread = 15,
                particlesize       = 22,
                particlesizespread = 26,
                particlespeed      = 6,
                particlespeedspread = 7,
                pos                = [[0, 60, 0]],
                sizegrowth         = 3.1,
                sizemod            = 1,
                texture            = [[flashside1]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        shard1 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.3, 0]],
        numparticles       = [[3 r2.3]],
        particlelife       = 90,
        particlelifespread = 25,
        particlesize       = 6,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard1]],
        useairlos          = false,
      },
    },
    shard2 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = [[2 r2.2]],
        particlelife       = 70,
        particlelifespread = 18,
        particlesize       = 7,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard2]],
        useairlos          = false,
      },
    },
    shard3 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = [[2 r1.5]],
        particlelife       = 80,
        particlelifespread = 20,
        particlesize       = 8,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard3]],
        useairlos          = false,
      },
    },
        sparks = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = false,
      properties = {
        airdrag            = 0.87,
        colormap           = [[0.9 0.85 0.77 0.025   0.8 0.55 0.3 0.011   0.8 0.55 0.3 0.005   0.25 0.15 0.08 0.01   0 0 0 0]],
        directional        = true,
        emitrot            = 30,
        emitrotspread      = 40,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.01, 0]],
        numparticles       = 13,
        particlelife       = 22,
        particlelifespread = 14,
        particlesize       = 36,
        particlesizespread = 42,
        particlespeed      = 12.5,
        particlespeedspread = 10,
        pos                = [[0, 4, 0]],
        sizegrowth         = -0.11,
        sizemod            = 0.98,
        texture            = [[gunshotxl]],
        useairlos          = false,
        alwaysvisible      = true,
      },
    },
    fireglow = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = true,
      properties = {
        airdrag            = 0.9,
        colormap           = [[0.4 0.3 0.055 0.01   0 0 0 0]],
        directional        = true,
        emitrot            = 65,
        emitrotspread      = 30,
        emitvector         = [[0.0, 1, 0.0]],
        gravity            = [[0.0, 0.0, 0.0]],
        numparticles       = 5,
        particlelife       = 30,
        particlelifespread = 0,
        particlesize       = 100,
        particlesizespread = 64,
        particlespeed      = 3,
        particlespeedspread = 0,
        pos                = [[0, 2, 0]],
        sizegrowth         = -0.2,
        sizemod            = 1,
        texture            = [[explo]],
        useairlos          = false,
        alwaysvisible      = true,
      },
    },
    shockwave = {
        class              = [[CSpherePartSpawner]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            air                = true,
            properties = {
                alpha           = 0.16,
                ttl             = 10,
                expansionSpeed  = 24,
                color           = [[1.0, 0.80, 0.45]],
                alwaysvisible      = true,
            },
    },
    -- shockwave_slow = {
    --     class              = [[CSpherePartSpawner]],
    --         count              = 1,
    --         ground             = true,
    --         water              = true,
    --         underwater         = true,
    --         air                = true,
    --         properties = {
    --             alpha           = 0.05,
    --             ttl             = 110,
    --             expansionSpeed  = 8.5,
    --             color           = [[0.8, 0.55, 0.2]],
    --         },
    -- },
    shockwave_inner = {
        class              = [[CSpherePartSpawner]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            air                = true,
            properties = {
                alpha           = 0.50,
                ttl             = 32,
                expansionSpeed  = 4.1,
                color           = [[0.7, 0.50, 0.30]],
                alwaysvisible      = true,
            },
    },
        dirt = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.96,
                colormap           = [[0.04 0.03 0.01 0   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = true,
                emitrot            = 35,
                emitrotspread      = 16,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.15, 0]],
                numparticles       = 36,
                particlelife       = 100,
                particlelifespread = 45,
                particlesize       = 30,
                particlesizespread = -3.6,
                particlespeed      = 5,
                particlespeedspread = 14,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.045,
                sizemod            = 1,
                texture            = [[randomdots]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        dirt2 = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.97,
                colormap           = [[0.04 0.03 0.01 0.88   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = true,
                emitrot            = 10,
                emitrotspread      = 20,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.15, 0]],
                numparticles       = 30,
                particlelife       = 140,
                particlelifespread = 40,
                particlesize       = 3,
                particlesizespread = -1.5,
                particlespeed      = 9,
                particlespeedspread = 18,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.015,
                sizemod            = 1,
                texture            = [[bigexplosmoke]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        dirt3 = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.95,
                colormap           = [[0.03 0.02 0.01 0.6   0.1 0.07 0.033 0.76    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = false,
                emitrot            = 45,
                emitrotspread      = 16,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.10, 0]],
                numparticles       = 7,
                particlelife       = 80,
                particlelifespread = 35,
                particlesize       = 70,
                particlesizespread = -3.6,
                particlespeed      = 7,
                particlespeedspread = 3,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.2,
                sizemod            = 1,
                texture            = [[randomdots]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        clouddust = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.95,
                colormap           = [[0 0 0 0.01  0.028 0.04 0.02 0.05  0.065 0.065 0.055 0.2  0.043 0.05 0.03 0.12   0.0238 0.023 0.021 0.06  0 0 0 0.01]],
                directional        = false,
                emitrot            = 40,
                emitrotspread      = 15,
                emitvector         = [[0.5, 1, 0.5]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 25,
                particlelife       = 70,
                particlelifespread = 120,
                particlesize       = 44,
                particlesizespread = 40,
                particlespeed      = 0.3,
                particlespeedspread = 5,
                pos                = [[0, 40, 0]],
                sizegrowth         = 0.15,
                sizemod            = 1.0,
                texture            = [[bigexplosmoke]],
                alwaysvisible      = true,
            },
        },
        dustparticles = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          underwater         = true,
          water              = true,
          properties = {
                airdrag            = 0.96,
                colormap           = [[1 0.85 0.6 0.22  1 0.63 0.3 0.12  1 0.52 0.2 0.06   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0.5, 1, 0.5]],
                gravity            = [[0, -0.011, 0]],
                numparticles       = 12,
                particlelife       = 25,
                particlelifespread = 5.75,
                particlesize       = 13,
                particlesizespread = 30,
                particlespeed      = 5.0,
                particlespeedspread = 3,
                pos                = [[0, 0, 0]],
                sizegrowth         = -0.30,
                sizemod            = 1.0,
                texture            = [[randomdots]],
                alwaysvisible      = true,
      },
    },
    grounddust = {
      air                = false,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = true,
      unit               = false,
      properties = {
        airdrag            = 0.92,
        colormap           = [[0.08 0.07 0.06 0.2   0 0 0 0.0]],
        directional        = false,
        emitrot            = 90,
        emitrotspread      = -2,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.03, 0]],
        numparticles       = 8,
        particlelife       = 140,
        particlelifespread = 60,
        particlesize       = 80.4,
        particlesizespread = 30.5,
        particlespeed      = 12,
        particlespeedspread = 3,
        pos                = [[0, 50, 0]],
        sizegrowth         = 0.2,
        sizemod            = 1.0,
        texture            = [[bigexplosmoke]],
        alwaysvisible      = true,
      },
    },

        fusfloor = {
            air                = true,
            class              = [[CExpGenSpawner]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                delay              = [[0]],
                explosiongenerator = [[custom:afus-floor]],
                pos                = [[-10 r20, 130, -10 r20]],
                alwaysvisible      = true,
            },
        },

        electricstorm = {
            air                = true,
            class              = [[CExpGenSpawner]],
            count              = 8,
            ground             = true,
            water              = false,
            underwater         = false,
            properties = {
                delay              = [[15 r70]],
                explosiongenerator = [[custom:lightning_stormbig]],
                pos                = [[0 r75, 20 r50, 0 r75]],
                alwaysvisible      = true,
            },
        },

        electricstormxl = {
            air                = true,
            class              = [[CExpGenSpawner]],
            count              = 4,
            ground             = true,
            water              = false,
            underwater         = false,
            properties = {
                delay              = [[60 r90]],
                explosiongenerator = [[custom:lightning_stormflares]],
                pos                = [[-20 r90, 120 r25, -20 r90]],
                alwaysvisible      = true,
            },
        },

        -- electricstorm2 = {
        --  air                = true,
        --  class              = [[CExpGenSpawner]],
        --  count              = 35,
        --  ground             = true,
        --  water              = true,
        --  underwater         = true,
        --  properties = {
        --      delay              = [[40 r200]],
        --      explosiongenerator = [[custom:lightning_stormbolt]],
        --      pos                = [[-200 r400, 2 r60, -200 r400]],
        --  },
        -- },
    },
	["afusexpl"] = {
		centerflare = {
            air                = true,
            class              = [[CHeatCloudProjectile]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                heat               = 11,
                heatfalloff        = 0.9,
                maxheat            = 11,
                pos                = [[r-10 r10, 50, r-10 r10]],
                size               = 20,
                sizegrowth         = 32,
                speed              = [[0, 1 0, 0]],
                texture            = [[orangenovaexplo]],
                alwaysvisible      = true,
            },
        },
        pop1 = {
			class = [[CHeatCloudProjectile]],
			air=1,
			water=1,
			ground=1,
			count=1,
			properties ={
				alwaysVisible=1,
				texture=[[explo]],
				heat = 5,
				maxheat = 5,
				heatFalloff = 1.5,
				size = 6,
				sizeGrowth = 15,
				pos = [[r-10 r10, 20, r-10 r10]],
				speed=[[0, 0, 0]],
			},
		},
        groundflash_large = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = false,
            ground             = true,
            water              = true,
            properties = {
                colormap           = [[1 0.7 0.3 0.45   0 0 0 0.01]],
                size               = 700,
                ttl                = 80,
                sizegrowth         = -1,
                texture            = [[groundflash]],
                alwaysvisible      = true,
            },
        },
        groundflash_white = {
            class              = [[CSimpleGroundFlash]],
            count              = 1,
            air                = false,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                colormap           = [[1 0.9 0.75 0.77   0 0 0 0.01]],
                size               = 190,
                sizegrowth         = 0,
                ttl                = 90,
                texture            = [[groundflash]],
                alwaysvisible      = true,
            },
        },
        kickedupwater = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            air                = false,
            ground             = false,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.87,
                colormap           = [[0.7 0.7 0.9 0.35 0 0 0 0.0]],
                directional        = false,
                emitrot            = 90,
                emitrotspread      = 5,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, 0.1, 0]],
                numparticles       = 100,
                particlelife       = 2,
                particlelifespread = 45,
                particlesize       = 3,
                particlesizespread = 1.5,
                particlespeed      = 12,
                particlespeedspread = 20,
                pos                = [[0, 1, 0]],
                sizegrowth         = 0.5,
                sizemod            = 1.0,
                texture            = [[wake]],
                alwaysvisible      = true,
            },
        },
        explosion_flames = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.94,
                colormap           = [[0 0 0 0   1 0.95 0.8 0.02   0.92 0.67 0.35 0.015   0.56 0.23 0.05 0.01   0.1 0.04 0.015 0.005   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 11,
                particlelife       = 30,
                particlelifespread = 16,
                particlesize       = 20,
                particlesizespread = 39,
                particlespeed      = 7,
                particlespeedspread = 7,
                pos                = [[0, 15, 0]],
                sizegrowth         = -0.3,
                sizemod            = 1,
                texture            = [[flashside2]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        explosion = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.91,
                colormap           = [[0 0 0 0   1 0.93 0.7 0.008  0.9 0.53 0.21 0.012   0.70 0.32 0.04 0.008   0.60 0.22 0.01 0.003   0.20 0.06 0.004 0.005   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 5,
                particlelife       = 30,
                particlelifespread = 15,
                particlesize       = 30,
                particlesizespread = 26,
                particlespeed      = 6,
                particlespeedspread = 7,
                pos                = [[0, 60, 0]],
                sizegrowth         = 3.2,
                sizemod            = 1,
                texture            = [[flashside1]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        shard1 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.3, 0]],
        numparticles       = [[3 r2.3]],
        particlelife       = 90,
        particlelifespread = 25,
        particlesize       = 6,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard1]],
        useairlos          = false,
      },
    },
    shard2 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = [[2 r2.2]],
        particlelife       = 70,
        particlelifespread = 18,
        particlesize       = 7,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard2]],
        useairlos          = false,
      },
    },
    shard3 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      properties = {
        airdrag            = 0.97,
        colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
        directional        = true,
        emitrot            = 20,
        emitrotspread      = 33,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.1, 0]],
        numparticles       = [[2 r1.5]],
        particlelife       = 80,
        particlelifespread = 20,
        particlesize       = 8,
        particlesizespread = 3.7,
        particlespeed      = 8.8,
        particlespeedspread = 11.7,
        pos                = [[0, 2, 0]],
        sizegrowth         = 0,
        sizemod            = 1,
        texture            = [[shard3]],
        useairlos          = false,
      },
    },
        sparks = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = false,
      properties = {
        airdrag            = 0.88,
        colormap           = [[0.9 0.85 0.77 0.025   0.8 0.55 0.3 0.011   0.8 0.55 0.3 0.005   0.25 0.15 0.08 0.01   0 0 0 0]],
        directional        = true,
        emitrot            = 30,
        emitrotspread      = 40,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, -0.01, 0]],
        numparticles       = 13,
        particlelife       = 24,
        particlelifespread = 14,
        particlesize       = 38,
        particlesizespread = 45,
        particlespeed      = 14.5,
        particlespeedspread = 11,
        pos                = [[0, 4, 0]],
        sizegrowth         = -0.11,
        sizemod            = 0.98,
        texture            = [[gunshotxl]],
        useairlos          = false,
        alwaysvisible      = true,
      },
    },
    fireglow = {
      air                = true,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = true,
      properties = {
        airdrag            = 0.9,
        colormap           = [[0.4 0.3 0.055 0.01   0 0 0 0]],
        directional        = true,
        emitrot            = 65,
        emitrotspread      = 30,
        emitvector         = [[0.0, 1, 0.0]],
        gravity            = [[0.0, 0.0, 0.0]],
        numparticles       = 5,
        particlelife       = 30,
        particlelifespread = 0,
        particlesize       = 100,
        particlesizespread = 64,
        particlespeed      = 3,
        particlespeedspread = 0,
        pos                = [[0, 2, 0]],
        sizegrowth         = -0.2,
        sizemod            = 1,
        texture            = [[explo]],
        useairlos          = false,
        alwaysvisible      = true,
      },
    },
    shockwave = {
        class              = [[CSpherePartSpawner]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            air                = true,
            properties = {
                alpha           = 0.16,
                ttl             = 16,
                expansionSpeed  = 29,
                color           = [[1.0, 0.80, 0.45]],
                alwaysvisible      = true,
            },
    },
    shockwave_inner = {
        class              = [[CSpherePartSpawner]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            air                = true,
            properties = {
                alpha           = 0.50,
                ttl             = 50,
                expansionSpeed  = 4.8,
                color           = [[0.7, 0.50, 0.30]],
                alwaysvisible      = true,
            },
    },
        dirt = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.97,
                colormap           = [[0.04 0.03 0.01 0   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = true,
                emitrot            = 35,
                emitrotspread      = 16,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.15, 0]],
                numparticles       = 50,
                particlelife       = 100,
                particlelifespread = 45,
                particlesize       = 40,
                particlesizespread = -3.6,
                particlespeed      = 6,
                particlespeedspread = 14,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.045,
                sizemod            = 1,
                texture            = [[randomdots]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        dirt2 = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.98,
                colormap           = [[0.04 0.03 0.01 0.88   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = true,
                emitrot            = 10,
                emitrotspread      = 20,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.15, 0]],
                numparticles       = 40,
                particlelife       = 180,
                particlelifespread = 40,
                particlesize       = 3,
                particlesizespread = -1.5,
                particlespeed      = 10,
                particlespeedspread = 18,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.015,
                sizemod            = 1,
                texture            = [[bigexplosmoke]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        dirt3 = {
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            properties = {
                airdrag            = 0.96,
                colormap           = [[0.03 0.02 0.01 0.6   0.1 0.07 0.033 0.76    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
                directional        = false,
                emitrot            = 45,
                emitrotspread      = 16,
                emitvector         = [[0, 1, 0]],
                gravity            = [[0, -0.10, 0]],
                numparticles       = 7,
                particlelife       = 80,
                particlelifespread = 45,
                particlesize       = 90,
                particlesizespread = -3.6,
                particlespeed      = 8,
                particlespeedspread = 4,
                pos                = [[0, 3, 0]],
                sizegrowth         = -0.2,
                sizemod            = 1,
                texture            = [[randomdots]],
                useairlos          = false,
                alwaysvisible      = true,
            },
        },
        clouddust = {
            air                = true,
            class              = [[CSimpleParticleSystem]],
            count              = 1,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                airdrag            = 0.96,
                colormap           = [[0 0 0 0.01  0.028 0.04 0.02 0.05  0.065 0.065 0.055 0.2  0.043 0.05 0.03 0.12   0.0238 0.023 0.021 0.06  0 0 0 0.01]],
                directional        = false,
                emitrot            = 40,
                emitrotspread      = 15,
                emitvector         = [[0.5, 1, 0.5]],
                gravity            = [[0, -0.01, 0]],
                numparticles       = 35,
                particlelife       = 90,
                particlelifespread = 150,
                particlesize       = 66,
                particlesizespread = 40,
                particlespeed      = 0.3,
                particlespeedspread = 6,
                pos                = [[0, 40, 0]],
                sizegrowth         = 0.15,
                sizemod            = 1.0,
                texture            = [[bigexplosmoke]],
                alwaysvisible      = true,
            },
        },
        dustparticles = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          underwater         = true,
          water              = true,
          properties = {
                airdrag            = 0.96,
                colormap           = [[1 0.85 0.6 0.22  1 0.63 0.3 0.12  1 0.52 0.2 0.06   0 0 0 0.01]],
                directional        = true,
                emitrot            = 45,
                emitrotspread      = 32,
                emitvector         = [[0.5, 1, 0.5]],
                gravity            = [[0, -0.011, 0]],
                numparticles       = 12,
                particlelife       = 30,
                particlelifespread = 5.75,
                particlesize       = 15,
                particlesizespread = 40,
                particlespeed      = 6.0,
                particlespeedspread = 3,
                pos                = [[0, 0, 0]],
                sizegrowth         = -0.30,
                sizemod            = 1.0,
                texture            = [[randomdots]],
                alwaysvisible      = true,
      },
    },
    grounddust = {
      air                = false,
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      water              = true,
      underwater         = true,
      unit               = false,
      properties = {
        airdrag            = 0.92,
        colormap           = [[0.08 0.07 0.06 0.2   0 0 0 0.0]],
        directional        = false,
        emitrot            = 90,
        emitrotspread      = -2,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0.03, 0]],
        numparticles       = 8,
        particlelife       = 140,
        particlelifespread = 60,
        particlesize       = 80.4,
        particlesizespread = 30.5,
        particlespeed      = 12,
        particlespeedspread = 3,
        pos                = [[0, 50, 0]],
        sizegrowth         = 0.2,
        sizemod            = 1.0,
        texture            = [[bigexplosmoke]],
        alwaysvisible      = true,
      },
    },

        afusfloor = {
            air                = true,
            class              = [[CExpGenSpawner]],
            count              = 3,
            ground             = true,
            water              = true,
            underwater         = true,
            properties = {
                delay              = [[0]],
                explosiongenerator = [[custom:afus-floor]],
                pos                = [[-10 r20, 130, -10 r20]],
                alwaysvisible      = true,
            },
        },

		electricstorm = {
			air                = true,
			class              = [[CExpGenSpawner]],
			count              = 17,
			ground             = true,
			water              = false,
			underwater         = false,
			properties = {
				delay              = [[15 r90]],
				explosiongenerator = [[custom:lightning_stormbig]],
				pos                = [[0 r165, 50 r50, 0 r165]],
                alwaysvisible      = true,
			},
		},

		electricstormxl = {
			air                = true,
			class              = [[CExpGenSpawner]],
			count              = 6,
			ground             = true,
			water              = false,
			underwater         = false,
			properties = {
				delay              = [[60 r110]],
				explosiongenerator = [[custom:lightning_stormflares]],
				pos                = [[-20 r150, 150 r25, -20 r150]],
                alwaysvisible      = true,
			},
		},
	},
    ["afus-floor"] = {
            smoke = {
                air                = true,
                class              = [[CSimpleParticleSystem]],
                count              = 1,
                ground             = true,
                water              = true,
                properties = {
                    airdrag            = 0.89,
                    colormap           = [[0.20 0.14 0.08 0.01   0.16 0.12 0.06 0.15    0.12 0.10 0.08 0.38   0.11 0.09 0.07 0.30   0.10 0.08 0.07 0.24   0.09 0.065 0.055 0.22   0.08 0.06 0.045 0.20   0.065 0.048 0.037 0.18   0.045 0.035 0.03 0.16   0.05 0.04 0.035 0.1   0.038 0.029 0.022 0.1   0.026 0.020 0.017 0.05   0.023 0.018 0.016 0.05   0 0 0 0.01]],
                    directional        = true,
                    emitrot            = 94,
                    emitrotspread      = 45,
                    emitvector         = [[0, 1, 0]],
                    gravity            = [[0.0, 0.08, 0.0]],
                    numparticles       = 16,
                    particlelife       = 175,
                    particlelifespread = 120,
                    particlesize       = 18,
                    particlesizespread = 22,
                    particlespeed      = 13,
                    particlespeedspread = 8,
                    pos                = [[0.0, 60, 0.0]],
                    sizegrowth         = 1.03,
                    sizemod            = 1,
                    texture            = [[dirt]],
                    useairlos          = true,
                    alwaysvisible      = true,
                },
            },
        },
    ["t3unitexplosion"] = {
        centerflare = {
          air                = true,
          class              = [[CHeatCloudProjectile]],
          count              = 1,
          ground             = true,
          water              = true,
          underwater         = true,
          properties = {
            heat               = 12,
            heatfalloff        = 1.2,
            maxheat            = 14,
            pos                = [[r-2 r2, 5, r-2 r2]],
            size               = 5.5,
            sizegrowth         = 14.5,
            speed              = [[0, 1 0, 0]],
            texture            = [[explo]],
          },
        },
        groundflash_large = {
          class              = [[CSimpleGroundFlash]],
          count              = 1,
          air                = false,
          ground             = true,
          water              = true,
          underwater         = false,
          properties = {
            colormap           = [[1 0.7 0.3 0.29   0 0 0 0.01]],
            size               = 235,
            sizegrowth         = -1.33,
            ttl                = 52,
            texture            = [[groundflash]],
          },
        },
        groundflash_white = {
          class              = [[CSimpleGroundFlash]],
          count              = 1,
          air                = false,
          ground             = true,
          water              = true,
          underwater         = false,
          properties = {
            colormap           = [[1 0.9 0.8 0.7   1 0.9 0.8 0.25   0 0 0 0.01]],
            size               = 200,
            sizegrowth         = -1.4,
            ttl                = 30,
            texture            = [[groundflashwhite]],
          },
        },
        pop1 = {
            class = [[CHeatCloudProjectile]],
            air=1,
            water=1,
            ground=1,
            count=1,
            properties ={
                --alwaysVisible=1,
                texture=[[explo]],
                heat = 14,
                maxheat = 20,
                heatFalloff = 0.9,
                size = 5,
                sizeGrowth = 14,
                pos = [[r-5 r10, 10, r-5 r10]],
                speed=[[0, 0, 0]],
            },
        },
        explosion = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = true,
          underwater         = false,
          properties = {
            airdrag            = 0.84,
            colormap           = [[0 0 0 0   1 0.8 0.5 0.09   0.9 0.4 0.15 0.066   0.66 0.22 0.03 0.033   0 0 0 0.01]],
            directional        = true,
            emitrot            = 45,
            emitrotspread      = 32,
            emitvector         = [[0, 1.1, 0]],
            gravity            = [[0, -0.01, 0]],
            numparticles       = 13,
            particlelife       = 6.5,
            particlelifespread = 15,
            particlesize       = 14,
            particlesizespread = 10.5,
            particlespeed      = 3.2,
            particlespeedspread = 5.5,
            pos                = [[0, 2, 0]],
            sizegrowth         = 0.48,
            sizemod            = 1,
            texture            = [[flashside2]],
            useairlos          = false,
          },
        },
        dustparticles = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          underwater         = true,
          water              = true,
          properties = {
            airdrag            = 0.88,
            colormap           = [[1 0.85 0.6 0.22  1 0.72 0.4 0.12  1 0.66 0.3 0.06   0 0 0 0.01]],
            directional        = true,
            emitrot            = 45,
            emitrotspread      = 32,
            emitvector         = [[0.5, 1, 0.5]],
            gravity            = [[0, -0.011, 0]],
            numparticles       = 4,
            particlelife       = 11.75,
            particlelifespread = 11,
            particlesize       = 7.8,
            particlesizespread = 2.8,
            particlespeed      = 4.8,
            particlespeedspread = 3.5,
            pos                = [[0, 0, 0]],
            sizegrowth         = 2.2,
            sizemod            = 0.92,
            texture            = [[randomdots]],
          },
        },
        fireglow = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          water              = true,
          underwater         = false,
          properties = {
            airdrag            = 0.5,
            colormap           = [[0.4 0.3 0.055 0.02   0 0 0 0]],
            directional        = true,
            emitrot            = 90,
            emitrotspread      = 0,
            emitvector         = [[0.0, 1, 0.0]],
            gravity            = [[0.0, 0.0, 0.0]],
            numparticles       = 1,
            particlelife       = 19,
            particlelifespread = 4,
            particlesize       = 190,
            particlesizespread = 25,
            particlespeed      = 0,
            particlespeedspread = 0,
            pos                = [[0, 2, 0]],
            sizegrowth         = -0.2,
            sizemod            = 1,
            texture            = [[glow2]],
            useairlos          = false,
          },
        },
        innersmoke = {
          class = [[CSimpleParticleSystem]],
          underwater         = true,
          water = 1,
          air = 1,
          ground = 1,
          count = 1,
          properties = {
            airdrag = 0.75,
            alwaysVisible = 0,
            sizeGrowth = 0.5,
            sizeMod = 1.0,
            pos = [[r-1 r1, 0, r-1 r1]],
            emitRot = 33,
            emitRotSpread = 50,
            emitVector = [[0, 1, 0]],
            gravity = [[0, 0.02, 0]],
            colorMap = [[1 0.6 0.35 0.6    0.3 0.2 0.1 0.5   0.18 0.14 0.09 0.44    0.12 0.1 0.08 0.33   0.09 0.09 0.085 0.26   0.06 0.06 0.05 0.16    0 0 0 0.01]],
            Texture = [[graysmoke]],
            particlelife = 66,
            particleLifeSpread = 100,
            numparticles = 5,
            particlespeed = 3.3,
            particlespeedspread = 10.5,
            particlesize = 12,
            particlesizespread = 24,
            directional = 0,
          },
        },
        outersmoke = {
          class = [[CSimpleParticleSystem]],
          underwater         = true,
          water = 1,
          air = 1,
          ground = 1,
          count = 1,
          properties = {
            airdrag = 0.35,
            alwaysVisible = 0,
            sizeGrowth = 0.45,
            sizeMod = 1.0,
            pos = [[r-1 r1, 0, r-1 r1]],
            emitRot = 33,
            emitRotSpread = 50,
            emitVector = [[0, 1, 0]],
            gravity = [[0, -0.02, 0]],
            colorMap = [[1 0.6 0.35 0.6    0.3 0.2 0.1 0.5   0.18 0.14 0.09 0.44    0.12 0.1 0.08 0.33   0.09 0.09 0.085 0.26   0.06 0.06 0.05 0.16    0 0 0 0.01]],
            Texture = [[graysmoke]],
            particlelife = 60,
            particleLifeSpread = 75,
            numparticles = 3.4,
            particlespeed = 4.9,
            particlespeedspread = 13,
            particlesize = 27,
            particlesizespread = 20,
            directional = 0,
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
            airdrag            = 0.91,
            colormap           = [[1 0.88 0.77 0.015   0.8 0.55 0.3 0.01   0 0 0 0]],
            directional        = true,
            emitrot            = 45,
            emitrotspread      = 32,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.17, 0]],
            numparticles       = 7,
            particlelife       = 52,
            particlelifespread = 14,
            particlesize       = 100,
            particlesizespread = 45,
            particlespeed      = 17,
            particlespeedspread = 3,
            pos                = [[0, 4, 0]],
            sizegrowth         = -0.015,
            sizemod            = 0.9,
            texture            = [[gunshotglow]],
            useairlos          = false,
          },
        },
        shockwave = {
            class              = [[CSpherePartSpawner]],
                count              = 1,
                ground             = true,
                water              = true,
                underwater         = false,
                air                = true,
                properties = {
                    alpha           = 0.39,
                    ttl             = 13,
                    expansionSpeed  = 9,
                    color           = [[1.0, 0.85, 0.45]],
                    --alwaysvisible      = true,
                },
        },
        shockwavewater = {
            class              = [[CSpherePartSpawner]],
                count              = 1,
                ground             = false,
                water              = true,
                underwater         = true,
                air                = false,
                properties = {
                    alpha           = 0.26,
                    ttl             = 18.5,
                    expansionSpeed  = 5.4,
                    color           = [[0.55, 0.55, 0.8]],
                    --alwaysvisible      = true,
                },
        },
        dirt = {
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          --unit               = false,
          properties = {
            airdrag            = 0.97,
            colormap           = [[0.04 0.03 0.01 0   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
            directional        = true,
            emitrot            = 35,
            emitrotspread      = 36,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.16, 0]],
            numparticles       = 17,
            particlelife       = 65,
            particlelifespread = 30,
            particlesize       = 22,
            particlesizespread = -2,
            particlespeed      = 4.1,
            particlespeedspread = 12,
            pos                = [[0, 6, 0]],
            sizegrowth         = -0.05,
            sizemod            = 1,
            texture            = [[randomdots]],
            useairlos          = false,
          },
        },
        dirt2 = {
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          --unit               = false,
          properties = {
            airdrag            = 0.98,
            colormap           = [[0.04 0.03 0.01 0   0.1 0.07 0.033 0.66    0.1 0.07 0.03 0.58   0.08 0.065 0.035 0.47   0.075 0.07 0.06 0.4   0 0 0 0  ]],
            directional        = true,
            emitrot            = 10,
            emitrotspread      = 20,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.16, 0]],
            numparticles       = 22,
            particlelife       = 105,
            particlelifespread = 20,
            particlesize       = 2.2,
            particlesizespread = -1.4,
            particlespeed      = 6.4,
            particlespeedspread = 15,
            pos                = [[0, 6, 0]],
            sizegrowth         = -0.018,
            sizemod            = 1,
            texture            = [[bigexplosmoke]],
            useairlos          = false,
          },
        },
        shard1 = {
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          properties = {
            airdrag            = 0.97,
            colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
            directional        = true,
            emitrot            = 20,
            emitrotspread      = 33,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.3, 0]],
            numparticles       = [[3 r2.3]],
            particlelife       = 45,
            particlelifespread = 25,
            particlesize       = 4,
            particlesizespread = 3.7,
            particlespeed      = 2.4,
            particlespeedspread = 7.7,
            pos                = [[0, 2, 0]],
            sizegrowth         = 0,
            sizemod            = 1,
            texture            = [[shard1]],
            useairlos          = false,
          },
        },
        shard2 = {
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          properties = {
            airdrag            = 0.97,
            colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
            directional        = true,
            emitrot            = 20,
            emitrotspread      = 33,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.3, 0]],
            numparticles       = [[2 r2.2]],
            particlelife       = 35,
            particlelifespread = 18,
            particlesize       = 4,
            particlesizespread = 3.7,
            particlespeed      = 2.4,
            particlespeedspread = 7.7,
            pos                = [[0, 2, 0]],
            sizegrowth         = 0,
            sizemod            = 1,
            texture            = [[shard2]],
            useairlos          = false,
          },
        },
        shard3 = {
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          properties = {
            airdrag            = 0.97,
            colormap           = [[1 0.55 0.45 1    0.55 0.44 0.38 1    0.36 0.34 0.33 1    0 0 0 0.01]],
            directional        = true,
            emitrot            = 20,
            emitrotspread      = 33,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, -0.3, 0]],
            numparticles       = [[2 r1.5]],
            particlelife       = 40,
            particlelifespread = 20,
            particlesize       = 4,
            particlesizespread = 3.7,
            particlespeed      = 2.4,
            particlespeedspread = 7.7,
            pos                = [[0, 2, 0]],
            sizegrowth         = 0,
            sizemod            = 1,
            texture            = [[shard3]],
            useairlos          = false,
          },
        },
        clouddust = {
          air                = true,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          properties = {
            airdrag            = 0.92,
            colormap           = [[0.02 0.02 0.02 0.03  0.055 0.055 0.055 0.066  0.05 0.05 0.05 0.052  0.03 0.03 0.03 0.03  0 0 0 0.01]],
            directional        = true,
            emitrot            = 45,
            emitrotspread      = 4,
            emitvector         = [[0.5, 1, 0.5]],
            gravity            = [[0, 0.025, 0]],
            numparticles       = 3,
            particlelife       = 75,
            particlelifespread = 110,
            particlesize       = 90,
            particlesizespread = 90,
            particlespeed      = 3.8,
            particlespeedspread = 3.8,
            pos                = [[0, 4, 0]],
            sizegrowth         = 0.25,
            sizemod            = 1.0,
            texture            = [[bigexplosmoke]],
          },
        },
        grounddust = {
          air                = false,
          class              = [[CSimpleParticleSystem]],
          count              = 1,
          ground             = true,
          unit               = false,
          properties = {
            airdrag            = 0.92,
            colormap           = [[0.07 0.07 0.07 0.1   0 0 0 0.0]],
            directional        = false,
            emitrot            = 90,
            emitrotspread      = -2,
            emitvector         = [[0, 1, 0]],
            gravity            = [[0, 0.02, 0]],
            numparticles       = 17,
            particlelife       = 20,
            particlelifespread = 55,
            particlesize       = 2.5,
            particlesizespread = 1.1,
            particlespeed      = 6.3,
            particlespeedspread = 2,
            pos                = [[0, 4, 0]],
            sizegrowth         = 0.6,
            sizemod            = 1.0,
            texture            = [[bigexplosmoke]],
          },
        },
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

local size = 0.7

definitions['t3unitexplosionmed'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionmed'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].sparks.properties.particlespeed * size)
definitions['t3unitexplosionmed'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionmed'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionmed'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionmed'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionmed'].explosion.properties.particlesize * size)
definitions['t3unitexplosionmed'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionmed'].explosion.properties.particlelife * size)
definitions['t3unitexplosionmed'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].dustparticles.properties.particlespeed * size)
definitions['t3unitexplosionmed'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionmed'].dustparticles.properties.particlesize * size)
definitions['t3unitexplosionmed'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionmed'].dustparticles.properties.particlelife * size)
definitions['t3unitexplosionmed'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].dirt.properties.particlespeed * size)
definitions['t3unitexplosionmed'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionmed'].dirt.properties.particlespeedspread * size)
definitions['t3unitexplosionmed'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionmed'].dirt.properties.numparticles * size)
definitions['t3unitexplosionmed'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].dirt2.properties.particlespeed * size)
definitions['t3unitexplosionmed'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionmed'].dirt2.properties.particlespeedspread * size)
definitions['t3unitexplosionmed'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionmed'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionmed'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionmed'].shockwave.properties.ttl * size)
definitions['t3unitexplosionmed'].centerflare.properties.size = math.floor(definitions['t3unitexplosionmed'].centerflare.properties.size * size)
definitions['t3unitexplosionmed'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionmed'].centerflare.properties.heat * size)
definitions['t3unitexplosionmed'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionmed'].centerflare.properties.maxheat * size)
definitions['t3unitexplosionmed'].pop1.properties.size = math.floor(definitions['t3unitexplosionmed'].pop1.properties.size * size)
definitions['t3unitexplosionmed'].pop1.properties.heat = math.floor(definitions['t3unitexplosionmed'].pop1.properties.heat * size)
definitions['t3unitexplosionmed'].pop1.properties.maxheat = math.floor(definitions['t3unitexplosionmed'].pop1.properties.maxheat * size)
definitions['t3unitexplosionmed'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionmed'].groundflash_large.properties.size * size)
definitions['t3unitexplosionmed'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionmed'].groundflash_large.properties.ttl * size)
definitions['t3unitexplosionmed'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionmed'].groundflash_white.properties.size * size)
definitions['t3unitexplosionmed'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionmed'].grounddust.properties.particlesize * size)
definitions['t3unitexplosionmed'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionmed'].grounddust.properties.particlespeed * size)
definitions['t3unitexplosionmed'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionmed'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionmed'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionmed'].grounddust.properties.particlelife * size)

local size = 1.4

definitions['t3unitexplosionxl'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionxl'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].sparks.properties.particlespeed * size)
definitions['t3unitexplosionxl'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxl'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionxl'].sparks.properties.numparticles = math.floor(definitions['t3unitexplosionxl'].sparks.properties.numparticles * size)
definitions['t3unitexplosionxl'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionxl'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].explosion.properties.particlesize * size * 0.7)
definitions['t3unitexplosionxl'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionxl'].explosion.properties.particlelife * size)
definitions['t3unitexplosionxl'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].dustparticles.properties.particlespeed * size * 0.6)
definitions['t3unitexplosionxl'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].dustparticles.properties.particlesize * size * 0.5)
definitions['t3unitexplosionxl'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionxl'].dustparticles.properties.particlelife * size)
definitions['t3unitexplosionxl'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].dirt.properties.particlespeed * size * 0.6)
definitions['t3unitexplosionxl'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxl'].dirt.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxl'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionxl'].dirt.properties.numparticles * size)
definitions['t3unitexplosionxl'].dirt.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].dirt.properties.particlesize * size * 0.9)
definitions['t3unitexplosionxl'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].dirt2.properties.particlespeed * size * 0.6)
definitions['t3unitexplosionxl'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxl'].dirt2.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxl'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionxl'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionxl'].dirt2.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].dirt2.properties.particlesize * size * 0.9)
definitions['t3unitexplosionxl'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionxl'].shockwave.properties.ttl * size * 0.85)
definitions['t3unitexplosionxl'].centerflare.properties.size = math.floor(definitions['t3unitexplosionxl'].centerflare.properties.size * size * 0.5)
definitions['t3unitexplosionxl'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionxl'].centerflare.properties.heat * size)
definitions['t3unitexplosionxl'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionxl'].centerflare.properties.maxheat * size)
definitions['t3unitexplosionxl'].pop1.properties.size = math.floor(definitions['t3unitexplosionxl'].pop1.properties.size * size * 0.7)
definitions['t3unitexplosionxl'].pop1.properties.heat = math.floor(definitions['t3unitexplosionxl'].pop1.properties.heat * size * 0.7)
definitions['t3unitexplosionxl'].pop1.properties.maxheat = math.floor(definitions['t3unitexplosionxl'].pop1.properties.maxheat * size * 0.7)
definitions['t3unitexplosionxl'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionxl'].groundflash_large.properties.size * size * 0.8)
definitions['t3unitexplosionxl'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionxl'].groundflash_large.properties.ttl * size * 0.7)
definitions['t3unitexplosionxl'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionxl'].groundflash_white.properties.size * size)
definitions['t3unitexplosionxl'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].grounddust.properties.particlesize * size)
definitions['t3unitexplosionxl'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxl'].grounddust.properties.particlespeed * size)
definitions['t3unitexplosionxl'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxl'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxl'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionxl'].grounddust.properties.particlelife * size * 0.6)

local size = 1.7

definitions['t3unitexplosionxxl'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionxxl'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].sparks.properties.particlespeed * size * 0.9)
definitions['t3unitexplosionxxl'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxl'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionxxl'].sparks.properties.numparticles = math.floor(definitions['t3unitexplosionxxl'].sparks.properties.numparticles * size)
definitions['t3unitexplosionxxl'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionxxl'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionxxl'].explosion.properties.particlesize * size * 0.9)
definitions['t3unitexplosionxxl'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionxxl'].explosion.properties.particlelife * size)
definitions['t3unitexplosionxxl'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].dustparticles.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxl'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionxxl'].dustparticles.properties.particlesize * size * 0.7)
definitions['t3unitexplosionxxl'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionxxl'].dustparticles.properties.particlelife * size)
definitions['t3unitexplosionxxl'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].dirt.properties.particlespeed * size * 0.7)
definitions['t3unitexplosionxxl'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxl'].dirt.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxxl'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionxxl'].dirt.properties.numparticles * size)
definitions['t3unitexplosionxxl'].dirt.properties.particlesize = math.floor(definitions['t3unitexplosionxxl'].dirt.properties.particlesize * size * 0.85)
definitions['t3unitexplosionxxl'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].dirt2.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxl'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxl'].dirt2.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxxl'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionxxl'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionxxl'].dirt2.properties.particlesize = math.floor(definitions['t3unitexplosionxl'].dirt2.properties.particlesize * size * 0.85)
definitions['t3unitexplosionxxl'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionxxl'].shockwave.properties.ttl * size * 0.80)
--definitions['t3unitexplosionxxl'].shockwave.properties.alpha = math.floor(definitions['t3unitexplosionxxl'].shockwave.properties.alpha * size * 0.9)
definitions['t3unitexplosionxxl'].centerflare.properties.size = math.floor(definitions['t3unitexplosionxxl'].centerflare.properties.size * size * 0.8)
definitions['t3unitexplosionxxl'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionxxl'].centerflare.properties.heat * size)
definitions['t3unitexplosionxxl'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionxxl'].centerflare.properties.maxheat * size)
definitions['t3unitexplosionxxl'].pop1.properties.size = math.floor(definitions['t3unitexplosionxxl'].pop1.properties.size * size * 0.8)
definitions['t3unitexplosionxxl'].pop1.properties.heat = math.floor(definitions['t3unitexplosionxxl'].pop1.properties.heat * size * 0.6)
definitions['t3unitexplosionxxl'].pop1.properties.maxheat = math.floor(definitions['t3unitexplosionxxl'].pop1.properties.maxheat * size * 0.7)
definitions['t3unitexplosionxxl'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionxxl'].groundflash_large.properties.size * size * 0.8)
definitions['t3unitexplosionxxl'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionxxl'].groundflash_large.properties.ttl * size * 0.8)
definitions['t3unitexplosionxxl'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionxxl'].groundflash_white.properties.size * size)
definitions['t3unitexplosionxxl'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxl'].grounddust.properties.particlesize * size)
definitions['t3unitexplosionxxl'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxl'].grounddust.properties.particlespeed * size)
definitions['t3unitexplosionxxl'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxl'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxl'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxl'].grounddust.properties.particlelife * size * 0.9)

local size = 2.2

definitions['t3unitexplosionxxxl'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionxxxl'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].sparks.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxxl'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxl'].sparks.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].sparks.properties.numparticles * size)
definitions['t3unitexplosionxxxl'].explosion.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].explosion.properties.numparticles * size)
definitions['t3unitexplosionxxxl'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionxxxl'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].explosion.properties.particlesize * size * 0.7)
definitions['t3unitexplosionxxxl'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].explosion.properties.particlelife * size)
definitions['t3unitexplosionxxxl'].dustparticles.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].dustparticles.properties.numparticles * size)
definitions['t3unitexplosionxxxl'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].dustparticles.properties.particlespeed * size * 0.9)
definitions['t3unitexplosionxxxl'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].dustparticles.properties.particlesize * size * 0.9)
definitions['t3unitexplosionxxxl'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].dustparticles.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxl'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].dirt.properties.particlespeed * size * 0.6)
definitions['t3unitexplosionxxxl'].dirt.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].dirt.properties.particlesize * size * 0.8)
definitions['t3unitexplosionxxxl'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].dirt.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxxxl'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].dirt.properties.numparticles * size)
definitions['t3unitexplosionxxxl'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].dirt2.properties.particlespeed * size * 0.6)
definitions['t3unitexplosionxxxl'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].dirt2.properties.particlespeedspread * size * 0.6)
definitions['t3unitexplosionxxxl'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionxxxl'].dirt2.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].dirt2.properties.particlesize * size * 0.8)
definitions['t3unitexplosionxxxl'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionxxxl'].shockwave.properties.ttl * size * 0.95)
--definitions['t3unitexplosionxxxl'].shockwave.properties.alpha = math.floor(definitions['t3unitexplosionxxxl'].shockwave.properties.alpha * size * 0.7)
definitions['t3unitexplosionxxxl'].centerflare.properties.size = math.floor(definitions['t3unitexplosionxxxl'].centerflare.properties.size * size * 0.5)
definitions['t3unitexplosionxxxl'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionxxxl'].centerflare.properties.heat * size)
definitions['t3unitexplosionxxxl'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionxxxl'].centerflare.properties.maxheat * size)
definitions['t3unitexplosionxxxl'].pop1.properties.size = math.floor(definitions['t3unitexplosionxxxl'].pop1.properties.size * size * 0.8)
definitions['t3unitexplosionxxxl'].pop1.properties.heat = math.floor(definitions['t3unitexplosionxxxl'].pop1.properties.heat * size * 0.5)
definitions['t3unitexplosionxxxl'].pop1.properties.maxheat = math.floor(definitions['t3unitexplosionxxxl'].pop1.properties.maxheat * size * 0.6)
definitions['t3unitexplosionxxxl'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionxxxl'].groundflash_large.properties.size * size * 0.8)
definitions['t3unitexplosionxxxl'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionxxxl'].groundflash_large.properties.ttl * size * 0.7)
definitions['t3unitexplosionxxxl'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionxxxl'].groundflash_white.properties.size * size)
definitions['t3unitexplosionxxxl'].grounddust.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].grounddust.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxl'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].grounddust.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxl'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].grounddust.properties.particlespeed * size * 1.2)
definitions['t3unitexplosionxxxl'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxl'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].grounddust.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxl'].clouddust.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].clouddust.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxl'].clouddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].clouddust.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxl'].clouddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].clouddust.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxl'].clouddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].clouddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxl'].clouddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].clouddust.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxl'].innersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].innersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxl'].innersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].innersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxl'].innersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].innersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxl'].innersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].innersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxl'].innersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].innersmoke.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxl'].outersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxl'].outersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxl'].outersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxl'].outersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxl'].outersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxl'].outersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxl'].outersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxl'].outersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxl'].outersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxl'].outersmoke.properties.particlelife * size * 1.2)

local size = 2.6

definitions['t3unitexplosionxxxxl'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionxxxxl'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].sparks.properties.particlespeed * size)
definitions['t3unitexplosionxxxxl'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxl'].explosion.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].explosion.properties.numparticles * size)
definitions['t3unitexplosionxxxxl'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionxxxxl'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].explosion.properties.particlesize * size * 0.8)
definitions['t3unitexplosionxxxxl'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].explosion.properties.particlelife * size)
definitions['t3unitexplosionxxxxl'].dustparticles.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].dustparticles.properties.numparticles * size)
definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlesize * size * 0.7)
definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].dustparticles.properties.particlelife * size)
definitions['t3unitexplosionxxxxl'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].dirt.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxxxl'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].dirt.properties.particlespeedspread * size * 0.8)
definitions['t3unitexplosionxxxxl'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].dirt.properties.numparticles * size)
definitions['t3unitexplosionxxxxl'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].dirt2.properties.particlespeed * size * 0.8)
definitions['t3unitexplosionxxxxl'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].dirt2.properties.particlespeedspread * size * 08)
definitions['t3unitexplosionxxxxl'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionxxxxl'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionxxxxl'].shockwave.properties.ttl * size * 1.05)
definitions['t3unitexplosionxxxxl'].centerflare.properties.size = math.floor(definitions['t3unitexplosionxxxxl'].centerflare.properties.size * size * 0.7)
definitions['t3unitexplosionxxxxl'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionxxxxl'].centerflare.properties.heat * size  * 0.7)
definitions['t3unitexplosionxxxxl'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionxxxxl'].centerflare.properties.maxheat * size * 0.7)
definitions['t3unitexplosionxxxxl'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionxxxxl'].groundflash_large.properties.size * size * 0.9)
definitions['t3unitexplosionxxxxl'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionxxxxl'].groundflash_large.properties.ttl * size * 0.8)
definitions['t3unitexplosionxxxxl'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionxxxxl'].groundflash_white.properties.size * size)
definitions['t3unitexplosionxxxxl'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].grounddust.properties.particlesize * size)
definitions['t3unitexplosionxxxxl'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].grounddust.properties.particlespeed * size)
definitions['t3unitexplosionxxxxl'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxl'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].grounddust.properties.particlelife * size * 0.8)
definitions['t3unitexplosionxxxxl'].clouddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].clouddust.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxl'].clouddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].clouddust.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxl'].clouddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].clouddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxl'].clouddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].clouddust.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxxl'].innersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].innersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].innersmoke.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxxl'].outersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxl'].outersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxl'].outersmoke.properties.particlelife * size * 1.2)

local size = 3.2

definitions['t3unitexplosionxxxxxl'] = deepcopy(definitions['t3unitexplosion'])
definitions['t3unitexplosionxxxxxl'].sparks.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].sparks.properties.particlespeed * size)
definitions['t3unitexplosionxxxxxl'].sparks.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].sparks.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxxl'].explosion.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].explosion.properties.numparticles * size)
definitions['t3unitexplosionxxxxxl'].explosion.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].explosion.properties.particlespeed * size)
definitions['t3unitexplosionxxxxxl'].explosion.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].explosion.properties.particlesize * size * 0.9)
definitions['t3unitexplosionxxxxxl'].explosion.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].explosion.properties.particlelife * size)
definitions['t3unitexplosionxxxxxl'].dustparticles.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].dustparticles.properties.numparticles * size)
definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlespeed * size * 0.9)
definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlesize * size * 0.8)
definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].dustparticles.properties.particlelife * size)
definitions['t3unitexplosionxxxxxl'].dirt.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].dirt.properties.particlespeed * size * 0.9)
definitions['t3unitexplosionxxxxxl'].dirt.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].dirt.properties.particlespeedspread * size * 0.9)
definitions['t3unitexplosionxxxxxl'].dirt.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].dirt.properties.numparticles * size)
definitions['t3unitexplosionxxxxxl'].dirt2.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].dirt2.properties.particlespeed * size * 0.9)
definitions['t3unitexplosionxxxxxl'].dirt2.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].dirt2.properties.particlespeedspread * size * 0.9)
definitions['t3unitexplosionxxxxxl'].dirt2.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].dirt2.properties.numparticles * size)
definitions['t3unitexplosionxxxxxl'].shockwave.properties.ttl = math.floor(definitions['t3unitexplosionxxxxxl'].shockwave.properties.ttl * size * 1.1)
definitions['t3unitexplosionxxxxxl'].centerflare.properties.size = math.floor(definitions['t3unitexplosionxxxxxl'].centerflare.properties.size * size * 0.8)
definitions['t3unitexplosionxxxxxl'].centerflare.properties.heat = math.floor(definitions['t3unitexplosionxxxxxl'].centerflare.properties.heat * size * 0.8)
definitions['t3unitexplosionxxxxxl'].centerflare.properties.maxheat = math.floor(definitions['t3unitexplosionxxxxxl'].centerflare.properties.maxheat * size * 0.8)
definitions['t3unitexplosionxxxxxl'].groundflash_large.properties.size = math.floor(definitions['t3unitexplosionxxxxxl'].groundflash_large.properties.size * size * 0.9)
definitions['t3unitexplosionxxxxxl'].groundflash_large.properties.ttl = math.floor(definitions['t3unitexplosionxxxxxl'].groundflash_large.properties.ttl * size * 0.8)
definitions['t3unitexplosionxxxxxl'].groundflash_white.properties.size = math.floor(definitions['t3unitexplosionxxxxxl'].groundflash_white.properties.size * size)
definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlesize * size)
definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlespeed * size)
definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].grounddust.properties.particlelife * size * 0.9)
definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].clouddust.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxxxl'].innersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].innersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].innersmoke.properties.particlelife * size * 1.2)
definitions['t3unitexplosionxxxxxl'].outersmoke.properties.numparticles = math.floor(definitions['t3unitexplosionxxxxxl'].outersmoke.properties.numparticles * size * 1.2)
definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlesize = math.floor(definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlesize * size * 1.2)
definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlespeed = math.floor(definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlespeed * size * 1.4)
definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlespeedspread = math.floor(definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlespeedspread * size)
definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlelife = math.floor(definitions['t3unitexplosionxxxxxl'].outersmoke.properties.particlelife * size * 1.2)

-- add purple scavenger variants
local scavengerDefs = {}
for k,v in pairs(definitions) do
  scavengerDefs[k..'-purple'] = deepcopy(definitions[k])
end

local purpleEffects = {
  centerflare = {
    properties = {
      texture           = [[purplenovaexplo]],
    },
  },
  pop1 = {
    properties = {
      texture           = [[purpleexplo]],
    },
  },
  groundflash_small = {
    properties = {
      colormap           = [[0.7 0.3 1 0.28   0 0 0 0.01]],
    },
  },
  groundflash_large = {
    properties = {
      colormap           = [[0.7 0.3 1 0.09   0 0 0 0.01]],
    },
  },
  groundflash_white = {
    properties = {
      colormap           = [[0.9 0.7 1 0.25   0 0 0 0.01]],
    },
  },
  explosion = {
    properties = {
      colormap           = [[0 0 0 0   0.8 0.5 1 0.09   0.65 0.2 0.9 0.066   0.35 0.07 0.6 0.033   0 0 0 0]],
    },
  },
  fireglow = {
    properties = {
      colormap           = [[0.29 0.055 0.4 0.02   0 0 0 0]],
    },
  },
  shockwave = {
    properties = {
      color              = [[0.9, 0.3, 1]],
    },
  },
  innersmoke = {
    properties = {
      colormap=[[0.8 0.44 1 0.2    0.3 0.2 0.4 0.35   0.16 0.11 0.21 0.31    0.11 0.07 0.15 0.28   0.09 0.08 0.1 0.22   0.065 0.06 0.07 0.15    0 0 0 0.01]],
    },
  },
  outersmoke = {
    properties = {
      colormap=[[0.8 0.45 1 0.45    0.22 0.15 0.3 0.4   0.15 0.11 0.18 0.35    0.12 0.1 0.13 0.32   0.105 0.095 0.11 0.25   0.061 0.059 0.063 0.17    0 0 0 0.01]],
    },
  },
  sparks = {
    properties = {
      colormap=[[0.75 0.6 0.9 0.017   0.6 0.3 0.8 0.011   0 0 0 0]],
    },
  },
  dustparticles = {
    properties = {
      colormap=[[0.85 0.6 1 0.22  0.75 0.3 1 0.12  0.6 0.2 1 0.06   0 0 0 0.01]],
    },
  },
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
