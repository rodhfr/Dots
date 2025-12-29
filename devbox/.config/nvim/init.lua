-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- copy everything with ctrl c
vim.keymap.set("n", "<C-c>", ":%y+<CR>", { noremap = true, silent = true })
-- select everything with ctrl a
vim.keymap.set("n", "<C-a>", "gg:sleep 100m<CR>vG$", { noremap = true, silent = true })
-- simple print()
vim.keymap.set("n", "gp", "oprint()<Esc>i", { noremap = true, silent = true })
-- print("\n :")
vim.keymap.set("n", "go", 'oprint("\\n: ")<Esc>3hi', { noremap = true, silent = true })
-- Wrap visual selection in print() with "gu"
vim.keymap.set("v", "gu", [[:s/\%V.*/print(&)/<CR>]], { noremap = true, silent = true })
