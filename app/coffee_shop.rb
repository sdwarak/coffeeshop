class CoffeeShop

    attr_reader :items

    def initialize items = []
        @items = if (items.is_a?(Array))
                    items
                 elsif (items)
                    [items]
                 else
                    []    
                 end
    end

    def add item
        @items << item
    end

    def remove item
        @items.delete item
    end

    def display
        puts 'Welcome to the coffee shop!'
    end

    def menu
        puts ("\nMenu:\n")
        @items.each_with_index do |item, idx|
            puts "#{idx+1}: #{item.display}"
        end
        puts ("\n\n")
    end

end