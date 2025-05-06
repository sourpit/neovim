--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme_conf = {
	gruvbox_material = function()
		-- foreground option can be material, mix, or original
		vim.g.gruvbox_material_foreground = "original"
		--background option can be hard, medium, soft
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_enable_italic = 1
		vim.g.gruvbox_material_better_performance = 1

		vim.cmd([[colorscheme gruvbox-material]])
	end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
	local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme_conf))

	-- Load the colorscheme and its settings
	M.colorscheme_conf[colorscheme]()
end

return M
