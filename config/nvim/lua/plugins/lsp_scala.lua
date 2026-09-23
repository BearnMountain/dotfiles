return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },

    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },

    config = function()
        local metals = require("metals")

        local metals_config = metals.bare_config()

        metals_config.settings = {
            showImplicitArguments = true,
            showInferredType = true,
            showImplicitConversionsAndClasses = true,

            excludedPackages = {
                "akka.actor.typed.javadsl",
            },
        }

        metals_config.on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end

        local group = vim.api.nvim_create_augroup(
            "nvim-metals",
            { clear = true }
        )

        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt", "java" },

            callback = function()
                metals.initialize_or_attach(metals_config)
            end,

            group = group,
        })
    end,
}
