local core_autocmd = vim.api.nvim_create_augroup("core_autocmd", { clear = true })
--
-- Activates commonlisp language syntax when opening .kbd files.
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.kbd",
	group = core_autocmd,
	callback = function()
		vim.bo.filetype = "commonlisp"
		-- kanata .kbd files use ";;" for comments, not the lisp default ";".
		-- This sets the buffer fallback; gcc/gc resolve via tree-sitter, so the
		-- real override lives in after/ftplugin/lisp.lua.
		vim.bo.commentstring = ";; %s"
	end,
})

-- Highlight yank.
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when copying (yank)",
	group = core_autocmd,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Saves sessions help function.
local function save_session()
	-- Avoids saving tmp files or empty buffers.
	if vim.fn.empty(vim.fn.expand("%:p")) == 0 then
		vim.cmd("mksession! .session.vim")
	end
end

-- Saves session when writing buffer.
vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Saves session when writing buffer",
	group = core_autocmd,
	callback = save_session,
})

-- Saves session when leaving vim.
vim.api.nvim_create_autocmd("VimLeave", {
	desc = "Saves session when leaving vim",
	group = core_autocmd,
	callback = function()
		vim.cmd("Neotree close") -- Avoids saving neotree buffer.
		save_session()
	end,
})

-- Start in insert mode when opening terminal.
vim.api.nvim_create_autocmd("TermOpen", {
	desc = "Starts terminal in insert mode",
	group = core_autocmd,
	pattern = "term://*",
	command = "startinsert",
})

-- Close pane when exiting terminal.
vim.api.nvim_create_autocmd("TermClose", {
	desc = "Closes pane when exiting terminal",
	group = core_autocmd,
	callback = function()
		vim.cmd("bdelete")
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "TermLeave" }, {
	desc = "cd to terminal cwd on enter",
	pattern = "term://*",
	callback = function()
		local cwd = vim.fn.resolve("/proc/" .. vim.b.terminal_job_pid .. "/cwd")
		if vim.fn.isdirectory(cwd) == 0 then
			return
		end
		vim.fn.chdir(cwd)
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	desc = "Changes the title based on the filetype",
	group = core_autocmd,
	callback = function()
		local ft = vim.bo.filetype
		if ft == "neo-tree" then
			vim.opt.titlestring = "Explorer - Nvim"
		else
			local filename = vim.fn.expand("%:t")
			local filepath = vim.fn.expand("%:~:h")
			vim.opt.titlestring = filename .. " (" .. filepath .. ") - Nvim"
		end
	end,
})
