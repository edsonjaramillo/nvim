-- load options
require("configs.options")

-- load lazy package manager
require("core.lazy")

-- load lsp
require("core.lsp")
require("configs.debug")

-- load keymaps
require("configs.keymaps.init")

-- load autocmds
require("autocmds.init")
