class_name JSONSchemaStringTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "A string is a string"
	test.json_data = JSON.print("This is a string")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string with unicode characters is a string"
	test.json_data = JSON.print("Déjà vu")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An empty string is a string"
	test.json_data = JSON.print("")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string with a number is a string"
	test.json_data = JSON.print("42")
	test.schema = JSON.print({ "type": "string" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A number is not a string"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({ "type": "string" })
	test.expected_error = "Type mismatch: expected [string] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"A\" is not at least 2 characters long"
	test.json_data = JSON.print("A")
	test.schema = JSON.print({
		"type": "string",
		"minLength": 2,
		"maxLength": 3
	})
	test.expected_error = "Validation fails with message: Length of 'schema root' (1) less than declared (2)"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"AB\" is at least 2 characters long and at most 3 characters long"
	test.json_data = JSON.print("AB")
	test.schema = JSON.print({
		"type": "string",
		"minLength": 2,
		"maxLength": 3
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"ABC\" is at least 2 characters long and at most 3 characters long"
	test.json_data = JSON.print("ABC")
	test.schema = JSON.print({
		"type": "string",
		"minLength": 2,
		"maxLength": 3
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"ABCD\" is not at most 3 characters long"
	test.json_data = JSON.print("ABCD")
	test.schema = JSON.print({
		"type": "string",
		"minLength": 2,
		"maxLength": 3
	})
	test.expected_error = "Validation fails with message: Length of 'schema root' (4) greater than declared (3)"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"555-1212\" does match the regular expression"
	test.json_data = JSON.print("555-1212")
	test.schema = JSON.print({
		"type": "string",
		"pattern": "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"(888)555-1212\" does match the regular expression"
	test.json_data = JSON.print("(888)555-1212")
	test.schema = JSON.print({
		"type": "string",
		"pattern": "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"(888)555-1212 ext. 532\" does not match the regular expression"
	test.json_data = JSON.print("(888)555-1212 ext. 532")
	test.schema = JSON.print({
		"type": "string",
		"pattern": "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
	})
	test.expected_error = "Validation fails with message: Content of 'schema root' does not match its corresponding pattern"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"(800)FLOWERS\" does not match the regular expression"
	test.json_data = JSON.print("(800)FLOWERS")
	test.schema = JSON.print({
		"type": "string",
		"pattern": "^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$"
	})
	test.expected_error = "Validation fails with message: Content of 'schema root' does not match its corresponding pattern"

	tests.append(test)

func check(results_tree : Tree) -> void:
	check_tests(results_tree, "String")
