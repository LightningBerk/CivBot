--takes as many of a given item as possible from the block the player is looking at

function takeItems(item,tslots)
  use()
  sleep(1000)
  local inv = openInventory()
  local map = inv.mapping.inventory
  for i=1, tslots do
    local sitem = inv.getSlot(i)
    --if sitem then log (sitem.id) else log (sitem) end
    if sitem and sitem.id == item then
      inv.quick(i)
      sleep(50)
    end
  end
  inv.close()
return end

return takeItems
