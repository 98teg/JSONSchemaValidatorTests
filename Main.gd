extends Node

func _ready():
	var tests_modules = []

	tests_modules.append(JSONSchemaTheBasicsTests.new())
	tests_modules.append(JSONSchemaTypeSpecificsKeywordsTests.new())

	for tests_module in tests_modules:
		tests_module.check()
