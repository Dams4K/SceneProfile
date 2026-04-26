@tool
extends Resource
class_name PropertyEntry

@export_storage var target: Object = null
@export var property: StringName = "":
	set(value):
		property = value
		notify_property_list_changed()
@export_tool_button("Pick") var pick_property_button = _pick_property

var _values: Array[Variant] = []

func _init() -> void:
	_values.resize(SceneProfileInterpretor.Presets.size())


func get_value(preset: SceneProfileInterpretor.Presets) -> Variant:
	return _get(SceneProfileInterpretor.Presets.keys()[preset])


func _pick_property() -> void:
	assert(target != null, "Target object can't be null")
	
	EditorInterface.popup_property_selector(target, _on_property_selected, PackedInt32Array(), property)


func _on_property_selected(p_property_path: NodePath) -> void:
	if p_property_path.is_empty():
		return
	property = p_property_path.get_concatenated_subnames()
	_init_default_values()


func _init_default_values() -> void:
	if target == null or property.is_empty():
		return
	var current_value: Variant = target.get(property)
	for i in range(_values.size()):
		_values[i] = current_value


func _get_property_type() -> Dictionary:
	if target == null or property.is_empty():
		return {}
	for prop in target.get_property_list():
		if prop["name"] == property:
			return prop
	return {}


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	var property_info := _get_property_type()
	if property_info.is_empty():
		return properties
	
	for preset: String in SceneProfileInterpretor.Presets.keys():
		properties.append({
			name = preset,
			type = property_info.get("type", TYPE_NIL),
			hint = property_info.get("hint", PROPERTY_HINT_NONE),
			hint_string = property_info.get("hint_string", ""),
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		})
	
	return properties


func _get(p_property: StringName) -> Variant:
	var idx: int = SceneProfileInterpretor.Presets.get(p_property.to_upper(), -1)
	if idx == -1:
		return null
	return _values[idx]


func _set(p_property: StringName, p_value: Variant) -> bool:
	var idx: int = SceneProfileInterpretor.Presets.get(p_property.to_upper(), -1)
	if idx == -1:
		return false
	_values[idx] = p_value
	return true


func _property_can_revert(p_property: StringName) -> bool:
	return SceneProfileInterpretor.Presets.get(p_property.to_upper(), -1) != -1


func _property_get_revert(p_property: StringName) -> Variant:
	if target == null or property.is_empty():
		return null
	return target.get(property)
