import net.html
import camsort_modules

[console]
fn main()
{
	mut html_data := html.parse_file("Sensors Database - DxOMark.html")
	mut tag := html_data.get_tag('tbody')[0]
	mut data_list := camsort_modules.get_data_list(tag)
	camsort_modules.calculate_joshs_rank(mut data_list)
	camsort_modules.calculate_overall_rank(mut data_list)
	// camsort_modules.terminal_user_interface(mut data_list)
	camsort_modules.graphical_user_interface(mut data_list)
}