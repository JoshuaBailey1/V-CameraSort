module camsort_modules

fn sort_by_josh_score(mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.joshs_score<b.joshs_score)
	}
	else
	{
		data_list.sort(a.joshs_score>b.joshs_score)
	}
}

fn sort_by_overall_score (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.overall_score<b.overall_score)
	}
	else
	{
		data_list.sort(a.overall_score>b.overall_score)
	}	
}

fn sort_by_dxo_overall_score (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.dxo_overall_score<b.dxo_overall_score)
	}
	else
	{
		data_list.sort(a.dxo_overall_score>b.dxo_overall_score)
	}	
}

fn sort_by_dxo_portrait_score (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.portrait_score<b.portrait_score)
	}
	else
	{
		data_list.sort(a.portrait_score>b.portrait_score)
	}	
}

fn sort_by_dxo_landscape_score (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.landscape_score<b.landscape_score)
	}
	else
	{
		data_list.sort(a.landscape_score>b.landscape_score)
	}	
}

fn sort_by_dxo_sports_score (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.sports_score<b.sports_score)
	}
	else
	{
		data_list.sort(a.sports_score>b.sports_score)
	}	
}

fn sort_by_age (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.launch_date>b.launch_date)
	}
	else
	{
		data_list.sort(a.launch_date<b.launch_date)
	}	
}

fn sort_by_megapixels (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.megapixels>b.megapixels)
	}
	else
	{
		data_list.sort(a.megapixels<b.megapixels)
	}	
}

fn sort_by_price (mut data_list[] Camera_data, greater_than bool)
{
	if greater_than
	{
		data_list.sort(a.launch_price>b.launch_price)
	}
	else
	{
		data_list.sort(a.launch_price<b.launch_price)
	}	
}
