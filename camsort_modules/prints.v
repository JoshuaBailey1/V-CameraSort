module camsort_modules
import os

fn print_data_list_to_console(data_list[] Camera_data)
{
	for n:=0; n<data_list.len; n+=1
	{
		println("Camera = ${data_list[n].camera_name}")
		println("Megapixels = ${data_list[n].megapixels}")
		println("Format = ${data_list[n].format}")
		println("Price = ${data_list[n].launch_price}")
		println("Launch Date = ${data_list[n].launch_date}")
		println("Overall Rank = ${data_list[n].overall_score}")
		println("DXO Overall Rank = ${data_list[n].dxo_overall_score}")
		println("Portrait Rank = ${data_list[n].portrait_score}")
		println("Landscape Rank = ${data_list[n].landscape_score}")
		println("Sports Rank = ${data_list[n].sports_score}")
		println("Josh's Rank = ${data_list[n].joshs_score}")
		println("*****************************************")
	}
}

fn print_data_list_to_file (data_list[] Camera_data)
{
	filename := "SortedCameras.txt"
	os.open_file(filename, 'w') or { panic(err) }
	mut file := os.open_append(filename) or { panic(err) }
	for n:=0; n<data_list.len; n+=1
	{
		file.writeln("Camera = ${data_list[n].camera_name}")or { panic(err) }
		file.writeln("Megapixels = ${data_list[n].megapixels}")or { panic(err) }
		file.writeln("Format = ${data_list[n].format}")or { panic(err) }
		file.writeln("Price = ${data_list[n].launch_price}")or { panic(err) }
		file.writeln("Launch Date = ${data_list[n].launch_date}")or { panic(err) }
		file.writeln("Overall Rank = ${data_list[n].overall_score}")or { panic(err) }
		file.writeln("Dxo Overall Rank = ${data_list[n].dxo_overall_score}")or { panic(err) }
		file.writeln("Portrait Rank = ${data_list[n].portrait_score}")or { panic(err) }
		file.writeln("Landscape Rank = ${data_list[n].landscape_score}")or { panic(err) }
		file.writeln("Sports Rank = ${data_list[n].sports_score}")or { panic(err) }
		file.writeln("Josh's Rank = ${data_list[n].joshs_score}")or { panic(err) }
		file.writeln("*****************************************")or { panic(err) }
	}
	file.close()
}