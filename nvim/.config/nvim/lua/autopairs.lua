-- INFO no clue why this file exists probably isn't being used
local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end
npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = "π",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})
