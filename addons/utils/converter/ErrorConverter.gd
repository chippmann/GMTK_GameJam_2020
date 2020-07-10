extends Reference
class_name ErrorConverter

static func toString(error: int) -> String:
	if error == OK:
		return "\"OK\""
	elif error == FAILED:
		return "\"Failed\""
	elif error == ERR_UNAVAILABLE:
		return "\"Unavailable\""
	elif error == ERR_UNCONFIGURED:
		return "\"Unconfigured\""
	elif error == ERR_UNAUTHORIZED:
		return "\"Unauthorized\""
	elif error == ERR_PARAMETER_RANGE_ERROR:
		return "\"Parameter Range Error\""
	elif error == ERR_OUT_OF_MEMORY:
		return "\"Out of memory\""
	elif error == ERR_FILE_NOT_FOUND:
		return "\"File not found\""
	elif error == ERR_FILE_BAD_DRIVE:
		return "\"Bad drive\""
	elif error == ERR_FILE_BAD_PATH:
		return "\"Bad path\""
	elif error == ERR_FILE_NO_PERMISSION:
		return "\"No permission on file\""
	elif error == ERR_FILE_ALREADY_IN_USE:
		return "\"File already in use\""
	elif error == ERR_FILE_CANT_OPEN:
		return "\"Can't open file\""
	elif error == ERR_FILE_CANT_WRITE:
		return "\"Can't write to file\""
	elif error == ERR_FILE_CANT_READ:
		return "\"Can't read from file\""
	elif error == ERR_FILE_UNRECOGNIZED:
		return "\"Unrecognized file\""
	elif error == ERR_FILE_CORRUPT:
		return "\"File corrupt\""
	elif error == ERR_FILE_MISSING_DEPENDENCIES:
		return "\"File missing dependency\""
	elif error == ERR_FILE_EOF:
		return "\"End of file\""
	elif error == ERR_CANT_OPEN:
		return "\"Can't open\""
	elif error == ERR_CANT_CREATE:
		return "\"Can't create\""
	elif error == ERR_QUERY_FAILED:
		return "\"Query failed\""
	elif error == ERR_ALREADY_IN_USE:
		return "\"Already in use\""
	elif error == ERR_LOCKED:
		return "\"Locked\""
	elif error == ERR_TIMEOUT:
		return "\"Timeout\""
	elif error == ERR_CANT_CONNECT:
		return "\"Can't connect\""
	elif error == ERR_CANT_RESOLVE:
		return "\"Can't resolve\""
	elif error == ERR_CONNECTION_ERROR:
		return "\"Connection Error\""
	elif error == ERR_CANT_ACQUIRE_RESOURCE:
		return "\"Can't aquire resource\""
	elif error == ERR_CANT_FORK:
		return "\"Can't fork\""
	elif error == ERR_INVALID_DATA:
		return "\"Invalid data\""
	elif error == ERR_INVALID_PARAMETER:
		return "\"Invalid parameter\""
	elif error == ERR_ALREADY_EXISTS:
		return "\"Already exists\""
	elif error == ERR_DOES_NOT_EXIST:
		return "\"Does not exist\""
	elif error == ERR_DATABASE_CANT_READ:
		return "\"Can't read from database\""
	elif error == ERR_DATABASE_CANT_WRITE:
		return "\"Can't write to database\""
	elif error == ERR_COMPILATION_FAILED:
		return "\"Compilation failed\""
	elif error == ERR_METHOD_NOT_FOUND:
		return "\"Method not found\""
	elif error == ERR_LINK_FAILED:
		return "\"Link failed\""
	elif error == ERR_SCRIPT_FAILED:
		return "\"Script failed\""
	elif error == ERR_CYCLIC_LINK:
		return "\"Cyclic link\""
	elif error == ERR_INVALID_DECLARATION:
		return "\"Invalid declaration\""
	elif error == ERR_DUPLICATE_SYMBOL:
		return "\"Duplicate Symbol\""
	elif error == ERR_PARSE_ERROR:
		return "\"Parse error\""
	elif error == ERR_BUSY:
		return "\"Busy\""
	elif error == ERR_SKIP:
		return "\"Skip\""
	elif error == ERR_HELP:
		return "\"Help\""
	elif error == ERR_BUG:
		return "\"Bug\""
	return "Unknown error"
