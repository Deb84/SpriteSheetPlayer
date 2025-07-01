--!strict
local Config: any = require(script.Parent.Config)
local Trace = {}

local FB_LOGS: any = {
	INVALID_MSG = '[SP-FB-WARN] [%s] Invalid message in trace',
	TRACE_TABLE_EMPTY = '[SP-FB-WARN] [%s] Trace table empty'
}


local traceLog: {string} = {}


-- Put a message in the trace table
function Trace.trace(msg: string)
	
	if not msg or type(msg) ~= 'string' then -- return if invalid message
		warn(string.format(FB_LOGS.INVALID_MSG, 'trace'))
		return
	end
	
	-- get the necessary infos
	local time: string = os.date("%H:%M:%S", os.time())
	local tag: string = Config.tag[Config.level.TRACE]
	local debugLevel: number = Config.traceDebugLevel
	local level = string.format('%s %s:', debug.info(debugLevel, 's'), debug.info(debugLevel, 'l'))
	
	-- format and insert
	local trace = string.format('%s %s %s %s', time, level, tag, msg)
	table.insert(traceLog, trace)
end

function Trace.printTrace()
	if not next(traceLog) then
		warn(string.format(FB_LOGS.TRACE_TABLE_EMPTY :: any, 'trace'))
		return
	end
	
	print('-- Start of trace --')
	for _, v in pairs(traceLog) do
		print(v)
	end
	print('-- End of trace --')
end

function Trace.clearTrace()
	if not next(traceLog) then return end
	table.clear(traceLog)
end

return Trace
