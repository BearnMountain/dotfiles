return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        -- VimTeX configuration goes here, e.g. 
        vim.g.vimtex_view_method = "skim"

		vim.g.vimtex_compiler_latexmk = {
            options = {
                "-silent", -- Suppresses most warnings (including underfull/overfull \hbox)
                "-file-line-error", -- Ensures errors are still shown
                "-interaction=nonstopmode", -- Prevents LaTeX from stopping for warnings
                "-halt-on-error", -- Stops compilation on errors
            },
        }
    end
}
