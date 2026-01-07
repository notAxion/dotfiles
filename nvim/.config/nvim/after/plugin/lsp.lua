local lsp = require("lsp-zero")

-- deprecated in v4.x
-- lsp.preset("recommended")

-- -- Fix Undefined global 'vim'
-- lsp.configure("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 		},
-- 	},
-- })

-- breadcrumbs
-- local navicPresent, navic = pcall(require, "nvim-navic")
-- if navicPresent then
-- 	-- navic.setup{}
-- 	navic.setup {
-- 		icons = {
-- 			File          = "󰈙 ",
-- 			Module        = " ",
-- 			Namespace     = "󰌗 ",
-- 			Package       = " ",
-- 			Class         = "󰌗 ",
-- 			Method        = "󰆧 ",
-- 			Property      = " ",
-- 			Field         = " ",
-- 			Constructor   = " ",
-- 			Enum          = "󰕘",
-- 			Interface     = "󰕘",
-- 			Function      = "󰊕 ",
-- 			Variable      = "󰆧 ",
-- 			Constant      = "󰏿 ",
-- 			String        = "󰀬 ",
-- 			Number        = "󰎠 ",
-- 			Boolean       = "◩ ",
-- 			Array         = "󰅪 ",
-- 			Object        = "󰅩 ",
-- 			Key           = "󰌋 ",
-- 			Null          = "󰟢 ",
-- 			EnumMember    = " ",
-- 			Struct        = "󰌗 ",
-- 			Event         = " ",
-- 			Operator      = "󰆕 ",
-- 			TypeParameter = "󰊄 ",
-- 		},
-- 		lsp = {
-- 			auto_attach = false,
-- 			preference = nil,
-- 		},
-- 		highlight = false,
-- 		separator = " > ",
-- 		depth_limit = 5,
-- 		depth_limit_indicator = "..",
-- 		safe_output = true,
-- 		lazy_update_context = false,
-- 		click = false,
-- 		format_text = function(text)
-- 			return text
-- 		end,
-- 	}
--
-- end

local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, remap = false })
  end

  nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  nmap("<leader>vd", vim.diagnostic.open_float, "show [V]im [D]iagnostics floating window")
  nmap("[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, "goto [[]previous [D]iagnostics point in the code")
  nmap("]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, "goto []]next [D]iagnostics point in the code")

  -- See `:help K` for why this keymap
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  -- Lesser used LSP functionality
  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  -- if navicPresent and client.server_capabilities.documentSymbolProvider then
  -- 	navic.attach(client, bufnr)
  -- end

  -- -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  -- 	if vim.lsp.buf.format then
  -- 		vim.lsp.buf.format()
  -- 	elseif vim.lsp.buf.formatting then
  -- 		vim.lsp.buf.formatting()
  -- 	end
  -- end, { desc = 'Format current buffer with LSP' })
  -- local function go_org_imports(wait_ms)
  -- 	local params = vim.lsp.util.make_range_params()
  -- 	params.context = { only = { "source.organizeImports" } }
  -- 	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  -- 	for cid, res in pairs(result or {}) do
  -- 		for _, r in pairs(res.result or {}) do
  -- 			if r.edit then
  -- 				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
  -- 				vim.lsp.util.apply_workspace_edit(r.edit, enc)
  -- 			end
  -- 		end
  -- 	end
  -- end
  --
  -- vim.api.nvim_create_autocmd('BufWritePre', {
  -- 	pattern = '*.go',
  -- 	callback = function()
  -- 		go_org_imports()
  -- 	end
  -- })
  -- vim.api.nvim_create_autocmd('BufWritePre', {
  -- 	pattern = { javascript, javascriptreact, javascript.jsx, typescript, typescriptreact, typescript.tsx },
  --
  -- 	callback = function()
  -- 		vim.lsp.buf.execute_command({command = "_typscript.organizeImports", arguments = {vim.api.nvim_buf_get_name(0)}})
  -- 	end
  -- })
  -- vim.api.nvim_create_autocmd('BufWritePre', {
  -- 	pattern = '*.*',
  -- 	callback = function()
  -- 		vim.cmd.Format()
  -- 	end
  -- })
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- local function organize_imports()
-- 	local params = {
-- 		command = "_typescript.organizeImports",
-- 		arguments = {vim.api.nvim_buf_get_name(0)},
-- 		title = ""
-- 	}
-- 	vim.lsp.buf.execute_command(params)
-- end
--
-- vim.lsp.config("ts_ls").setup {
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	commands = {
-- 		OrganizeImports = {
-- 			organize_imports,
-- 			description = "Organize Imports"
-- 		}
-- 	}
-- }

-- deprecated in v4.x
-- lsp.on_attach(on_attach)
--
-- lsp.setup()

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

-- vim.diagnostic.config({
-- 	float = {border = border("CursorLineFold")},
-- 	float_border = {border = border("CursorLineFold")},
-- })

lsp.extend_lspconfig({
  sign_text = true,
  lsp_attach = on_attach,
  capabilities = capabilities,
  suggest_lsp_servers = true,
  sign_icons = {
    error = "E",
    warn = "W",
    hint = "H",
    info = "I",
  },
})

lsp.ui({
  float_border = "rounded",
  lsp_attach = on_attach,
  capabilities = capabilities,
})

require("luasnip.loaders.from_vscode").lazy_load()

----------------------------- lspconfig -----------------------------

require("mason").setup({})
-- require("java").setup()
-- local has_java_lsp, java = require("java")
--
-- if has_java_lsp then
-- 	java.setup({})
-- end

require("mason-lspconfig").setup({
  ensure_installed = { "gopls", "lua_ls", "rust_analyzer", "ts_ls", "jdtls" },
  handlers = {
    -- lsp.default_setup,
    function(server_name)
      vim.lsp.config(server_name).setup({
        -- handlers = {
        -- 	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        -- 	['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        -- }
      })
    end,
    ts_ls = function()
      local function organize_imports()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = "",
        }
        local clients = vim.lsp.get_clients({ name = "ts_ls" })
        if #clients == 0 then
          vim.notify("No ts_ls client found", vim.log.levels.ERROR)
          return
        end
        local client = clients[1]
        client:exec_cmd(params)
        vim.notify("Imports sorted", vim.log.levels.INFO)
      end
      vim.lsp.config("ts_ls").setup({
        on_attach = on_attach,
        capabilities = capabilities,
        single_file_support = false,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
          },
        },
      })
    end,

    -- lua_ls = function()
    -- 	-- function printTable(t, indent)
    -- 	-- 	indent = indent or ""
    -- 	-- 	if type(t) ~= "table" then
    -- 	-- 		print(indent .. tostring(t))
    -- 	-- 		return
    -- 	-- 	end
    -- 	--
    -- 	-- 	print(indent .. "{")
    -- 	-- 	for k, v in pairs(t) do
    -- 	-- 		io.write(indent .. "  [" .. tostring(k) .. "] = ")
    -- 	-- 		if type(v) == "table" then
    -- 	-- 			printTable(v, indent .. "  ")
    -- 	-- 		elseif type(v) == "string" then
    -- 	-- 			print('"' .. v .. '"')
    -- 	-- 		else
    -- 	-- 			print(tostring(v))
    -- 	-- 		end
    -- 	-- 	end
    -- 	-- 	print(indent .. "}")
    -- 	-- end
    --
    -- 	local lua_opts = lsp.nvim_lua_ls()
    --
    -- 	local vim_fix_opt = {
    -- 		settings = {
    -- 			Lua = {
    -- 				workspace = {
    -- 					library = vim.api.nvim_get_runtime_file("", true),
    -- 				},
    -- 			},
    -- 		},
    -- 	}
    --
    -- 	vim.lsp.config("lua_ls", vim_fix_opt)
    -- end,

    jdtls = function()
      vim.lsp.config("jdtls").setup({
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "Java 21",
                  path = "/home/linuxbrew/.linuxbrew/opt/openjdk@21",
                  default = true,
                },
              },
            },
          },
        },
      })
    end,
    -- pylsp = function()
    -- 	vim.lsp.config("pylsp", {
    -- 			settings = {
    -- 				pylsp = {
    -- 					plugins = {
    -- 						pycodestyle = {
    -- 							-- ignore = {'W391'},
    -- 							ignore = { "E501" },
    -- 							maxLineLength = 100,
    -- 						},
    -- 					},
    -- 				},
    -- 			},
    -- 		})
    -- end,
  },
})

