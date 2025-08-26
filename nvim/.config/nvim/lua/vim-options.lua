-- Some general configuration that does not relate to any specific plugin!

local helper = require("helpers")
vim.opt.clipboard = "unnamedplus"
vim.o.winborder = "rounded"

-- General
vim.cmd("set number relativenumber")
vim.cmd("set scrolloff=5")
vim.g.mapleader = " "

-- Set path to include all sub directory files
vim.cmd("set path+=**")

-- This is needed for js projects where node_modules folder presents.
-- i create an .exrc file in each javascript project so things liek vim's find command will not get stuck searching that.
vim.cmd("set exrc")
vim.cmd("set secure")
vim.cmd("set wildmenu")
helper.Map("n","<leader>t",":Lexplore<CR>:vertical resize 50<CR>")

vim.diagnostic.config({
	-- Use the default configuration
	virtual_lines = false,
	virtual_text = true,

	-- Alternatively, customize specific options
	-- virtual_lines = {
	--  -- Only show virtual line diagnostics for the current cursor line
	--  current_line = true,
	-- },
})

-- Copy entire buffer
helper.Map("n", "<leader>cb", ":%y+<CR>")

-- Select the entire buffer
helper.Map("n", "<leader>sb", "ggVG")

-- Keymap for tab-Navigation
vim.keymap.set("n", "<Tab>", ":bn<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bp<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>t", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":tabclose<CR>", { noremap = true, silent = true })

-- Escape in terminal mode
helper.Map("t", "<ESC>", "<C-\\><C-N>")
-- move tabs
helper.Map("n", "<M-Right>", ":+tabmove<CR>")
helper.Map("n", "<M-Left>", ":-tabmove<CR>")

-- Select from bufferlist fast
helper.Map("n", "gb", ":ls<CR>:b<space>")

-- Customizing the tabline label
vim.api.nvim_set_hl(0, "npmbuffer", { foreground = "#f69220", background = "#000000" })
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
		elseif helper.GetBufferType(tabnum) == "terminal" then
			tabline_string = tabline_string .. "%#npmbuffer#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		else
			tabline_string = tabline_string .. "%#TabLine#" .. " " .. tabnum .. ": " .. buffername_short .. " "
		end
	end
	tabline_string = tabline_string .. "%#TabLineFill#"
	return tabline_string
end

vim.o.tabline = "%!v:lua.get_tabline_string()"
vim.o.showtabline = 2

-- Autosave by FocusLost
vim.api.nvim_create_augroup("autosave_buffer", { clear = true })

vim.api.nvim_create_autocmd({ "FocusLost" }, {
	group = "autosave_buffer",
	pattern = "*",
	callback = function()
		local buffername = vim.api.nvim_buf_get_name(0)
		if vim.bo.modified and string.len(buffername) ~= 0 and vim.bo.buftype == "" then
			vim.cmd("w")
		end
	end,
})
