class Restaurant < ActiveRecord::Base
    has_many :dishes

    validates :name, presence: :true

    def self.mcdonalds
        self.find_by(name: "McDonald's")
    end

    def self.tenth
        self.find_by(id: 10)
    end

    def self.with_long_names
        self.all.select do |r|
            r.name.length > 12
        end
    end

    def self.max_dishes
        max = -1
        
        self.all.each do |r|
            length = r.dishes.length
            if length > max
                maxR = r
                max = length
            end
        end
        maxR
    end

    def self.focused
        self.all.select do |r|
            r.dishes.length < 5
        end
    end

    def self.large_menu
        self.all.select do |r|
            r.dishes.length > 20
        end
    end

    def self.vegetarian
        # all restaurants where all of the dishes are tagged vegetarian
        veg = Tag.find_by(name: "Vegetarian")
        self.all.select do |r|
            r.dishes.all? do |d|
                d.tags.include(veg)
            end
        end
    end

    def self.name_like(name)
        # all restaurants where the name is like the name passed in
        self.all.select do |r|
            r.name.match(/#{name}/)
        end
    end

    def self.name_not_like(name)
        # all restaurants where the name is not like the name passed in
        self.all.select do |r|
            !r.name.match(/#{name}/)
        end
    end
end