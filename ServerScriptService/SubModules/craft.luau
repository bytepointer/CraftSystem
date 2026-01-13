local CraftManager = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CraftsList = require(ReplicatedStorage.Items.CraftsList)

local InventoryService = require(script.Parent.Parent.InventoryService)

function CraftManager.hasRecipe(player, item)

	for _, ingredient in ipairs(item.recipe) do

		if not InventoryService.hasItem(player, ingredient).has then
			return false
		end
	end

	return true
end

function CraftManager.getAvaliableCrafts(player)

	local crafts = {}

	for id, craft in pairs(CraftsList) do

		if CraftManager.hasRecipe(player, craft) then
			crafts[id] = craft 
		end
	end

	return crafts
end

function CraftManager.getNotAvaliableCrafts(avaliableCrafts)

	local notAvaliables = {}

	for id, craft in pairs(CraftsList) do

		if not avaliableCrafts[id] then
			notAvaliables[id] = craft
		end

	end

	return notAvaliables
end

function CraftManager.getCraftById(id)

	return CraftsList[id]
end

return CraftManager
