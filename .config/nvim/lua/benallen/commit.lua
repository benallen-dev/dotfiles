vim.api.nvim_create_user_command('CommitMessage', function(opts)
	local git_diff = vim.fn.system('git diff --staged')

	local prompt = string.format(
		"Analyze the following staged git diff and generate a single-line conventional commit message.\n\nStaged changes: %s\n\nRules:\n- Output ONLY the commit message, nothing else\n- Format: <type>: <description>\n- Type must be one of: feat, fix, refactor, docs, test, chore, style, perf, ci, build\n- Description should be concise (under 50 characters)\n- Start description with lowercase letter\n- No period at the end\n- No extra text, explanations, or formatting\n- If multiple types apply, prioritize: feat > fix > refactor > others\n\nGenerate the message now:",
		git_diff
	)

	local message = vim.fn.system({'opencode', 'run', '--model', 'github-copilot/claude-haiku-4.5', prompt})


	message = vim.fn.split(message, "\n")[4] -- lua is 1-indexed
	message = vim.fn.trim(message)

	if vim.v.shell_error == 0 and message ~= '' then
		vim.api.nvim_buf_set_lines(0, 0, 0, false, {message})
	else
		print('Error generating commit message')
	end
end, { nargs = 0 })

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "gitcommit",
--   callback = function()
--     vim.cmd("CommitMessage")
--   end,
-- })
