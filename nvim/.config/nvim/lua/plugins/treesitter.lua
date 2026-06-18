return {           -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  branch = 'main', -- the rewrite; old `master` API is gone on nvim 0.12
  build = ':TSUpdate',
  config = function()
    local ensure_installed = {
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
      'vue',
      'css',
      'javascript',
      'typescript',
    }

    -- Install only the parsers that aren't already present.
    local installed = require('nvim-treesitter.config').get_installed()
    local to_install = vim.tbl_filter(function(lang)
      return not vim.tbl_contains(installed, lang)
    end, ensure_installed)
    if #to_install > 0 then
      require('nvim-treesitter').install(to_install)
    end

    -- Build the set of filetypes our installed parsers handle, so the autocmd
    -- below only fires for those and never for plugin UI buffers (noice, lazy, ...).
    local filetypes = {}
    for _, lang in ipairs(ensure_installed) do
      for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        filetypes[#filetypes + 1] = ft
      end
    end

    -- The new plugin only installs parsers; highlighting/indent are enabled
    -- per-buffer here (replaces the old highlight.enable / indent.enable opts).
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('my.treesitter', { clear = true }),
      pattern = filetypes,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
