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

-- Lorem ipsum
local lorem_words = {
	"lorem",
	"ipsum",
	"dolor",
	"sit",
	"amet",
	"consectetur",
	"adipiscing",
	"elit",
	"sed",
	"do",
	"eiusmod",
	"tempor",
	"incididunt",
	"ut",
	"labore",
	"et",
	"dolore",
	"magna",
	"aliqua",
}

function Lorem(params)
	local n = tonumber(params.args)

	local sentence = ""
	for i = 1, n, 1 do
		local random_index = math.random(1, #lorem_words)
		sentence = sentence .. lorem_words[random_index] .. " "
	end
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. sentence .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
end

vim.api.nvim_create_user_command("Lorem", Lorem, { nargs = 1 })

-- This is needed for js projects where node_modules folder presents.
-- i create an .exrc file in each javascript project so things liek vim's find command will not get stuck searching that.
vim.cmd("set exrc")
vim.cmd("set secure")
vim.cmd("set wildmenu")
helper.Map("n", "<leader>t", ":Lexplore<CR>:vertical resize 50<CR>")

vim.diagnostic.config({
	virtual_text = {
		-- only show when i am on that line.
		current_line = true,
		spacing = 2,
	},
	signs = true, -- show signs in the gutter
	underline = true, -- underline problematic text
	update_in_insert = false, -- don't update diagnostics while typing
	severity_sort = true, -- sort diagnostics by severity
	virtual_lines = false,
})

-- Copy entire buffer
helper.Map("n", "<leader>cb", ":%y+<CR>")

-- Select the entire buffer
helper.Map("n", "<leader>sb", "ggVG")

-- Keymap for tab-Navigation
vim.keymap.set("n", "[b", ":bprevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]B", ":bfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]b", ":blast<CR>", { noremap = true, silent = true })

-- source the current file in place.
vim.keymap.set("n", "<leader>x", "<cmd>source %<CR>")
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

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	group = "autosave_buffer",
	pattern = "*",
	callback = function()
		local buffername = vim.api.nvim_buf_get_name(0)
		if vim.bo.modified and string.len(buffername) ~= 0 and vim.bo.buftype == "" then
			vim.cmd("w")
		end
	end,
})

-- Filetypes to enable spellcheck
local spell_types = { "gitcommit", "markdown" }

-- Disable spell check by default
vim.opt_local.spell = false

vim.api.nvim_create_augroup("Spellcheck", { clear = true })

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "Spellcheck",
	pattern = spell_types,
	callback = function()
		vim.opt_local.spell = true
	end,
	desc = "Enable spell check for defined filetypes",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	callback = function()
		vim.highlight.on_yank()
	end,
})
