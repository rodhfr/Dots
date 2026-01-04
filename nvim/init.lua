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
-- Saves and exit
vim.keymap.set("n", "<leader>w", "<cmd>wq<CR>", { noremap = true, silent = true, desc = "Save and quit" })
-- force exit
vim.keymap.set("n", "<leader>q", "<cmd>q!<CR>", { noremap = true, silent = true, desc = "Quit without saving" })

local term_win = nil
local term_buf = nil

vim.keymap.set("n", "<leader>r", function()
  -- TOGGLE OFF
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_close(term_win, true)

    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
      vim.api.nvim_buf_delete(term_buf, { force = true })
    end

    term_win = nil
    term_buf = nil
    return
  end

  -- TOGGLE ON
  vim.cmd("w")

  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file to run")
    return
  end

  -- create split
  vim.cmd("botright 12split")
  term_win = vim.api.nvim_get_current_win()

  -- create terminal buffer
  term_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(term_win, term_buf)

  -- start python as a terminal job (NO shell, NO globbing)
  vim.fn.jobstart({ "python", file }, {
    term = true,
    stdout_buffered = false,
    stderr_buffered = false,
  })
end, { noremap = true, silent = true, desc = "Run Python file" })
