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
}
