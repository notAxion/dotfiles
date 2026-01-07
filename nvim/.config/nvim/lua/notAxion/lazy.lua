-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.1",
    -- or                            , branch = '0.1.x',
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")
    end,
  },

  -- 'morhetz/gruvbox',
  "ellisonleao/gruvbox.nvim",
  -- 'navarasu/onedark.nvim',
  -- 'nanotech/jellybeans.vim',
  -- 'sickill/vim-monokai',
  -- 'fatih/molokai',

  -- git wrapper magic
  "tpope/vim-fugitive",

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update({ with_sync = true }))
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      multiline_threshold = 5,
    },
  },

  -- to show inline git changes
  "mhinz/vim-signify",
  {
    "petertriho/nvim-scrollbar",
    opts = {},
    -- config = function ()
    -- 	require("scrollbar").setup()
    -- end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  "mbbill/undotree",
  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs",
  {
    "aserowy/tmux.nvim",
    opts = {},
    -- config = function()
    -- 	return require("tmux").setup()
    -- end,
  },

  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  -- install with npm i guess ?
  --	{ "iamcco/markdown-preview.nvim", build = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Formatter Support
      -- { "mhartington/formatter.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },

      -- useful status update for LSP
      {
        "j-hui/fidget.nvim",
        version = "v1.6.1",
      },
    },
  },

  -- mason installed formatter
  {
    {
      "nvimtools/none-ls.nvim",
      config = function()
        local nls = require("null-ls")
        local fmt = nls.builtins.formatting
        local dgn = nls.builtins.diagnostics
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        nls.setup({
          sources = {
            -- # FORMATTING #
            fmt.google_java_format.with({ extra_args = { "--aosp" } }),
            -- # DIAGNOSTICS #
            dgn.checkstyle.with({
              extra_args = {
                "-c",
                -- vim.fn.expand("~/.config/checkstyle/sun_checks.xml"),
                vim.fn.expand("~/.config/checkstyle/google_checks.xml"),
              },
            }),
          },
          on_attach = function(client, bufnr)
            if client and client:supports_method("textDocument/formatting") then
              vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
              vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                  vim.lsp.buf.format({ bufnr = bufnr })
                end,
              })
            end
          end,
        })
      end,
    },
    {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
      },
      opts = {
        ensure_installed = {
          "prettier",
          "shfmt",
          "gofmt",
          "goimports",
          "golines",
          "stylua",
          "dartformat",
          "black",
          "checkstyle",
          "google-java-format",
        },
        -- automatic_installation = false,
        handlers = {},
      },
    },
  },

  -- breadcrumbs (statusbar/winbar shows current code context)
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },

  -- popup display to navigate at different levels of code
  --	{
  -- 	"SmiteshP/nvim-navbuddy",
  -- 	dependencies = {
  -- 		"neovim/nvim-lspconfig",
  -- 		"SmiteshP/nvim-navic",
  -- 		"MunifTanjim/nui.nvim",
  -- 		"numToStr/Comment.nvim",        -- Optional
  -- 		"nvim-telescope/telescope.nvim" -- Optional
  -- 	}
  -- },

  -- lsp, debug application, hot reload etc for flutter
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
  },

  -- debugging
  "mfussenegger/nvim-dap",
  -- 'rcarriga/nvim-dap-ui',
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  "theHamsta/nvim-dap-virtual-text",
  -- 'nvim-telescope/telescope-dap.nvim',
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
      {
        "microsoft/vscode-js-debug",
        lazy = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    -- ft = { "js", "ts", "mjs" },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
  },

  {
    "leoluz/nvim-dap-go",
    dependencies = "mfussenegger/nvim-dap",
    opts = {},
    -- config = function(_, opts)
    -- 	require("dap-go").setup(opts)
    -- end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    -- opts = {},
  },
  -- some neet features for go
  {
    "olexsmir/gopher.nvim",
    ft = { "go" },
    -- branch = "develop",
    -- config = function(_, opts)
    -- 	require("gopher"),setup({
    -- 		gotag = {
    -- 			transform = "camelcase",
    -- 		},
    -- 	})
    -- end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
  -- 'mfussenegger/nvim-jdtls',
  "nvim-java/nvim-java",

  -- {
  -- 	"linux-cultist/venv-selector.nvim",
  -- 	dependencies = {
  -- 		"neovim/nvim-lspconfig",
  -- 		{ "nvim-telescope/telescope.nvim", tag = "v0.2.1", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  -- 	},
  -- 	ft = "python", -- Load when opening Python files
  -- 	keys = {
  -- 		{ ",v", "<cmd>VenvSelect<cr>" }, -- Open picker on keymap
  -- 	},
  -- 	opts = { -- this can be an empty lua table - just showing below for clarity.
  -- 		search = {}, -- if you add your own searches, they go here.
  -- 		options = {}, -- if you add plugin options, they go here.
  -- 	},
  -- },

  "ThePrimeagen/vim-be-good",
  {
    "stevearc/oil.nvim",
    lazy = false,
    opts = {
      default_file_explorer = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    },
    keys = {
      { "<leader>f", "<cmd>Oil<cr>", desc = "open oil file explorer" },
      -- can't disable like this for some reason
      -- { "<C-l>", false },
      -- { "g?", false },
    },
    -- config = function()
    -- 	require("oil").setup()
    -- end,
  },
  {
    "cameron-wags/rainbow_csv.nvim",
    opts = {},
    -- config = function()
    -- 	require("rainbow_csv").setup()
    -- end,
    -- optional lazy-loading below
    -- module = {
    -- 	"rainbow_csv",
    -- 	"rainbow_csv.fns",
    -- },
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        highlight = {
          pattern = [[.*\s<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
        },
        search = {
          pattern = [[\b(KEYWORDS)\b]], -- might give false positives default = [[\b(KEYWORDS):]]
        },
      })
    end,
  },
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", lazy = false, opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      vim.keymap.set("n", "<leader>oa", function()
        require("opencode").ask("@buffer: ", { submit = true })
      end, { desc = "Ask opencode" })
      vim.keymap.set("v", "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode" })
      -- Recommended/example keymaps.
      -- vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      -- vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
      -- vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add to opencode" })
      -- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      -- vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "opencode half page up" })
      -- vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
      -- -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  },
})
