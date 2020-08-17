# fivem-getwave
Get audio wave data, with some options...

# Installation
Add fivem-getwave to your resources directory (through git or download).

# Usage
If you want to get the wave data from a local file, ensure you have placed it inside the "nui/files" dreictory.
You will also need to define your files in the `fxmanifest.lua`.

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
/wave:visualize filters/altar.mp3 1 10000
```

# Video
https://streamable.com/c9t8ku
