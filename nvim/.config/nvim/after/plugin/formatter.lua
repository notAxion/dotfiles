local has_formatter, formatter = pcall(require, "formatter")

if not has_formatter then
  return
end

local util = require("formatter.util")
-- local au = require("_.utils.au")

local function prettier()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

local function shfmt()
  return {
    exe = "shfmt",
    args = { "-" },
    stdin = true,
  }
end

-- au.augroup("__formatter__", function()
-- 	au.autocmd("BufWritePre", "*", "FormatWrite")
-- end)

local formatterGroup = vim.api.nvim_create_augroup("__formatter__", {
  clear = true,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = formatterGroup,
  pattern = "*.*",
  command = "FormatWrite",
  -- callback = function()
  -- 	vim.cmd.FormatWrite()
  -- end,
})

formatter.setup({
  logging = false,
  filetype = {
    javascript = { prettier },
    typescript = { prettier },
    javascriptreact = { prettier },
    typescriptreact = { prettier },
    vue = { prettier },
    ["javascript.jsx"] = { prettier },
    ["typescript.tsx"] = { prettier },
    markdown = { prettier },
    css = { prettier },
    json = { prettier },
    jsonc = { prettier },
    scss = { prettier },
    less = { prettier },
    yaml = { prettier },
    graphql = { prettier },
    html = { prettier },
    gohtml = { prettier },
    sh = { shfmt },
    bash = { shfmt },
    rust = {
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },
    -- gopls is probabaly better and what i have been using
    -- instead gofmt
    go = {
      require("formatter.filetypes.go").gofmt,
      require("formatter.filetypes.go").goimports,
      require("formatter.filetypes.go").golines,
    },
    lua = { require("formatter.filetypes.lua").stylua },
    dart = { require("formatter.filetypes.dart").dartformat },
    python = { require("formatter.filetypes.python").black },
    java = { require("formatter.filetypes.java").google_java_format },
    -- -- Use the special "*" filetype for defining formatter configurations on
    -- -- any filetype
    -- ["*"] = {
    -- 	-- "formatter.filetypes.any" defines default configurations for any
    -- 	-- filetype
    -- 	require("formatter.filetypes.any").remove_trailing_whitespace,
    -- 	-- Remove trailing whitespace without 'sed'
    -- 	-- require("formatter.filetypes.any").substitute_trailing_whitespace,
    -- }
  },
})
