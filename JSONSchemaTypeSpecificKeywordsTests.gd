class_name JSONSchemaTypeSpecificsKeywordsTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "An integer is a number"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({"type": "number"})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A real is a number"
	test.json_data = JSON.print(42.0)
	test.schema = JSON.print({"type": "number"})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is not a number"
	test.json_data = JSON.print("42")
	test.schema = JSON.print({"type": "number"})
	test.expected_error = "Type mismatch: expected [number] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A number is a number or a string"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({"type": ["number", "string"]})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is a number or a string"
	test.json_data = JSON.print("Life, the universe, and everything")
	test.schema = JSON.print({"type": ["number", "string"]})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An array is not a number or a string"
	test.json_data = JSON.print(["Life", "the universe", "and everything"])
	test.schema = JSON.print({"type": ["number", "string"]})
	test.expected_error = "Type mismatch: expected [number, string] for 'schema root'"

	tests.append(test)
