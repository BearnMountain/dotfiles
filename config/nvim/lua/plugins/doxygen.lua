return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("neogen").setup({
			enabled = true,
			languages = {
				c = {
					template = { annotation_convention = "doxygen" }
				},
				cpp = {
					template = { annotation_convention = "doxygen" }
				},
			}
		})
	end,
	-- Quick keymap to trigger it
	keys = {
		{ "<leader>nf", ":lua require('neogen').generate()<CR>", desc = "Generate Function Doc" }
	}
}
