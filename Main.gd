extends Node

func _ready():
	var tests_results = get_node("ResultsScroller/TestsResults")
	tests_results.create_item()
	tests_results.set_column_min_width(0, 57)
	tests_results.set_column_expand(0, false)
	
	var test_module

	test_module = JSONSchemaTheBasicsTests.new()
	test_module.check(tests_results)

	test_module = JSONSchemaTypeSpecificsKeywordsTests.new()
	test_module.check(tests_results)

	test_module = JSONSchemaStringTests.new()
	test_module.check(tests_results)
	
	test_module = JSONSchemaNumericTypesTests.new()
	test_module.check(tests_results)
