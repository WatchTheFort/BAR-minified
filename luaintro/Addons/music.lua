
if addon.InGetInfo then
	return {
		name    = "Music",
		desc    = "plays music",
		author  = "jK",
		date    = "2012,2013",
		license = "GPL2",
		layer   = 0,
		--depend  = {"LoadProgress"},
		enabled = true, -- loading makes it choppy towards the end; also, volume cannot be adjusted
	}
end

Spring.Echo("Loading Screen Music Initialized")
--if Spring.GetConfigInt("music_loadscreen", 1) ~= 1 or Spring.GetConfigInt('music', 1) ~= 1 then
	--return
--end

function addon.DrawLoadScreen()
	-- local loadProgress = SG.GetLoadProgress()

	-- -- fade in & out music with progress
	-- if (loadProgress > 0.9) then
		-- Spring.SetSoundStreamVolume(1 - ((loadProgress - 0.9) * 10))
	-- end
end

function addon.Shutdown()
	--Spring.SetSoundStreamVolume(1)
end

function addon.Initialize()
	math.randomseed( os.clock() )
	math.random(); math.random(); math.random()
	local musicvolume = Spring.GetConfigInt("snd_volmusic", 50) * 0.01
	Spring.SetSoundStreamVolume(musicvolume)
	local musicfiles = VFS.DirList("sounds/musicnew/intro", "*.ogg")
	--Spring.Echo("musicfiles", #musicfiles)
	if #musicfiles > 0 then
		--local i = 1 + (math.floor((1000*os.clock())%#musicfiles))

		--Spring.SetConfigInt('musictrack', i)
		if #musicfiles > 1 then
			local pickedTrack = math.ceil(#musicfiles*math.random())
			Spring.PlaySoundStream(musicfiles[pickedTrack], 1)
			Spring.SetSoundStreamVolume(musicvolume)
		elseif #musicfiles == 1 then
			Spring.PlaySoundStream(musicfiles[1], 1)
			Spring.SetSoundStreamVolume(musicvolume)
		end	
	end
end
