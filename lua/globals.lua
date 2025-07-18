local fn = vim.fn
local api = vim.api

local utils = require("utils")

--- ----------------------------------------------
--- 		Performance improvements
--- ----------------------------------------------
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

--- ----------------------------------------------
--- 		Check python if installed
--- ----------------------------------------------

--- We need python3 for plugins that use python
if utils.executable("python3") then
  if vim.g.is_win then
    vim.g.python3_host_prog = fn.substitute(fn.exepath("python3"), ".exe$", "", "g")
  else
    vim.g.python3_host_prog = fn.exepath("python3")
  end
else
  api.nvim_err_writeln("Python3 executable not found! You must install Python3 and set its PATH correctly!")
  return
end

--- ----------------------------------------------
--- 		custom variables
--- ----------------------------------------------

vim.g.logging_level = vim.log.levels.INFO
vim.g.have_nerd_font = true

--- ----------------------------------------------
--- 		builtin variables
--- ----------------------------------------------
vim.g.loaded_perl_provided = 0      -- Disable perl provider
vim.g.loaded_ruby_provided = 0      -- Disable ruby provider
vim.g.loaded_node_provided = 0      -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

-- Custom mapping <leader> (see `:h mapleader` for more info)
vim.g.mapleader = " "

-- Enable highlighting for lua HERE doc inside vim script
vim.g.vimsyn_embed = "l"

-- Use English as main language
vim.cmd([[language en_US.UTF-8]])

-- Think of C Headers for C files
vim.g.c_syntax_for_h = 1

--- ----------------------------------------------
--- 		Disable loading certain plugins
--- ----------------------------------------------

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not load the tutor plugin
vim.g.loaded_tutor_mode_plugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- Disable sql omni completion, it is broken.
vim.g.loaded_sql_completion = 1

-- control how to show health check window
vim.g.health = { style = nil }
