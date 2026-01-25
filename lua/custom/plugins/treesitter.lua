-- return {
--   { -- Highlight, edit, and navigate code
--     'nvim-treesitter/nvim-treesitter',
--     build = ':TSUpdate',
--     -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
--     opts = {
--       ensure_installed = {
--         'bash',
--         'c',
--         'diff',
--         'html',
--         'lua',
--         'luadoc',
--         'markdown',
--         'markdown_inline',
--         'query',
--         'vim',
--         'vimdoc',
--         'cpp',
--         'c_sharp',
--         'css',
--         'javascript',
--         'typescript',
--         'tsx',
--         'jsx',
--       },
--       -- Autoinstall languages that are not installed
--       auto_install = true,
--       highlight = {
--         enable = true,
--         -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
--         --  If you are experiencing weird indenting issues, add the language to
--         --  the list of additional_vim_regex_highlighting and disabled languages for indent.
--         -- additional_vim_regex_highlighting = { 'ruby' },
--       },
--       -- indent = { enable = true, disable = { 'ruby' } },
--     },
--     -- There are additional nvim-treesitter modules that you can use to interact
--     -- with nvim-treesitter. You should go explore a few and see what interests you:
--     --
--     --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
--     --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
--     --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--     -- config = function(_, opts)
--     --   -- NOTE: Use 'nvim-treesitter.configs' if on the stable/master branch
--     --   -- Use 'nvim-treesitter.config' (singular) if you are on the new 'main' branch
--     --   local status, configs = pcall(require, 'nvim-treesitter.configs')
--     --   if not status then
--     --     configs = require 'nvim-treesitter.config'
--     --   end
--     --   configs.setup(opts)
--     -- end,
--   },
-- }
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'

      -- 1. Setup the plugin (minimal config)
      ts.setup {
        -- You can specify local parser paths here if needed
        -- but default settings usually suffice now.
      }

      -- 2. Replacement for ensure_installed
      -- This ensures parsers are downloaded and compiled via tree-sitter-cli
      ts.install {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'cpp',
        'c_sharp',
        'css',
        'javascript',
        'typescript',
        'jsx',
        'tsx',
      }

      -- 3. Activation via Autocommand
      -- This replaces 'highlight = { enable = true }'
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true }),
        callback = function(args)
          -- pcall prevents errors if a parser isn't found for a specific filetype
          local ok, _ = pcall(vim.treesitter.start, args.buf)

          -- Optional: Enable Treesitter-based indentation
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
