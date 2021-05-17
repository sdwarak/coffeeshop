class OrderedItem

    attr_reader :items

    def initialize
        @items = []
    end

    def add item 
        @items.push item
    end

    def remove item
        @items.delete item
    end

end

