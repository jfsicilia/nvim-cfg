-- Code symbol outline (stevearc/aerial.nvim): sidebar panel listing functions, classes, etc.
-- of the current file (via treesitter/LSP).
-- Keybinds:
--   <leader>to    Open/close the outline panel
--   <leader>ton   Open/close navigation mode
--   {             Jump to previous symbol (only where aerial is attached)
--   }             Jump to next symbol (only where aerial is attached)
return {
  'stevearc/aerial.nvim',
  lazy_load = true,
  opts = {},
  -- Optional dependencies
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('aerial').setup {
      -- optionally use on_attach to set keymaps when aerial has attached to a buffer
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
      layout = {
        min_width = 30,
      },
    }
    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set('n', '<leader>to', '<cmd>AerialToggle!<CR>', { desc = 'AER: Toggle outline' })
    vim.keymap.set('n', '<leader>ton', '<cmd>AerialNavToggle<CR>', { desc = 'AER: Toggle navigation outline' })
  end,
}
