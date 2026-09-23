-- Fuzzy finder (nvim-telescope/telescope.nvim + telescope-fzf-native for better performance +
-- telescope-ui-select to use telescope as the vim.ui.select picker): finder for files, text,
-- buffers, LSP symbols, git, etc.
-- Keybinds:
--   <leader>sf         Find files
--   <leader>sg         Live grep (search text across the project)
--   <leader>sw         Search word under cursor
--   <leader>s/         Live grep in open buffers
--   <leader>/          Search in the current buffer
--   <leader>sb         Search open buffers
--   <leader><space>    Search open buffers
--   <leader>sm         Search marks
--   <leader>so         Recent files
--   <leader>sh         Search help
--   <leader>sd         Search diagnostics
--   <leader>sr         Resume last search
--   <leader>sds        LSP document symbols
--   <leader>gf         Git files
--   <leader>gc         Git commits
--   <leader>gcf        Git commits for current file
--   <leader>gb         Git branches
--   <leader>gs         Git status
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- To shorten lines.
    local actions = require 'telescope.actions'
    local builtin = require 'telescope.builtin'

    require('telescope').setup {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'bottom',
            preview_width = 0.6,
            width = { padding = 0 },
            height = { padding = 0 },
          },
        },
        mappings = {
          i = {
            ['<C-p>'] = actions.move_selection_previous, -- move to prev result
            ['<C-n>'] = actions.move_selection_next, -- move to next result
            -- ['<esc>'] = actions.close, -- open file
            -- ['<C-l>'] = actions.select_default, -- open file
          },
          -- Always in insert mode and esc closes fuzzy.
          -- n = {
          -- ['q'] = actions.close,
          -- },
        },
        path_display = {
          filename_first = {
            reverse_directories = true,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          hidden = true,
        },
        buffers = {
          initial_mode = 'insert',
          sort_lastused = true,
          -- sort_mru = true,
          mappings = {
            n = {
              ['d'] = actions.delete_buffer,
              ['l'] = actions.select_default,
            },
          },
        },
        marks = {
          initial_mode = 'insert',
        },
        oldfiles = {
          initial_mode = 'insert',
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '%.git', '%.venv' },
          additional_args = function(_)
            return { '--hidden' }
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
      git_files = {
        previewer = false,
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'FUZ: [S]earch existing [B]uffers' })
    -- vim.keymap.set('n', '<leader><tab>', builtin.buffers, { desc = 'FUZ: [S]earch existing [B]uffers' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = 'FUZ: [S]earch existing buffers' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'FUZ: [S]earch [M]arks' })
    vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'FUZ: Search [G]it [F]iles' })
    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'FUZ: Search [G]it [C]ommits' })
    vim.keymap.set('n', '<leader>gcf', builtin.git_bcommits, { desc = 'FUZ: Search [G]it [C]ommits for current [F]ile' })
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'FUZ: Search [G]it [B]ranches' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'FUZ: Search [G]it [S]tatus (diff view)' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'FUZ: [S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'FUZ: [S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'FUZ: [S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'FUZ: [S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'FUZ: [S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'FUZ: [S]earch [R]resume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = 'FUZ: [S]earch Recent Files' })
    vim.keymap.set('n', '<leader>sds', function()
      builtin.lsp_document_symbols {
        symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Property' },
      }
    end, { desc = 'FUZ: [S]each LSP document [S]ymbols' })
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = 'FUZ: [S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = 'FUZ: [/] Fuzzily search in current buffer' })
  end,
}
