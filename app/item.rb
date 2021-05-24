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
        tax_hash[@category] ? tax_hash[@category] : 0.12
    end

    def tax_hash
        { "Beverage" => 0.15,
          "Sandwich" => 0.10 }
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

    def to_h
        {"name" => @name,
        "category" => @category,
        "price" => @price}
    end

end