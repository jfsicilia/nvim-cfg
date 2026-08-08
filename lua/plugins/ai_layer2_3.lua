return {
	"folke/sidekick.nvim",
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
		-- nes = { enabled = false },
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
	},
}
