return {
    'saghen/blink.cmp',
    version = "*",
    -- build = "cargo build --release",
    opts = {
        snippets = { preset = 'luasnip', },
        completion = {
            keyword = {
                range = 'prefix',
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = false,
                },
            },
            menu = {
                border = "",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind" , "source_name", gap = 1} },
                },
            },
            documentation = {
                auto_show = true,
            },
            ghost_text = {
                enabled = true,
            },
        },
        signature = {
            enabled = false,
        },
        fuzzy = {
            prebuilt_binaries = {
                download = true,
            },
        },
        keymap = {
			-- set to 'none' to disable the 'default' preset
			preset = 'default',
			['<C-j>'] = { 'select_next', 'fallback' },
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<Tab>'] = { 'accept', 'fallback' },
        },
        sources = {
            default = { 'lsp', 'path', 'buffer', 'snippets' },
            providers = {
                buffer = {
                    name = 'Buffer',
                    module = 'blink.cmp.sources.buffer',
                    opts = {
                        -- all buffers of same filetype
                        get_bufnrs = function()
                            return vim
                                .iter(vim.api.nvim_list_bufs())
                                :filter(
                                    function (buf)
                                        return vim.bo[buf].buftype ~= 'nofile'
                                            and vim.bo[buf].filetype == vim.bo.filetype
                                    end)
                                :totable()
                        end,
                    }
                },
            }
        },
    },
}
