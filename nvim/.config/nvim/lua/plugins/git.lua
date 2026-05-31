-- Adds related signs to the gutter, as well as utilities for managing changes

return {
  {
    -- See `:help gitsigns` to understand what the configuration keys do
    'lewis6991/gitsigns.nvim',
    opts = {
      -- Adds related signs to the gutter, as well as utilities for managing changes
      signs = {
        -- add = { text = '+' },
        -- change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        -- changedelete = { text = '~' },
      },
      diff_opts = {
        algorithm = "histogram",
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>gs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[s]tage hunk' })
        map('v', '<leader>gr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = '[r]eset hunk' })
        -- normal mode
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[s]tage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[r]eset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
        -- map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[u]ndo stage hunk' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
        map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[p]review hunk' })
        -- map('n', '<leader>gb', gitsigns.blame_line, { desc = '[b]lame line' })
        map('n', '<leader>gd', gitsigns.diffthis, { desc = '[d]iff against index' })
        map('n', '<leader>gD', function()
          gitsigns.diffthis '@'
        end, { desc = '[D]iff against last commit' })
        -- Toggles
        map('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = '[b]lame line toggle' })
        -- map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle show [D]eleted' })
      end,
    },
  },
  {
    'rickhowe/diffchar.vim',
    config = function()
      --   -- Use bold/underline on adjacent chars instead of virtual blank columns.
      --   vim.g.DiffDelPosVisible = 1
      --
      --   -- Disable diffchar default keymaps.
      --   -- See: https://github.com/rickhowe/diffchar.vim/issues/21
      vim.cmd([[
      nmap <leader>g <Nop>
      nmap <leader>p <Nop>
    ]])
    end,
  },
  {
    -- "sindrets/diffview.nvim",
    "dlyongemallo/diffview.nvim",
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        -- enhanced_diff_hl = true,
        diffopt = { algorithm = "myers", "linematch:60" }, -- vim.opt.diffopt others "histogram" | "patience" | "minimal"
        view = {
          default = { layout = "diff1_inline" },
          inline = {
            deletion_highlight = "full_width",
            style = "unified",
          },
          file_history_view = { layout = "diff1_inline" },
          file_history = { layout = "diff1_inline" },
          cycle_layouts = {
            default = { "diff1_inline", "diff2_horizontal", },
          },
          merge_tool = {
            layout = "diff4_mixed", -- or "diff3_vertical", "diff3_mixed", "diff4_mixed"
            disable_diagnostics = true,
            winbar_info = true,
          },
        },
        keymaps = {
          view = {
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "[e]xplorer" } },
            { "n", "<leader>b", false,                                    { desc = "" } },
          },
          file_panel = {
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "[e]xplorer" } },
            { "n", "<leader>b", false,                                    { desc = "" } },
          },
          file_history_panel = {
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "[e]xplorer" } },
            { "n", "<leader>b", false,                                    { desc = "" } },
          },
        }
      })
    end,
  }
}
