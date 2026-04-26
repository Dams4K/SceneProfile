@tool
extends Resource
class_name PropertyEntry

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_NONE) var target: Object = null :
	set(value):
		target = value
		_cache_property_info()
@export var property: StringName = "":
	set(value):
		property = value
		notify_property_list_changed()
@export_tool_button("Pick") var pick_property_button = _pick_property

@export_storage var _values: Dictionary[int, Variant] = {}

var _cached_property_info: Dictionary = {}



func get_value(quality: Presets.Quality) -> Variant:
	return _get(Presets.Quality.keys()[quality])


func _pick_property() -> void:
	assert(target != null, "Target object can't be null")
	SceneProfilePluginHelper.popup_property_selector(target, _on_property_selected, PackedInt32Array(), property)


func _on_property_selected(p_property_path: NodePath) -> void:
	if p_property_path.is_empty():
		return
	property = p_property_path.get_concatenated_subnames()
	_init_default_values()
	_cache_property_info()


func _init_default_values() -> void:
	if target == null or property.is_empty():
		return
	var current_value: Variant = target.get(property)
	for i in range(_values.size()):
		_values[i] = current_value


func _cache_property_info() -> void:
	if target == null or property.is_empty():
		return
	
	for prop in target.get_property_list():
		if prop["name"] == property:
			_cached_property_info = prop
	return


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	var property_info := _cached_property_info
	
	if property_info.is_empty():
		return properties
	
	for quality: String in Presets.Quality.keys():
		properties.append({
			name = quality,
			type = property_info.get("type", TYPE_NIL),
			hint = property_info.get("hint", PROPERTY_HINT_NONE),
			hint_string = property_info.get("hint_string", ""),
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		})
	
	return properties


func _get(p_property: StringName) -> Variant:
	var idx: int = Presets.Quality.get(p_property.to_upper(), -1)
	return _values.get(idx, null)


func _set(p_property: StringName, p_value: Variant) -> bool:
	var idx: int = Presets.Quality.get(p_property.to_upper(), -1)
	if idx == -1:
		return false
	_values[idx] = p_value
	SceneProfilePluginHelper.update_current_scene()
	return true


func _property_can_revert(p_property: StringName) -> bool:
	return Presets.Quality.get(p_property.to_upper(), -1) != -1


func _property_get_revert(p_property: StringName) -> Variant:
	if target == null or property.is_empty():
		return null
	return target.get(property)
