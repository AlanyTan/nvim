vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
  -- optionally enable 24-bit colour
vim.opt.termguicolors = true

  -- empty setup using defaults
require('nvim-web-devicons').get_icons()
--require("nvim-web-devicons").set_default_icon("📝", "#6d8086")
require('nvim-web-devicons').setup {
 -- your personal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "🐚",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- set the light or dark variant manually, instead of relying on `background`
 -- (default to nil)
 variant = "light|dark";
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
 };
 -- same as `override` but specifically for operating system
 -- takes effect when `strict` is true
 override_by_operating_system = {
  ["apple"] = {
    icon = "🍎",
    color = "#A2AAAD",
    cterm_color = "248",
    name = "Apple",
  },
 };
}

require("nvim-tree").setup()

  -- OR setup with some options
require("nvim-tree").setup({
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
--    renderer = {
--      group_empty = true,
--      icons = {
--       glyphs = {
--	default = "📝",
--        symlink = "⛓️",
--        folder = {
--          arrow_closed = "├",
--          arrow_open = "⎿",
--          default = "📁",
--          open = "📂",
--          empty = "🫙",
--          empty_open = "🫙📂",
--          symlink = "🔗",
--          symlink_open = "🖇️",
--        },
--        git = {
--          unstaged = "",
--          staged = "✓",
--          unmerged = "",
--          renamed = "➜",
--          untracked = "★",
--          deleted = "✗",
--          ignored = "◌",
--        },
--       },
--    },
--    },
--    filters = {
--      dotfiles = true,
--    },
})
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

