local guifont = 'JetBrainsMono Nerd Font Mono'
local guifont_size = 14

local function update_guifont()
  vim.opt.guifont = { guifont, ':h' .. guifont_size }
end

update_guifont()

local original_guifont_size = guifont_size

local function scale(amount)
  if not amount then
    guifont_size = original_guifont_size
  else
    guifont_size = guifont_size + amount
  end

  update_guifont()
end

local all_modes = { 'n', 'v', 's', 'x', 'o', 'i', 'l', 'c', 't' }

vim.keymap.set(all_modes, '<D-=>', function()
  scale(1)
end)
vim.keymap.set(all_modes, '<D-->', function()
  scale(-1)
end)
vim.keymap.set(all_modes, '<D-0>', function()
  scale()
end)

local function paste_from_primary_clipboard()
  vim.api.nvim_paste(vim.fn.getreg '+', true, -1)
end

vim.keymap.set(all_modes, '<D-v>', paste_from_primary_clipboard, { noremap = true, silent = true })

vim.keymap.set(all_modes, '<D-}>', function()
  vim.cmd 'bnext'
end)

vim.keymap.set(all_modes, '<D-{>', function()
  vim.cmd 'bprevious'
end)

vim.keymap.set(all_modes, '<D-w>', function()
  vim.cmd 'bd'
end)
