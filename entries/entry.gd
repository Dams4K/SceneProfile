@tool
@abstract
extends Resource
class_name Entry

@export_custom(PROPERTY_HINT_NONE, "", PROPERTY_USAGE_NONE) var target: Object = null : set = set_target

@export_storage var _values: Dictionary[int, Variant] = {}

func set_target(p_target) -> void:
	target = p_target


func get_value(quality: Presets.Quality) -> Variant:
	return _get(Presets.Quality.keys()[quality])

@abstract func is_valid() -> bool
@abstract func apply(quality: Presets.Quality) -> void
@abstract func _get_quality_property(quality: String) -> Dictionary

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	if not is_valid(): return properties
	
	for quality: String in Presets.Quality.keys():
		properties.append(_get_quality_property(quality))
	
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
