
-- Disable LSP logging
vim.lsp.set_log_level("OFF") 

-- ensures that ts highlighting is active for colorscheme
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local filetype = vim.bo[buf].filetype

		-- Skip if the filetype is 'nvimtree' or doesn't have a tree-sitter parser
		if filetype == "nvimtree" then
			return
		end

		-- Check if a tree-sitter parser is available for the filetype
		local has_parser, _ = pcall(vim.treesitter.language.get_lang, filetype)
		if has_parser then
			-- Use pcall to safely execute the command
			pcall(vim.cmd, "TSBufEnable highlight")
		end
	end,
})

-- new line doesnt create new comment line
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "o", "r" })
	end,
})

-- lsp applies to rmlui
vim.filetype.add({
	extension = {
		rcss = 'css',
		rml = 'html'
	}
})

-- turns off warnings
vim.diagnostic.config({
	virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR } -- Show only errors
	},
	signs = {
		severity = { min = vim.diagnostic.severity.WARN } -- Ignore hints and show only warnings/errors
	},          -- Keep signs visible
	underline = true,      -- Underline errors
	update_in_insert = false, -- Don't show messages while typing
})

-- reformats file
function FormatBuffer()
	local save_cursor = vim.fn.getpos('.')
	local save_view = vim.fn.winsaveview()

	vim.api.nvim_command('normal! ggVG')
	vim.api.nvim_command('normal! ==')

	vim.fn.setpos('.', save_cursor)
	vim.fn.winrestview(save_view)
end

-- creates new file
-- function NewFile()
-- 	local filename = vim.fn.input("Create File: ")
--
-- 	if filename == "" or filename == nil then return end
--
-- 	-- get current directory from netrw
-- 	local cwd = vim.b.netrw_curdir or vim.fn.getcwd()
-- 	local file_path = cwd .. "/" .. filename
--
-- 	local function toMacro(filename)
-- 		local name = filename:match("^.+/(.+)$") or filename
-- 		name = name:gsub("%.%w+$", "")
-- 		name = name:gsub("([a-z])([A-Z])", "%1_%2")
-- 		name = name:gsub("[^%w]", "_"):upper()
-- 		return name .. "_H"
-- 	end
--
-- 	local function classNameFromPath(path)
-- 		local base = path:match("^.+/(.+)$") or path
-- 		base = base:gsub("%.h$", ""):gsub("%.cpp$", "") 
-- 		return base:sub(1,1):upper() .. base:sub(2)
-- 	end
--
-- 	-- check for .h files
-- 	if filename:sub(-2) == ".h" then
-- 		-- for cpp dev
-- 		local cpp_filename = filename:gsub("%.h", ".cpp")
--
-- 		-- creates .cpp and .h file
-- 		local function createFile(path, filetype)
-- 			local file = io.open(path, "w")
-- 			if file then
-- 				if filetype == 0 then
-- 					file:write(
-- 						"#ifndef " .. toMacro(path) .. "\n" ..
-- 						"#define " .. toMacro(path) .. "\n" ..
-- 						"\n" ..
-- 						"class " .. classNameFromPath(path) .. " {\n" ..
-- 						"public:\n" ..
-- 						"\t" .. classNameFromPath(path) .. "();\n" ..
-- 						"\t~" .. classNameFromPath(path) .. "();\n" ..
-- 						"\n" ..
-- 						"private:\n" ..
-- 						"\n" ..
-- 						"};\n" ..
-- 						"\n" ..
-- 						"#endif\n"
-- 					)
-- 				else
-- 					file:write(
-- 						'#include "' .. filename .. '"\n\n' ..
-- 						classNameFromPath(path) .. "::" .. classNameFromPath(path) .. "() {\n" ..
-- 						"\n" ..
-- 						"}\n\n" ..
-- 						classNameFromPath(path) .. "::~" .. classNameFromPath(path) .. "() {\n" ..
-- 						"\n" ..
-- 						"}\n"
-- 					)
-- 				end
-- 				file:close()
-- 			end
-- 		end
--
-- 		createFile(file_path, 0)
-- 		createFile(cwd .. "/" .. cpp_filename, 1)
-- 	else
-- 		-- creates file if not .h file
-- 		local file = io.open(file_path, "w")
-- 		if file then
-- 			file:close()
-- 		end
-- 	end
-- 	vim.cmd("edit " .. vim.fn.fnameescape(file_path))
-- end

vim.api.nvim_create_user_command('Cb', function()
	local outfile = 'build_error.txt'
	vim.fn.writefile({}, outfile) -- Clear the file

	local output = {}

	vim.fn.jobstart(
		'cmake --preset debug && cmake --build --preset debug && ./build/Gatality.app/Contents/MacOS/Gatality',
		{
			stdout_buffered = false,
			on_stdout = function(_, data, _)
				if type(data) == "table" then
					for _, line in ipairs(data) do
						if line and line ~= "" then
							table.insert(output, line)
							local percent = line:match("%[ *(%d+%%)%]")
							if percent then
								vim.api.nvim_echo({{ "Build Progress: " .. percent, "None" }}, false, {})
							end
						end
					end
				end
			end,
			on_stderr = function(_, data, _)
				if type(data) == "table" then
					for _, line in ipairs(data) do
						if line and line ~= "" then
							table.insert(output, line)
						end
					end
				end
			end,
			on_exit = function()
				vim.fn.writefile(output, outfile)

				-- Check if file is already open in a window
				local file_open = false
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local buf = vim.api.nvim_win_get_buf(win)
					if vim.api.nvim_buf_get_name(buf):find(outfile) then
						file_open = true
						vim.api.nvim_set_current_win(win)
						vim.cmd('edit') -- reload file
						break
					end
				end

				if not file_open then
					vim.cmd('vsplit ' .. outfile)
				end

				vim.api.nvim_echo({{ "Build finished.", "None" }}, false, {})
			end
		}
	)
end, {})

-- netrw file sorting
vim.g.netrw_sort_sequence = '[.]h$, [.]hpp$, [.]c$, [.]cpp$, *'
