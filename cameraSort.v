import os
import ui
import net.html
//import camsort_modules

struct App {
mut:
	high_or_low 	bool
	window         &ui.Window = 0
	camera_name 	string
	megapixels		string
	format			string
	launch_date 	string
	launch_price 	string
	overall_score 	string
	dxo_overall_score string
	portrait_score 	string
	landscape_score string
	sports_score	string
	joshs_score 	string
	data_list[]		Camera_data
}

[console]
fn main()
{
	mut html_data := html.parse_file("Sensors Database - DxOMark.html")
	mut tag := html_data.get_tag('tbody')[0]
	mut data_list := get_data_list(tag)
	calculate_joshs_rank(mut data_list)
	calculate_overall_rank(mut data_list)
	// terminal_user_interface(mut data_list)
	graphical_user_interface(mut data_list)
}

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

//*******************GRAPHICAL USER INTERFACE*******************

fn graphical_user_interface(mut data_list[] Camera_data)
{
	mut app := &App{
		data_list: data_list}
	app.window = ui.window(
		width: 1000
		height: 500
		title: 'Camera Sort'
		state: app
		children: [
			ui.column(
				spacing: 5
				alignment: .center
				margin: ui.Margin{30, 30, 30, 30}
				children: 
				[
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.button(text: "Sort By Best/Highest", onclick: btn_set_preference_high, width:200)
							ui.button(text: "Sort By Worst/Lowest", onclick: btn_set_preference_low, width:200)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children: 
						[
							ui.button(text: "Josh's", onclick: btn_josh_sort, width: 80)
							ui.button(text: "Overall", onclick: btn_overall_sort, width: 80)	
							ui.button(text: "DXO Overall", onclick: btn_dxo_overall_sort, width: 80)
							ui.button(text: "DXO Portrait", onclick: btn_dxo_portrait_sort, width: 80)
							ui.button(text: "DXO Landscape", onclick: btn_dxo_landscape_sort, width: 80)
							ui.button(text: "DXO Sports", onclick: btn_dxo_sports_sort, width: 80)
							ui.button(text: "Age", onclick: btn_age_sort, width: 80)	
							ui.button(text: "Megapixels", onclick: btn_megapixel_sort, width: 80)
							ui.button(text: "Price", onclick: btn_price_sort, width: 80)
						]
					)
					ui.textbox(
					text: &app.camera_name	
					is_wordwrap: true
					height: 30
					width: 30
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Megapixels"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.megapixels
								height: 30
								width: 100
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Format"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.format
								height: 30
								width: 110
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Price"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.launch_price
								height: 30
								width: 60
							)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Date"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.launch_date
								height: 30
								width: 80
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Overall"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.overall_score
								height: 30
								width: 50
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "DXO Overall"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.dxo_overall_score
								height: 30
								width: 50
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Portrait"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.portrait_score
								height: 30
								width: 50
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Landscape"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.landscape_score
								height: 30
								width: 50
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Sports"
								height: 30
								width: 90
								)
							ui.textbox(
								text: &app.sports_score
								height: 30
								width: 50
								)
						]
					)
					ui.row(
						spacing: 10
						alignment: .center
						children:
						[
							ui.textbox(
								placeholder: "Josh's"
								height: 30
								width: 90
								)
							ui.textbox(
							text: &app.joshs_score
							height: 30
							width: 50
							)
						]
					)
				]
			)
		]
	)
	ui.run(app.window)
}

fn btn_set_preference_high(mut app App, btn &ui.Button)
{
	app.high_or_low = true
}

fn btn_set_preference_low(mut app App, btn &ui.Button)
{
	app.high_or_low = false
}

