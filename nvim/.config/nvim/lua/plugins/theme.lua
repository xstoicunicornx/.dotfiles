return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-moon'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#8b93c4' })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#545c7e' })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#8b93c4' })
      vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#737aa2' })
      --   git = {
      --     add = '#b8db87',
      --     change = '#7ca1f2',
      --     delete = '#e26a75',
      --   },

      vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#3f4e30' })
      vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#5c4660' })
      -- vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#52252c' })
      vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#2e4268' })
      -- vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#73ad68' })
      -- vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#995d5b' })
      -- vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#6886ab' })
      -- vim.api.nvim_set_hl(0, 'DiffviewDiffAddInline', { bg = '#4a6038' })
      -- vim.api.nvim_set_hl(0, 'DiffviewDiffDeleteInline', { bg = '#6b3a4a' })
      -- vim.api.nvim_set_hl(0, 'DiffviewDiffDeleteDim', { bg = '#3a1a1f' })
      -- vim.api.nvim_set_hl(0, 'DiffText', { bg = '#394b70' })
      vim.api.nvim_set_hl(0, 'DiffText', { bg = '#465e90' })
      vim.api.nvim_set_hl(0, 'DiffviewDiffTextInline', { bg = '#465e90' })
      vim.api.nvim_set_hl(0, 'Comment', { fg = '#8b93c4' })
      vim.api.nvim_set_hl(0, 'Visual', { bg = '#7a5faa' })
    end,
  },
  -- {
  --   'catppuccin/nvim',
  --   enabled = false,
  --   lazy = false,
  --   name = 'catppuccin',
  --   priority = 1000,
  --
  --   config = function()
  --     require('catppuccin').setup {
  --       transparent_background = true,
  --     }
  --     vim.cmd.colorscheme 'catppuccin-frappe'
  --   end,
  -- },
}
