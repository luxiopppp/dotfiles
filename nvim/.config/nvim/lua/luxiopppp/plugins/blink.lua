return {
  'saghen/blink.cmp',
  enabled = function ()
    return not vim.list_contains({ "DressingInput" }, vim.bo.filetype)
  end,
  event = "InsertEnter",
  version = '*',
  opts_extend = { "sources.default" },
  dependencies = {
    -- 'moyiz/blink-emoji',
    {
      'L3MON4D3/LuaSnip',
      lazy = true,
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function ()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({
              paths = { vim.fn.stdpath("config") .. "/snippets" }
            })
          end,
        },
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
    },
  },
  opts = function()
    return {
      snippets = { preset = 'luasnip', },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', },
        -- providers = {
        --   emoji = {
        --     module = "blink-emoji",
        --     name = 'Emoji',
        --     score_offset = 15,
        --     opts = { insert = true },
        --   }
        -- }
      },

      completion = {
        list = {
          selection = { preselect = true, auto_insert = false }
        },
        accept = {
          auto_brackets = {
            enabled = true,
          }
        },
        menu = {
          -- border = "rounded",
          winblend = 10,
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            -- border = "rounded",
            winblend = 10,
          },
          auto_show_delay_ms = 100,
        },
        ghost_text = {
          enabled = true,
        }
      },

      signature = {
        enabled = true,
        window = {
          -- border = "rounded",
          winblend = 10,
        },
      },

      keymap = {
        preset = 'default',
        ["<C-Space>"] = { "show", "hide" },
        ["<C-e>"] = { "show_documentation", "hide_documentation" },

        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },

        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },

      appearance = {
        nerd_font_variant = 'mono'
      },


      fuzzy = { implementation = "lua", },


    }
  end,
}
