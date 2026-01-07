local present, dap = pcall(require, "dap")
if not present then
  return
end

local opts = { remap = false }

vim.fn.sign_define("DapStopped", { text = "ඞ", texthl = "warning", linehl = "" })

vim.keymap.set("n", "<F4>", "<cmd>lua require'dap'.step_out()<CR>", opts)
vim.keymap.set("n", "<F5>", "<cmd>lua require'dap'.continue()<CR>", opts)
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_over()<CR>", opts)
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<CR>", opts)
vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set("n", "<leader>cb", "<cmd>lua require'dap'.clear_breakpoints()<CR>", opts)
vim.keymap.set(
  "n",
  "<leader>B",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  opts
)
vim.keymap.set(
  "n",
  "<leader>lp",
  "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  opts
)
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", opts)

require("dap-go").setup({
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Debug GO project",
      request = "launch",
      program = "${workspaceFolder}",
    },
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Debug GO project (args)",
      request = "launch",
      args = require("dap-go").get_arguments,
      program = "${workspaceFolder}",
    },
  },
})

require("dap-python").setup("uv")

require("nvim-dap-virtual-text").setup()
require("mason-nvim-dap").setup()

local dapui = require("dapui")

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
