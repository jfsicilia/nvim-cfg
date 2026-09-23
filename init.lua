require("core.options")
require("core.autocmd")
require("core.keymaps")
require("core.commands")

-- Load lazy.nvim plugin manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- ───────────────────────────────────────────────────────────────────────────
-- Mini howto: inspecting keybindings and finding collisions
-- ───────────────────────────────────────────────────────────────────────────
-- :Telescope keymaps        Fuzzy-search ALL active keymaps (built-in + plugins), with
--                           mode, description and the file/line that defined them.
-- :WhichKey                 Open the which-key popup for the current mode — same as
--                           pressing <leader> and waiting, shows what's available right now.
-- :WhichKey <prefix>        e.g. :WhichKey <leader>g  shows only that prefix's subtree.
-- :map                      List ALL mappings (normal + visual + select + operator-pending).
-- :nmap / :imap / :vmap     List mappings for just that mode (normal/insert/visual/...).
-- :omap / :tmap
-- :map <lhs>                Show what a key/combo is mapped to, e.g. :map <leader>e
-- :verbose map <lhs>        Same, but also shows the file/line that set it — the fastest
--                           way to find WHO defined (or silently overrode) a keybinding.
-- :verbose nmap <lhs>       Same as above, scoped to one mode (swap nmap for imap/vmap/...).
-- :checkhealth              General health check; also flags some keymap/plugin issues.
--
-- Collisions aren't reported automatically: the last mapping set for a given key just
-- silently wins. To check "did anything else already claim this key?", set your own
-- mapping last (or run :verbose map <lhs> before adding it) and read the file/line it prints.
-- ───────────────────────────────────────────────────────────────────────────

