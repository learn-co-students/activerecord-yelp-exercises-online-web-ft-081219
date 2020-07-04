class Dish < ActiveRecord::Base
    belongs_to :restaurant
    has_many :dishes_tags
    has_many :tags, through: :dishes_tags

    validates :name, presence: true
    validates :restaurant, presence: true

    def self.names
        # - all the names of dishes
        self.all.collect do |d|
            d.name
        end
    end

    def self.max_tags
        # - single dish with the most tags
        max = -1
        Dish.all.each do |d|
            if d.tag_count > max
                max = d.tag_count
                maxD = d
            end
        end
        maxD
    end

    def self.untagged
        # - dishes with no tags
        self.all.select do |d|
            d.tag_count == 0
        end
    end

    def self.average_tag_count
        # - average tag count for dishes
        total = Dish.all.inject { |sum, d| sum + d.tag_count } 
        total / Dish.all.length
    end

    def tag_count
        # - number of tags for a dish
        self.tags.length
    end

    def tag_names
        # - names of the tags on a dish
        self.tags.collect { |t| t.name }
    end

    def most_popular_tag
        # - most widely used tag for a dish
        max = -1
        self.tags.each do |t|
            if t.dishes.length > max
                max = t
                popD = d
            end
        end
        return popD
    end

end