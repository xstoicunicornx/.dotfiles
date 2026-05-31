-- -- tokyonight moon colors
-- local colors = {
--   bg = '#222436',
--   bg_dark = '#1e2030',
--   bg_dark1 = '#191B29',
--   bg_highlight = '#2f334d',
--   blue = '#82aaff',
--   blue0 = '#3e68d7',
--   blue1 = '#65bcff',
--   blue2 = '#0db9d7',
--   blue5 = '#89ddff',
--   blue6 = '#b4f9f8',
--   blue7 = '#394b70',
--   comment = '#636da6',
--   cyan = '#86e1fc',
--   dark3 = '#545c7e',
--   dark5 = '#737aa2',
--   fg = '#c8d3f5',
--   fg_dark = '#828bb8',
--   fg_gutter = '#3b4261',
--   green = '#c3e88d',
--   green1 = '#4fd6be',
--   green2 = '#41a6b5',
--   magenta = '#c099ff',
--   magenta2 = '#ff007c',
--   orange = '#ff966c',
--   purple = '#fca7ea',
--   red = '#ff757f',
--   red1 = '#c53b53',
--   teal = '#4fd6be',
--   terminal_black = '#444a73',
--   yellow = '#ffc777',
--   git = {
--     add = '#b8db87',
--     change = '#7ca1f2',
--     delete = '#e26a75',
--   },
--   white = '#D4D4D4',
--   steel_grey = '#4c566a',
--   grey = '#3b4252',
-- }
local colors = require("tokyonight.colors").setup({ style = 'moon' })
colors.white = '#D4D4D4' ---@diagnostic disable-line: inject-field
colors.steel_grey = '#4c566a' ---@diagnostic disable-line: inject-field
colors.grey = '#3b4252' ---@diagnostic disable-line: inject-field

-- define custom theme
local theme = {
  normal = {
    b = { fg = colors.white, bg = colors.steel_grey },
    a = { fg = colors.white, bg = colors.bg_highlight },
    c = { fg = colors.white, guibg = 'none' },
  },
  visual = {
    b = { fg = colors.magenta, bg = colors.steel_grey },
    a = { fg = colors.bg, bg = colors.magenta, gui = 'bold' },
    c = { fg = colors.bg, bg = colors.magenta },
  },
  inactive = {
    b = { fg = colors.white, bg = colors.steel_grey },
    a = { fg = colors.white, bg = colors.steel_grey },
  },
  replace = {
    b = { fg = colors.yellow, bg = colors.steel_grey },
    a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' },
    c = { fg = colors.bg, bg = colors.yellow },
  },
  insert = {
    b = { fg = colors.orange, bg = colors.steel_grey },
    a = { fg = colors.bg, bg = colors.orange, gui = 'bold' },
    c = { fg = colors.bg, bg = colors.orange },
  },
  command = {
    b = { fg = colors.cyan, bg = colors.steel_grey },
    a = { fg = colors.bg, bg = colors.cyan, gui = 'bold' },
    c = { fg = colors.bg, bg = colors.cyan },
  },
}

-- define custom functions
local function get_total_lines()
  return vim.fn.line '$'
end

-- define sections
local tabline = {
  lualine_a = { 'buffers' },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'tabs' },
}

local sections = {
  lualine_a = {
    {
      function()
        return 'RECORDING'
      end,
      cond = require('noice').api.status.mode.has,
      color = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    },
    {
      'mode',
    },
  },
  lualine_b = { 'branch', 'diff', 'diagnostics' },
  lualine_c = { { 'filename', file_status = true, path = 1 } },
  lualine_x = { 'encoding', 'fileformat', 'filetype' },
  lualine_y = { 'progress' },
  lualine_z = {
    'location',
    { get_total_lines, description = 'total lines' },
    {
      function()
        return '●'
      end,
      cond = require('noice').api.status.mode.has,
      color = { fg = colors.bg, bg = colors.red, gui = 'bold' },
    },
  },
}

local inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = { { 'filename', file_status = true, path = 1 } },
  lualine_x = { 'location', { get_total_lines, description = 'total lines' } },
  lualine_y = {},
  lualine_z = {},
}

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { { 'MunifTanjum/nui.nvim', lazy = true } },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      routes = {
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
            },
          },
          view = 'mini',
        },
      },
      presets = {
        -- bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>zn",  "",                                                                            desc = "+noice" },
      { "<S-Enter>",   function() require("noice").redirect(vim.fn.getcmdline()) end,                 mode = "c",                              desc = "Redirect Cmdline" },
      { "<leader>znl", function() require("noice").cmd("last") end,                                   desc = "Noice Last Message" },
      { "<leader>znh", function() require("noice").cmd("history") end,                                desc = "Noice History" },
      { "<leader>zna", function() require("noice").cmd("all") end,                                    desc = "Noice All" },
      { "<leader>znd", function() require("noice").cmd("dismiss") end,                                desc = "Dismiss All" },
      { "<leader>znt", function() require("noice").cmd("pick") end,                                   desc = "Noice Picker (Telescope/FzfLua)" },
      { "<c-f>",       function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,  silent = true,                           expr = true,              desc = "Scroll Forward",  mode = { "i", "n", "s" } },
      { "<c-b>",       function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true,                           expr = true,              desc = "Scroll Backward", mode = { "i", "n", "s" } },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          theme = theme,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = sections,
        inactive_sections = inactive_sections,
        tabline = tabline,
      }
    end,
  },
}
