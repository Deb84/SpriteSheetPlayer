local Logger = require(script.Parent.Logger)
local Trace = require(script.Parent.Trace)

local Init = {}

Init.get = Logger.get


Init.Trace = Trace.trace
Init.printTrace = Trace.printTrace
Init.clearTrace = Trace.clearTrace

return Init
