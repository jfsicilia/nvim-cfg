-- Keybind hints (folke/which-key.nvim): shows a popup with the available key combos as you
-- type them, and here it also documents (as labels only, not actual bindings) several native
-- Vim combos like <C-b>/<C-f>, <C-u>/<C-d>, <C-a>/<C-x>, etc.
-- Keybinds: defines no combos of its own; inside the popup:
--   <c-n>   Scroll the list down
--   <c-p>   Scroll the list up
return {
  -- Hints keybinds
  'folke/which-key.nvim',
  opts = {
    delay = 1000,
    spec = {

      -- Scrolling / movimiento
      { '<C-b>', desc = 'Page up (backward)' },
      { '<C-f>', desc = 'Page down (forward)' },
      { '<C-u>', desc = 'Half page up' },
      { '<C-d>', desc = 'Half page down' },
      { '<C-y>', desc = 'Scroll up one line' },
      { '<C-e>', desc = 'Scroll down one line' },

      -- Cursor / pantalla
      { '<C-l>', desc = 'Redraw screen / clear highlights' },
      { '<C-g>', desc = 'Show file info and cursor position' },

      -- Numbers
      { '<C-a>', desc = 'Increment number under cursor' },
      { '<C-x>', desc = 'Decrement number under cursor' },

      -- Jumps
      { '<C-i>', desc = 'Jump forward in jump list' },
      { '<C-o>', desc = 'Jump backward in jump list' },

      -- Tags
      { '<C-]>', desc = 'Jump to tag under cursor' },
      { '<C-t>', desc = 'Jump back from tag' },

      -- Files
      { '<C-^>', desc = 'Edit alternate file' },

      -- Undo / control
      { '<C-r>', desc = 'Redo last undone change' },
      { '<C-z>', desc = 'Suspend editor (job control)' },
      { '<C-c>', desc = 'Interrupt / cancel command (like Esc)' },

      -- Window prefix
      { '<C-w>', desc = 'Window commands prefix' },
    },
    keys = {
      scroll_down = '<c-n>', -- binding to scroll down inside the popup
      scroll_up = '<c-p>', -- binding to scroll up inside the popup
    },
    win = {
      border = {
        { '┌', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '┐', 'FloatBorder' },
        { '│', 'FloatBorder' },
        { '┘', 'FloatBorder' },
        { '─', 'FloatBorder' },
        { '└', 'FloatBorder' },
        { '│', 'FloatBorder' },
      },
    },
  },
}
