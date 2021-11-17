import cool_module

fn main()
{
	cool_module.say_hello()
}

module cool_module

pub fn say_hello()
{
	print("Hello!")
}

number := 5 
match true 
{
	number > 5 {print("Bigger")}
	number == 5 {print("Same")}
	else {print("Smaller")}
}

number := 5
if number > 5 {print("Bigger")}
else if number == 5 {print("Same")}
else {print("Smaller")}

mut numbers := [0, 1, 2]
for mut num in numbers
{
	print(num)
}

for i in 0..3
{
	print(i)
}

mut i:= 0
for
{
	print(i)
	i+=1
	if i==3
	{
		break
	}
}

for i := 0; i < 3; i++
{
	print(i)
}

mut my_map := map[string]string{}
my_map['uno'] = 'one'
my_map['dos'] = 'two'

mut my_map_two := map[string]int{}
my_map_two['one'] = 1
my_map_two['two'] = 2

struct Zombie{}
struct Creeper{}
struct Skeleton{}
type Minecraft_mobs = Zombie | Creeper | Skeleton

struct Types_of_rats
{
	chef_rat string //Private and Immutable
mut:
	super_fat_rat string //Private and Mutable
pub:
	new_york_rat string //Public and Immutable
pub mut:
	plague_rat string //Public and Mutable
__global:
	pakistani_rat string //GLOBAL Public and Mutable
}

__global(
	moon int
	another_slightly_bigger_moon int
)

fn main()
{
	mut my_name_is_not_bob := true
	if my_name_is_not_bob
	{
		my_name_is_not_bob = false
	}
	print(my_name_is_not_bob)
}

struct Cold_weather
{
	temperature_fahrenheit int
	temperature_celsius int
	is_cold_enough_to_make_potter_wear_jacket bool
}

struct Cold_weather
{
	int temperature_fahrenheit;
	int temperature_celsius;
	bool is_cold_enough_to_make_potter_wear_jacket;
}