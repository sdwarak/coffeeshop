module Tax

    def self.calculate(item)
        tax_hash[item.class.to_s] ? tax_hash[item.class.to_s] : 0.12
    end
    
    def self.tax_hash
        { "Beverage" => 0.15,
          "Sandwich" => 0.10 }
    end
    
end