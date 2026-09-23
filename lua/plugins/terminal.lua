-- Integrated floating terminal (akinsho/toggleterm.nvim).
-- Keybinds:
--   <C-j>   Open/close the floating terminal
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    size = 20,
    open_mapping = [[<C-j>]], -- Toggle with Ctrl+j
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true, -- Whether open mapping applies in insert mode
    terminal_mappings = true, -- Whether open mapping applies in terminal mode
    persist_size = true,
    direction = 'float', -- This makes it a pop-up
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'rounded', -- Elegant rounded borders
      --winblend = 3, -- Slight transparency
    },
  },
}
