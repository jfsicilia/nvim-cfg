-- Syntax highlighting, editing and code navigation (nvim-treesitter), configured with
-- treesitter-modules.nvim to easily enable highlighting, indentation, folding and incremental
-- selection for the languages listed below.
-- Keybinds: none defined here; treesitter-modules' incremental_selection uses its own
-- built-in defaults (buffer-local, active once treesitter attaches):
--   gnn   Start incremental selection
--   grn   Expand selection to the next node
--   grc   Expand selection to the surrounding scope
--   grm   Shrink selection to the previous node
-- Interesting reading:
-- https://www.reddit.com/r/neovim/comments/1ky0i9q/treesittermodulesnvim_a_reimplementation_of/
-- https://www.reddit.com/r/neovim/comments/1l3z4j4/help_with_new_treesitter_setup_in_neovim_default/
local languages = { "c", "lua", "python", "rust", "javascript", "typescript", "tsx", "zig", "terraform", "commonlisp" }
return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	{
		-- This plugin lets you easily configure treesitter: languages, folding, highlighting,
		-- indent and incremental_selection. You could also use the commented-out config
		-- below if you don't want to depend on this plugin, but incremental selection
		-- wouldn't be configured that way.
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ensure_installed = languages,
			fold = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		},
	},
}

-- return {
--   'nvim-treesitter/nvim-treesitter',
--   lazy = false,
--   build = ':TSUpdate',
--   config = function()
--     require('nvim-treesitter').install(languages)
--
--     vim.api.nvim_create_autocmd('FileType', {
--       group = vim.api.nvim_create_augroup('treesitter.setup', {}),
--       callback = function(args)
--         local buf = args.buf
--         local filetype = args.match
--
--         -- you need some mechanism to avoid running on buffers that do not
--         -- correspond to a language (like oil.nvim buffers), this implementation
--         -- checks if a parser exists for the current language
--         local language = vim.treesitter.language.get_lang(filetype) or filetype
--         if not vim.treesitter.language.add(language) then
--           return
--         end
--
--         -- replicate `fold = { enable = true }`
--         vim.wo.foldmethod = 'expr'
--         vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--
--         -- replicate `highlight = { enable = true }`
--         vim.treesitter.start(buf, language)
--
--         -- replicate `indent = { enable = true }`
--         vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--
--         -- `incremental_selection = { enable = true }` cannot be easily replicated
--       end,
--     })
--   end
-- }
