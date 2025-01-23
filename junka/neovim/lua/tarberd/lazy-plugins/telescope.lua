return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-fzy-native.nvim"
  },
  config = function()
    require('telescope').setup({
      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        }
      }
    })

    require('telescope').load_extension('fzy_native')

    local builtin = require('telescope.builtin')
    local grep_args = { '--follow', '--no-ignore', '--hidden' }
    vim.keymap.set('n', '<leader>pf', function()
      builtin.find_files({ follow = true })
    end, {})
    vim.keymap.set('n', '<leader>pF', function()
      builtin.find_files({ follow = true, hidden = true, no_ignore = true })
    end, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word, additional_args = grep_args })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word, additional_args = grep_args })
    end)
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > "), additional_args = grep_args })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
