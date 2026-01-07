local present, onedark = pcall(require, "onedark")

if not present then
  return
end

onedark.setup({
  style = "warmer",
  transparent = true,
})

require("colors")
-- onedark.load()
