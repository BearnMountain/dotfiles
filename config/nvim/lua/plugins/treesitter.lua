return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
	name = "treesitter",
	lazy = false,
    config = function()
        require('nvim-treesitter.config').setup({
            ensure_installed = {
                "c",
                "cpp",
                "dockerfile",
                "make",
                "gitignore",
                "lua",
                "bash",
                "html",
                "css",
				"javascript",
                "json",
                "rust",
                "toml",
				"markdown",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
        })
    end
}
