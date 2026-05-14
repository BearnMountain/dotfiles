return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next, -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- mapping 
        local builtin = require('telescope.builtin')
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd"})
        vim.keymap.set("n", "<leader>fb", function()
            builtin.buffers({ sort_mru = true, ignore_current_buffer = true})
        end, { desc = "Fuzzy change buffer"})
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files"})
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd"})
        vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in ..."})
    end,
}
