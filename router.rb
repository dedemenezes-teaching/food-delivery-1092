class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @sessions_controller = sessions_controller
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    while @running
      @employee = @sessions_controller.login #=> ths method is returning the instace
      while !@employee.nil?
        # BEFORE DISPLAY THE MENU
        # WE NEED TO CHECK IF THE LOGGED IN EMPLOYEE
        # IS A RIDER OR A MANAGER
        # WE NEED TO HAVE THE EMPLOYEE INSTANCE
        if @employee.manager?
          print_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route_manager_action(choice)
        else
          print_rider_menu
          choice = gets.chomp.to_i
          print `clear`
          route_rider_action(choice)
        end
      end
    end
  end

  private

  def print_manager_menu
    puts "1. add meal"
    puts "2. list meal"
    puts "3. new customer"
    puts "4. list customers"
    puts '8. Log out'
    puts "9. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 8
      @employee = nil
    when 9 then stop!
    else puts "try again..."
    end
  end

  def print_rider_menu
    puts "1. Mark one of my orders as delivered"
    puts "2. List all my undelivered orders"
    puts "8. Exit"
    print "> "
  end

  def route_rider_action(action)
    case action
    when 1 then puts 'TODO: Mark one of my orders as delivered'
    when 2 then puts 'TODO: List all my undelivered orders'
    when 8 then stop!
    else puts "try again..."
    end
  end

  def stop!
    @employee = nil
    @running = false
  end
end
