class_name ArrayUtils extends RefCounted

static func array_join(arrays: Array, join := "+") -> String:
	if arrays.is_empty():
		return ""
	
	if arrays.size() == 1:
		return str(arrays[0])
	
	var result := ""
	for i in arrays.size():
		result += str(arrays[i])
		if i < arrays.size() - 1:
			result += join

	return result
