@tool
extends ProfileItem
class_name NodeItem

@export var node_path: NodePath
@export_tool_button("Pick property") var pick_property_button = pick_property
@export var property: StringName

func apply() -> void:
	pass

func pick_property() -> void:
	var target = SceneProfileInterpretor.instance.get_node_or_null(node_path)
	EditorInterface.popup_property_selector(target, _on_property_selected, PackedInt32Array(), property)

func _on_property_selected(p_property_path: NodePath) -> void:
	if p_property_path.is_empty():
		return
	property = p_property_path.get_concatenated_subnames()
	print(property)
