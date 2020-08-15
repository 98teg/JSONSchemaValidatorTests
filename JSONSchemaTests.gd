class_name JSONSchemaTests

var tests : Array = []

func check():
	var validator = JSONSchema.new()

	for test in tests:
		print(test.check(validator))
