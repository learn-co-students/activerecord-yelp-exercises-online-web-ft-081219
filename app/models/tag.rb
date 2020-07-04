class Tag < ActiveRecord::Base
    class TagNameValidator < ActiveModel::Validator
        def validate(record)
            options[:fields].each do |field|
                if record.send(field).nil?
                    record.errors[:base] << "name must be present"
                elsif record.send(field).length < 3
                    record.errors[:base] << "name must be at least 3 characters"
                elsif record.send(field).split(" ").length > 2
                    record.errors[:base] << "name can only consist of 1 or 2 words"
                end
            end
        end
    end

    validates_with TagNameValidator, fields: [:name]
    has_many :dishes_tags
    has_many :dishes, through: :dishes_tags

    scope :grouped_by_tag_id, -> { joins(:dishes_tags).group(:tag_id) }
    scope :restaurants_for_tag, -> (tag) { Restaurant.joins(:dishes => :tags).where("dishes_tags.tag_id = ?", tag.id) }
    scope :ordered_by_popularity_desc, -> { grouped_by_tag_id.order("COUNT(dishes_tags.dish_id) DESC") }
    scope :ordered_by_popularity_asc, -> { grouped_by_tag_id.order("COUNT(dishes_tags.dish_id) ASC") }
    scope :popular, -> { ordered_by_popularity_desc.take(5) }
    scope :most_common, -> { ordered_by_popularity_desc.take }
    scope :least_common, -> { ordered_by_popularity_asc.take }

    def self.unused
        # - all tags that haven't been used
        Tag.all.select do |t|
            t.dish_count == 0
        end
    end

    def self.uncommon
        # - all tags that have been used fewer than 5 times
        Tag.all.select do |t|
            t.dish_count < 5
        end
    end

    def restaurants
        # - restaurants that have this tag on at least one dish
        Tag.restaurants_for_tag(self).distinct
    end

    def top_restaurant
        # - restaurant that uses this tag the most
        Tag.restaurants_for_tag(self).group(:restaurant_id).order("COUNT(restaurant_id) DESC").take
    end

    def dish_count
        # - how many dishes use this tag
        self.dishes.length
    end

end

