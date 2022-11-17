class OrdersView
  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - Meal: #{order.meal.name} - Customer: #{order.customer.name} - Rider: #{order.employee.username}"
    end
  end

  def ask_user_for(stuff)
    puts "#{stuff}?"
    gets.chomp
  end
end