-- Load plugins.
require("lazy").setup({
	-- Welcome screen / dashboard (alpha-nvim).
	-- Keybinds: none defined here; alpha's startify theme sets its own defaults:
	--   1, 2, 3...   Open the Nth recent file   e   New file   q   Quit
	require("plugins.welcome"),

	-- Colorscheme plugin (catppuccin).
	-- Keybinds: none.
	require("plugins.theme"),

	-- File explorer sidebar (neo-tree).
	-- Keybinds:
	--   <leader>e   Open/close neo-tree
	-- Inside the tree (see `:h neo-tree-mappings` for the full list):
	--   <space>  Expand/collapse       <cr>  Open              a / A  Add file/directory
	--   d        Delete                r     Rename            y/x/p  Copy/cut/paste
	--   s / S    Open in vsplit/split  t     Open in new tab   H      Toggle hidden files
	--   /        Search                R     Refresh           ?      Help
	require("plugins.fileexplorer"),

	-- Bottom statusline (lualine).
	-- Keybinds: none.
	require("plugins.infoline"),

	-- Buffer/tabs top line (bufferline).
	-- Keybinds (jump by position in the bufferline, not by buffer number):
	--   <leader>1..<leader>9   Jump to buffer 1-9
	require("plugins.tabs"),

	-- Abbreviations / substitutions / coercions (abolish).
	-- Keybinds: none defined here; uses the plugin's own coercion defaults (cr + a letter):
	--   crs snake_case   crm MixedCase   crc camelCase   cr_ snake_case (alias)   cru UPPER_CASE
	require("plugins.edit"),

	-- Vertical indent guides (indent-blankline).
	-- Keybinds: none.
	require("plugins.indentlines"),

	-- Search and replace in file/project (grug-far).
	-- Keybinds: none defined here; opened via :GrugFar. Defaults inside its buffer
	-- (under <localleader> unless noted):
	--   <localleader>r   Replace                  <localleader>t   Open history
	--   <localleader>q   Send to quickfix         <localleader>a   Add search to history
	--   <localleader>s   Sync all lines           <localleader>f   Refresh results
	--   <localleader>l   Sync current line        <localleader>o/i Open/preview result under cursor
	--   <localleader>v   Sync current file        <localleader>b   Abort
	--   <localleader>j/k Apply next/prev change   <localleader>w   Toggle command shown
	--   <localleader>n/p Sync next/prev change    <localleader>e   Swap search engine
	--   <down>/<up>      Next/prev result         <enter>   Go to result / pick history entry
	--   <Tab>/<S-Tab>    Next/prev input field    g?   Help
	require("plugins.search_n_replace"),

	-- Navigation between Neovim panes and tmux (nvim-tmux-navigation).
	-- Keybinds:
	--   <A-h>/<A-j>/<A-k>/<A-l>   Move left/down/up/right
	--   <A-\>                     Go back to the previously active pane
	require("plugins.nav"),

	-- Language parser plugin (treesitter).
	-- Keybinds: none defined here; treesitter-modules' incremental_selection uses its own
	-- built-in defaults:
	--   gnn   Start incremental selection    grc   Expand to surrounding scope
	--   grn   Expand to next node            grm   Shrink to previous node
	require("plugins.parser"),

	-- Autoformatting and linting on save (none-ls).
	-- Keybinds: none (everything triggers automatically on save).
	require("plugins.autoformatting"),

	-- Autocompletion plugin (blink.cmp).
	-- Keybinds (inside the completion menu):
	--   <Up>/<Down>   Select previous/next suggestion
	--   <Tab>         Accept suggestion (or show the menu if not visible)
	require("plugins.autocompletion"),

	-- AI autocomplete, ghost text (GitHub Copilot).
	-- Keybinds (while a Copilot suggestion is visible, insert mode):
	--   <C-space>   Accept   <Right>   Next suggestion
	--   <Esc>       Dismiss  <Left>    Previous suggestion
	require("plugins.autocompletion_AI_L1"),

	-- AI autocomplete: NES + Claude CLI integrated in a panel (sidekick).
	-- Keybinds:
	--   <Tab>        Goto/apply next edit suggestion (NES)
	--   <leader>aa   Select agent            <leader>af   Send current file to agent
	--   <leader>ac   Toggle Claude session   <leader>ap   Select prompt
	--   <leader>as   Send selection (visual) <leader>ad   Close session
	require("plugins.autocompletion_AI_L2_L3"),

	-- Fast jump with labels (flash).
	-- Keybinds (normal, visual, operator-pending modes):
	--   <space>     Start Flash jump
	--   <S-space>   Flash Treesitter (jump/select syntax nodes)
	require("plugins.fastjump"),

	-- Fuzzy find plugin (telescope).
	-- Keybinds:
	--   <leader>sf   Find files                 <leader>sm    Search marks
	--   <leader>sg   Live grep (project)        <leader>so    Recent files
	--   <leader>sw   Search word under cursor   <leader>sh    Search help
	--   <leader>s/   Live grep in open buffers  <leader>sd    Search diagnostics
	--   <leader>/    Search current buffer      <leader>sr    Resume last search
	--   <leader>sb   Search open buffers        <leader>sds   LSP document symbols
	--   <leader>gf   Git files                  <leader>gc   Git commits
	--   <leader>gcf  Git commits (file)
	--   <leader>gb   Git branches               <leader>gs   Git status
	require("plugins.fuzzyfind"),

	-- Git gutter signs and hunk utilities (gitsigns).
	-- Keybinds (set when gitsigns attaches to a buffer):
	--   ]c / [c        Next/previous hunk         <leader>ghp   Preview hunk
	--   <leader>ghs    Stage hunk                 <leader>ghi   Preview hunk inline
	--   <leader>ghr    Reset hunk                 <leader>ghb   Blame current line
	--   <leader>ghS    Stage entire buffer        <leader>ghd   Diff the file
	--   <leader>ghR    Reset entire buffer        <leader>ghD   Diff against previous commit
	--   <leader>ghQ    Quickfix, all hunks        <leader>tb    Toggle inline blame
	--   <leader>ghq    Quickfix, buffer's hunks   <leader>tl    Toggle word diff
	--   ih             "hunk" text object (operator-pending and visual)
	require("plugins.git"),

	-- Terminal in nvim (toggleterm).
	-- Keybinds:
	--   <C-j>   Open/close the floating terminal
	require("plugins.terminal"),

	-- LazyGit TUI in a floating window (lazygit.nvim).
	-- Keybinds: none active (used via :LazyGit, :LazyGitConfig, :LazyGitCurrentFile,
	-- :LazyGitFilter, :LazyGitFilterCurrentFile commands).
	require("plugins.lazygit"),

	-- Use buffer as file explorer plugin (oil).
	-- Keybinds (inside an oil buffer):
	--   g?  Help          <C-s>  Vertical split   -  Parent directory   gs  Change sort
	--   <CR> Select/open  <C-h>  Horizontal split _  Open cwd           gx  Open externally
	--   <C-p> Preview     <C-t>  New tab          `  Cd to directory    g.  Toggle hidden
	--   <C-c> Close       <C-l>  Refresh          ~  Cd (tab only)      g\  Toggle trash
	require("plugins.bufferfileexplorer"),

	-- Language Server Providers plugin (nvim-lspconfig + mason).
	-- Keybinds (set when an LSP attaches to a buffer, LspAttach):
	--   gd   Go to definition        <leader>lD    Type definition
	--   gr   References              <leader>lds   Document symbols
	--   gI   Go to implementation    <leader>lws   Workspace symbols
	--   gD   Go to declaration       <leader>lrn   Rename
	--   K    Hover documentation     <leader>lca   Code action
	--   <leader>lwa/<leader>lwr/<leader>lwl   Add/remove/list workspace folders
	--   <leader>lth   Toggle inlay hints (if the server supports them)
	require("plugins.lsp"),

	-- Outline window plugin (aerial).
	-- Keybinds:
	--   <leader>to    Open/close the outline panel
	--   <leader>ton   Open/close navigation mode
	--   { / }         Jump to previous/next symbol (only where aerial is attached)
	require("plugins.outline"),

	-- Help plugin (which-key).
	-- Keybinds: defines no combos of its own; inside the popup, <c-n>/<c-p> scroll the list
	-- down/up.
	require("plugins.help"),

	-- Small misc plugins (autopairs, fugitive, sleuth, todo-comments, colorizer, etc.).
	-- Keybinds: none defined here; each plugin uses its own default commands/keybinds.
	require("plugins.misc"),
})
