-- SERVER

local InventoryService = require(script.Parent.InventoryService)
local CraftingService = require(script.Parent.Crafting)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local getInventory = ReplicatedStorage.Inventory.getInventory or false
local changeInventory = ReplicatedStorage.Inventory.changeInventory or false
local splitItem = ReplicatedStorage.Inventory.splitItem or false
local dropItem = ReplicatedStorage.Inventory.dropItem or false

local getAvaliableCrafts = ReplicatedStorage.Crafting.getCrafts or false
local Craft = ReplicatedStorage.Crafting.Craft or false

-- INVENTORY

getInventory.OnServerInvoke = function(player)
	
	return InventoryService.getInventory(player)
end

changeInventory.OnServerEvent:Connect(function(player, sourceSlot, targetSlot)
	
	print(InventoryService:changeInventory(player, sourceSlot, targetSlot))
end)

splitItem.onServerEvent:Connect(function(player, item)
	
	print(InventoryService:SplitItem(player, item))
end)

dropItem.onServerEvent:Connect(function(player, slot)
	
	InventoryService:DropItem(player, slot)
end)

game.Players.PlayerRemoving:Connect(function(player)
	
	InventoryService:SaveData(player)
end)

-- CRAFT

getAvaliableCrafts.OnServerInvoke = function(player)
	
	return CraftingService.getCrafts(player)
end

Craft.onServerEvent:Connect(function(player, item)
	
	CraftingService:craft(player, item)
end)

