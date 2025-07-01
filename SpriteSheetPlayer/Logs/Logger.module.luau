--!strict
local Config: any = require(script.Parent.Config)
local Msg: any = require(script.Parent.Messages)
local Logger = {}

local FB_LOGS: any = {
	INVALID_LEVEL = '[SP-FB-WARN] [%s] Invalid level "%s"',
	INVALID_CODE = '[SP-FB-WARN] [%s] Invalid code "%s"',
	INCORRECT_ARGS_N = '[SP-FB-WARN] [%s] Incorrect number of args (%s expected, got %s)',
}


function Logger.get(level: string, code: string, args: {any}?): string
	level = string.upper(level)
	
	local levelT: {[string]: string} = Msg[level]
	
	if not levelT then
		error(string.format(FB_LOGS.INVALID_LEVEL, 'get', level))
		-- return	
	end
	
	local msgTemplate: any = levelT[code]

	if not levelT[code] then
		error(string.format(FB_LOGS.INVALID_CODE, 'get', code))
		-- return
	end

	if args then
		local _, expectedArgsN = string.gsub(msgTemplate, '%%[^%%]', "")
		if #args ~= expectedArgsN then
			error(string.format(FB_LOGS.INCORRECT_ARGS_N, 'get', expectedArgsN, #args))
		end

		return string.format('%s %s', Config.tag[level], string.format(msgTemplate, table.unpack(args)))
	else
		return string.format('%s %s', Config.tag[level], msgTemplate)
	end
end

return Logger
