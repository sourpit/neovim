local conform = require("conform")

conform.setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

conform.formatters.clang_format = {
  inherit = false,
  command = "clang-format",
  args = { "-style", "GNU" },
}

conform.formatters.stylua = {
  inherit = false,
  command = "stylua",
}
