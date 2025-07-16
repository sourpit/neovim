local conform = require("conform")

conform.setup({
	log_level = vim.log.levels.DEBUG,
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},

	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		sh = { "shfmt" },
	},
})
