#!/usr/bin/env ruby
require('./lib/helper')

#  should quantity be part of the item 
# is quantity applicable to every item, like what about they are different units
#  how will the size affect quantity
# e.g the beverage may be available in small,medium,large, extra large
# a sandwich may be available in footlong and 

coffee_shop = Helper.populate_shop
Helper.display_panel(coffee_shop)
orders = Helper.request_orders
puts ("\n")
selection = Helper.select(coffee_shop)
processed_payment = Helper.pay(selection,orders)
Helper.generate_receipt(processed_payment)