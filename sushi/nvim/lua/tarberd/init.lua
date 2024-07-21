vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  fileencoding = "utf-8",
  hidden = true,
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  undofile = true,
  writebackup = false,
  expandtab = true,
  shiftwidth = 0,
  tabstop = 2,
  number = true,
  relativenumber = true,
  wrap = false,
  termguicolors = true,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

require("tarberd.lazy")
require("tarberd.keymaps").remap()

vim.cmd.colorscheme("rose-pine")
