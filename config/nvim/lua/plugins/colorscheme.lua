-- return {
--     "tiagovla/tokyodark.nvim",
--     priority = 1000,
--     config = function()
--         vim.cmd [[colorscheme tokyodark]]
--     end,
-- }

-- return {
--     "sainnhe/gruvbox-material",
--     priority = 1000,
--     config = function()
--         vim.g.everforest_enable_italic = true
--
--         vim.cmd("colorscheme gruvbox-material")
--     end,
-- }

-- return {
-- 	"projekt0n/github-nvim-theme",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("github-theme").setup({
-- 			options = {
-- 				styles = {
-- 					comments = "italic",
-- 					functions = "bold",
-- 					keywords = "italic",
-- 					types = "italic,bold",
-- 				},
-- 			},
-- 		})
--
-- 		-- Now select the style via :colorscheme
-- 		vim.cmd("colorscheme github_dark_dimmed")  -- or any variant you want
-- 	end,
-- }

-- return {
--     "sainnhe/sonokai",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.g.sonokai_enable_italic = true
--         vim.cmd("colorscheme sonokai")
--         vim.g.sonokai_style = "atlantis"
--         vim.cmd([[set background=dark]])
--         vim.api.nvim_set_hl(0, "Function", { fg = "#5f875f" })
--         vim.api.nvim_set_hl(0, "Normal", { bg = "#121212" }) -- 1a1d23 alt
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1c1c1c" })  -- Lighter background for inactive windows
--     end,
-- }
	

return {
  {
    "cryptomilk/nightcity.nvim",
    version = false,
    lazy = false,
    priority = 1000,
    opts = {
      style = "kabuki",
      on_highlights = function(hl, c)
        local bg = "#0b0b0d" -- darker background

        hl.Normal = { bg = bg }
        hl.NormalFloat = { bg = bg }
        hl.FloatBorder = { bg = bg }
        hl.SignColumn = { bg = bg }
        hl.LineNr = { bg = bg }
        hl.CursorLine = { bg = "#111113" }
        hl.CursorLineNr = { bg = bg }
      end,
    },
	config = function(_, opts)
      require("nightcity").setup(opts)
      vim.cmd.colorscheme("nightcity")
    end,
  },
}

-- return {
-- 	-- Neovim config with moonfly colorscheme
--
-- -- Enable true color\ vim.opt.termguicolors = true
--
-- -- Moonfly plugin via lazy.nvim
-- require("lazy").setup({
--   {
--     "bluz71/vim-moonfly-colors",
--     name = "moonfly",
--     lazy = false,
--     priority = 1000,
--   },
-- })
--
-- -- Moonfly options (set BEFORE colorscheme)
-- vim.g.moonflyCursorColor = true
-- vim.g.moonflyItalics = false
-- vim.g.moonflyNormalPmenu = true
-- vim.g.moonflyNormalFloat = true
-- vim.g.moonflyTransparent = false
-- vim.g.moonflyUndercurls = true
-- vim.g.moonflyUnderlineMatchParen = false
-- vim.g.moonflyVirtualTextColor = true
-- vim.g.moonflyWinSeparator = 2
--
-- -- Optional prettier window separators
-- vim.opt.fillchars = {
--   horiz = '━',
--   horizup = '┻',
--   horizdown = '┳',
--   vert = '┃',
--   vertleft = '┫',
--   vertright = '┣',
--   verthoriz = '╋',
-- }
--
-- -- Custom palette override (optional; remove if not needed)
-- -- require("moonfly").custom_colors({
-- --   bg = "#121212",
-- --   violet = "#ff74b8",
-- -- })
--
-- -- Apply colorscheme
-- vim.cmd([[colorscheme moonfly]])
--
-- -- Custom highlight overrides\ nlocal custom_hl = vim.api.nvim_create_augroup("CustomMoonflyHighlights", {})
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "moonfly",
--   group = custom_hl,
--   callback = function()
--     vim.api.nvim_set_hl(0, "Function", { fg = "#74b2ff", bold = true })
--     vim.api.nvim_set_hl(0, "Comment", { fg = "#6e6e6e", italic = true })
--   end,
-- })
--
-- -- General options
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.cursorline = true
-- vim.opt.expandtab = true
-- vim.opt.shiftwidth = 2
-- vim.opt.tabstop = 2
-- vim.opt.smartindent = true
--
-- }
