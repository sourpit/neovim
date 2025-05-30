-- PDF Viewer:
-- http://manpages.ubuntu.com/manpages/trusty/man5/zathurarc.5.html
vim.g['vimtex_view_method'] = 'zathura_simple'
vim.g['vimtex_quickfix_mode'] =0

-- Ignore mappings
vim.g['vimtex_mappings_enabled'] = 1

-- Auto Indent
vim.g['vimtex_indent_enabled'] = 1

-- Syntax highlighting
vim.g['vimtex_syntax_enabled'] = 1

-- Error suppression:
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt

vim.g['vimtex_log_ignore'] = ({
  'Underfull',
  'Overfull',
  'specifier changed to',
  'Token not allowed in a PDF string',
})

vim.g['vimtex_context_pdf_viewer'] = 'zathura'

vim.g['vimtex_compiler_method'] = 'latexmk'
vim.g['vimtex_compiler_latexmk'] = {
      aux_dir = ".build",
      -- out_dir = "",
      options = {
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      }
    }

-- vim.g['vimtex_complete_enabled'] = 1
-- vim.g['vimtex_compiler_progname'] = 'nvr'
-- vim.g['vimtex_complete_close_braces'] = 1
