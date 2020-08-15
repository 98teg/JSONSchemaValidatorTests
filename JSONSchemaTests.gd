class_name JSONSchemaTests

var tests : Array = []

func check():
	var correct_tests = 0
	var validator = JSONSchema.new()

	var result
	for test in tests:
		if test.check(validator):
			correct_tests += 1
			result = "Success"
		else:
			result = "Failure"
		print(test.name + ": " + result)

	print("%d correct tests out of %d" % [correct_tests, tests.size()])
