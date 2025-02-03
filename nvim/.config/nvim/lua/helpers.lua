-- this file provides some helper function for my neovim configuration.
-- for example, writing "vim.keymap.set()" can be repetitive. here we provide something like Map(), easier to remember and more rebust

local M = {}

-- Mapping keys to execute some vim commands...
function M.Map(mode,lhs,rhs,option)
	option = option or { noremap = true, silent = true }
	vim.keymap.set(mode,lhs,rhs,option)
end


return M
