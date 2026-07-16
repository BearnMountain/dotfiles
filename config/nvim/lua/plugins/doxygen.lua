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
                rust = {
					template = {
						annotation_convention = "custom_rustdoc",
						custom_rustdoc = {
							-- Pass plain strings, do not include '///' manually. Neogen handles the comments!
							{ nil, "Brief description here", { type = { "func" } } },
							{ nil, "", { type = { "func" } } },
							
							-- Arguments Section
							{ nil, "# Arguments", { type = { "func" }, parameters = true } },
							-- %s automatically grabs the actual parameter name from treesitter!
							{ "parameters", "* `%s` - description", { type = { "func" } } }, 
							{ nil, "", { type = { "func" }, parameters = true } },
							
							-- Returns Section
							{ nil, "# Returns", { type = { "func" }, returns = true } },
							{ "returns", "* return_description", { type = { "func" } } },
							{ nil, "", { type = { "func" }, returns = true } },
							
							-- Examples Section
							{ nil, "# Examples", { type = { "func" } } },
							{ nil, "```rust", { type = { "func" } } },
							{ nil, "// TODO: Add example code here", { type = { "func" } } },
							{ nil, "```", { type = { "func" } } },
						}
					}                
				},
            },
            -- templates = {
            --     -- This nests the custom convention specifically under the rust language definition
            --     rust = {
            --         custom_rustdoc = {
            --             type = { "func", "class" },
            --             template = {
            --                 { nil, "/// $1", { type = { "func" } } }, -- Brief summary
            --                 { nil, "///", { type = { "func" } } },
            --                 { nil, "/// # Arguments", { type = { "func" }, parameters = true } },
            --                 { "parameters", "/// * `$1` - $2" },
            --                 { nil, "///", { type = { "func" }, parameters = true } },
            --                 { nil, "/// # Returns", { type = { "func" }, returns = true } },
            --                 { "returns", "/// * $1" },
            --                 { nil, "///", { type = { "func" } } },
            --                 { nil, "/// # Examples", { type = { "func" } } },
            --                 { nil, "/// ```rust", { type = { "func" } } },
            --                 { nil, "/// // TODO: Add example code here", { type = { "func" } } },
            --                 { nil, "/// ```", { type = { "func" } } },
            --             }
            --         }
            --     }
            -- }
        })
    end,
    keys = {
        { "<leader>nf", ":lua require('neogen').generate()<CR>", desc = "Generate Function Doc" }
    }
}
