return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-space>",
					next = "<Right>",
					prev = "<Left>",
					dismiss = "<Esc>",
				},
			},
			panel = { enabled = false },
			filetypes = {
				["*"] = true,
				gitcommit = false,
				[".env"] = false,
			},
			nes = { enabled = false }, -- Use sidekick to manage NES instead of copilot.
		})
	end,
}
