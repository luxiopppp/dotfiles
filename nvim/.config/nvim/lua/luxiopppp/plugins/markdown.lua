return {
  { "jubnzv/mdeval.nvim" },
  { "ixru/nvim-markdown" },
  { "dhruvasagar/vim-open-url" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
  },
  { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  {
    "jbyuki/nabla.nvim",
    config = function ()
      vim.api.nvim_set_keymap("n", "<leader>mm", ":lua require('nabla').popup()<CR>", { noremap = true, silent = true })
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
