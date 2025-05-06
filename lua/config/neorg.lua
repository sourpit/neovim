local org = require("neorg")

org.setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.integrations.nvim-cmp"] = {},
		["core.integrations.treesitter"] = {},
		["core.export.markdown"] = {},
		["core.journal"] = {},
		["core.presenter"] = {
			config = {
				zen_mode = "zen-mode",
			},
		},
		["core.dirman"] = {
			config = {
				workspaces = {
					daPit = "~/repo/daPit",
					notes = "~/repo/notes",
				},
				default_workspace = "notes",
				index = "index.norg",
			},
		},
	},
})
