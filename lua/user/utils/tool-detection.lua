local M = {}

-- Check if ESLint configuration exists in the project
function M.eslint_config_exists()
	local current_dir = vim.fn.expand("%:p:h")

	-- Check for ESLint configs in current file's directory tree (for monorepos)
	local eslint_configs = {
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		"eslint.config.js",
		"eslint.config.mjs",
		"eslint.config.cjs",
	}

	-- Search upward from current file location
	for _, config in ipairs(eslint_configs) do
		local found = vim.fs.find(config, {
			path = current_dir,
			upward = true,
		})[1]
		if found then
			return true
		end
	end

	-- Check for ESLint config in package.json (search upward)
	local package_json = vim.fs.find("package.json", {
		path = current_dir,
		upward = true,
	})[1]

	if package_json then
		local package_content = vim.fn.readfile(package_json)
		local package_str = table.concat(package_content, "\n")
		if string.find(package_str, '"eslintConfig"') then
			return true
		end
	end

	return false
end

-- Check if Biome configuration exists
function M.biome_config_exists()
	local cwd = vim.fn.getcwd()

	-- Check in root directory
	if vim.fn.filereadable(cwd .. "/biome.json") == 1 then
		return true
	end

	-- Check in common frontend subdirectories
	local subdirs = {"frontend", "webapp"}
	for _, subdir in ipairs(subdirs) do
		if vim.fn.filereadable(cwd .. "/" .. subdir .. "/biome.json") == 1 then
			return true
		end
	end

	return false
end

-- Check if Prettier configuration exists
function M.prettier_config_exists()
	local configs = {
		".prettierrc",
		"prettier.config.js",
		".prettierrc.json",
		".prettierrc.js",
		".prettierrc.mjs",
		".prettierrc.cjs",
		".prettierrc.yaml",
		".prettierrc.yml",
		".prettierrc.toml",
	}

	for _, config in ipairs(configs) do
		local found = vim.fs.find(config, {
			path = vim.fn.expand("%:p:h"),
			upward = true,
		})[1]
		if found then
			return true
		end
	end

	-- Check for prettier config in package.json
	local cwd = vim.fn.getcwd()
	local package_json_path = cwd .. "/package.json"
	if vim.fn.filereadable(package_json_path) == 1 then
		local package_content = vim.fn.readfile(package_json_path)
		local package_str = table.concat(package_content, "\n")
		if string.find(package_str, '"prettier"') then
			return true
		end
	end

	return false
end

-- Get the appropriate linter for JavaScript/TypeScript files
function M.get_js_linter()
	if M.biome_config_exists() then
		return "biomejs"
	elseif M.eslint_config_exists() then
		return "eslint"
	end
	return nil
end

-- Get the appropriate formatters for JavaScript/TypeScript files
-- Returns an array of formatters to run in order
-- NOTE: ESLint auto-fix is now handled via LSP code actions, not formatters
function M.get_js_formatters()
	local formatters = {}

	-- Only add the main formatter (Prettier or Biome)
	-- ESLint auto-fix is handled separately via LSP code actions
	if M.prettier_config_exists() then
		table.insert(formatters, "prettier")
	elseif M.biome_config_exists() then
		table.insert(formatters, "biome")
	end

	return formatters
end

return M
