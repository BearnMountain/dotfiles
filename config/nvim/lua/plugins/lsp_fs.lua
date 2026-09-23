return {
	"ionide/Ionide-vim",
	ft = { "fsharp", "fsharp_project" },

	init = function()
		-- Must be set BEFORE Ionide-vim loads
		vim.g["fsharp#fsautocomplete_command"] = {
			"dotnet",
			"fsautocomplete",
		}
	end,

	config = function()
		vim.api.nvim_create_autocmd("CursorHold", {
			pattern = { "*.fs", "*.fsi", "*.fsx" },
			callback = function()
				if vim.fn.exists("*fsharp#showTooltip") == 1 then
					vim.fn["fsharp#showTooltip"]()
				end
                vim.lsp.buf.format({
                    async = false,
                    timeout_ms = 5000,
                })
			end,
		})

		-- FSI window
		-- vim.g["fsharp#fsi_window_command"] = "vnew"
	end,
}
