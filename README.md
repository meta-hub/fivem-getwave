# fivem-getwave
Get audio wave data, with some options...

# Installation
Add fivem-getwave to your resources directory (through git or download).

# Usage
If you want to get the wave data from a local file, ensure you have placed it inside the "nui/files" directory.
You will also need to define your audio files in the `fxmanifest.lua`.

```
local url         = "files/altar.mp3" 
local play_song   = true  
local sample_size = 10000
TriggerEvent("Wave:Get",url,play_song,sample_size,function(wave,duration)
  print(string.format("Received %s samples over %s seconds.",tostring(#wave),tostring(duration))
end)
```

# Command
```
/wave:visualize files/altar.mp3 1 10000
```

# Video
https://streamable.com/mmtzgm

# Music Credits
All music included in this mod is available for free, provided by Aim to Head's official youtube:
https://www.youtube.com/channel/UC1KJEk-EZMmDF9DJKMK5OCQ

## Tracks
- [Altar] https://www.youtube.com/watch?v=7supUJ10_Fc
- [Nocturnal] https://www.youtube.com/watch?v=1M0ddgyEcc0
- [They Exist] https://www.youtube.com/watch?v=C0i_HN8JhNU
