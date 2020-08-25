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

      local mod = 0.5
      local modifier = math.min(5.0,math.max(-5.0,wave_target*5.0))
      for i=-2.4,2.4,0.1 do
        local p1 = PointOnSphere(5.0 * (i*15.0),0.0,(5.0 + (5.0 * (modifier*i)))) + pos + (GetEntityForwardVector(ped) * 10.0) + vector3(0.0,0.0,wave_target * math.abs(i))
        DrawBox(p1.x-mod,p1.y-mod,p1.z-(mod*modifier), p1.x+mod,p1.y+mod,p1.z+(mod*modifier), math.floor(255*(wave_target)),150-math.floor(255*wave_target),255-math.floor(255*(wave_target)),200)
      end

      if since >= duration then
        return
      end
      Wait(0)
    end
  end)
end)


GetVecDist = function(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

PointOnSphere = function(alt,azu,radius,orgX,orgY,orgZ)
  local toradians = 0.017453292384744
  alt,azu,radius,orgX,orgY,orgZ = ( tonumber(alt or 0) or 0 ) * toradians, ( tonumber(azu or 0) or 0 ) * toradians, tonumber(radius or 0) or 0, tonumber(orgX or 0) or 0, tonumber(orgY or 0) or 0, tonumber(orgZ or 0) or 0
  if      vector3
  then
      return
      vector3(
           orgX + radius * math.sin( azu ) * math.cos( alt ),
           orgY + radius * math.cos( azu ) * math.cos( alt ),
           orgZ + radius * math.sin( alt )
      )
  end
end