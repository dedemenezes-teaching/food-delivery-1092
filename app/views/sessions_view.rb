class SessionsView
  def ask_user_for(stuff)
    puts "#{stuff}?"
    gets.chomp
  end

  def wrong_credentials
    puts 'Wrong credentials. Try again...'
  end

  def welcome_message(employee)
    puts "Welcome, #{employee.name}"
  end
end
