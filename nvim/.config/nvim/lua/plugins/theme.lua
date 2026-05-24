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
      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#3b4261' })
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#545c7e' })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#3b4261' })
      vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { fg = '#737aa2' })
      vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#2a4556' })
      vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#4b2a3d' })
      vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#4a4530' })
      vim.api.nvim_set_hl(0, 'DiffText', { bg = '#394b70' })
      vim.api.nvim_set_hl(0, 'Comment', { fg = '#636da6' })
    end,
  },
  {
    'catppuccin/nvim',
    enabled = false,
    lazy = false,
    name = 'catppuccin',
    priority = 1000,

    config = function()
      require('catppuccin').setup {
        transparent_background = true,
      }
      vim.cmd.colorscheme 'catppuccin-frappe'
    end,
  },
}
