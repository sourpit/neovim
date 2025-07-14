vim.loader.enable()

local utils = require("utils")

local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

-- all the plugins installed and their configurations
vim.cmd("source " .. vim.fs.joinpath(config_dir, "viml_conf/plugins.vim"))
-- setting options in nvim
vim.cmd("source " .. vim.fs.joinpath(config_dir, "viml_conf/options.vim"))
-- some global settings
require("globals")

-- colorscheme settings
----------------------------------------------

-- foreground option can be material, mix, or original
vim.g.gruvbox_material_foreground = "original"
--background option can be hard, medium, soft
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_better_performance = 1
vim.cmd.colorscheme("gruvbox-material")

-- various autocommands
require("custom-autocmd")
-- all the user-defined mappings
require("mappings")
-- diagnostic related config
require("diagnostic-conf")
