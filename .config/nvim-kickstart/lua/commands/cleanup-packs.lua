vim.api.nvim_create_user_command("CleanupPacks", function()
	local packs = vim.pack.get()
	local inactive = {}

	for _, pack in pairs(packs) do
		if not pack.active then
			table.insert(inactive, pack.spec.name)
		end
	end

	if #inactive > 0 then
		vim.pack.del(inactive)
	else
		print("No inactive packs")
	end
end, {})
