module camsort_modules

struct Camera_data
{
	mut:
	camera_name string
	megapixels int
	format string
	launch_date string
	launch_price int
	overall_score int
	dxo_overall_score int
	portrait_score int
	landscape_score int
	sports_score int
	joshs_score int
}

