if not pcall(require, "gruvbox") then
  return
end

-- vim.cmd([[
-- " Color Scheme
-- autocmd vimenter * ++nested colorscheme gruvbox
-- " guibg=NONE
-- autocmd VimEnter * hi Normal ctermbg=NONE
-- ]])
--
--
-- -- Customising gruvbox colorscheme
-- vim.g.gruvbox_transparent_bg = 1
-- vim.g.gruvbox_contrast_dark = 'hard'
-- -- highlight the strings
-- vim.g.gruvbox_improved_strings = 0

require("gruvbox").setup({
  transparent_mode = true,
  -- dim_inactive = true,
})

-- vim.cmd("colorscheme gruvbox")
require("colors")
