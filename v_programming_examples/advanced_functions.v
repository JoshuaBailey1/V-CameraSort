fn main()
{
	first_function := fn (word string) string
	{
		return " First Function "
	}
	second_function := fn (word string) string
	{
		return " Second Function "
	}
	string_one,string_two := confusing_print("Who Needs A Documentation Anyway...", first_function, second_function)
	print(string_one+string_two)
}
fn confusing_print(word string, function_one fn (string) string, function_two fn (string) string) (string, string)
{
	return word+function_one(word),word+function_two(word)
}





