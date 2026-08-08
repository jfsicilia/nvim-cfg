-- Keymaps for better default experience

-- Set leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Help variables and functions
local opts = { noremap = true, silent = true }

local function nmap(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = "JFS: " .. desc }))
end

local function vmap(lhs, rhs, desc)
	vim.keymap.set("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = "JFS: " .. desc }))
end

local function imap(lhs, rhs, desc)
	vim.keymap.set("i", lhs, rhs, vim.tbl_extend("force", opts, { desc = "JFS: " .. desc }))
end

local function tmap(lhs, rhs, desc)
	vim.keymap.set("t", lhs, rhs, vim.tbl_extend("force", opts, { desc = "JFS: " .. desc }))
end

-- Disable the leader key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, ",", "<Nop>", { silent = true })

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Clear highlights
nmap("<Esc>", ":noh<CR>", "Clear highlights")

-- Save file
nmap("<C-s>", "<cmd>w<CR>", "Save file")
imap("<C-s>", "<C-o>:w<CR>", "Save file")

-- Save file without auto-formatting
nmap("<leader>wn", "<cmd>noautocmd w <CR>", "Save file without formatting")

-- Quit file
nmap("<C-q>", "<cmd> q <CR>", "Quit file")

-- Acoid c or x copying to clipboard. Use y (yank) or d (delete) when
-- copy to clipboard is needed.
nmap("c", '"_c', "Change without clipboard")
nmap("x", '"_x', "Delete char without clipboard")
nmap("C", '"_C', "Change til end without clipboard")
nmap("X", 'v$h"_x', "Deletes til end without clipboard") -- Deletes from cursor to end.

-- Arrow like movement in insert and normal mode.
nmap("<C-h>", "<Left>", "Move left")
nmap("<C-l>", "<Right>", "Move right")
nmap("<C-j>", "<Down>", "Move down")
nmap("<C-k>", "<Up>", "Move up")
imap("<C-h>", "<Left>", "Move left")
imap("<C-l>", "<Right>", "Move right")
imap("<C-j>", "<Down>", "Move down")
imap("<C-k>", "<Up>", "Move up")

-- Select all
--nmap('<leader>a', 'ggVG', 'Select all')

-- Move lines
nmap("-", ":m .+1<CR>", "Move line upwards")
nmap("_", ":m .-2<CR>", "Move line downwards")
vmap("-", ":m '>+1<CR>gv=gv'", "Move line upwards")
vmap("_", ":m '<-2<CR>gv=gv'", "Move line downwards")

-- Vertical scroll and center
nmap("<C-d>", "<C-d>", "Half page down and center")
nmap("<C-u>", "<C-u>", "Half page up and center")

-- Find and center
nmap("n", "nzzzv", "Find and center")
nmap("N", "Nzzzv", "Find and center")

-- Resize with arrows
-- nmap('<Up>', ':resize -2<CR>', 'Resize window up')
-- nmap('<Down>', ':resize +2<CR>', 'Resize window down')
-- nmap('<Left>', ':vertical resize -2<CR>', 'Resize window left')
-- nmap('<Right>', ':vertical resize +2<CR>', 'Resize window right')

-- Buffers
-- nmap('<Tab>', ':bnext<CR>', 'Next buffer')
nmap("<leader>.", ":bnext<CR>", "Next buffer")
-- nmap('<S-Tab>', ':bprevious<CR>', 'Previous buffer')
nmap("<leader>m", ":bprevious<CR>", "Previous buffer")
nmap("<leader><leader>", ":b#<CR>", "Toggle recent buffer")
--nmap('<C-i>', '<C-i>', 'Jump forward')
nmap("<leader>x", ":Bdelete!<CR>", "Close buffer") -- close buffer
nmap("<leader>nb", "<cmd> enew <CR>", "New buffer") -- new buffer

-- Window management
nmap("<leader>\\", "<C-w>v", "Split window vertically")
nmap("<leader>-", "<C-w>s", "Split window horizonatally")

-- Navigate between splits
nmap("<leader>k", "<C-w>k", "Focus above pane")
nmap("<leader>j", "<C-w>j", "Focus below pane")
nmap("<leader>h", "<C-w>h", "Focus left pane")
nmap("<leader>l", "<C-w>l", "Focus right pane")
--
-- Navigate between splits from the terminal.
-- Salir al modo normal de Neovim con doble Esc desde el terminal
tmap("<Esc><Esc>", [[<C-\><C-n>]], "Total escape form terminal")
tmap("<A-h>", [[<C-\><C-n><C-w>h]], "Focus above pane")
tmap("<A-j>", [[<C-\><C-n><C-w>j]], "Focus below pane")
tmap("<A-k>", [[<C-\><C-n><C-w>k]], "Focus left pane")
tmap("<A-l>", [[<C-\><C-n><C-w>l]], "Focus right pane")

-- Blank lines
nmap("<leader>nl", ":<C-u>call append(line('.'), repeat([''], v:count1))<CR>", "New line below (remain normal mode)")
nmap("<leader>nL", ":<C-u>call append(line('.')-1, repeat([''], v:count1))<CR>", "New line above (remain normal mode)")

-- Fast line begin/end
nmap("H", "^", "Begin of line")
nmap("L", "$", "End of line")

-- Toggles
nmap("<leader>tw", "<cmd>set wrap!<CR>", "Toggle wrapping")

-- Indent
vmap("<", "<gv", "Indent left") -- Remains selection.
vmap(">", ">gv", "Indent right") -- Remains selection.

-- Keep last yanked when pasting
vmap("p", '"_dP', "Paste visual")

-- Which-Key
nmap("<leader>?", function()
	require("which-key").show({ global = true })
end, "JFS: Show which-key")

-- LazyGit
nmap("<leader>gl", "<cmd>LazyGit<CR>", "LazyGit")

-- Diagnostics
local diagnostics_active = true
nmap("<leader>td", function()
	diagnostics_active = not diagnostics_active

	if diagnostics_active then
		vim.diagnostic.enable(true)
	else
		vim.diagnostic.enable(false)
	end
end, "JFS: Toggle diagnostics")

vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "JFS: Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "JFS: Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "JFS: Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "JFS: Open diagnostics list" })

-- Save and load session
vim.keymap.set(
	"n",
	"<leader>ss",
	":mksession! .session.vim<CR>",
	{ desc = "JFS: Save session", noremap = true, silent = false }
)
vim.keymap.set(
	"n",
	"<leader>sl",
	":source .session.vim<CR>",
	{ desc = "JFS: Load session", noremap = true, silent = false }
)

vim.keymap.set("n", "j", function()
	if vim.v.count > 1 then
		return "m'" .. vim.v.count .. "j"
	end
	return "j"
end, { expr = true, noremap = true, silent = true })

vim.keymap.set("n", "k", function()
	if vim.v.count > 1 then
		return "m'" .. vim.v.count .. "k"
	end
	return "k"
end, { expr = true, noremap = true, silent = true })
-- Explicitly yank to system clipboard (highlighted and entire row)
-- vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
-- vim.keymap.set('n', '<leader>Y', [["+Y]])
--nmap('<leader>se', '<C-w>=', 'Make split window equal width & height')
--nmap('<leader>xs', ':close<CR>', 'Close current split')
--
--
--
-- TODO
-- hacer que C-] y C-[ sean atras y adelante. Quizás entonces hacer C-i
-- jump to tag. y C-o jump back from tag.sl
