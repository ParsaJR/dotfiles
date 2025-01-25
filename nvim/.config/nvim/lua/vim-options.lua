-- Some general configuration that does not relate to any specific plugin!

vim.cmd("set number")
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

function _G.get_tabline_string()
	local tabline_string = ""
	for tabnum = 1, vim.fn.tabpagenr("$") do
		local winnr = vim.fn.tabpagewinnr(tabnum)
		local bufferlist = vim.fn.tabpagebuflist(tabnum)[winnr]
		local buffername = vim.fn.bufname(bufferlist)
		-- remove the buffername absolute path from the buffername. here, :t means tail of the file name
		local buffername_short = vim.fn.fnamemodify(buffername, ":t")
		-- check if it is the active tab
		if tabnum == vim.fn.tabpagenr() then
			tabline_string = tabline_string ..
			"%#TabLineSel#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		else
			tabline_string = tabline_string ..
			"%#TabLine#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		end
	end
	tabline_string = tabline_string .. "%#TabLineFill#"
	return tabline_string
end

vim.o.tabline = "%!v:lua.get_tabline_string()"
-- always show the tabline
vim.o.showtabline = 2

--Autosave by FocusLost
vim.api.nvim_create_augroup("autosave_buffer", { clear = true })

vim.api.nvim_create_autocmd("FocusLost", {
	group = "autosave_buffer",
	pattern = "*",
	callback = function()
		vim.cmd("w")
	end,
})
