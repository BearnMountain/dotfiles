return {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "rust", "c", "cpp" },

    config = function()
        require("neogen").setup({
            enabled = true,
            snippet_engine = "nvim",

            languages = {
                rust = {
					template = {
						annotation_convention = "rust_alternative",
					},
				},
                c = {
                    template = {
                        annotation_convention = "doxygen",
                    },
                },

                cpp = {
                    template = {
                        annotation_convention = "doxygen",
                    },
                },
            },
        })
    end,

    keys = {
        {
            "<leader>nf",
            function()
                require("neogen").generate({
                    type = "func",
                })
            end,
            desc = "Generate Function Doc",
        },
        {
            "<leader>ns",
            function()
                require("neogen").generate({
                    type = "class",
                })
            end,
            desc = "Generate Struct Doc",
        },
    },
}
