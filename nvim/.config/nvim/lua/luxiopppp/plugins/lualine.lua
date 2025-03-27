local function get_path()
  local path = vim.fn.expand('%:p')
  local icon, _ = require('nvim-web-devicons').get_icon(path)

  local trimmed_path = vim.fn.fnamemodify(path, ":~3")

  if icon then
    return icon .. ' ' .. trimmed_path
  else
    return trimmed_path
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function ()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local noice_status = require("noice.api.status")
    local custom_gruvbox = require("lualine.themes.gruvbox-material")

    custom_gruvbox.visual.a.bg = "#98971a"
    custom_gruvbox.insert.a.bg = "#458588"
    custom_gruvbox.replace.a.bg = "#cc241d"

    lualine.setup({
      options = {
        theme = custom_gruvbox,
        section_separators = '',
        component_separators = '|',
        disabled_filetypes = { "NvimTree", }
      },
      sections = {
        lualine_b = {
          { "branch", icon = "", color = { gui = "bold" } },
          { "diff" },
          { "diagnostics" },
        },
        lualine_c = {
          get_path
        },
        lualine_x = {
          { function () return vim.wo.spell and "Spell On" or "" end, color = { bg = "#b16286" } },
          {
            noice_status.command.get,
            cond = noice_status.command.has,
            color = { fg = "#fe8019" },
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#fe8019" },
          },
        },
        lualine_y = {
          -- { function () return vim.fn.getfperm(vim.api.nvim_buf_get_name(0)) end },
        },
        lualine_z = {
          { "location", padding = { left = 0, right = 1 } },
        },
      }
    })
  end,
}
