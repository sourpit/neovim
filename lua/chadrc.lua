local M = {}

M.base46 = {
	theme = "doomchad",
	transparency = false,
}

M.ui = {
	statusline = {
		enabled = true,
		theme = "default",
		separator_style = "default",
		order = nil,
		modules = nil,
	},
}

M.term = {
	base46_colors = true,
	winopts = { number = false, relativenumber = false },
	sizes = {
		sp = 0.3,
		vsp = 0.2,
		["bo sp"] = 0.3,
		["bo vsp"] = 0.2,
	},
	float = {
		relative = "editor",
		row = 0.3,
		col = 0.25,
		width = 0.5,
		height = 0.4,
		border = "single",
	},
}

M.nvdash = {
	load_on_startup = true,
	header = {
		"                      ",
		"  ▄▄         ▄ ▄▄▄▄▄▄▄",
		"▄▀███▄     ▄██ █████▀ ",
		"██▄▀███▄   ███        ",
		"███  ▀███▄ ███        ",
		"███    ▀██ ███        ",
		"███      ▀ ███        ",
		"▀██ █████▄▀█▀▄██████▄ ",
		"  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀",
		"                      ",
		"  Powered By  eovim ",
		"                      ",
	},

	buttons = {
		{ txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
		{ txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
		{ txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
		{ txt = "󱥚  Themes", keys = "th", cmd = "Telescope themes" },

		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " ms"
				return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
		},

		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	},
}

M.lsp = { signature = true }

return M
