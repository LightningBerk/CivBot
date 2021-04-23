--walks the player directly towards tx,tz
--press K to abort and stop moving

function walkToward(tx,tz,announce)
  announce = announce or false
  forward(-1)
  ttx,ttz = tx+0.5,tz+0.5
  b=false
  repeat
    local x,y,z = getPlayerBlockPos()
    y = y + 1.5
    if not b then
      lookAt(ttx,y,ttz)
    end
    sleep(50)
    if isKeyDown("K") then
      b=true
    end
  until x == tx and z == tz
  forward(0)
return end

return walkToward