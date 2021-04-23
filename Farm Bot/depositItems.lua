--dumps as much of the specified item from the player's inventory as possible into the the block he is looking at
--target inventory size must be specified (54 for double chest, etc.)

function depositItems(item,tslots)
  use()
  sleep(1000)
  local inv = openInventory()
  local map = inv.mapping.inventory
  for i=tslots,tslots+36 do
    local sitem = inv.getSlot(i)
    --if sitem then log (sitem.id) else log (sitem) end
    if sitem and sitem.id == item then
      inv.quick(i)
      sleep(50)
    end
  end
  inv.close()
return end

return depositItems
