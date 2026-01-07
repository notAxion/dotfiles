local present, _ = pcall(require, "dap")
if not present then
  return
end

local opts = { remap = false }

vim.keymap.set("n", "<leader>gs", "<cmd>Git|15wincmd_<CR>", opts)
