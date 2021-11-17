fn main()
{
	mut array := []LOTR_character{len: 2, cap: 10, init:LOTR_character{"Hobbit",60}}
	array.prepend(LOTR_character{"Gandalf", 24000})
	array.prepend(LOTR_character{"Frodo", 51})
	array.prepend(LOTR_character{"Gimli", 140})
	array << [LOTR_character{"Legolas", 2931}]
	array << [LOTR_character{"Aragorn", 87}]
	array.sort(a.age < b.age)
	println("Full Array = ${array}")
	println("Array Snippet = ${array[3..array.len]}")
}

struct LOTR_character
{
	character string
	age int
}


