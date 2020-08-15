class_name JSONSchemaTheBasicsTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "A number is always valid with {}"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is always valid with {}"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An arbitrarily nested data structure is always valid with {}"
	test.json_data = JSON.print({
		"an": [ "arbitrarily", "nested" ],
		"data": "structure"
	})
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A number is always valid with true"
	test.json_data = JSON.print(42)
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is always valid with true"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An arbitrarily nested data structure is always valid with true"
	test.json_data = JSON.print({
		"an": [ "arbitrarily", "nested" ],
		"data": "structure"
	})
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Nothing is valid with false"
	test.json_data = JSON.print("Resistance is futile...  This will always fail!!!")
	test.schema = JSON.print(false)
	test.expected_error = "Validation fails with message: Schema declared as deny all"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is a string"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A number is not a string"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({ "type": "string" })
	test.expected_error = "Type mismatch: expected [string] for 'schema root'"

	tests.append(test)

func check(results_tree : Tree) -> void:
	check_tests(results_tree, "The Basics")
