local Config = {
	level = {
		ERROR = 'ERROR',
		WARN = 'WARN',
		INFO = 'INFO',
		TRACE = 'TRACE'
	},
	tag = {
		ERROR = '[SP-ERROR]',
		WARN = '[SP-WARN]',
		INFO = '[SP-INFO]',
		TRACE = '[SP-TRACE]'
	},
	
	saveLogInTrace = true,

	traceDebugLevel = 3,
	debugLevel = 3,
	debugInfo = true
}

return Config
