@tool
extends EntriesItem
class_name NodeItem

@export var node_path: NodePath : set = set_node_path


func get_target() -> Object:
	if interpretor == null:
		return null
	return interpretor.get_node_or_null(node_path)


func apply(quality: Presets.Quality) -> void:
	target = get_target()
	if target == null:
		push_warning("NodeItem: target is null for node_path: %s" % node_path)
		return
	super.apply(quality)


func set_node_path(value) -> void:
	node_path = value
	target = get_target()


func _sync_targets() -> void:
	if interpretor == null: return
	
	target = get_target()
	super._sync_targets()
