return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- Show dotfiles by default like LazyVim
        },
        follow_current_file = {
          enabled = true, -- Focus the file you are currently editing
        },
      },
      window = {
        mappings = {
          -- Use 'l' to open a file or expand a directory
          ['l'] = 'open',
          -- Use 'h' to close a directory or go up to parent
          ['h'] = 'close_node',
          -- Map 's' and 'v' for splits (common in LazyVim)
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
        },
      },
    },
  },
}
