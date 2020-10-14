local resources = {
      graphics = {
         maps = {
            detailtex         = 'default/detailtex2.bmp',
            watertex	        = 'default/ocean.jpg',
         },
         groundfx = {
            groundflash       = 'default/groundflash.tga',
            groundflashwhite  = 'default/groundflashwhite.tga',
            groundring        = 'default/groundring.tga',
            seismic           = 'default/circles.tga',
            circlefx0         = 'default/circlefx0.png',
            circlefx1         = 'default/circlefx1.png',
            circlefx2         = 'default/circlefx2.png',
            circlefx3         = 'default/circlefx3.png',
         },
         projectiletextures = {
            circularthingy		= 'default/circularthingy.tga',
            laserend			    = 'default/laserend.tga',
            laserfalloff	   	= 'default/laserfalloff.tga',
            randdots			    = 'default/randdots.tga',
            smoketrail		  	= 'default/smoketrail.tga',
            wake			       	= 'default/wake.tga',
            flare			      	= 'default/flare.tga',
            flare2			     	= 'default/flare2.tga',
            explo				      = 'default/explo.tga',
            explo2			     	= 'default/explo2.tga',
	          sakexplo2 		   	= 'default/sakexplo2.tga',
            explofade		     	= 'default/explofade.tga',
            heatcloud		    	= 'default/explo.tga',
            blastwave         = 'projectiletextures/blastwave.tga',
            flame			      	= 'default/flame.tga',
            flame_alt		    	= 'gpl/flame.png',
            fire			       	= 'gpl/fire.png',
            treefire				  = 'gpl/treefire.png',
            muzzlesideflipped	= 'default/muzzlesideflipped.tga',
            muzzleside		  	= 'default/muzzleside.tga',
            muzzlefront		  	= 'default/muzzlefront.tga',
            largebeam			    = 'default/largelaserfalloff.tga',
            gunshotxl         = 'default/gunshotxl.tga',
			      null              = 'PD/null.tga',
            trans             = 'projectiletextures/trans.tga',
            
            fogdirty          = 'atmos/fogdirty.tga',
            rain              = 'atmos/rain.tga',
            cloudpuff         = 'atmos/cloudpuff.tga',
            sandblast         = 'atmos/sandblast.tga',
            smoke_puff_red    = 'atmos/smoke_puff_red.png',
            explowater        = 'projectiletextures/explowater.tga',
            waterrush         = 'projectiletextures/waterrush.tga',
            subwak            = 'projectiletextures/subwake.tga',

            --Animated Explosion effect (test)
            -- barexplo_29 = 'anims/barexplo_29.png',
            -- barexplo_0 = 'anims/barexplo_1.png',
            -- barexplo_1 = 'anims/barexplo_4.png',
            -- barexplo_2 = 'anims/barexplo_7.png',
            -- barexplo_3 = 'anims/barexplo_10.png',
            -- barexplo_4 = 'anims/barexplo_13.png',
            -- barexplo_5 = 'anims/barexplo_16.png',
            -- barexplo_6 = 'anims/barexplo_19.png',
            -- barexplo_7 = 'anims/barexplo_22.png',
            -- barexplo_8 = 'anims/barexplo_25.png',

      			--Chicken Defense effects
      			uglynovaexplo     = 'CC/uglynovaexplo.tga',
      			sporetrail        = 'GPL/sporetrail.tga',
      			blooddrop         = 'PD/blooddrop.tga',
      			bloodblast        = 'PD/bloodblast.tga',
      			bloodsplat        = 'PD/bloodsplat.tga',
      			blooddropwhite    = 'PD/blooddropwhite.tga',
      			bloodblastwhite   = 'PD/bloodblastwhite.tga',
         },
      }
   }

local VFSUtils = VFS.Include('gamedata/VFSUtils.lua')

local function AutoAdd(subDir, map, filter)
  local dirList = RecursiveFileSearch("bitmaps/" .. subDir)
  for _, fullPath in ipairs(dirList) do
    local path, key, ext = fullPath:match("bitmaps/(.*/(.*)%.(.*))")
    if not fullPath:match("/%.svn") then
    local subTable = resources["graphics"][subDir] or {}
    resources["graphics"][subDir] = subTable
      if not filter or filter == ext then
        if not map then
          table.insert(subTable, path)
        else -- a mapped subtable
          subTable[key] = path
        end
      end
    end
  end
end

-- Add default caustics, smoke and scars
AutoAdd("caustics", false)
AutoAdd("smoke", false, "tga")
AutoAdd("scars", false)
-- Add mod groundfx and projectiletextures
AutoAdd("groundfx", true)
AutoAdd("projectiletextures", true)

return resources

