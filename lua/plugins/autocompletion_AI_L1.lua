-- AI level 1 (zbirenbaum/copilot.lua): GitHub Copilot "ghost text" suggestions while you type.
-- NES (Next Edit Suggestion) is disabled here because sidekick.nvim manages it
-- (autocompletion_AI_L2_L3.lua).
-- Keybinds (while a Copilot suggestion is visible, insert mode):
--   <C-space>  Accept suggestion
--   <Right>    Next suggestion
--   <Left>     Previous suggestion
--   <Esc>      Dismiss suggestion
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
