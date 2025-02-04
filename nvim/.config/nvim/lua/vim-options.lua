-- Some general configuration that does not relate to any specific plugin!

local helper = require("helpers")

-- General
vim.cmd("set number")
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- Keymap for tab-Navigation
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-T>", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-W>", ":tabclose<CR>", { noremap = true, silent = true })


helper.Map("t", "<ESC>", "<C-\\><C-N>")
helper.Map("n","<M-Right>", ":+tabmove<CR>")
helper.Map("n","<M-Left>", ":-tabmove<CR>")
-- Customizing the tabline label
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
			tabline_string = tabline_string .. "%#TabLineSel#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		else
			tabline_string = tabline_string .. "%#TabLine#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		end
	end
	tabline_string = tabline_string .. "%#TabLineFill#"
	return tabline_string
end

vim.o.tabline = "%!v:lua.get_tabline_string()"
vim.o.showtabline = 2

--Autosave by FocusLost
vim.api.nvim_create_augroup("autosave_buffer", { clear = true })

vim.api.nvim_create_autocmd("FocusLost", {
	group = "autosave_buffer",
	pattern = "*",
	callback = function()
		if vim.bo.modified then
			vim.cmd("w")
		end
	end,
})
