require 'byebug'

class Item

    attr_accessor :name
    attr_accessor :price
    attr_accessor :category

    def initialize item
        @name = item["name"]
        @category = item["category"]
        @price = item["price"]
    end

    def method_missing(m, *args, &block)
        "#{@category.downcase.gsub(' ', '_')}?" == m.to_s if m.to_s.include?('?')
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

    def category? category
        @category == category
    end

    def to_h
        instance_variables.map{ |v| Hash[v.to_s.delete("@"), instance_variable_get(v)] }.inject(:merge)
    end

end