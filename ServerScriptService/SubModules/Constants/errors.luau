local Errors = {
	API_ERR = {
		--message = "The database could not be acessed by a API internal error",
		code = 301,
		status = "error"
	},
	ITEM_NOT_FOUND = {
		--message = "Item not found",
		code = 302,
		status = "error"
	},
	NO_SUFFICIENT_MATERIAL = {
		--message = "You don't have enough material to craft this item",
		code = 303,
		status = "error"
	},
	FULL_INVENTORY = {
		code = 304,
		--message = "You are with inventory full, drop something and try again.",
		status = "error"
	}
}

return Errors
