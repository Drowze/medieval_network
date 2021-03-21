Item.find_or_create_by(name: 'Food') { |item| item.value = 1 }
Item.find_or_create_by(name: 'Beer') { |item| item.value = 2 }
Item.find_or_create_by(name: 'Life potion') { |item| item.value = 3 }
Item.find_or_create_by(name: 'Health potion') { |item| item.value = 4 }
