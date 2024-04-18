require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "v" }, "<leader>fm", function()
--     require("conform").format { async = true, lsp_fallback = true }
-- end, { desc = "format buffer from normal and visual mode" })