fn btn_josh_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_josh_score(mut app.data_list, true)}
		else { sort_by_josh_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_overall_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_overall_score(mut app.data_list, true)}
		else { sort_by_overall_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_overall_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_dxo_overall_score(mut app.data_list, true)}
		else { sort_by_dxo_overall_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_portrait_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_dxo_portrait_score(mut app.data_list, true)}
		else { sort_by_dxo_portrait_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_landscape_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_dxo_landscape_score(mut app.data_list, true)}
		else { sort_by_dxo_landscape_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_sports_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_dxo_sports_score(mut app.data_list, true)}
		else { sort_by_dxo_sports_score(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_age_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_age(mut app.data_list, true)}
		else { sort_by_age(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_megapixel_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_megapixels(mut app.data_list, true)}
		else { sort_by_megapixels(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_price_sort(mut app App, btn &ui.Button)
{
	match app.high_or_low
	{
		true { sort_by_price(mut app.data_list, true)}
		else { sort_by_price(mut app.data_list, false)}
	}
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn change_text_in_textboxes(mut app App)
{
	app.camera_name = app.data_list[0].camera_name
	app.megapixels = app.data_list[0].megapixels.str() + " Megapixels"
	app.format = app.data_list[0].format
	app.launch_price = "$" + app.data_list[0].launch_price.str()
	app.launch_date = app.data_list[0].launch_date
	app.overall_score = "# " + app.data_list[0].overall_score.str()
	app.dxo_overall_score = "# "+ app.data_list[0].dxo_overall_score.str()
	app.portrait_score = "# " + app.data_list[0].portrait_score.str()
	app.landscape_score = "# " + app.data_list[0].landscape_score.str()
	app.sports_score = "# " + app.data_list[0].sports_score.str()
	app.joshs_score = "# " + app.data_list[0].joshs_score.str()
}

//*******************TERMINAL USER INTERFACE*******************

fn terminal_user_interface(mut data_list[] Camera_data)
{
	mut action := "0"
	for
	{
		action = os.input("(1) Josh Best | (2) Josh Worst | (3) Overall Best | (4) Overall Worst | (5) DXO Overall Best | 
(6) DXO Overall Worst | (7) DXO Portrait Best | (8) DXO Portrait Worst | (9) DXO Landscape Best | 
(10) DXO Landscape Worst | (11) DXO Sports Best | (12) DXO Sports Worst | (13) Newest | (14) Oldest |
(15) Highest Megapixel | (16) Lowest Megapixel  | (17) Highest Price | (18) Lowest Price : ")
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

//*******************SORTS*******************

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

//*******************PRINTS*******************

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

//*******************GETTING DATA*******************

fn get_data_list(tag &html.Tag) []Camera_data
{
	budget:=2000
	mut data_list := []Camera_data{len:388, cap:388}
	j := 1
	for i := 0; i<data_list.len; i++
	{
		data_list[i].camera_name = tag.children[i].children[j].attributes["data-value"]
		data_list[i].megapixels = tag.children[i].children[j+1].attributes["data-value"].int()
		data_list[i].format = tag.children[i].children[j+2].children[0].content
		data_list[i].launch_price = tag.children[i].children[j+3].attributes["data-value"].int()
		data_list[i].launch_date = tag.children[i].children[j+4].attributes["data-value"]
		data_list[i].dxo_overall_score = tag.children[i].children[j+5].attributes["data-value"].int()
		data_list[i].portrait_score = tag.children[i].children[j+6].attributes["data-value"].int()
		data_list[i].landscape_score = tag.children[i].children[j+7].attributes["data-value"].int()
		data_list[i].sports_score = tag.children[i].children[j+8].attributes["data-value"].int()
		data_list[i].joshs_score = calculate_joshs_score(data_list[i], budget)
	}
	return data_list
}

fn calculate_joshs_rank(mut data_list[] Camera_data)
{
	data_list.sort(a.joshs_score>b.joshs_score)	
	for i:=1; i<data_list.len+1; i++
	{
		data_list[i-1].joshs_score = i
	}
}

fn calculate_overall_rank(mut data_list[] Camera_data)
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
	if data.megapixels > 24
	{
		for i:= data.megapixels; i>24; i-=3
		{
			score += 10
		}	
	}

	return score
}