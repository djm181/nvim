vim.opt.listchars = {
  eol = "↩",
  tab = ">-",
  lead = "·",
  trail = "•",
}
vim.opt.list = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.wildmode = "longest,list"
vim.o.number = true
vim.o.relativenumber = true
vim.cmd([[autocmd FileType ruby setlocal indentkeys-=.]])
vim.cmd([[autocmd FileType netrw setlocal number relativenumber]])
