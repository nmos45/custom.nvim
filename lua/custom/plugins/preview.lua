return {
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },

    ft = { 'md', 'html' },
    keys = {
      { '<leader>lo', ':LivePreview start<CR>', desc = '[L]ivePreview [O]pen' },
      { '<leader>lc', ':LivePreview close<CR>', desc = '[L]ivePreview [C]lose' },
      { '<leader>lf', ':LivePreview pick<CR>', desc = '[L]ivePreview [f]ind' },
    },

    config = function()
      require('livepreview.config').set {
        port = 5500,
        browser = 'default',
        dynamic_root = false,
        sync_scroll = true,
        address = '127.0.0.1',
      }
    end,
  },
}
