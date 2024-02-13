-- text wrap
vim.cmd("set wrap")
vim.cmd("set textwidth=180")
-- lvim.transparent_window = true
-- lvim.colorscheme = "catppuccin"
lvim.colorscheme = "tokyonight"
-- vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme tokyonight") -- for night themes
-- vim.cmd("colorscheme catppuccin") -- for night themes
vim.g.tokyonight_style = "night"
lvim.use_icons = true
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
vim.opt.relativenumber = true
vim.g.italic_variables = true -- italic variables(Default: false)
vim.g.italic_functions = true -- italic functions(Default: false)
vim.api.nvim_set_hl(0, 'class', { italic = true })
-- lvim.builtin.lualine.style = "default" -- or "none"
-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "tsserver",
  "clangd",
}

local luasnip = require("luasnip")
luasnip.filetype_extend("dart", { "flutter" })
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.telescope.on_config_done = function(telescope)
  telescope.load_extension "flutter"
end


lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.plugins = {


  {
    'simrat39/rust-tools.nvim',
    config = function()

    end
  },


  { "bluz71/vim-nightfly-colors" },

  { "folke/tokyonight.nvim" },

  -- {
  --   'wfxr/minimap.vim',
  --   build = "cargo install --locked code-minimap",
  --   cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
  --   config = function()
  --     vim.cmd("let g:minimap_width = 10")
  --     vim.cmd("let g:minimap_auto_start = 1")
  --     vim.cmd("let g:minimap_auto_start_win_enter = 1")
  --   end,
  -- },


  { "saadparwaiz1/cmp_luasnip" },


  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },

  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120,              -- Width of the floating window
        height = 25,              -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false,            -- Print debug information
        opacity = nil,            -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil,     -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>"),
        vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>"),
        vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>"),
      }
    end
  },

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },

  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   build = ":TSUpdate",
  --   config = function()
  --     local config = require("nvim-treesitter.configs")
  --     config.setup({

  --       auto_install = true,
  --       highlight = { enable = true },
  --       indent = { enable = true },
  --     })
  --   end
  -- },

  {
    "mrjones2014/nvim-ts-rainbow",
  },

  { "mfussenegger/nvim-dap" },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      require('flutter-tools').setup {
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = false,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = true,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = false,
          }
        },
        dev_log = {
          enabled = true,
          notify_errors = true, -- if there is an error whilst running then notify the user
          open_cmd = "tabedit", -- command to use to open the log buffer
        },

        -- for widget guides lines in the code
        -- widget_guides = {
        --   enabled = true,
        -- },
        --
        debugger = {
          -- make these two params true to enable debug mode
          enabled = false,
          run_via_dap = false,
          register_configurations = function(_)
            require("dap").adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" }
            }

            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch flutter",
                dartSdkPath = '/Users/vamshikrishna/Development/flutter/bin/dart',
                flutterSdkPath = '/Users/vamshikrishna/Development/flutter/bin/flutter',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              }
            }
            -- uncomment below line if you've launch.json file already in your vscode setup
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          renameFilesWithClasses = "prompt", -- "always"
          enableSnippets = true,
          updateImportsOnRename = true,      -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
          enableSdkFormatter = true,
        },
        lsp = {
          on_attach = require("lvim.lsp").common_on_attach,
          capabilities = require("lvim.lsp").default_capabilities,
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = true, -- highlight the background
            background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight

          },
        },
      }
    end
  },
  -- for dart syntax hightling
  {
    "dart-lang/dart-vim-plugin"
  },

  -- {
  --   "aserowy/tmux.nvim",
  --   config = function()
  --     require("tmux").setup {
  --       navigation = {
  --         -- cycles to opposite pane while navigating into the border
  --         -- cycle_navigation = true,

  --         -- enables default keybindings (C-hjkl) for normal mode
  --         enable_default_keybindings = true,

  --         -- prevents unzoom tmux when navigating beyond vim border
  --         persist_zoom = true,
  --       },
  --       resize = {
  --         -- enables default keybindings (A-hjkl) for normal mode
  --         enable_default_keybindings = true,
  --       },
  --     }
  --   end,
  -- },


  { "catppuccin/nvim",      name = "catppuccin", priority = 1000 },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },

  {
    "rcarriga/nvim-notify"
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },

  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },

}


-- keybindings

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}


-- auto cmds

lvim.autocommands = {

  -- {
  --   "BufEnter", -- see `:h autocmd-events`
  --   {           -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
  --     command = "Minimap",
  --   }
  -- }

}

lvim.builtin.telescope = {
  active = true,
  defaults = {
    layout_strategy = "horizontal",
    path_display = { truncate = 2 }
  }
}
