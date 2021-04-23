--more advanced version of harvestLine
--player looks towards given yaw, pitch, walks left/right/back/forward until reaching tx,tz.
--pause of pause milliseconds between breaks (can be 0, higher to stop anticheat getting mad)

function harvestLineB(tx,tz,yaw,pitch,wkey,pause)
  local x,y,z = getPlayerBlockPos()
  pause = pause or 50
  look(yaw,pitch)
  sleep(100)
  attack()
  if wkey == "left" then
    left(-1)
  elseif wkey == "right" then
    right(-1)
  elseif wkey == "forward" then
    forward(-1)
  elseif wkey == "back" then
    back(-1)
  else
    log("invalid wkey?")
    log(wkey)
    return
  end
  while (z==tz or x==tx) and not (z==tz and x==tx) do
    look(yaw,pitch)
    attack()
    sleep(pause)
    x,y,z=getPlayerBlockPos()
  end
  left(0)
  right(0)
  forward(0)
  back(0)
  if (z==tz and x==tx) then
    sleep(250)
    attack()
    return true
  elseif not (z==tz or x==tx) then
    return false
  end
end

return harvestLineB
