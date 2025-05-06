local conform = require("conform")

conform.setup{
    format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

conform.formatters.clang_format = {
  inherit = false,
  command = "shfmt",
  args = { "-style", "GNU" },
}
