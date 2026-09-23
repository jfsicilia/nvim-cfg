-- Fast on-screen jumping with labels (folke/flash.nvim): lets you jump to any visible spot by
-- marking targets with letters, and also jump between treesitter nodes.
-- Keybinds (normal, visual, operator-pending modes):
--   <space>    Start Flash jump
--   <S-space>  Flash Treesitter (jump/select syntax nodes)
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    label = {
      -- Don't user uppercase letters in labels.
      uppercase = false,
      -- Use colors in labels.
      rainbow = {
        enabled = true,
        shades = 9,
      },
    },
    modes = {
      -- Enable fast jump in searches.
      search = {
        enabled = true,
      },
      -- Enable labels in f, F, t, T
      char = {
        jump_labels = false,
      },
    },
  },
  keys = {
    {
      '<space>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'FAST: Flash',
    },
    {
      '<S-space>',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'FAST: Flash Treesitter',
    },
    -- {
    --   'r',
    --   mode = 'o',
    --   function()
    --     require('flash').remote()
    --   end,
    --   desc = 'Remote Flash',
    -- },
    -- {
    --   'R',
    --   mode = { 'o', 'x' },
    --   function()
    --     require('flash').treesitter_search()
    --   end,
    --   desc = 'Treesitter Search',
    -- },
    -- {
    --   '<c-s>',
    --   mode = { 'c' },
    --   function()
    --     require('flash').toggle()
    --   end,
    --   desc = 'Toggle Flash Search',
    -- },
  },
}
