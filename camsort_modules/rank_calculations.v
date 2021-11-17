module camsort_modules

pub fn calculate_joshs_rank(mut data_list[] Camera_data)
{
	data_list.sort(a.joshs_score>b.joshs_score)	
	for i:=1; i<data_list.len+1; i++
	{
		data_list[i-1].joshs_score = i
	}
}

pub fn calculate_overall_rank(mut data_list[] Camera_data)
{
	for i:=0; i<data_list.len; i++
	{
		data_list[i].overall_score = (data_list[i].dxo_overall_score+data_list[i].portrait_score+
			data_list[i].landscape_score+data_list[i].sports_score+data_list[i].joshs_score)
	}
	data_list.sort(a.overall_score<b.overall_score)
	for i:=1; i<data_list.len+1; i++
	{
		data_list[i-1].overall_score = i
	}
}

pub fn calculate_joshs_score(data Camera_data, budget int) int
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