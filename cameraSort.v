import os
import net.http
import net.html

fn main()
{
	//data := os.read_file("html.txt")?
	//http.download_file('https://www.dxomark.com/Cameras/',"dxo.html")?
	mut html_data := html.parse_file("Sensors Database - DxOMark.html")
	//mut html_data := html.parse(raw_data)
	mut tag := html_data.get_tag('tbody')[0]
	//mut tag := html_data.get_tag_by_attribute_value('id','pointCloudResultList')[0] 
	//mut data_list := get_data_list(tag)
	//data_list.sort(a.joshs_score>b.joshs_score)
	print(tag.attributes)
	//calculate_joshs_rank(mut data_list)?
	//data_list.sort(a.overall_score<b.overall_score)
	//print_data_list_to_console(data_list)?
	//print_data_list_to_file(data_list)?
	// println(tag.children[0].children[3].children[0].content)	
	// println(tag.children[0].children[6].children[0].children[0].content)
	//os.write_file("test.txt", )?
}

struct Score
{
	mut:
	rank int
	raw_value int
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
	portrait_score int
	landscape_score int
	sports_score int
	joshs_score int
}

fn print_data_list_to_console(data_list[] Camera_data)?
{
	for n:=0; n<data_list.len; n+=1
	{
		println("Camera = ${data_list[n].camera_name}")
		println("Megapixels = ${data_list[n].megapixels}")
		println("Format = ${data_list[n].format}")
		println("Price = ${data_list[n].launch_price}")
		println("Launch Date = ${data_list[n].launch_date}")
		println("Overall Score = ${data_list[n].overall_score}")
		println("Portrait Score = ${data_list[n].portrait_score}")
		println("Landscape Score = ${data_list[n].landscape_score}")
		println("Sports Score = ${data_list[n].sports_score}")
		println("Josh's Score = ${data_list[n].joshs_score}")
		println("*****************************************")
	}
}

fn print_data_list_to_file (data_list[] Camera_data)?
{
	os.open_file("test.txt", 'w')?
	mut file := os.open_append("test.txt")?
	for n:=0; n<data_list.len; n+=1
	{
		file.writeln("Camera = ${data_list[n].camera_name}")?
		file.writeln("Megapixels = ${data_list[n].megapixels}")?
		file.writeln("Format = ${data_list[n].format}")?
		file.writeln("Price = ${data_list[n].launch_price}")?
		file.writeln("Launch Date = ${data_list[n].launch_date}")?
		file.writeln("Overall Rank = ${data_list[n].overall_score}")?
		file.writeln("Portrait Rank = ${data_list[n].portrait_score}")?
		file.writeln("Landscape Rank = ${data_list[n].landscape_score}")?
		file.writeln("Sports Rank = ${data_list[n].sports_score}")?
		file.writeln("Josh's Rank = ${data_list[n].joshs_score}")?
		file.writeln("*****************************************")?
	}
	file.close()
}

fn get_data_list(tag &html.Tag) []Camera_data
{
	mut data_list := []Camera_data{len:388, cap:388}
	j := 1
	for i := 0; i<data_list.len; i++
	{
		data_list[i].camera_name = tag.children[i].children[j].attributes["data-value"]
		data_list[i].megapixels = tag.children[i].children[j+1].attributes["data-value"].int()
		data_list[i].format = tag.children[i].children[j+2].children[0].content
		data_list[i].launch_price = tag.children[i].children[j+3].attributes["data-value"].int()
		data_list[i].launch_date = tag.children[i].children[j+4].attributes["data-value"]
		data_list[i].overall_score = tag.children[i].children[j+5].attributes["data-value"].int()
		data_list[i].portrait_score = tag.children[i].children[j+6].attributes["data-value"].int()
		data_list[i].landscape_score = tag.children[i].children[j+7].attributes["data-value"].int()
		data_list[i].sports_score = tag.children[i].children[j+8].attributes["data-value"].int()
		data_list[i].joshs_score = calculate_joshs_score(data_list[i], 1500)
	}
	return data_list
}

fn calculate_joshs_rank(mut data[] Camera_data)?
{
	data.sort(a.joshs_score>b.joshs_score)	
	for i:=1; i<data.len+1; i++
	{
		data[i-1].joshs_score = i
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
			score += 20
		}	
	}

	return score
}