return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '-' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
		on_attach = function(bufnr)
			-- Keymaps
			local gs = package.loaded.gitsigns
			local map = vim.keymap.set

			map("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Next Git hunk" })
			map("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Previous Git hunk" })
			map("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview Git hunk" })
			map("n", "<leader>gb", gs.blame_line, { buffer = bufnr, desc = "Git blame line" })
		end
	}
}
