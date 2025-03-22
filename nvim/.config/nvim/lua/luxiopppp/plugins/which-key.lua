return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = function()
    local wk = require("which-key")
    wk.add({
      {
        mode = { "n", "v" },
        { "<leader>m", group = "markdown" },
        { "<leader>ms", group = 'spell'},
        { "<leader>msl", group = 'language'},
      },
    })
  end,
}
