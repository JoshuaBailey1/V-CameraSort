module camsort_modules

fn calculate_joshs_score(data Camera_data, budget int) int
{
	mut score := 1000
	if data.launch_price > budget
	{
		for i:= data.launch_price; i>budget; i-=100
		{
			score -= 10
		}
	}
	if data.landscape_score > 1
	{
		for i:= data.landscape_score; i>1; i--
		{
			score -= 2
		}
	}
	if data.megapixels < 24
	{
		for i:= data.megapixels; i<20; i+=3
		{
			score -= 50
		}
	}
	else if data.megapixels > 24
	{
		for i:= data.megapixels; i>24; i-=3
		{
			score += 10
		}	
	}
	return score
}