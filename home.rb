#!/usr/bin/env ruby
require('./lib/helper')

coffee_shop = Helper.populate_shop
Helper.display_panel(coffee_shop)
orders = Helper.request_orders
puts ("\n")
processed_payment = Helper.select_and_pay(coffee_shop,orders)
Helper.generate_receipt(processed_payment)