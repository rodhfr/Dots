-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.keymap.set("n", "gp", "oprint()<Esc>i", { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", ":%y+<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-a>", "gg:sleep 100m<CR>vG$", { noremap = true, silent = true })
vim.keymap.set("n", "go", 'oprint("\\n:")<Esc>2hi', { noremap = true, silent = true })
