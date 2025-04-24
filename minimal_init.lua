-- ~/minimal_init.lua

-- Essential settings for drawing
vim.opt.termguicolors = true
vim.opt.laststatus = 3 -- Force statusline/separator area
vim.opt.cmdheight = 1 -- Ensure command line height is normal
vim.opt.fillchars = { vert = '┃', horiz = '━' } -- Use heavy characters

-- Apply highlights directly after a short delay (no theme needed for test)
vim.defer_fn(function()
  print 'Minimal config: Setting highlights'
  local bar_color = '#FF0000' -- Bright Red
  vim.api.nvim_set_hl(0, 'VertSplit', { fg = bar_color, bg = bar_color, link = nil })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = bar_color, bg = bar_color, link = nil })
  -- Optional: Give status lines distinct backgrounds for clarity
  vim.api.nvim_set_hl(0, 'StatusLine', { bg = '#555555', fg = '#FFFFFF' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = '#333333', fg = '#AAAAAA' })
end, 50) -- Delay 50ms

print 'Minimal config loaded.'
