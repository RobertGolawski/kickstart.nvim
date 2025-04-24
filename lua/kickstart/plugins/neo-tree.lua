-- lua/plugins/neo-tree.lua (or wherever you define this plugin)

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*', -- Use version = false for stability or '*' for latest features
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- Recommended for icons
    'MunifTanjim/nui.nvim',
    -- OPTIONAL: Add this if you want integration with Git signs highlights
    -- 'lewis6991/gitsigns.nvim'
  },
  cmd = 'Neotree',
  keys = {
    -- Define a keymap to easily reveal the current file in the tree
    -- You can change '\\' to your preferred leader key sequence, e.g., '<leader>e'
    {
      '\\',
      function()
        require('neo-tree.command').execute { toggle = true, reveal = true }
      end,
      desc = 'NeoTree (reveal)',
      silent = true,
    },
    -- Or a keymap to just toggle the tree
    -- { '<leader>e', ':Neotree toggle<CR>', desc = 'NeoTree toggle', silent = true },
  },
  opts = {
    -- ## General Options ##

    -- Close Neovim if Neo-tree is the last window
    close_if_last_window = false, -- Set to true if you like this behavior
    -- Open the tree automatically when Neovim starts (if no file is specified)
    -- open_files_do_not_replace_types = { "terminal", "Trouble", "qf" }, -- Types of buffers that won't be replaced by Neo-tree opening

    -- ## Source Selectors ##
    -- Define sources for the selection popup (defaults are fine for most)
    -- source_selector = { ... }

    -- ## Event Handlers ##
    -- Custom event handlers if needed
    -- event_handlers = { ... }

    -- ## Filesystem Source Options ##
    filesystem = {
      -- Enable the libuv file watcher for automatic refreshing
      use_libuv_file_watcher = true,

      -- Filter options (modern way to handle hidden/ignored files)
      filtered_items = {
        visible = false, -- Set to true to see hidden files by default
        never_show = { -- Remains hidden even when filtering is toggled
          '.DS_Store',
          'thumbs.db',
        },
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_by_name = {
          -- '.git',
          -- 'node_modules'
        },
        hide_by_pattern = { -- Uses Lua patterns
          -- '*/.meta/*',
          -- '__pycache__'
        },
      },

      -- Automatically reveal the current buffer's file in the tree
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false, -- Close previously opened dirs when following
      },

      -- Use this for Git status instead of the separate git_status source
      -- see :h neo-tree-git-status
      git_status_use_simple_mode = false,

      -- Filesystem Window Specific Settings
      window = {
        mappings = {
          -- Default mappings:
          ['<CR>'] = 'open',
          ['o'] = 'open',
          ['<esc>'] = 'cancel', -- Close drawer or popup
          ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['l'] = 'focus_preview',
          -- ['S'] = 'open_split',
          -- ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew', -- Uncomment/change if needed
          ['w'] = 'open_with_window_picker',
          ['W'] = 'open_with_window_picker', -- Alias for consistency
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['Z'] = 'expand_all_nodes',
          ['a'] = { 'add', config = { show_path = 'relative' } }, -- Add file/folder
          ['A'] = 'add_directory', -- Add directory
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy', -- Copy operation (requires destination)
          ['m'] = 'move', -- Move operation (requires destination)
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
          ['i'] = 'show_file_details', -- Show details in preview window

          -- Custom mappings from your original config:
          ['\\'] = 'close_window', -- Map backslash to close
          ['.'] = 'toggle_hidden', -- Toggle visibility of items hidden by filters
          ['v'] = 'open_vsplit', -- Already mapped to 's' by default, but you can keep 'v' too
          ['s'] = 'open_split', -- Already mapped to 'S' by default, but you can keep 's' too
        },
        -- Add other filesystem window specific settings if needed
      },
    },

    -- ## Buffers Source Options ##
    buffers = {
      -- follow_current_file = true, -- Optional
      -- window = { mappings = { ... } } -- Buffer specific mappings
    },

    -- ## Git Status Source Options ##
    -- NOTE: It's often recommended to integrate Git status directly into the
    -- filesystem view using `filesystem.git_status_use_simple_mode = false` (default)
    -- and configuring the `git_status` component below, rather than using this
    -- separate source. If you prefer a separate Git Status tree, configure here.
    git_status = {
      enable = true, -- Enable the Git Status component (used by filesystem view)
      -- window = { mappings = { ... } } -- Git Status specific mappings
    },

    -- ## Diagnostics Source Options ##
    diagnostics = {
      enable = true, -- Enable the Diagnostics component (used by filesystem view)
      -- symbols = { ... } -- Configure diagnostic symbols if needed
      -- window = { mappings = { ... } } -- Diagnostics specific mappings
    },

    -- ## Window Options (Global) ##
    -- These apply to all Neo-tree windows unless overridden by source-specific settings
    window = {
      position = 'left',
      width = 30,
      -- Other global window settings...
      -- auto_expand_width = true, -- Automatically resize width?
    },

    -- ## Default Component Configurations ##
    -- Configure the appearance and behavior of components like icons, git status, etc.
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- Padding AFTER the indent chars
        -- indent_marker = "│",
        -- last_indent_marker = "└",
        highlight = 'NeoTreeIndentMarker',
        -- Additional options for expanders:
        with_expanders = true, -- Show expanders?
        expander_collapsed = '', -- ▶
        expander_expanded = '', -- ▼
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '', -- 
        folder_open = '', -- 
        folder_empty = '󰜌', -- 
        -- The default icon specifically for files
        default = '󰈚', -- 
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = ' ✚ ', -- You can use '✚' or '●' etc.
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
        highlight_opened = 'NeoTreeFileNameOpened', -- Optional highlight for opened files
      },
      git_status = {
        symbols = {
          -- Use icons based on your font (Nerd Font examples shown)
          added = '✚', -- or ''
          modified = ' M ', -- or '', ''
          deleted = '✖', -- or '', ''
          renamed = '➜', -- or ''
          -- Status type
          untracked = '?', -- or ''
          ignored = '◌', -- or ''
          unstaged = '!', -- or '󰏫'
          staged = '✓', -- or '󰜄'
          conflict = '', -- or '󰘬'
        },
        highlights = {
          -- Default highlights linking to GitSigns highlights
          added = 'GitSignsAdd',
          modified = 'GitSignsChange',
          deleted = 'GitSignsDelete',
          renamed = 'GitSignsAdd', -- Or define NeoTreeRenamed highlight
          untracked = 'GitSignsAdd', -- Or define NeoTreeUntracked highlight
          ignored = 'Comment', -- Or define NeoTreeIgnored highlight
          unstaged = 'GitSignsChange', -- Or define NeoTreeUnstaged highlight
          staged = 'GitSignsAdd', -- Or define NeoTreeStaged highlight
          conflict = 'GitSignsDelete', -- Or define NeoTreeConflict highlight
        },
      },
      diagnostics = {
        symbols = {
          error = ' ',
          warn = ' ',
          info = ' ',
          hint = '󰌶 ',
        },
        highlights = {
          error = 'DiagnosticError',
          warn = 'DiagnosticWarn',
          info = 'DiagnosticInfo',
          hint = 'DiagnosticHint',
        },
      },
      -- Add other component configs if needed (e.g., file_size, type, date)
    },
  },
}
