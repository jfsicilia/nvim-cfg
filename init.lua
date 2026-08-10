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

-- Load plugins.
require("lazy").setup({
	require("plugins.welcome"), -- Displays recent files on welcome screen plugin (alpha).
	require("plugins.theme"), -- Colorscheme plugin (catppuccin)
	require("plugins.fileexplorer"), -- File manager plugin (neotree).
	require("plugins.infoline"), -- Buffer bottom line information plugin (lualine).
	require("plugins.tabs"), -- Buffer/tabs top line plugin (bufferline).
	require("plugins.edit"), -- Abbreviations / Substitutions / Coercions (abolish).
	require("plugins.indentlines"), -- Displays vertical lines for indents plugin (indent-blankline).
	require("plugins.search_n_replace"), -- Search and replace in file and filesystem (grug-far).
	require("plugins.nav"), -- Navigation (tmux-nvim)
	require("plugins.parser"), -- Language parser plugin (treesitter).
	require("plugins.autoformatting"), -- Autoformatting plugin (none-ls).
	require("plugins.autocompletion"), -- Autocompletion plugin
	require("plugins.autocompletion_AI_L1"), -- AI autocomplete (Github copilot).
	require("plugins.autocompletion_AI_L2_L3"), -- AI autocomplete (sidekick: NES and Claude integrated in panel).
	require("plugins.fastjump"), -- Fast jump with labels plugin (flash).
	require("plugins.fuzzyfind"), -- Fuzzy find plugin (telescope).
	require("plugins.git"), -- Git enhancements.
	require("plugins.terminal"), -- Terminal in nvim.
	require("plugins.lazygit"), -- Lazy git plugin.
	require("plugins.bufferfileexplorer"), -- Use buffer as file explorer plugin (oil).
	require("plugins.lsp"), -- Language Server Providers plugin (nvim-lspconfig + mason)
	require("plugins.outline"), -- Outline window plugin (aerial) .
	require("plugins.help"), -- Help plugin (which-key).
	require("plugins.misc"), -- Small misc plugins.
})
