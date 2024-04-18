require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

<<<<<<< HEAD
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
=======
-- map({ "n", "v" }, "<leader>fm", function()
--     require("conform").format { async = true, lsp_fallback = true }
-- end, { desc = "format buffer from normal and visual mode" })
>>>>>>> fa96536dd0775b9f32c0cc6370041400060efed5
