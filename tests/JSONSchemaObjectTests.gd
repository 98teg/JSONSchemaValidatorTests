class_name JSONSchemaObjectTests extends JSONSchemaTests

func _init():
	var test

	test = JSONSchemaTest.new()

	test.name = "Valid object"
	test.json_data = JSON.print({
		"key"         : "value",
		"another_key" : "another_value"
	})
	test.schema = JSON.print({ "type": "object" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Another valid object"
	test.json_data = JSON.print({
		"Sun"     : 1.9891e30,
		"Jupiter" : 1.8986e27,
		"Saturn"  : 5.6846e26,
		"Neptune" : 10.243e25,
		"Uranus"  : 8.6810e25,
		"Earth"   : 5.9736e24,
		"Venus"   : 4.8685e24,
		"Mars"    : 6.4185e23,
		"Mercury" : 3.3022e23,
		"Moon"    : 7.349e22,
		"Pluto"   : 1.25e22
	})
	test.schema = JSON.print({ "type": "object" })

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Incorrect object because of numerical keys"
	test.json_data = "{0.01: \"cm\", 1: \"m\", 1000: \"km\"}"
	test.schema = JSON.print({ "type": "object" })
	test.expected_error = "Invalid JSON data passed with message: 0:Expected key"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "A string is not an object"
	test.json_data = JSON.print("Not an object")
	test.schema = JSON.print({ "type": "object" })
	test.expected_error = "Type mismatch: expected [object] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "An array is not an object"
	test.json_data = JSON.print(["An", "array", "not", "an", "object"])
	test.schema = JSON.print({ "type": "object" })
	test.expected_error = "Type mismatch: expected [object] for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Correct direction description"
	test.json_data = JSON.print({ "number": 1600, "street_name": "Pennsylvania", "street_type": "Avenue" })
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Incorrect direction description"
	test.json_data = JSON.print({ "number": "1600", "street_name": "Pennsylvania", "street_type": "Avenue" })
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		}
	})
	test.expected_error = "Type mismatch: expected [number] for 'number'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Missing optional parameters in the direction"
	test.json_data = JSON.print({ "number": 1600, "street_name": "Pennsylvania" })
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Empty dictionary is correct"
	test.json_data = JSON.print({})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are allowed"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue",
		"direction": "NW"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are not allowed and there is none"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		},
		"additionalProperties": false
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are not allowed but there is one"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue",
		"direction": "NW"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		},
		"additionalProperties": false
	})
	test.expected_error = "Additional properties are not required: found 'direction'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are allowed (only string) and there is none"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		},
		"additionalProperties": { "type": "string" }
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are allowed (only string) and there is one"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue",
		"direction": "NW"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		},
		"additionalProperties": { "type": "string" }
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Additional properties are allowed (only string) but there is an integer"
	test.json_data = JSON.print({
		"number": 1600,
		"street_name": "Pennsylvania",
		"street_type": "Avenue",
		"office_number": 201
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"number":      { "type": "number" },
			"street_name": { "type": "string" },
			"street_type": {
				"type": "string",
				"enum": ["Street", "Avenue", "Boulevard"]
			}
		},
		"additionalProperties": { "type": "string" }
	})
	test.expected_error = "Type mismatch: expected [string] for 'office_number'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Just the required properties are provided"
	test.json_data = JSON.print({
		"name": "William Shakespeare",
		"email": "bill@stratford-upon-avon.co.uk"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"name":      { "type": "string" },
			"email":     { "type": "string" },
			"address":   { "type": "string" },
			"telephone": { "type": "string" }
		},
		"required": ["name", "email"]
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The required properties and others are provided"
	test.json_data = JSON.print({
		"name": "William Shakespeare",
		"email": "bill@stratford-upon-avon.co.uk",
		"address": "Henley Street, Stratford-upon-Avon, Warwickshire, England",
		"authorship": "in question"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"name":      { "type": "string" },
			"email":     { "type": "string" },
			"address":   { "type": "string" },
			"telephone": { "type": "string" }
		},
		"required": ["name", "email"]
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The required properties are not provided"
	test.json_data = JSON.print({
		"name": "William Shakespeare",
		"address": "Henley Street, Stratford-upon-Avon, Warwickshire, England"
	})
	test.schema = JSON.print({
		"type": "object",
		"properties": {
			"name":      { "type": "string" },
			"email":     { "type": "string" },
			"address":   { "type": "string" },
			"telephone": { "type": "string" }
		},
		"required": ["name", "email"]
	})
	test.expected_error = "Missing required property: 'email' for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Accept correct tokens as keys"
	test.json_data = JSON.print({"_a_proper_token_001": "value"})
	test.schema = JSON.print({
		"type": "object",
		"propertyNames": {
			"pattern": "^[A-Za-z_][A-Za-z0-9_]*$"
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Does not accept incorrect tokens as keys"
	test.json_data = JSON.print({"001 invalid": "value"})
	test.schema = JSON.print({
		"type": "object",
		"propertyNames": {
			"pattern": "^[A-Za-z_][A-Za-z0-9_]*$"
		}
	})
	test.expected_error = "Validation fails with message: String '001 invalid' does not match its corresponding pattern"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "0 properties are not enought properties"
	test.json_data = JSON.print({})
	test.schema = JSON.print({
		"type": "object",
		"minProperties": 2,
		"maxProperties": 3
	})
	test.expected_error = "0 propertie(s) are not enough properties, at least 2 are required"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "1 properties are not enought properties"
	test.json_data = JSON.print({ "a": 0 })
	test.schema = JSON.print({
		"type": "object",
		"minProperties": 2,
		"maxProperties": 3
	})
	test.expected_error = "1 propertie(s) are not enough properties, at least 2 are required"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "2 properties are enought properties"
	test.json_data = JSON.print({ "a": 0, "b": 1 })
	test.schema = JSON.print({
		"type": "object",
		"minProperties": 2,
		"maxProperties": 3
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "3 properties are enought properties"
	test.json_data = JSON.print({ "a": 0, "b": 1, "c": 2 })
	test.schema = JSON.print({
		"type": "object",
		"minProperties": 2,
		"maxProperties": 3
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "4 properties are too many properties"
	test.json_data = JSON.print({ "a": 0, "b": 1, "c": 2, "d": 3 })
	test.schema = JSON.print({
		"type": "object",
		"minProperties": 2,
		"maxProperties": 3
	})
	test.expected_error = "4 propertie(s) are too many properties, at most 3 are allowed"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The dependent property is included"
	test.json_data = JSON.print({
		"name": "John Doe",
		"credit_card": 5555555555555555,
		"billing_address": "555 Debtor's Lane"
	})
	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": ["billing_address"]
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "This instance has a credit_card, but it’s missing a billing_address."
	test.json_data = JSON.print({
		"name": "John Doe",
		"credit_card": 5555555555555555,
	})
	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": ["billing_address"]
		}
	})
	test.expected_error = "Missing required property: 'billing_address' for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "This is okay, since we have neither a credit_card, or a billing_address."
	test.json_data = JSON.print({
		"name": "John Doe"
	})
	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": ["billing_address"]
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "Note that dependencies are not bidirectional. It’s okay to have a billing address without a credit card number."
	test.json_data = JSON.print({
		"name": "John Doe",
		"billing_address": "555 Debtor's Lane"
	})
	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": ["billing_address"]
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "This has a billing_address, but is missing a credit_card."
	test.json_data = JSON.print({
		"name": "John Doe",
		"billing_address": "555 Debtor's Lane"
	})
	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": ["billing_address"],
			"billing_address": ["credit_card"]
		}
	})
	test.expected_error = "Missing required property: 'credit_card' for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "The dependent property is included."
	test.json_data = JSON.print({
		"name": "John Doe",
		"credit_card": 5555555555555555,
		"billing_address": "555 Debtor's Lane"
	})

	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": {
				"properties": {
					"billing_address": { "type": "string" }
				},
				"required": ["billing_address"]
			}
		}
	})

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "This instance has a credit_card, but it’s missing a billing_address."
	test.json_data = JSON.print({
		"name": "John Doe",
		"credit_card": 5555555555555555
	})

	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": {
				"properties": {
					"billing_address": { "type": "string" }
				},
				"required": ["billing_address"]
			}
		}
	})
	test.expected_error = "Missing required property: 'billing_address' for 'schema root'"

	tests.append(test)

	test = JSONSchemaTest.new()

	test.name = "This has a billing_address, but is missing a credit_card. This passes, because here billing_address just looks like an additional property."

	test.json_data = JSON.print({
		"name": "John Doe",
		"billing_address": "555 Debtor's Lane"
	})

	test.schema = JSON.print({
		"type": "object",
		
		"properties": {
			"name": { "type": "string" },
			"credit_card": { "type": "number" },
			"billing_address": { "type": "string" }
		},
		
		"required": ["name"],
		
		"dependencies": {
			"credit_card": {
				"properties": {
					"billing_address": { "type": "string" }
				},
				"required": ["billing_address"]
			}
		}
	})

	tests.append(test)


func check(results_tree : Tree) -> void:
	check_tests(results_tree, "Object")
