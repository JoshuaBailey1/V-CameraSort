module camsort_modules
import ui

struct App 
{
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

pub fn graphical_user_interface(mut data_list[] Camera_data)
{
	mut app := &App
	{
		high_or_low: true
		data_list: data_list
	}
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
					create_ui_row("Megapixels", &app.megapixels)
					create_ui_row("Format", &app.format)
					create_ui_row("Price", &app.launch_price)
					create_ui_row("Date", &app.launch_date)
					create_ui_row("Overall", &app.overall_score)
					create_ui_row("DXO Overall", &app.dxo_overall_score)
					create_ui_row("Portrait", &app.portrait_score)
					create_ui_row("Landscape", &app.landscape_score)
					create_ui_row("Sports", &app.sports_score)
					create_ui_row("Josh", &app.joshs_score)
				]
			)
		]
	)
	ui.run(app.window)
}

fn create_ui_row(placeholder string, text &string) &ui.Stack
{
	unsafe{
	return ui.row(
		spacing: 10
		alignment: .center
		children:
		[
			ui.textbox(
				placeholder: placeholder
				height: 30
				width: 90
			)
			ui.textbox(
				text: text
				height: 30
				width: 120
			)
		]
	)
	}
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
	sort_by_josh_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_overall_sort(mut app App, btn &ui.Button)
{
	sort_by_overall_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_overall_sort(mut app App, btn &ui.Button)
{
	sort_by_dxo_overall_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_portrait_sort(mut app App, btn &ui.Button)
{
	sort_by_dxo_portrait_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_landscape_sort(mut app App, btn &ui.Button)
{
	sort_by_dxo_landscape_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_dxo_sports_sort(mut app App, btn &ui.Button)
{
	sort_by_dxo_sports_score(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_age_sort(mut app App, btn &ui.Button)
{
	sort_by_age(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_megapixel_sort(mut app App, btn &ui.Button)
{
	sort_by_megapixels(mut app.data_list, app.high_or_low)
	print_data_list_to_file(app.data_list)
	change_text_in_textboxes(mut app)
}

fn btn_price_sort(mut app App, btn &ui.Button)
{
	sort_by_price(mut app.data_list, app.high_or_low)
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
