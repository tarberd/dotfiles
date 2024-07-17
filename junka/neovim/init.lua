vim.api.nvim_set_keymap('n', '<Space>', '', {})
vim.g.mapleader = " "

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
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = true,
  shiftwidth = 0,
  tabstop = 2,
  number = true,
  relativenumber = true,
  wrap = false,
  termguicolors = true,
  list = true,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"

vim.opt.list = true

local space = " "
vim.opt.listchars:append {
  tab = "▸ ",
  multispace = space,
  lead = space,
  trail = space,
  nbsp = space
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "farmergreg/vim-lastplace",
    { "tenxsoydev/tabs-vs-spaces.nvim", config = true },
    {
      "ojroques/nvim-osc52",
      config = function()
        require("osc52").setup {
          max_length = 0,          -- Maximum length of selection (0 for no limit)
          silent = false,          -- Disable message on successful copy
          trim = false,            -- Trim surrounding whitespaces before copy
        }
        local function copy()
          if ((vim.v.event.operator == "y" or vim.v.event.operator == "d")
            and vim.v.event.regname == "") then
            require("osc52").copy_register("")
          end
        end

        vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
      end,
    },
  }
)

require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require('lspconfig')
lspconfig.pyright.setup({})
lspconfig.clangd.setup({})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/implementation') then
      -- Create a keymap for vim.lsp.buf.implementation
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end
    if client.supports_method('textDocument/completion') then
      -- Enable auto-completion
      -- vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
    end
    if client.supports_method('textDocument/formatting') then
      -- Format the current buffer on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({bufnr = args.buf, id = client.id})
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
