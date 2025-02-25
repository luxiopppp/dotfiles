return {
  "rmagatti/auto-session",
  config = function()
    local as = require("auto-session")

    as.setup({
      auto_restore_enabled = false,
      auto_session_suppress_dirs = {},
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
  end,
}
