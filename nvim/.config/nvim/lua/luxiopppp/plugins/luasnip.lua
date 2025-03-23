return {
  "L3MON4D3/LuaSnip",
  config = function ()
    local ls = require('luasnip')

    ls.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
      override_builtin = true,
    }

    -- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/luxiopppp/snippets/*.lua", true)) do
    --   loadfile(ft_path)()
    -- end

    -- require("luasnip.loaders.from_vscode").lazy_load()
    -- require("luasnip.loaders.from_vscode").load({ path = "~/.config/nvim/snippets" })

    vim.keymap.set({ "i", "s" }, "<Tab>", function () return ls.expand_or_jumpable() and ls.jump(1) or "<Tab>" end, { desc = "LuaSnip forward jump", expr = true })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function () return ls.jumpable(-1) and ls.jump(-1) or "<S-Tab>" end, { desc = "LuaSnip backward jump", expr = true })

  end
}
