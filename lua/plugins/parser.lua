-- Highlight, edit, and navigate code
-- Info interesante:
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
		-- Este plugin, permite configurar treesitter facilmente: lenguajes, folding, highlighting,
		-- indent e incremental_selection. También podrías utilizar la configuración que viene
		-- comentada debajo si no quieres depender de este plugin, pero el tema del incremento
		-- de la selección no lo tendrías configurado.
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
