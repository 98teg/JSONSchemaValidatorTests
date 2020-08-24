class_name JSONSchemaNumericTypesTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "42 is an integer"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({ "type": "integer" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "-1 is an integer"
	test.json_data = JSON.print(-1)
	test.schema = JSON.print({ "type": "integer" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "3.1415926 is not an integer"
	test.json_data = JSON.print(3.1415926)
	test.schema = JSON.print({ "type": "integer" })
	test.expected_error = "Type mismatch: expected [integer] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"42\" is not an integer"
	test.json_data = JSON.print("42")
	test.schema = JSON.print({ "type": "integer" })
	test.expected_error = "Type mismatch: expected [integer] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "42 is a number multiple of 1.0"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 1.0
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "42.0 is a number multiple of 1.0"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 1.0
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "3.1415926 is not a number multiple of 1.0"
	test.json_data = JSON.print(3.1415926)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 1.0
	})
	test.expected_error = "Key schema root that equal 3.141593 must be multiple of 1.000000"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "42 is a number"
	test.json_data = JSON.print(42)
	test.schema = JSON.print({ "type": "number" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "-1 is a number"
	test.json_data = JSON.print(-1)
	test.schema = JSON.print({ "type": "number" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "5.1 is a number"
	test.json_data = JSON.print(5.1)
	test.schema = JSON.print({ "type": "number" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "2.99792458e8 is a number"
	test.json_data = JSON.print(2.99792458e8)
	test.schema = JSON.print({ "type": "number" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "\"42\" is not a number"
	test.json_data = JSON.print("42")
	test.schema = JSON.print({ "type": "number" })
	test.expected_error = "Type mismatch: expected [number] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "0 is a number multiple of 10"
	test.json_data = JSON.print(0)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 10
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "10 is a number multiple of 10"
	test.json_data = JSON.print(10)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 10
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "20 is a number multiple of 10"
	test.json_data = JSON.print(20)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 10
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "23 is not a number multiple of 10"
	test.json_data = JSON.print(23)
	test.schema = JSON.print({
		"type": "number",
		"multipleOf": 10
	})
	test.expected_error = "Key schema root that equal 23.000000 must be multiple of 10.000000"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "-1 is not in the range [0,100)"
	test.json_data = JSON.print(-1)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})
	test.expected_error = "Key schema root that equal -1.000000 must be greater or equal than 0.000000"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "0 is in the range [0,100)"
	test.json_data = JSON.print(0)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "10 is in the range [0,100)"
	test.json_data = JSON.print(10)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "99 is in the range [0,100)"
	test.json_data = JSON.print(99)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "100 is not in the range [0,100)"
	test.json_data = JSON.print(100)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})
	test.expected_error = "Key schema root that equal 100.000000 must be less than 100.000000"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "101 is not in the range [0,100)"
	test.json_data = JSON.print(101)
	test.schema = JSON.print({
		"type": "number",
		"minimum": 0,
		"exclusiveMaximum": 100
	})
	test.expected_error = "Key schema root that equal 101.000000 must be less than 100.000000"

	tests.append(test)

func check(results_tree : Tree) -> void:
	check_tests(results_tree, "Numeric Types")
