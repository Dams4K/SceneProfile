@tool
extends Entry
class_name MethodEntry

@export var method: String:
	set(value):
		method = value
		notify_property_list_changed()

@export_tool_button("Pick") var pick_method_button = _pick_method

func _pick_method() -> void:
	assert(target != null, "Target object can't be null")
	SceneProfilePluginHelper.popup_method_selector(target, _on_method_selected, method)

func _on_method_selected(p_method: String) -> void:
	if p_method.is_empty():
		return
	method = p_method


func is_valid() -> bool:
	return target != null and method != null and not method.is_empty()


func apply(quality: Presets.Quality) -> void:
	if not is_valid(): return
	
	var arguments: Arguments = get_value(quality)
	target.callv(method, arguments.arguments)


func _get_quality_property(quality: String) -> Dictionary:
	return {
		name = quality,
		type = TYPE_OBJECT,
		hint = PROPERTY_HINT_RESOURCE_TYPE,
		hint_string = "Arguments",
		usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
	}
