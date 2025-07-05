--!strict
local Config: any = require(script.Parent.Config)
local Msg: any = require(script.Parent.Messages)
local Trace: any = require(script.Parent.Trace)
	
local Logger = {}

local FB_LOGS: any = {
	INVALID_LEVEL = '[SP-FB-WARN] [%s] Invalid level "%s"',
	INVALID_CODE = '[SP-FB-WARN] [%s] Invalid code "%s"',
	INCORRECT_ARGS_N = '[SP-FB-WARN] [%s] Incorrect number of args (%s expected, got %s)',
}


function Logger.get(level: string, code: string, args: any | {any}?, debugLevel: number?): string
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
	

	-- debugInfo
	local function debugFormat(_debugLevel)
		local source = debug.info(_debugLevel :: number, 's')
		local line = debug.info(_debugLevel :: number, 'l')
		--local funcName = debug.info(level :: number, 'n')

		return string.format('[%s:%i:]', source, line)
	end

	local debugInfo = ''
	if Config.debugInfo then
		if debugLevel then
			debugInfo = debugFormat(debugLevel)
		elseif Config.debugInfo then
			debugInfo = debugFormat(Config.debugLevel)
		end
	end

	local function addTrace(finalMsg)
		if Config.saveLogInTrace then
			Trace.trace(finalMsg)
		end
	end

	if args then
		if type(args) ~= 'table' then
			args = {args}
		end

		local _, expectedArgsN = string.gsub(msgTemplate, '%%[^%%]', "")
		if #args ~= expectedArgsN then
			error(string.format(FB_LOGS.INCORRECT_ARGS_N, 'get', expectedArgsN, #args))
		end
		
		local finalMsg = string.format('%s %s %s', debugInfo, Config.tag[level], string.format(msgTemplate, table.unpack(args)))

		addTrace(finalMsg)
		return finalMsg
	else
		local finalMsg = string.format('%s %s %s', debugInfo, Config.tag[level], msgTemplate)
		
		addTrace(finalMsg)
		return finalMsg
	end
end

return Logger
