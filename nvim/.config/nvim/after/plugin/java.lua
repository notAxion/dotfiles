local present, jdtls = pcall(require, "jdtls")
if not present then
  return
end

-- -- File types that signify a Java project's root directory. This will be
-- -- used by eclipse to determine what constitutes a workspace
-- local root_markers = {'gradlew', 'mvnw', '.git'}
-- local root_dir = require('jdtls.setup').find_root(root_markers)
--
-- -- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- -- with multiple different projects, each project must use a dedicated data directory.
-- -- This variable is used to configure eclipse to use the directory name of the
-- -- current project found using the root_marker as the folder for project specific data.
-- local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local home = os.getenv("HOME")
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = home .. "/.local/share/nvim/java" .. project_name

local config = {
  cmd = {
    --
    "java", -- Or the absolute path '/path/to/java11_or_newer/bin/java'
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    --
    "-jar",
    "/usr/local/Cellar/jdtls/1.22.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar",
    "-configuration",
    "/usr/local/Cellar/jdtls/1.22.0/libexec/config_mac",
    "-data",
    workspace_dir,
  },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      import = { enabled = true },
      rename = { enabled = true },
    },
  },
  init_options = {
    bundles = {},
  },
}

jdtls.start_or_attach(config)
