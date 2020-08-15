class_name JSONSchemaTest

var name : String
var json_data : String
var schema : String
var expected_error : String = ""

func check(validator : JSONSchema) -> bool:
	return validator.validate(json_data, schema) == expected_error
