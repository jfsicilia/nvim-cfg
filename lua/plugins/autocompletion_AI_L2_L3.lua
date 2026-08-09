return {
	"folke/sidekick.nvim",
	-- NOTE: no copilot-lsp dependency needed: copilot.lua (ai_layer1.lua) already
	-- exposes an authenticated LSP client named "copilot" that sidekick uses for NES.
	-- Loads sidekick right after startup (instead of waiting for a `keys` mapping like
	-- <leader>aa) so NES is active from the moment Neovim opens. InsertEnter is added as a
	-- safety net in case VeryLazy is ever delayed past the first keystroke.
	-- event = { "VeryLazy", "InsertEnter" },
	event = { "InsertEnter" },
	opts = {
		cli = {
			mux = {
				backend = "tmux", -- tmux saves the state of the pane.
				enabled = true,
				create = "split", -- Split in tmux (split) or new window (window)
				split = {
					vertical = true, -- split vertical
					size = 0.4, -- 40% width
				},
			},
		},
		nes = { enabled = true },
	},
	keys = {
		{
			"<leader>aa",
			function()
				require("sidekick.cli").select({ filter = { installed = true } })
			end,
			desc = "Sidekick: Select agent",
		},
		{
			"<leader>ac",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			desc = "Sidekick: Toggle Claude",
			mode = { "n", "v" },
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").send({ selection = true })
			end,
			mode = { "v" },
			desc = "Sidekick: Send selection to agent",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "Review this file: " .. vim.fn.expand("%") })
			end,
			desc = "Sidekick: Send current file to agent",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick: Select Prompt",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Sidekick: Detach a CLI Session",
		},
		{
			"<Tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			mode = { "n" },
			expr = true,
			desc = "Sidekick: Goto/Apply Next Edit Suggestion",
		},
	},
}
