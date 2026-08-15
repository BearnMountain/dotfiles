vim.g.mapleader = " "
vim.keymap.set("n", "<leader>lv", vim.cmd.Ex)

-- deletion
vim.keymap.set("n", "dd", "_dd", { noremap=true })
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d",        { desc = "deletes without saving to register"})
-- indentation
vim.keymap.set("v", "<", "<gv",                        { desc = "right shifts line" })
vim.keymap.set("v", ">", ">gv",                        { desc = "left shifts line" })
vim.keymap.set("n", "<leader>=", FormatBuffer,         { desc = "retab entire file" })

-- window managment
vim.keymap.set("n", "<leader>sv", "<C-w>v",            { desc = "split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s",            { desc = "split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=",            { desc = "make split window equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>",    { desc = "closes current split window" })

-- vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>",   { desc = "new tab" })
-- vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close tab" })
-- vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>",     { desc = "next tab" })
-- vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>",     { desc = "prev tab" })
-- vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "opens current buffer in new tab" })

-- preferences
-- vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" }) -- bad habbit
vim.keymap.set({"n", "v"}, "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: rename" })
vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: code actions" })
vim.keymap.set({"n", "v"}, "<leader>gd", vim.lsp.buf.definition, { desc = "LSP: go to definition" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Floating diagnostic messages" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			vim.cmd("cc")
			vim.cmd("cclose")
		end, { buffer = true, silent = true })
	end,
})
vim.keymap.set({"n", "v"}, "<leader>cf", function()
	local current_path = vim.api.nvim_buf_get_name(0)
	if current_path == "" then 
		return
	end
	if string.sub(current_path, -2) == '.c' then
		vim.cmd('edit ' .. current_path:sub(1, -2) .. 'h')
	end
	if string.sub(current_path, -4) == '.cpp' then
		vim.cmd('edit ' .. current_path:sub(1, -4) .. 'h')
	end

	-- checks if there exists c or cpp file to switch to
	if string.sub(current_path, -2) == '.h' then
		local base = current_path:gsub("%.h$", "")

		local function file_exists(path)
			local stat = vim.loop.fs_stat(path)
			return stat ~= nil
		end


		if string.sub(current_path, -2) == ".h" then
			local c_file = base .. ".c"
			local cpp_file = base .. ".cpp"

			if file_exists(c_file) then
				vim.cmd("edit " .. c_file)
			elseif file_exists(cpp_file) then
				vim.cmd("edit " .. cpp_file)
			end
		end

	end
end, { desc = "Switch source and header" })
vim.keymap.set({"n", "v"}, "<leader>q", "<cmd>noh<CR>", { desc = "turn highlighting off" })

-- formatting 
vim.keymap.set("n", "<leader>gf", function()
  vim.opt_local.textwidth = 80
  vim.cmd("normal! gggqG``")
end, { desc = "Format buffer to 80 chars" })

-- netrw remappings(native file tree)
vim.api.nvim_create_autocmd('filetype', {
	pattern = 'netrw',
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set('n', lhs, rhs, {remap = true, buffer = true})
		end

		-- bind('a', NewFile) -- add file
		bind('a', '%') -- add file
		bind('r', 'R') -- rename file
	end

})
