local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")

local M = {}

-- Function to get files using ripgrep with glob patterns
local function get_files_with_rg(pattern, opts)
	opts = opts or {}
	local cmd = { "rg", "--files" }
	
	if pattern and pattern ~= "" and pattern ~= "*" then
		-- Add glob pattern to ripgrep command
		table.insert(cmd, "--glob")
		table.insert(cmd, pattern)
	end
	
	-- Add additional ripgrep options
	table.insert(cmd, "--hidden")
	table.insert(cmd, "--no-ignore-vcs")
	table.insert(cmd, "--glob")
	table.insert(cmd, "!node_modules")
	table.insert(cmd, ".")
	
	local results = vim.fn.systemlist(cmd)
	
	if vim.v.shell_error ~= 0 then
		print("Error running ripgrep: " .. table.concat(cmd, " "))
		return {}
	end
	
	-- Filter out empty results
	local files = {}
	for _, file in ipairs(results) do
		if file and file ~= "" then
			table.insert(files, file)
		end
	end
	
	return files
end

-- Custom action to open all selected files in buffers
local function open_selected_files(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local multi_selection = picker:get_multi_selection()
	
	actions.close(prompt_bufnr)
	
	local files_to_open = {}
	
	-- Get files to open
	if #multi_selection > 0 then
		for _, entry in ipairs(multi_selection) do
			table.insert(files_to_open, entry.value)
		end
	else
		local selection = action_state.get_selected_entry()
		if selection then
			table.insert(files_to_open, selection.value)
		end
	end
	
	-- Open files
	for i, file in ipairs(files_to_open) do
		if i == 1 then
			-- Open first file in current window
			vim.cmd("edit " .. vim.fn.fnameescape(file))
		else
			-- Load other files as buffers
			vim.cmd("badd " .. vim.fn.fnameescape(file))
		end
	end
	
	if #files_to_open > 1 then
		print(string.format("Opened %d files. Use :buffers to see all.", #files_to_open))
	end
end

-- Function to refresh the picker with a new glob pattern
local function refresh_with_pattern(prompt_bufnr)
	local current_input = action_state.get_current_line()
	local picker = action_state.get_current_picker(prompt_bufnr)
	
	if not current_input or current_input == "" then
		current_input = "*"
	end
	
	print("Searching with pattern: " .. current_input)
	
	local files = get_files_with_rg(current_input)
	print("Found " .. #files .. " files")
	
	local new_finder = finders.new_table({
		results = files,
		entry_maker = function(entry)
			return {
				value = entry,
				display = entry,
				ordinal = entry,
			}
		end,
	})
	
	picker:refresh(new_finder, { reset_prompt = false })
end

-- Main glob file picker function
function M.glob_file_picker(opts)
	opts = opts or {}
	
	-- Start with all files
	local initial_files = get_files_with_rg("*", opts)
	
	pickers.new(opts, {
		prompt_title = "Find Files by Glob Pattern (Press <C-r> to search)",
		finder = finders.new_table({
			results = initial_files,
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry,
					ordinal = entry,
				}
			end,
		}),
		sorter = require("telescope.sorters").empty(),
		previewer = conf.file_previewer(opts),
		attach_mappings = function(prompt_bufnr, map)
			-- Replace default action with our multi-file opener
			actions.select_default:replace(function()
				open_selected_files(prompt_bufnr)
			end)
			
			-- Multi-selection mappings
			map("i", "<C-q>", actions.toggle_selection + actions.move_selection_worse)
			map("n", "<C-q>", actions.toggle_selection + actions.move_selection_worse)
			map("i", "<M-a>", actions.select_all)
			map("n", "<M-a>", actions.select_all)
			
			-- Open all currently visible/filtered files in buffers
			map("i", "<C-a>", function()
				-- Simply select all visible items and then open them
				actions.select_all(prompt_bufnr)
				open_selected_files(prompt_bufnr)
			end)
			
			map("n", "<C-a>", function()
				-- Simply select all visible items and then open them
				actions.select_all(prompt_bufnr)
				open_selected_files(prompt_bufnr)
			end)
			
			-- Refresh with current input as glob pattern
			map("i", "<C-r>", function()
				refresh_with_pattern(prompt_bufnr)
			end)
			
			map("n", "<C-r>", function()
				refresh_with_pattern(prompt_bufnr)
			end)
			
			return true
		end,
	}):find()
end


-- Test function
function M.test_glob(pattern)
	pattern = pattern or "*.lua"
	local files = get_files_with_rg(pattern)
	print("Pattern: " .. pattern)
	print("Found " .. #files .. " files:")
	for i, file in ipairs(files) do
		print("  " .. file)
		if i >= 10 then
			print("  ... and " .. (#files - 10) .. " more")
			break
		end
	end
end

return M