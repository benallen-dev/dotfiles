local M = {}

local function shquote(s)
	return "'" .. s:gsub("'", "'\\''") .. "'"
end

--- Build rofi picker as a shell command string.
--- Spawn async with hl.exec_cmd / hl.dsp.exec_cmd — running it via
--- io.popen/os.execute inside a bind callback freezes the compositor.
--- @param prompt string rofi prompt
--- @param entries { label: string, cmd: string }[] label = menu entry, cmd = raw shell snippet run on selection
--- @return string shell command
function M.buildCmd(prompt, entries)
	local labels = {}
	for _, entry in ipairs(entries) do
		labels[#labels + 1] = shquote(entry.label)
	end

	local cmd = {
		"sel=$(printf '%s\\n' " .. table.concat(labels, " ") .. " | rofi -dmenu -p " .. shquote(prompt) .. ") || exit 0",
		'case "$sel" in',
	}
	for _, entry in ipairs(entries) do
		cmd[#cmd + 1] = string.format("\t%s) %s ;;", shquote(entry.label), entry.cmd)
	end
	cmd[#cmd + 1] = "\t*) exit 0 ;;" -- ignore typed input matching nothing
	cmd[#cmd + 1] = "esac"

	return table.concat(cmd, "\n")
end

return M
