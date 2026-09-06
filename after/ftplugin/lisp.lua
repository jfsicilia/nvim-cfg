-- kanata .kbd files are opened with filetype=commonlisp (see lua/core/autocmd.lua).
-- Neovim's built-in commenting (gcc/gc) resolves 'commentstring' through the
-- tree-sitter language -> filetype chain: commonlisp's ts parser maps to the
-- "lisp" filetype, whose runtime ftplugin sets ";%s". kanata (like Lisp
-- convention itself) uses ";;" for line comments, so override it here.
vim.bo.commentstring = ";; %s"
