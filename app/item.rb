class Item

    attr_accessor :name
    attr_accessor :price
    attr_accessor :category

    def initialize item
        @name = item["name"]
        @category = item["category"]
        @price = item["price"]
    end

    def tax
        if beverage?
            0.15
        elsif sandwich?
            0.10
        else
            0.12
        end
    end
    
    def display
        "#{@name}, #{@category} for $ #{@price}"
    end

    def beverage?
        @category == "Beverage"
    end

    def sandwich?
        @category == "Sandwich"
    end

    def category? category
        oi.category == category
    end

end