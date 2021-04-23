--returns the number of stacks of a particular item the player has in their inventory

function getInvStacks(item)
  local stacks = 0
  local inv = openInventory()
  local map = inv.mapping.inventory
  for i,j in pairs(map.hotbar) do
    sitem = inv.getSlot(j)
    if sitem and sitem.id == item then
      stacks = stacks + 1
    end
  end
  for i,j in pairs(map.main) do
    sitem = inv.getSlot(j)
    if sitem and sitem.id == item then
      stacks = stacks + 1
    end
  end
  inv.close()
return stacks end

return getInvStacks
