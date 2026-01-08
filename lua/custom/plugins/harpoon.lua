return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}

      local conf = require('telescope.config').values

      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end
      local function remove_current_from_harpoon(harpoon_files)
        local current_file = vim.api.nvim_buf_get_name(0)
        -- Normalize the path to match how Harpoon stores it
        local relative_path = vim.fn.fnamemodify(current_file, ':.')

        for _, item in ipairs(harpoon_files.items) do
          if item.value == relative_path then
            harpoon_files:remove(item)
            print('Removed from Harpoon: ' .. relative_path)
            return
          end
        end
        print 'Buffer not found in Harpoon list.'
      end

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[H]arpoon [A]dd' })
      vim.keymap.set('n', '<leader>hr', function()
        remove_current_from_harpoon(harpoon:list())
      end, { desc = '[H]arpoon [R]emove' })
      vim.keymap.set('n', '<leader>hp', function()
        harpoon:list():prev()
      end, { desc = '[H]arpoon  [P]revious' })
      vim.keymap.set('n', '<leader>hn', function()
        harpoon:list():next()
      end, { desc = '[H]arpoon  [N]ext' })
      vim.keymap.set('n', '<leader>hl', function()
        toggle_telescope(harpoon:list())
      end, { desc = '[H]arpoon [L]ist' })
    end,
  },
}
