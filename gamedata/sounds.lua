local Sounds = {
	SoundItems = {
		IncomingChat = {
			file = "sounds/ui/blank.wav",
			in3d = "false",
		},
		MultiSelect = {
			file = "sounds/ui/button9.wav",
			in3d = "false",
		},
		MapPoint = {
			file = "sounds/ui/beep6.wav",
			rolloff = 0.3,
			dopplerscale = 0,       
		},
		FailedCommand = {
			file = "sounds/replies/cantdo4.wav",       
		},
	},
}


-- UI SOUNDS
local files = VFS.DirList("sounds/ui/")
local t = Sounds.SoundItems
for i=1,#files do
	local fileName = files[i]
	fileNames = string.sub(fileName, 11, string.find(fileName, ".wav") -1)
	t[fileNames] = {
		file     = fileName;
		gain = 0.8,
		pitchmod = 0,
		gainmod  = 0,
		dopplerscale = 0,
		maxconcurrent = 1,
		rolloff = 0,
	}
end

-- WEAPON SOUNDS
local files = VFS.DirList("sounds/weapons/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   fileNames = string.sub(fileName, 16, string.find(fileName, ".wav") -1)
   t[fileNames] = {
      file     = fileName;
      gain = 1.2*0.3,
      pitchmod = 0.17,
      gainmod  = 0.2*0.3,
      dopplerscale = 1.0,
      maxconcurrent = 8,
      rolloff = 1.0,
   }
   
   if fileNames == "disigun1" then
    t[fileNames].gain = 0.075*0.3
    end
   if fileNames == "xplomas2" then
    t[fileNames].gain = 0.225*0.3
    end
   -- if fileNames == "newboom" then
   --  t[fileNames].gain = 0.045*0.3
   --  end
    if fileNames == "beamershot2" then
    t[fileNames].gain = 0.5*0.3
    t[fileNames].pitchmod = 0.04
    end
   if fileNames == "lasfirerc" then
    t[fileNames].pitchmod = 0.06
    end
   if string.sub(fileNames, 1, 7) == "heatray" then
    t[fileNames].pitchmod = 0
    end
   if string.sub(fileNames, 1, 4) == "lasr" then
    t[fileNames].pitchmod = 0
    end
   if string.sub(fileNames, 1, 7) == "xplolrg" then
    t[fileNames].pitchmod = 0.3
    end
   if string.sub(fileNames, 1, 7) == "xplomed" then
    t[fileNames].pitchmod = 0.25
    end
    if string.sub(fileNames, 1, 7) == "xplosml" then
    t[fileNames].pitchmod = 0.22
    end
end

-- REPLY SOUNDS
local files = VFS.DirList("sounds/replies/")
local t = Sounds.SoundItems
for i=1,#files do
	local fileName = files[i]
	fileNames = string.sub(fileName, 16, string.find(fileName, ".wav") -1)
	t[fileNames] = {
		file     = fileName;
		gain = 1.2*0.3,
		pitchmod = 0.01,
		gainmod  = 0.2*0.3,
		dopplerscale = 1.0,
		maxconcurrent = 2,
		rolloff = 0.2,
	}
end

local files = VFS.DirList("sounds/chickens/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   fileNames = string.sub(fileName, 17, string.find(fileName, ".wav") -1)
   t[fileNames] = {
      file     = fileName;
	    gain = 1.2*0.3,
      pitchmod = 0.18,
      gainmod  = 0.2*0.3,
	    dopplerscale = 1.0,
      maxconcurrent = 4,
	    rolloff = 1.5,
   }
end

local files = VFS.DirList("sounds/critters/")
local t = Sounds.SoundItems
for i=1,#files do
   local fileName = files[i]
   fileNames = string.sub(fileName, 16, string.find(fileName, ".wav") -1)
   t[fileNames] = {
      file     = fileName;
	    gain = 1.2*0.3,
      pitchmod = 0.01,
      gainmod  = 0.2*0.3,
	    dopplerscale = 1.0,
      maxconcurrent = 4,
	    rolloff = 0.7,
   }
end

-- SCAVENGER SOUNDS not in use currently
local files = VFS.DirList("sounds/scavengers/")
local t = Sounds.SoundItems
for i=1,#files do
	local fileName = files[i]
	fileNames = string.sub(fileName, 19, string.find(fileName, ".wav") -1)
	t[fileNames] = {
  		file     = fileName;
  		gain = 1.0*0.3,
  		pitchmod = 0.33,
  		gainmod  = 0.1*0.3,
  		dopplerscale = 1.0,
  		maxconcurrent = 8,
  		rolloff = 0.2,
	}
end

-- AMBIENCE
local files = VFS.DirList("sounds/atmos/")
local t = Sounds.SoundItems
for i=1,#files do
  local fileName = files[i]
  fileNames = string.sub(fileName, 14, string.find(fileName, ".wav") -1)
  t[fileNames] = {
      file     = fileName;
      gain = 0.8,
      pitchmod = 0.22,
      gainmod  = 0.2*0.3,
      dopplerscale = 1.0,
      maxconcurrent = 3,
      rolloff = 0.2,
  }
end

return Sounds