-- vim.lsp.config("jdtls").setup({})
-- flutter-tools will configure dartls instead
-- vim.lsp.config("dartls").setup({})

-- erroring for some reason
-- vim.lsp.config("pylsp").setup({
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				pycodestyle = {
-- 					ignore = { "E501" },
-- 					maxLineLength = 100,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

-- local vim_fix_opt = {
-- 	settings = {
-- 		Lua = {
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 		},
-- 	},
-- }
--
-- vim.lsp.config("lua_ls", vim_fix_opt)

vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath("config")
        and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- working at ignoring
-- vim.lsp.config("pylsp", {
-- 	settings = {
-- 		pylsp = {
-- 			plugins = {
-- 				pycodestyle = {
-- 					-- ignore = {'W391'},
-- 					ignore = { "E501" },
-- 					maxLineLength = 100,
-- 				},
-- 			},
-- 		},
-- 	},
-- })

vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          -- ignore = {'W391'},
          ignore = { "E501" },
          maxLineLength = 100,
        },
      },
    },
  },
})

------------------------------- cmp -------------------------------

local cmp = require("cmp")

cmp.setup({
  completion = {
    completeopt = "menu,menuone",
  },

  window = {

    completion = {
      side_padding = 1, -- (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
      winhighlight = "Normal:GruvboxBlue,CursorLine:PmenuSel,Search:None",
      border = border("CursorLineFold"),
    },
    documentation = {
      border = border("GruvBoxGray"),
      winhighlight = "Normal:FloatShodow",
      scrollbar = true,
    },

    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  -- formatting = formatting_style,
  format = function(entry, item)
    local menu_icon = {
      nvim_lsp = "λ",
      luasnip = "⋗",
      buffer = "Ω",
      path = "⁄",
      nvim_lua = "Π",
    }

    item.menu = menu_icon[entry.source.name]
    return item
  end,

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
})

-- local cmp = require("cmp")
-- local cmp_sources = {
-- 	{ name = "luasnip", priority = 40 },
-- 	{ name = "nvim_lsp", priority = 30 },
-- 	{ name = "buffer", priority = 20 },
-- 	{ name = "path", priority = 10 },
-- }
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
-- 	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
-- 	["<C-y>"] = cmp.mapping.confirm({ select = true }),
-- 	["<C-Space>"] = cmp.mapping.complete(),
-- })

-- disable completion with tab
-- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

-- lsp.setup_nvim_cmp({
-- 	mapping = cmp_mappings,
-- 	sources = cmp_sources,
-- })

-- probably deprecated on v4.x
-- lsp.set_preferences({
-- 	suggest_lsp_servers = true,
-- 	sign_icons = {
-- 		error = "E",
-- 		warn = "W",
-- 		hint = "H",
-- 		info = "I",
-- 	},
-- })

-- Turn on lsp status information
local present, fidget = pcall(require, "fidget")
if present then
  fidget.setup()
end
