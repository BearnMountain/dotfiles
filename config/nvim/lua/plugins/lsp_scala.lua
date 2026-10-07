return {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt", "java" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "saghen/blink.cmp",
        "mfussenegger/nvim-dap",
    },
    opts = function()
        local metals_config = require("metals").bare_config()

        metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()
        metals_config.init_options.statusBarProvider = "on"
        metals_config.root_patterns = { "build.sbt", "build.sc", "build.gradle", "pom.xml", ".git" }

        metals_config.settings = {
            verboseCompilation = false,
            showImplicitArguments = true,
            showImplicitConversionsAndClasses = true,
            showInferredType = true,
            superMethodLensesEnabled = true,
            defaultBspToBuildTool = true,
            excludedPackages = {
                "akka.actor.typed.javadsl",
                "org.apache.pekko.actor.typed.javadsl",
                "com.github.swagger.akka.javadsl",
            },
        }

        metals_config.on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            require("metals").setup_dap()
        end

        return metals_config
    end,
    config = function(self, metals_config)
        local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            pattern = self.ft,
            callback = function()
                require("metals").initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
        })
    end,
}
