local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local callback = function()
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
				lsp_formatting(bufnr)
			end,
		})
	end
end

local sources = {
	--- C/C++ Formatter
	null_ls.builtins.formatting.clang_format.with({
		extra_args = { "-style", "GNU" },
	}),
	--- Lua Formatter
	null_ls.builtins.formatting.stylua,
	--- asm Formatter
	null_ls.builtins.formatting.asmfmt,
	--- sh Formatter
	null_ls.builtins.formatting.shfmt,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
