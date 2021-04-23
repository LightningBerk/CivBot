--returns the number of empty inventory slots the player has. useful for bots that need to unload items periodically.

function getInvSpace()
  local invspace = 36
  local inv = openInventory()
  local map = inv.mapping.inventory
  for i,j in pairs(map.hotbar) do
    if inv.getSlot(j) then invspace = invspace - 1 end
  end
  for i,j in pairs(map.main) do
    if inv.getSlot(j) then invspace = invspace - 1 end
  end
  inv.close()
return invspace end

return getInvSpace
