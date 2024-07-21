local function config()
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local keymaps = require("tarberd.keymaps")
  local lsp_status = require("lsp-status")
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      keymaps.create_buffer_lsp_keymaps(client, args.buf)
      lsp_status.on_attach(client)
    end,
  })

  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      scope = "cursor",
    },
  })

  keymaps.global_lsp()

  vim.lsp.inlay_hint.enable(true)

  lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
    capabilities = capabilities,
  })

  -- Dynamic server setup, so we don't have to explicitly list every single server
  -- and can just list the ones we want to override configuration for.
  -- See :help mason-lspconfig-dynamic-server-setup
  mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name)
        require("lspconfig")[server_name].setup({})
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["clangd"] = function()
      require("lspconfig").clangd.setup({
        filetypes = { "c", "cpp" }, -- we don't want objective-c and objective-cpp!
      })
    end,
    ["lua_ls"] = function()
      require'lspconfig'.lua_ls.setup({
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              --library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
    end,
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "nvim-lua/lsp-status.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
}
