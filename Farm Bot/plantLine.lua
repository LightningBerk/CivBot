--similar to harvestLine, bot walks in given dir until reaching tx,tz placing item id

function plantLine(dir,tx,tz,id,slot)
  --log(string.format("%s to %d, %d", id, tx, tz))
  slot = slot or 2
  package.loaded.pick = nil
  package.loaded.getInvStacks = nil
  pick = require("pick")
  getInvStacks = require("getInvStacks")
  look(dir,90)
  pick(id,-1,slot)
  sleep(200)
  use()
  forward(-1)
  repeat
    look(dir,90)
    held = getInventory()[getHotbar()]
    if (not held or not (held.id == id)) and getInvStacks(id)>0 then
      forward(0)
      pick(id,-1,slot)
      sleep(250)
      forward(-1)
    end
    use()
    sleep(50)
    local x,y,z = getPlayerBlockPos()
  until x == tx and z == tz
  forward(0)
  use()
  sleep(100)
  use()
  sleep(100)
return end

return plantLine
