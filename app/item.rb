require_relative('tax')

class Item
    include Tax

    attr_accessor :name
    attr_accessor :price
    attr_accessor :category

    def initialize item
        @name = item["name"]
        @price = item["price"]
    end

    def tax
        Tax.calculate(self)
    end
    
    def display
        "#{@name}, #{self.class.to_s} for $ #{@price}"
    end

    def to_h
        instance_variables.map{ |v| Hash[v.to_s.delete("@"), instance_variable_get(v)] }.inject(:merge)
    end

end