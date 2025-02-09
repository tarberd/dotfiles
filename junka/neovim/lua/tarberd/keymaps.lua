local map = vim.keymap.set

local M = {}

local function toggle_inlay_hints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

M.remap = function()
  vim.keymap.set("n", "<leader>pe", vim.cmd.Explore)
end

M.create_buffer_lsp_keymaps = function(_, buffer)
  -- NOTE there are other cool possibilities listed in nvim-lspconfig
  map("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = buffer, desc = "Declaration" })
  map("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = buffer, desc = "Definition" })
  map("n", "<leader>r", vim.lsp.buf.references, { silent = true, buffer = buffer, desc = "References" })
  map("n", "<leader>r", vim.lsp.buf.workspace_symbol, { silent = true, buffer = buffer, desc = "References" })
  map("n", "<localleader>i", vim.lsp.buf.implementation, { silent = true, buffer = buffer, desc = "Implementation" })
  map("n", "<localleader>t", vim.lsp.buf.type_definition, { silent = true, buffer = buffer, desc = "Type definition" })
  map("n", "<localleader>h", vim.lsp.buf.hover, { silent = true, buffer = buffer, desc = "Hover" })
  map("n", "<localleader>s", vim.lsp.buf.signature_help, { silent = true, buffer = buffer, desc = "Signature help" })
  map("n", "<localleader>x", vim.lsp.buf.code_action, { silent = true, buffer = buffer, desc = "Code action" })
  map("n", "<localleader>l", "<cmd>lua vim.diagnostic.open_float({ focusable = false })<CR>")
  map("n", "<localleader>R", vim.lsp.buf.rename, { silent = true, buffer = buffer, desc = "Rename" })
  map("n", "<localleader>I", vim.lsp.buf.incoming_calls, { silent = true, buffer = buffer, desc = "Incoming calls" })
  map("n", "<localleader>O", vim.lsp.buf.outgoing_calls, { silent = true, buffer = buffer, desc = "Outgoing calls" })
  map("n", "<localleader>=", vim.lsp.buf.format, { silent = true, buffer = buffer, desc = "Outgoing calls" })
  map({ "n", "v" }, "<localleader>=", vim.lsp.buf.format, { silent = true, buffer = buffer, desc = "Outgoing calls" })
  map("n", "<localleader>w", ":Trouble symbols toggle<CR>", { silent = true, buffer = buffer, desc = "Document symbols" })
  map("n", "<localleader>H", toggle_inlay_hints)
end

-- These are default bindings in Neovim but they don't open the diagnostic floats immediately.
-- Calling them manually does though...
M.global_lsp = function()
  map("n", "]d", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
  map("n", "[d", vim.diagnostic.goto_prev, { silent = true, desc = "Prev diagnostic" })
end

return M
