return {
  { 'towolf/vim-helm', ft = 'helm' },
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        -- Conform can also run multiple formatters sequentially
        python = { 'ruff_organize_imports', 'ruff_format' },
        terraform = { 'terraform_fmt' },
        html = { 'prettierd' },
        markdown = { 'prettierd' },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',

    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
      },
    },
  },
}
