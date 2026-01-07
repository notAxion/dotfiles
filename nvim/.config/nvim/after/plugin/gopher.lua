local present, gopher = pcall(require, "gopher")

if not present then
  return
end

-- doesn't seem to be calling this file
gopher.setup({
  gotag = {
    transform = "camelcase",
  },
})
