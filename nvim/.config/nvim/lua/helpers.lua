-- this file provides some helper function for my neovim configuration.
-- for example, writing "vim.keymap.set()" can be repetitive. here we provide something like Map(), easier to remember and more rebust

local M = {}

--- Maps a key combination to a command in Neovim.
-- @param mode The mode in which the mapping is active (e.g., 'n' for normal mode).
-- @param lhs The left-hand side of the mapping (the key combination).
-- @param rhs The right-hand side of the mapping (the command to execute).
-- @param option Optional table of options for the mapping (default: { noremap = true, silent = true }).
function M.Map(mode, lhs, rhs, option)
	option = option or { noremap = true, silent = true }
	vim.keymap.set(mode, lhs, rhs, option)
end

function M.GetBufferType(tabnumber)
	local winnr = vim.fn.tabpagewinnr(tabnumber)
	local bufferlist = vim.fn.tabpagebuflist(tabnumber)[winnr]
	if bufferlist then
		return vim.bo[bufferlist].buftype
	else
		return nil
	end
end

return M
