class_name JSONSchemaTests

var tests : Array = []

func check_tests(results_tree : Tree, test_module_name : String = "") -> void:
	var results_root = results_tree.create_item(results_tree.get_root())
	results_root.set_collapsed(true)
	results_root.set_text_align(0, TreeItem.ALIGN_RIGHT)

	var correct_tests = 0
	var validator = JSONSchema.new()
	for test in tests:
		var results_child = results_tree.create_item(results_root)
		results_child.set_text(1, test.name)
		results_child.set_text_align(0, TreeItem.ALIGN_RIGHT)

		if test.check(validator):
			correct_tests += 1
			results_child.set_text(0, "[OK]")
			results_child.set_custom_color(0, Color.green)
		else:
			results_child.set_text(0, "[ERR]")
			results_child.set_custom_color(0, Color.red)

	results_root.set_text(0, "[%d/%d]" % [correct_tests, tests.size()])
	results_root.set_text(1, "%s" % test_module_name)

	if correct_tests == tests.size():
		results_root.set_custom_color(0, Color.green)
	else:
		results_root.set_custom_color(0, Color.red)
