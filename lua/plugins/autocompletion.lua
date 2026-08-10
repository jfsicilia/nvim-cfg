local kind_icons = {
	Text = "󰉿",
	Method = "m",
	Function = "󰊕",
	Constructor = "𝐶",
	Field = "𝐹",
	Variable = "󰆧",
	Class = "󰌗",
	Interface = "𝐼",
	Module = "𝑀",
	Property = "𝑃",
	Unit = "𝑈",
	Value = "󰎠",
	Enum = "𝐸",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰇽",
	Struct = "𝑆",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
}

return { -- Autocompletion (blink.cmp variant of autocompletion.lua)
	"saghen/blink.cmp",
	-- V2 (main branch) is under active development with breaking changes, stay on stable v1.
	version = "1.*",
	dependencies = {
		-- Snippet Engine & its associated blink.cmp source
		{
			"L3MON4D3/LuaSnip",
			build = (function()
				-- Build Step is needed for regex support in snippets
				-- This step is not supported in many windows environments
				-- Remove the below condition to re-enable on windows
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
		},
		-- Adds a number of user-friendly snippets
		"rafamadriz/friendly-snippets",
	},
	-- event = 'InsertEnter', -- kept eager (like the cmp variant) so `require("blink.cmp")` is
	-- always available synchronously for lsp_blink.lua's capabilities().
	opts = {
		snippets = { preset = "luasnip" },
		keymap = {
			preset = "none",
			["<Up>"] = { "select_prev", "fallback" }, -- Select the [p]revious item
			["<Down>"] = { "select_next", "fallback" }, -- Select the [n]ext item
			["<Tab>"] = { "accept", "fallback" }, -- Accept the completion with Tab.
			["<C-space>"] = { "show" }, -- Manually trigger a completion.
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
		},
		-- Equivalent to cmp-nvim-lsp-signature-help, but as its own floating window
		-- instead of a completion source. Opt-in / experimental per blink.cmp docs.
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = kind_icons,
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
