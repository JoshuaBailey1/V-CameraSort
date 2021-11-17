fn main()
{
	response := call_the_krusty_crab("Is This The Krusty Crab?")
	println(response)
}

fn call_the_krusty_crab(word string) string
{
	if word=="Is This The Krusty Crab?"
	{
		return "NO, THIS IS PATRICK!!!"
	}
	else
	{
		return ""
	}
}

