@tool
extends Entry
class_name PropertyEntry

@export var property: StringName = "":
	set(value):
		property = value
		notify_property_list_changed()
@export_tool_button("Pick") var pick_property_button = _pick_property

var _cached_property_info: Dictionary = {}


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


func set_target(p_target) -> void:
	super.set_target(p_target)
	_cache_property_info()


func _cache_property_info() -> void:
	if target == null or property.is_empty():
		return
	
	for prop in target.get_property_list():
		if prop["name"] == property:
			_cached_property_info = prop
	return


func is_valid() -> bool:
	return target != null and property != null and not property.is_empty()

func apply(quality: Presets.Quality) -> void:
	target.set(property, get_value(quality))


func _get_quality_property(quality: String) -> Dictionary:
	var property_info := _cached_property_info
	return {
		name = quality,
		type = property_info.get("type", TYPE_NIL),
		hint = property_info.get("hint", PROPERTY_HINT_NONE),
		hint_string = property_info.get("hint_string", ""),
		usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
	}


func _property_can_revert(p_property: StringName) -> bool:
	return Presets.Quality.get(p_property.to_upper(), -1) != -1


func _property_get_revert(p_property: StringName) -> Variant:
	if target == null or property.is_empty():
		return null
	return target.get(property)
