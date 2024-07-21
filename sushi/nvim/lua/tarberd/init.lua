vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
  cmdheight = 1,
  mouse = "a",

  clipboard = "unnamedplus",
  completeopt = { "menuone", "noselect" },
  fileencoding = "utf-8",
  updatetime = 50,

  backup = false,
  writebackup = false,
  swapfile = false,
  undofile = true,

  hlsearch = false,
  incsearch = true,
  ignorecase = true,
  smartcase = true,

  smartindent = true,
  splitbelow = true,
  splitright = true,

  conceallevel = 0,

  expandtab = true,
  shiftwidth = 0,
  tabstop = 2,
  number = true,
  relativenumber = true,
  wrap = false,
  termguicolors = true,
  colorcolumn = "80",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

require("tarberd.lazy")
require("tarberd.keymaps").remap()

vim.cmd.colorscheme("rose-pine")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local tarberd_group = augroup('tarberd', {})

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function ()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

autocmd({"BufWritePre"}, {
    group = tarberd_group,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
