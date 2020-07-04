# Seeds

# Create a seeds file that creates:

# 20 restaurants.
# Each restaurant should have 10 dishes
# Each Dish should have 3 tags
# There should be only 10 or 15 tags, with names like 'Spicy' and 'Vegetarian'

spicy = Tag.create(name: "Spicy")
mild = Tag.create(name: "Mild")
medium = Tag.create(name: "Medium Spice")
spice = [mild, medium, spicy]

vegetarian = Tag.create(name: "Vegetarian")
peanuts = Tag.create(name: "Contains Peanuts")
glutenFree = Tag.create(name: "Gluten Free")
pork = Tag.create(name: "Contains Pork")
dietary = [vegetarian, peanuts, glutenFree, pork]

large = Tag.create(name: "Serves Four")
app = Tag.create(name: "Appetizer")
small = Tag.create(name: "Small Plate")
size = [large, app, small]

restaurants = [
    "McDonald's",
    "Arby's",
    "Dominos",
    "Noodles & Co",
    "Kazoku",
    "Chipotle",
    "Olive Garden",
    "Red Lobster",
    "Cafe Latte",
    "Outback Steakhouse",
    "Capital Grille",
    "Crave",
    "Rainforest Cafe",
    "Al's Diner",
    "Fig & Farro",
    "Junior's",
    "Jensen's Supper Club",
    "Original Pancake House",
    "Blue Ox",
    "Guiseppe's"
]

food = [
    "chicken",
    "pasta",
    "rice",
    "beans",
    "paella",
    "burger",
    "lamb",
    "salad",
    "veggies",
    "fresh fruit"
]

i = 0
20.times do
    restaurant = Restaurant.new(name: restaurants[i])
    j = 0
    10.times do
        dish = Dish.new(name: "#{restaurants[i]} #{food[j]}")
        dish.restaurant = restaurant
        dish.tags << spice[rand(3)]
        dish.tags << dietary[rand(4)]
        dish.tags << size[rand(3)]
        dish.save
        j += 1
    end
    restaurant.save
    i += 1
end


