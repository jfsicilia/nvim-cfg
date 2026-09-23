-- Search and replace across a file/project (MagicDuck/grug-far.nvim): ripgrep-based UI for
-- finding and replacing text with a preview before applying changes.
-- Keybinds: none defined here; opened via the :GrugFar command. grug-far.nvim sets its own
-- defaults inside its buffer (all under <localleader> unless noted):
--   <localleader>r     Perform replace
--   <localleader>q     Send results to quickfix list
--   <localleader>s     Sync all changed lines back to their files
--   <localleader>l     Sync current line back to its file
--   <localleader>v     Sync current file back to disk
--   <localleader>n/p   Sync next/previous change
--   <localleader>j/k   Apply next/previous change
--   <localleader>c     Close the Grug Far buffer
--   <localleader>t     Open search history
--   <localleader>a     Add current search to history
--   <localleader>f     Refresh results
--   <localleader>o     Open the result under cursor
--   <localleader>i     Preview the result under cursor
--   <localleader>b     Abort current search/replace
--   <localleader>w     Toggle showing the underlying search command
--   <localleader>e     Swap search engine (ripgrep/astgrep/...)
--   <localleader>x     Swap replacement interpreter
--   <down> / <up>      Open next/previous result location
--   <enter>            Go to location under cursor / pick history entry
--   <Tab> / <S-Tab>    Move to next/previous input field
--   g?                 Help
return {
  'MagicDuck/grug-far.nvim',
  -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
  -- additional lazy config to defer loading is not really needed...
  config = function()
    -- optional setup call to override plugin options
    -- alternatively you can set options with vim.g.grug_far = { ... }
    require('grug-far').setup {
      -- options, see Configuration section below
      -- there are no required options atm
    }
  end,
}
