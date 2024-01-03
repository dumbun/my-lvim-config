-- lvim.colorscheme = "lunar"
lvim.transparent_window = true
vim.g.tokyonight_style = "night"



lvim.use_icons = true

lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "catppuccin"
vim.opt.relativenumber = true

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
--
--
-- plugins
--
--



-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "clangd"
}


local luasnip = require("luasnip")
luasnip.filetype_extend("dart", { "flutter" })

lvim.plugins = {
  { "mfussenegger/nvim-dap" },

  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
    config = function()
      require('flutter-tools').setup {
        -- (uncomment below line for windows only)
        -- flutter_path = "home/flutter/bin/flutter.bat",
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
                dartSdkPath = '/Users/vamshikrishna/Development/flutter/bin/flutter',
                flutterSdkPath = '/Users/vamshikrishna/Development/flutter/bin/dart',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              }
            }
            -- uncomment below line if you've launch.json file already in your vscode setup
            -- require("dap.ext.vscode").load_launchjs()
          end,
        },
        dev_log = {
          -- toggle it when you run without DAP
          enabled = false,
          open_cmd = "tabedit",
        },
        lsp = {
          on_attach = require("lvim.lsp").common_on_attach,
          capabilities = require("lvim.lsp").default_capabilities,
        },

      }
    end
  },
  -- for dart syntax hightling
  {
    "dart-lang/dart-vim-plugin"
  },
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

  -- {
  --   "akinsho/flutter-tools.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "stevearc/dressing.nvim", -- optional for vim.ui.select
  --   },
  --   config = function()
  --     require("flutter-tools").setup({
  --       flutter_path = "/Users/vamshikrishna/Development/flutter/bin/flutter",
  --       root_patterns = { ".git", "pubspec.yaml" },
  --       closing_tags = {
  --         highlight = "ErrorMsg", -- highlight for the closing tag
  --         prefix = "//",          -- character to use for close tag e.g. > Widget
  --         enabled = true,         -- set to false to disable
  --       },
  --       dev_log = {
  --         enabled = true,
  --         notify_errors = false, -- if there is an error whilst running then notify the user
  --         open_cmd = "tabedit",  -- command to use to open the log buffer
  --       },
  --       outline = {
  --         open_cmd = "30vnew", -- command to use to open the outline buffer
  --         auto_open = false    -- if true this will open the outline automatically when it is first populated
  --       },
  --       lsp = {
  --         color = { -- show the derived colours for dart variables
  --           enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
  --           background = true, -- highlight the background
  --           background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
  --           foreground = false, -- highlight the foreground
  --           virtual_text = false, -- show the highlight using virtual text
  --           virtual_text_str = "■", -- the virtual text character to highlight
  --         },
  --       },
  --       capabilities = function(config)
  --         config.specificThingIDontWant = false
  --         return config
  --       end,
  --       settings = {
  --         showTodos = true,
  --         completeFunctionCalls = true,
  --         --analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
  --         renameFilesWithClasses = "prompt", -- "always"
  --         enableSnippets = true,
  --         updateImportsOnRename = true,      -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
  --       },
  --       widget_guides = {
  --         enabled = true,
  --       },
  --     })
  --   end,
  -- },


}
--autoo commands



-- lvim.autocommands = {
-- autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()

-- autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- }



-- -- keyBingings
-- --
-- -- vim.lsp.buf.document_highlight()
-- -- vim.lsp.buf.references()
-- -- vim.lsp.buf.clear_references()
-- lvim.lsp.buffer_mappings.normal_mode['H'] = { vim.lsp.buf.references(), "Show references" }
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client.server_capabilities.hoverProvider then
--       vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
--   end,
-- })

-- lvim.keys.normal_mode["<C-t>"] = ":ToggleTermToggle<CR>"

-- lvim.lsp.buffer_mappings.normal_mode['H'] = { vim.lsp.buf.hover, "Show documentation" }
-- vim.api.nvim_create_autocmd("<buffer>", {
-- command = "vim.lsp.buf.document_highlight()",
-- })
