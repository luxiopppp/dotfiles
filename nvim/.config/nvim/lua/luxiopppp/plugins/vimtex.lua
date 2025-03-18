return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.tex_flavor = 'latex'                     -- Set file type for TeX files
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_mode = 0                 -- Suppress quickfix on save/build
    vim.g.tex_conceal = 'abdmg'
  end
}
