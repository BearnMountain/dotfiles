return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	init = function()
		local ensure_installed = { 
			"c", 
			"cpp", 
			"lua", 
			"bash", 
			"vimdoc", 
			"json", 
			"markdown",
			"python",
			"toml"
		}
		local installed = require("nvim-treesitter.config").get_installed()
		local to_install = vim.iter(ensure_installed)
			:filter(function(p) return not vim.tbl_contains(installed, p) end)
			:totable()
		if #to_install > 0 then
			require("nvim-treesitter").install(to_install)
		end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start) -- enable highlighting
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
