return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.startify'

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    dashboard.section.top_buttons.val = {
      dashboard.button('l', '[l]ast session', ':lua require("persistence").load() <CR>'),
      dashboard.button('r', '[r]ecent', ':lua require("telescope.builtin").oldfiles({ cwd_only = true }) <CR>'),
      dashboard.button('f', '[f]ind file', ':Telescope find_files <CR>'),
      dashboard.button('e', '[e]xplorer', ':Neotree filesystem reveal toggle left <CR>'),
      dashboard.button('n', '[n]ew file', '<cmd>ene <CR>'),
    }

    alpha.setup(dashboard.opts)
  end,
}
