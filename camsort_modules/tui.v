module camsort_modules
import os

pub fn terminal_user_interface(mut data_list[] Camera_data)
{
	mut action := "0"
	for
	{
		action = os.input("(1) Josh Best | (2) Josh Worst | (3) Overall Best | (4) Overall Worst | (5) DXO Overall Best | 
(6) DXO Overall Worst | (7) DXO Portrait Best | (8) DXO Portrait Worst | (9) DXO Landscape Best | 
(10) DXO Landscape Worst | (11) DXO Sports Best | (12) DXO Sports Worst | (13) Newest | (14) Oldest |
(15) Highest Megapixel | (16) Lowest Megapixel  | (17) Highest Price | (18) Lowest Price | (19) Print To File: ")
		println("")
		match true
		{
			action.int()==1 { sort_by_josh_score(mut data_list, true) }
			action.int()==2 { sort_by_josh_score(mut data_list, false) }
			action.int()==3 { sort_by_overall_score(mut data_list, true) }
			action.int()==4 { sort_by_overall_score(mut data_list, false) }
			action.int()==5 { sort_by_dxo_overall_score(mut data_list, true) }
			action.int()==6 { sort_by_dxo_overall_score(mut data_list, false) }
			action.int()==7 { sort_by_dxo_portrait_score(mut data_list, true) }
			action.int()==8 { sort_by_dxo_portrait_score(mut data_list, false) }
			action.int()==9 { sort_by_dxo_landscape_score(mut data_list, true) }
			action.int()==10 { sort_by_dxo_landscape_score(mut data_list, false) }
			action.int()==11 { sort_by_dxo_sports_score(mut data_list, true) }
			action.int()==12 { sort_by_dxo_sports_score(mut data_list, false) }
			action.int()==13 { sort_by_age(mut data_list, true) }
			action.int()==14 { sort_by_age(mut data_list, false) }
			action.int()==15 { sort_by_megapixels(mut data_list, true) }
			action.int()==16 { sort_by_megapixels(mut data_list, false) }
			action.int()==17 { sort_by_price(mut data_list, true) }
			action.int()==18 { sort_by_price(mut data_list, false) }
			action.int()==19 { print_data_list_to_file(data_list) }
			else { break }
		}
		print_data_list_to_console(data_list[..1])
		println("")
	}
}