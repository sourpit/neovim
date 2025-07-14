local utils = require("utils")

local plugin_dir = vim.fn.stdpath("data") .. "/lazy"
local lazypath = plugin_dir .. "/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugin_specs = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    config = function()
      require("config.treesitter")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    branch = "master",
    config = function()
      require("config.treesitter-textobjects")
    end,
  },
  { -- using the ol'reliable lsp
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("config.lsp")
    end,
  },
  { -- auto-completion engine
    "hrsh7th/nvim-cmp",
    name = "nvim-cmp",
    event = "VeryLazy",
    config = function()
      require("config.nvim-cmp")
    end,
  },
  {
    "nvim-neorg/neorg",
    version = "*", -- Pin Neorg to the latest stable release
    lazy = true,
    cmd = "Neorg",
    config = function()
      require("config.neorg")
    end,
  },
  -- This takes so much time
  { "quangnguyen30192/cmp-nvim-ultisnips", lazy = true },
  { "hrsh7th/cmp-nvim-lsp",                lazy = true },
  { "hrsh7th/cmp-path",                    lazy = true },
  { "hrsh7th/cmp-buffer",                  lazy = true },
  { "hrsh7th/cmp-omni",                    lazy = true },
  { "hrsh7th/cmp-cmdline",                 lazy = true },
  { "onsails/lspkind-nvim",                lazy = true },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
  },
  {
    "dnlhc/glance.nvim",
    config = function()
      require("config.glance")
    end,
    event = "VeryLazy",
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = { "BufReadPre" },
    config = function()
      require("config.mason")
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("config.conform")
    end,
  },
  { "machakann/vim-swap",          event = "VeryLazy" },
  { -- Super fast buffer jump
    "smoka7/hop.nvim",
    event = "VeryLazy",
    config = function()
      require("config.nvim_hop")
    end,
  },
  -- Show match number and index for searching
  {
    "kevinhwang91/nvim-hlslens",
    branch = "main",
    keys = { "*", "#", "n", "N" },
    config = function()
      require("config.hlslens")
    end,
  },
  {
    "Yggdroot/LeaderF",
    cmd = "Leaderf",
    build = function()
      local leaderf_path = plugin_dir .. "/LeaderF"
      vim.opt.runtimepath:append(leaderf_path)
      vim.cmd("runtime! plugin/leaderf.vim")

      if not vim.g.is_win then
        vim.cmd("LeaderfInstallCExtension")
      end
    end,
  },
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-telescope/telescope-symbols.nvim",
    },
  },
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({
        lsp = {
          -- make lsp requests synchronous so they work with null-ls
          async_or_timeout = 3000,
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
  },
  -- A list of colorscheme plugin you may want to try.
  { "sainnhe/gruvbox-material",    priority = 1000 },
  { "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    config = function()
      require("config.indent-blankline")
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    opts = {},
    config = function()
      require("config.nvim-statuscol")
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {},
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function()
      require("config.nvim_ufo")
    end,
  },

  -- Highlight URLs inside vim
  { "itchyny/vim-highlighturl", event = "VeryLazy" },

  -- notification plugin
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("config.nvim-notify")
    end,
  },

  -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
  -- not be possible since we maybe in a server which disables GUI.
  {
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,      -- default settings
    submodules = false, -- not needed, submodules are required only for tests
  },

  -- Snippet engine and snippet template
  {
    "SirVer/ultisnips",
    dependencies = {
      "honza/vim-snippets",
      "rafamadriz/friendly-snippets",
    },
    event = "InsertEnter",
  },

  -- Automatic insertion and deletion of a pair of characters
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "sontungexpt/sttusline",
    branch = "table_version",
    event = { "BufEnter" },
    config = function()
      require("config.sttusline")
    end,
  },

  -- vim startuptime
  {
    "dstein64/vim-startuptime",
    event = "VeryLazy",
  },

  -- Comment plugin
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = "n" },
      { "gc", mode = "v" },
    },
  },

  -- Show undo history visually
  { "simnalamburt/vim-mundo",   cmd = { "MundoToggle", "MundoShow" } },

  -- Manage your yank history
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = function()
      require("config.yanky")
    end,
  },

  -- Handy unix command inside Vim (Rename, Move etc.)
  { "tpope/vim-eunuch",          cmd = { "Rename", "Delete" } },

  -- Repeat vim motions
  { "tpope/vim-repeat",          event = "VeryLazy" },

  { "nvim-zh/better-escape.vim", event = { "InsertEnter" } },

  -- Git command inside vim
  {
    "tpope/vim-fugitive",
    event = "User InGitRepo",
    config = function()
      require("config.fugitive")
    end,
  },

  -- Better git log display
  { "rbong/vim-flog",                   cmd = { "Flog" } },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("config.git-conflict")
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "User InGitRepo",
    config = function()
      require("config.git-linker")
    end,
  },

  -- Show git change (change, delete, add) signs in vim sign column
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead" },
    config = function()
      require("config.gitsigns")
    end,
  },

  {
    "sindrets/diffview.nvim",
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = function()
      require("config.bqf")
    end,
  },

  -- Faster footnote generation
  { "vim-pandoc/vim-markdownfootnotes", lazy = true,       ft = { "markdown" } },

  -- Additional powerful text object for vim, this plugin should be studied
  -- carefully to use its full power
  { "wellle/targets.vim",               event = "VeryLazy" },

  -- Plugin to manipulate character pairs quickly
  { "machakann/vim-sandwich",           event = "VeryLazy" },

  {
    "lervag/vimtex",
    lazy = true,
    ft = { "tex" },
    config = function()
      require("config.vimtex")
    end,
  },

  -- Add indent object for vim (useful for languages like Python)
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" },

  -- Since tmux is only available on Linux and Mac, we only enable these plugins
  -- for Linux and Mac
  -- .tmux.conf syntax highlighting and setting check
  {
    "tmux-plugins/vim-tmux",
    enabled = function()
      if utils.executable("tmux") then
        return true
      end
      return false
    end,
    ft = { "tmux" },
  },

  -- Modern matchit implementation
  { "andymass/vim-matchup",            event = "BufRead" },
  { "tpope/vim-scriptease",            cmd = { "Scriptnames", "Messages", "Verbose" } },

  -- Asynchronous command execution
  { "skywind3000/asyncrun.vim",        cmd = { "AsyncRun" } },
  { "cespare/vim-toml",                ft = { "toml" },                               branch = "main" },

  -- Debugger plugin
  {
    "sakhnik/nvim-gdb",
    build = { "bash install.sh" },
    ft = { "c", "cpp" },
  },

  {
    "ThePrimeagen/vim-be-good",
    cmd = "Gitgud",
  },

  -- Session management plugin
  { "tpope/vim-obsession",   cmd = "Obsession" },

  {
    "folke/zen-mode.nvim",
    lazy = true,
    dependencies = { "folke/twilight.nvim" },
    config = function()
      require("config.zenmode")
    end,
  },

  -- showing keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("config.which-key")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- more beautiful vim.ui.input
      input = {
        enabled = true,
        win = {
          relative = "cursor",
          backdrop = true,
        },
      },
      -- more beautiful vim.ui.select
      picker = { enabled = true },
      dashboard = { enabled = true },
    },
  },

  -- show and trim trailing whitespaces
  { "jdhao/whitespace.nvim", event = "VeryLazy" },

  -- -- file explorer
  -- {
  -- 	"nvim-tree/nvim-tree.lua",
  -- 	event = "VeryLazy",
  -- 	dependencies = { "nvim-tree/nvim-web-devicons" },
  -- 	config = function()
  -- 		require("config.nvim-tree")
  -- 	end,
  -- },

  -- better file explorer
  {
    "ms-jpq/chadtree",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = "CHADopen",
    config = function()
      require("config.chadtree")
    end,
  },

  { -- Cmake integration
    "cdelledonne/vim-cmake",
    lazy = true,
    ft = { "c", "cpp" },
  },
  -- Only install these plugins if ctags are installed on the system
  -- show file tags in vim window
  {
    "liuchengxu/vista.vim",
    enabled = function()
      return utils.executable("ctags")
    end,
    cmd = "Vista",
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    tag = "legacy",
    config = function()
      require("config.fidget-nvim")
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {},
  },
  {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via Git tags
    -- tag = "2.*",
    cmd = "Preview",
    config = function()
      require("config.live-command")
    end,
    event = "VeryLazy",
  },
  {
    "aklt/plantuml-syntax",
    ft = { "puml", "pu", "uml", "iuml", "plantuml" },
  },
  {
    -- show hint for code actions, the user can also implement code actions themselves,
    -- see discussion here: https://github.com/neovim/neovim/issues/14869
    "kosayoda/nvim-lightbulb",
    config = function()
      require("config.lightbulb")
    end,
    event = "LspAttach",
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = { -- set to setup table
    },
  },
}

require("lazy").setup({
  spec = plugin_specs,
  ui = {
    border = "rounded",
    title = "Plugin Manager",
    title_pos = "center",
  },
  rocks = {
    enabled = true,
    hererocks = false,
  },
})
