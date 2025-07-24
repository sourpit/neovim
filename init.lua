vim.loader.enable()

local utils = require("utils")

local config_dir = vim.fn.stdpath("config")
---@cast config_dir string

-- some global settings
require("globals")

-- various autocommands
require("custom-autocmd")

-- all the user-defined mappings
require("mappings")

-- diagnostic related config
require("diagnostic-conf")

-- put this in your main init.lua file ( before lazy setup )
vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

-- all the plugins installed and their configurations
vim.cmd("source " .. vim.fs.joinpath(config_dir, "viml_conf/plugins.vim"))
-- setting options in nvim
vim.cmd("source " .. vim.fs.joinpath(config_dir, "viml_conf/options.vim"))

-- (method 1, For heavy lazyloaders)
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")

-- -- (method 2, for non lazyloaders) to load all highlights at once
for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
	dofile(vim.g.base46_cache .. v)
end
