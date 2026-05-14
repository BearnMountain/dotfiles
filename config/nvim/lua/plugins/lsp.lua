return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "L3MON4D3/LuaSnip",
        'saghen/blink.cmp',
        'chomosuke/typst-preview.nvim',
    },
    config = function()
        local blink = require('blink.cmp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            blink.get_lsp_capabilities())
        local luasnip = require("luasnip")
        luasnip.setup({
            enable_autosnippets = true,
        })
        require("mason").setup({
            PATH = "append",
        })

        vim.lsp.enable({
            "lua_ls",
            "clangd",
            "rust-analyzer",
            "texlab",
            "tinymist",
            "zls",
            "pylsp",
			"pyright",
        })

        vim.lsp.config("*", {
            capabilities = capabilities,
        })
        vim.lsp.config.zls = {
            on_init = function()
                vim.g.zig_fmt_parse_errors = 0
                vim.g.zig_fmt_autosave = 0
            end,
            capabilities = capabilities,
            autoformat = false,
        }
        vim.lsp.config.lua_ls = {
            capabilities = capabilities,
            settings = {
                Lua = {
                    telemetry = { enable = false, },
                    runtime = {
                        version = "LuaJIT",
                        path =  { "lua/?.lua", "lua/?/init.lua", }
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME, },
                    }
                }
            },

        }
		vim.lsp.config.clangd = {
			cmd = {
				"/opt/homebrew/opt/llvm/bin/clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--query-driver=/opt/homebrew/bin/mpicc,/opt/homebrew/bin/mpic++",
			},
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
			root_markers = { ".clangd", ".clang-format", "compile_commands.json", ".git" },
		}
		vim.lsp.config.matlab_ls = {
			cmd = {
				"node",
				"/Users/augustbernberg/Documents/Libraries/MATLAB-language-server/out/index.js",
				"--stdio"
			},
			filetypes = { "matlab" },
			root_dir = vim.fs.root(0, { ".git", "matlab.prj", "startup.m" }),
			settings = {
				matlab = {
					installPath = "/Applications/MATLAB_R2025a.app",
				}
			}
		}
		vim.diagnostic.config({
            -- update_in_insert = true,
            virtual_text = true,
            float = {
                focusable = false,
                style = "minimal",
                border = nil,
                source = true,
                header = "",
                prefix = "",
            },
        })
        vim.filetype.add({
            extension = {
                odin = "odin",
				cu = "cpp",
            },
        })
    end
}
