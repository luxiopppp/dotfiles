return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
'      ___           ___           ___           ___                       ___     ',
'     /\\__\\         /\\  \\         /\\  \\         /\\__\\          ___        /\\__\\    ',
'    /::|  |       /::\\  \\       /::\\  \\       /:/  /         /\\  \\      /::|  |   ',
'   /:|:|  |      /:/\\:\\  \\     /:/\\:\\  \\     /:/  /          \\:\\  \\    /:|:|  |   ',
'  /:/|:|  |__   /::\\~\\:\\  \\   /:/  \\:\\  \\   /:/__/  ___      /::\\__\\  /:/|:|__|__ ',
' /:/ |:| /\\__\\ /:/\\:\\ \\:\\__\\ /:/__/ \\:\\__\\  |:|  | /\\__\\  __/:/\\/__/ /:/ |::::\\__\\',
' \\/__|:|/:/  / \\:\\~\\:\\ \\/__/ \\:\\  \\ /:/  /  |:|  |/:/  / /\\/:/  /    \\/__/~~/:/  /',
'     |:/:/  /   \\:\\ \\:\\__\\    \\:\\  /:/  /   |:|__/:/  /  \\::/__/           /:/  / ',
'     |::/  /     \\:\\ \\/__/     \\:\\/:/  /     \\::::/__/    \\:\\__\\          /:/  /  ',
'     /:/  /       \\:\\__\\        \\::/  /       ~~~~         \\/__/         /:/  /   ',
'     \\/__/         \\/__/         \\/__/                                   \\/__/    ',
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", "<cmd>ene<CR>"),
      dashboard.button("e", "  Open file explorer", function() Snacks.picker.explorer() end),
      dashboard.button("f", "󰱼  Find file", function() Snacks.picker.smart() end),
      dashboard.button("t", "  Find text", function() Snacks.picker.grep() end),
      dashboard.button("r", "  Recent used files", function() Snacks.picker.recent() end),
      dashboard.button("s", "󰁯  Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
	    dashboard.button("c", "  Configuration", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end),
      dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
      dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("m", "󱌣  Mason", "<cmd>Mason<CR>"),
      dashboard.button("q", "  Quit NVIM", "<cmd>qa<CR>"),
    }

    -- layout
    dashboard.opts.layout = {
      { type = "padding", val = 4},
      dashboard.section.header,
      { type = "padding", val = 2 }, -- Space between logo and buttons
      dashboard.section.buttons,
      { type = "padding", val = 1 }, -- Space between buttons and recent files
      dashboard.section.footer,
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Draw footer after start
    vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "LazyVimStarted",
    callback = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

      -- Footer
      dashboard.section.footer.val = "⚡ Neovim loaded "
        .. stats.loaded
        .. "/"
        .. stats.count
        .. " plugins in "
        .. ms
        .. "ms"
      pcall(vim.cmd.AlphaRedraw)
      dashboard.section.footer.opts.hl = "AlphaFooter"
    end,
  })

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
