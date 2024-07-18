local function capture_command_output(cmd)
	local handle = io.popen(cmd)
	if handle then
		local result = handle:read("*a")
		handle:close()
		return string.gsub(result, "%s+", "")
	else
		print("Failed to read OPENAI key")
		return nil
	end
end

local openai_api_key = capture_command_output(os.getenv("HOME") .. "/.config/echo-openai-key.sh 2> /dev/null")

return {
	"robitx/gp.nvim",
	enabled = openai_api_key ~= "",
	opts = function()
		return {
			openai_api_key = openai_api_key,
			agents = {
				{
					name = "ChatGPT4",
					chat = true,
					command = true,
					model = "gpt-4o",
					system_prompt = "You are a general AI assistant.\n\n"
						.. "The user provided the additional info about how they would like you to respond:\n\n"
						.. "- If you're unsure don't guess and say you don't know instead.\n"
						.. "- Ask question if you need clarification to provide better answer.\n"
						.. "- Think deeply and carefully from first principles step by step.\n"
						.. "- If the answer does not need to be lengthy, keep it short.\n"
						.. "- Don't elide any code from your output if the answer requires coding.\n"
						.. "- Take a deep breath; You've got this!\n",
				},
			},
		}
	end,
	config = function(_, opts)
		local gp = require("gp")
		gp.setup(opts)
		gp._state.chat_agent = "ChatGPT4"
	end,
}
