extends Reference
class_name Serializer


static func serialize(obj) -> Dictionary:
	var type: int = typeof(obj)
	
	match type:
		TYPE_BOOL, TYPE_INT, TYPE_REAL, TYPE_STRING, TYPE_VECTOR2, TYPE_RECT2, TYPE_VECTOR3, TYPE_TRANSFORM2D, TYPE_PLANE, TYPE_QUAT, TYPE_AABB, TYPE_BASIS, TYPE_TRANSFORM, TYPE_COLOR, TYPE_NODE_PATH, TYPE_RID:
			return {
				"type": type,
				"value": var2str(obj)
			}
		TYPE_OBJECT:
			var serialized: Dictionary = {}
			
			for property in obj.get_property_list():
				var subtype: int = property["type"]
				var name: String = property["name"]
				
				if subtype != TYPE_NIL:
					if subtype == TYPE_OBJECT && name == "script":
						continue
					
					serialized[name] = _serializeProperty(obj.get(name))
			
			serialized["script"] = obj.get_script().get("resource_path")
			
			return {
				"type": type,
				"value": serialized
			}
		TYPE_DICTIONARY:
			var dictContentDict: Dictionary =  {}
			for key in obj.keys():
				dictContentDict[key] = serialize(obj[key])
			return {
				"type": type,
				"value": dictContentDict
			}
		TYPE_ARRAY, TYPE_RAW_ARRAY, TYPE_INT_ARRAY, TYPE_REAL_ARRAY, TYPE_STRING_ARRAY, TYPE_VECTOR2_ARRAY, TYPE_VECTOR3_ARRAY, TYPE_COLOR_ARRAY:
			var array: Array = []
			for item in obj:
				var itemType: int = typeof(item)
				array.append({
					"type": itemType,
					"value": serialize(item)
				})
			return {
				"type": type,
				"value": var2str(array)
			}
		_:
			Logger.error("Could not serialize property: %s" % obj)
			return {}


static func deserialize(dictionary: Dictionary):
	var type: int = dictionary["type"]
	var value = dictionary["value"]
	
	match type:
		TYPE_BOOL, TYPE_INT, TYPE_REAL, TYPE_STRING, TYPE_VECTOR2, TYPE_RECT2, TYPE_VECTOR3, TYPE_TRANSFORM2D, TYPE_PLANE, TYPE_QUAT, TYPE_AABB, TYPE_BASIS, TYPE_TRANSFORM, TYPE_COLOR, TYPE_NODE_PATH, TYPE_RID:
			return str2var(value)
		TYPE_OBJECT:
			var instance: Object = (load(value["script"]) as GDScript).new()
		
			if !instance:
				return null
		
			for key in value.keys():
				if key != "script":
					var propertyName: String = key
					var propertyType: int = value[key]["type"]
					var propertyValue = _deserializeProperty(value[key])
		
					if !typeof(propertyValue) == propertyType:
						Logger.error("Could not deserialize property %s with type %s as actual type of deserialized value seems to be %s" % [propertyName, propertyType, typeof(propertyValue)])
						continue
					instance.set(propertyName, propertyValue)
		
			return instance
		TYPE_DICTIONARY:
			var dict: Dictionary = {}
			
			for key in value.keys():
				dict[key] = deserialize(value[key])
			
			return dict
		TYPE_ARRAY:
			var array: Array = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_RAW_ARRAY:
			var array: PoolByteArray = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_INT_ARRAY:
			var array: PoolIntArray = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_REAL_ARRAY:
			var array: PoolRealArray = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_STRING_ARRAY:
			var array: PoolStringArray = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_VECTOR2_ARRAY:
			var array: PoolVector2Array = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_VECTOR3_ARRAY:
			var array: PoolVector3Array = []
			for item in value:
				array.append(deserialize(item))
			return array
		TYPE_COLOR_ARRAY:
			var array: PoolColorArray = []
			for item in value:
				array.append(deserialize(item))
			return array
		_:
			Logger.error("Could not deserialize property: %s" % value)
			return null


static func _serializeProperty(property) -> Dictionary:
	var type: int = typeof(property)
	match type:
		TYPE_BOOL, TYPE_INT, TYPE_REAL, TYPE_STRING, TYPE_VECTOR2, TYPE_RECT2, TYPE_VECTOR3, TYPE_TRANSFORM2D, TYPE_PLANE, TYPE_QUAT, TYPE_AABB, TYPE_BASIS, TYPE_TRANSFORM, TYPE_COLOR, TYPE_NODE_PATH, TYPE_RID, TYPE_DICTIONARY:
			return {
				"type": type,
				"value": var2str(property)
			}
		TYPE_OBJECT:
			return serialize(property)
		TYPE_ARRAY, TYPE_RAW_ARRAY, TYPE_INT_ARRAY, TYPE_REAL_ARRAY, TYPE_STRING_ARRAY, TYPE_VECTOR2_ARRAY, TYPE_VECTOR3_ARRAY, TYPE_COLOR_ARRAY:
			var array: Array = []
			for item in property:
				array.append(serialize(item))
			return {
				"type": type,
				"value": var2str(array)
			}
		_:
			Logger.error("Could not serialize property: %s" % property)
			return {}


static func _deserializeProperty(propertyDict: Dictionary):
	var propertyType: int = propertyDict["type"]
	var propertyValue = propertyDict["value"]
	
	match propertyType:
		TYPE_BOOL, TYPE_INT, TYPE_REAL, TYPE_STRING, TYPE_VECTOR2, TYPE_RECT2, TYPE_VECTOR3, TYPE_TRANSFORM2D, TYPE_PLANE, TYPE_QUAT, TYPE_AABB, TYPE_BASIS, TYPE_TRANSFORM, TYPE_COLOR, TYPE_NODE_PATH, TYPE_RID, TYPE_DICTIONARY:
			return str2var(propertyValue)
		TYPE_OBJECT:
			return deserialize(propertyValue)
		TYPE_ARRAY:
			var array: Array = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_RAW_ARRAY:
			var array: PoolByteArray = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_INT_ARRAY:
			var array: PoolIntArray = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_REAL_ARRAY:
			var array: PoolRealArray = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_STRING_ARRAY:
			var array: PoolStringArray = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_VECTOR2_ARRAY:
			var array: PoolVector2Array = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_VECTOR3_ARRAY:
			var array: PoolVector3Array = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		TYPE_COLOR_ARRAY:
			var array: PoolColorArray = []
			for item in str2var(propertyValue):
				array.append(deserialize(item))
			return array
		_:
			Logger.error("Could not deserialize property: %s" % propertyValue)
			return null

