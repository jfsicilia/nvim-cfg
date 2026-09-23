-- Navigation between Neovim panes and tmux (alexghergh/nvim-tmux-navigation): lets you move
-- between Neovim splits and tmux panes with the same keys, transparently.
-- Keybinds:
--   <A-h>   Move to the left pane
--   <A-j>   Move to the pane below
--   <A-k>   Move to the pane above
--   <A-l>   Move to the right pane
--   <A-\>   Go back to the previously active pane
return {
  'alexghergh/nvim-tmux-navigation',
  config = function()
    local nvim_tmux_nav = require 'nvim-tmux-navigation'

    nvim_tmux_nav.setup {
      disable_when_zoomed = true, -- defaults to false
    }

    vim.keymap.set('n', '<A-h>', nvim_tmux_nav.NvimTmuxNavigateLeft)
    vim.keymap.set('n', '<A-j>', nvim_tmux_nav.NvimTmuxNavigateDown)
    vim.keymap.set('n', '<A-k>', nvim_tmux_nav.NvimTmuxNavigateUp)
    vim.keymap.set('n', '<A-l>', nvim_tmux_nav.NvimTmuxNavigateRight)
    vim.keymap.set('n', '<A-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive)
    -- vim.keymap.set('n', '<A-Space>', nvim_tmux_nav.NvimTmuxNavigateNext)
  end,
}
