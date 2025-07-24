local fzf = require("fzf-lua")

fzf.setup({
	lsp = {
		-- make lsp requests synchronous so they work with null-ls
		async_or_timeout = 3000,
	},
	oldfiles = {
		include_current_session = true,
		cwd_only = true,
		stat_file = true, -- verify files exist on disk
	},
	previewers = {
		builtin = {
			syntax_limit_b = 1024 * 100, -- 100kb
		},
	},
})
