class_name JSONSchemaTheBasicsTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "42 with an empty object"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "I'm a string with an empty object"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An arbitrarily nested data structure with an empty object"
	test.json_data = JSON.print({
		"an": [ "arbitrarily", "nested" ],
		"data": "structure"
	})
	test.schema = JSON.print({})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "42 with true as the schema"
	test.json_data = JSON.print(42)
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "I'm a string with true as the schema"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An arbitrarily nested data structure with true as the schema"
	test.json_data = JSON.print({
		"an": [ "arbitrarily", "nested" ],
		"data": "structure"
	})
	test.schema = JSON.print(true)

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Anything with false as the schema"
	test.json_data = JSON.print("Resistance is futile...  This will always fail!!!")
	test.schema = JSON.print(false)
	test.expected_error = "Validation fails with message: Schema declared as deny all"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The type keyword, correct test"
	test.json_data = JSON.print("I'm a string")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The type keyword, incorrect test"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({ "type": "string" })
	test.expected_error = "Type mismatch: expected [string] for 'schema root'"

	tests.append(test)
