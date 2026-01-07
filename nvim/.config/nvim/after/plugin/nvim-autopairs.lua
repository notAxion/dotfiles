local present, npairs = pcall(require, "nvim-autopairs")

if not present then
  return
end

npairs.setup({
  check_ts = true,
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
