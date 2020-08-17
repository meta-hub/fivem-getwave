Wave = {}
Wave.Request  = 0
Wave.Requests = {}
Wave.Resource = GetCurrentResourceName()

Wave.Get = function(url,play,samplesize,callback)
  local id = Wave.Request+1

  Wave.Request      = id
  Wave.Requests[id] = {
    url       = url,
    callback  = callback
  }

  SendNUIMessage({
    type        = "Get",
    url         = url,
    id          = id,
    play        = play,
    samplesize  = samplesize,
    cb          = string.format("https://%s/got",Wave.Resource)
  })
end

Wave.Got = function(data)
  if Wave.Requests[data.id] and Wave.Requests[data.id].callback then
    Wave.Requests[data.id].callback(data.wave,data.duration)
  end
end 

RegisterNUICallback('got',Wave.Got)

RegisterNetEvent("Wave:Get")
AddEventHandler("Wave:Get",Wave.Get)
  
RegisterCommand('wave:visualize', function(source,args)
  local url         = (args and args[1] and args[1]:len() >= 1  and args[1]           or "files/altar.mp3")
  local doplay      = (args and args[2] and args[2] == "1"      and true              or false)
  local samplesize  = (args and args[3] and args[3]:len() >= 1  and tonumber(args[3]) or 5000)

  Wave.Get(url,doplay,samplesize,function(wave,duration)
    local start = (GetGameTimer() / 1000)    
    local durations = (#wave / duration)
    while true do
      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)
      local fwd = GetEntityForwardVector(ped)

      local now   = (GetGameTimer() / 1000)
      local since = (now - start)

      local target      = math.max(1,math.min(#wave,math.floor(since * durations)))
      local wave_target = wave[target]

      local p1 = pos + (fwd*5.0) + vector3(0.0,0.0, wave_target)

      DrawBox(p1.x-0.5,p1.y-0.5,p1.z-0.5, p1.x+0.5,p1.y+0.5,p1.z+0.5, math.floor(255*(wave_target+0.5)),150-math.floor(255*wave_target),255-math.floor(255*(wave_target-0.5)),200)

      if since >= duration then
        return
      end
      Wait(0)
    end
  end)
end)