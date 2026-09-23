-- Standalone plugins with very little config (less than 10 lines each):
-- - windwp/nvim-ts-autotag: auto-closes and renames matching HTML/JSX tags.
-- - tpope/vim-sleuth: automatically detects tabstop/shiftwidth per file.
-- - tpope/vim-fugitive: Git commands inside Vim (:Git, :Gdiffsplit, etc.).
-- - tpope/vim-rhubarb: GitHub integration for vim-fugitive (:GBrowse).
-- - will133/vim-dirdiff: diff between two folders.
-- - windwp/nvim-autopairs: auto-closes parentheses, brackets and quotes while typing.
-- - folke/todo-comments.nvim: highlights TODO/FIXME/NOTE/etc. in comments.
-- - catgoose/nvim-colorizer.lua: highlights colors (#fff, rgb(...), etc.) with their real color.
-- Keybinds: none defined here; each plugin uses its own default commands/keybinds.
return {
	{
		-- autoclose tags
		"windwp/nvim-ts-autotag",
	},
	{
		-- Detect tabstop and shiftwidth automatically
		"tpope/vim-sleuth",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Diff for folders.
		"will133/vim-dirdiff",
	},
	{
		-- Autoclose parentheses, brackets, quotes, etc.
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
	},
	{
		-- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		-- High-performance color highlighter
		"catgoose/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
