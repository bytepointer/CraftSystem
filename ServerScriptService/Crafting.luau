local CraftingSystem = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CraftsList = require(ReplicatedStorage.Items.CraftsList)

local InventoryService = require(script.Parent.InventoryService)

local items = require(ReplicatedStorage.Items.ItemsList)

local errors = require(script.Constants.errors)

local craftManager = require(script.craft)

function CraftingSystem.getCrafts(player)
	
	local avaliableCrafts = craftManager.getAvaliableCrafts(player)
	
	local notAvaliableCrafts = craftManager.getNotAvaliableCrafts(avaliableCrafts) -- get not avaliable crafts through avaliable crafts
	
	return {
		avaliables = avaliableCrafts,
		notAvaliables = notAvaliableCrafts, 
		status = "success"
	}
end

function CraftingSystem:craft(player, item)
	
	local itemCraft = craftManager.getCraftById(item)
	
	if not itemCraft then
		return errors["ITEM_NOT_FOUND"]
	end
	
	if not craftManager.hasRecipe(player, itemCraft) then
		return errors["NO_SUFFICIENT_MATERIAL"]
	end
	
	local addedItem = InventoryService:addItem(player, {
		id = item,
		amount = 1
	})
	
	if addedItem.status ~= "success" then
		return errors["FULL_INVENTORY"]
	end
	
	for _, recipe in ipairs(itemCraft.recipe) do
		InventoryService:RemoveItem(player, {
			id = recipe.id,
			amount = recipe.amount
		})
	end
	
	return {
		message = "Item crafted successfully.",
		status = "success"
	}
end

return CraftingSystem
